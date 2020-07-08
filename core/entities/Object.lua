local Sprite = require 'core.entities.Sprite'

-- File:Object.lua
local Object = class('entity.Object')

-- Register custom method
function Object:create() end
function Object:step() end
function Object:draw() end

-- TODO metjhods
-- distance_to_object
-- distance_to_point
-- motion_add
-- motion_set
-- move_towards_point
-- move_bounce_all
-- move_bounce_solid
-- move_contact_all
-- move_contact_solid
-- move_outside_all
-- move_outside_solid
-- move_random
-- move_snap
-- place_snapped
-- move_wrap

-- Object:initialize
-- Object constructor
function Object:initialize(properties)
  -- General variables
  self.id = properties.id
  self.room = properties.room
  self.solid = false
  self.visible = true -- TODO
  self.persistent = true -- TODO
  self.depth = 0 -- TODO
  self.alarm = {} -- TODO
  self.object_index = 0 -- TODO

  -- Sprite variables TODO
  self.sprite_index = false
  self.sprite_width = 0
  self.sprite_height = 0
  self.sprite_xoffset = 0
  self.sprite_yoffset = 0
  self.image_alpha = 0
  self.image_angle = 0
  self.image_blend = 0
  self.image_index = 0
  self.image_number = 0
  self.image_speed = 1
  self.image_xscale = 1
  self.image_yscale = 1

  -- Mask variables TODO
  self.mask_index = 0
  self.bbox_bottom = 0
  self.bbox_left = 0
  self.bbox_right = 0
  self.bbox_top = 0

  -- Built-in movements
  self.direction = 0
  self.friction = 0
  self.bounce = 0
  self.gravity = 0
  self.gravity_direction = 0
  self.hspeed = 0
  self.vspeed = 0
  self.speed = 0

  -- Axis movements
  self.x = properties.x or 0
  self.y = properties.y or 0
  self.xprevious = self.x -- TODO
  self.yprevious = self.y
  self.xstart = self.x -- TODO
  self.ystart = self.y

  -- Run create
  self:_run_create()
end

function Object:_run_create()
  self:create()
end

function Object:_run_step()
  if self.sprite_index and self.sprite_index:isInstanceOf(Sprite) then
    self.sprite_index:_run_step()

    self.sprite_width = self.sprite_index._frame_width
    self.sprite_height = self.sprite_index._frame_height
  end

  self:step()
  self:_apply_velocities()
end

function Object:_run_draw()
  -- Skip draw event
  if not self.visible then
    return nil
  end

  -- Object drawing
  if self.sprite_index and self.sprite_index:isInstanceOf(Sprite) then
    self.sprite_index:_run_draw(self)
  end

  self:draw()

  if __conf__.debug == true then
    local r, g, b, a = love.graphics.getColor()
    love.graphics.setColor(255, 0, 0, 1)
    love.graphics.line(self.x, self.y, self.x, self.y - 16)
    love.graphics.setColor(0, 255, 0, 1)
    love.graphics.line(self.x, self.y, self.x + 16, self.y)
    love.graphics.setColor(0, 0, 255, 1)
    love.graphics.line(self.x, self.y, self.x, self.y + 16)
    love.graphics.setColor(255, 255, 0, 1)
    love.graphics.line(self.x, self.y, self.x - 16, self.y)
    love.graphics.setColor(r, g, b, a)
  end
end

function Object:_check_collision(x1, y1, w1, h1, x2, y2, w2, h2)
  return x1 < x2 + w2 and
         x2 < x1 + w1 and
         y1 < y2 + h2 and
         y2 < y1 + h1
end

function Object:place_free(x, y)
  local collision = false

  for index, instance in ipairs(self.room.instances) do
    if instance.solid and instance.id ~=self.id then
      local has_collision = self:_check_collision(
        x, y, self.width, self.height,
        instance.x, instance.y, instance.width, instance.height
      )

      if has_collision then
        collision = true
      end
    end
  end

  return not toBoolean(collision)
end

function Object:_apply_gravity()
  local radians = math.rad(self.gravity_direction)
  local vacceleration = self.gravity * math.sin(radians);
  local hacceleration = self.gravity * math.cos(radians);

  self.vspeed = self.vspeed - vacceleration
  self.hspeed = self.hspeed + hacceleration
end

function Object:_apply_speed()
  local radians = math.rad(self.direction)
  local vacceleration = self.speed * math.sin(radians);
  local hacceleration = self.speed * math.cos(radians);

  self.vspeed = self.vspeed - vacceleration
  self.hspeed = self.hspeed + hacceleration
end

function Object:_handle_collision()
  if self.room and self.solid == false then
    for index, instance in ipairs(self.room.instances) do
      if instance.id == self.id then
        return
      end

      local separation_x, separation_y = self:_calculate_separators(instance)

      if separation_x and separation_y then
        self:_resolve_collision(instance, separation_x, separation_y)
      end
    end
  end
end

function Object:_calculate_separators(instance)
  -- Calculate enter x and center y
  local sxx = self.x + (self.width / 2)
  local ixx = instance.x + (instance.width / 2)
  local syy = self.y + (self.height / 2)
  local iyy = instance.y + (instance.height / 2)

  -- distance between the rects
  local distanceX = sxx - ixx
  local distanceY = syy - iyy

  local abs_distance_x = math.abs(distanceX)
  local abs_distance_y = math.abs(distanceY)

  -- sum of the extents
  local sum_half_width = (self.width + instance.width) / 2
  local sum_half_height = (self.height + instance.height) / 2

  if abs_distance_x >= sum_half_width or abs_distance_y >= sum_half_height then
    -- no collision
    return
  end

  -- shortest separation
  local separation_x = sum_half_width - abs_distance_x
  local separation_y = sum_half_height - abs_distance_y

  if separation_x < separation_y then
    if separation_x > 0 then
      separation_y = 0
    end
  else
    if separation_y > 0 then
      separation_x = 0
    end
  end

  -- correct sign
  if distanceX < 0 then
    separation_x = -separation_x
  end

  if distanceY < 0 then
    separation_y = -separation_y
  end

  return separation_x, separation_y
end

function Object:_resolve_collision(instance, separation_x, separation_y)
  -- find the collision normal
  local delta = math.sqrt(separation_x * separation_x + separation_y * separation_y)

  local normalX = separation_x / delta
  local normalY = separation_y / delta

  -- relative velocity
  local hspeed = self.hspeed - (instance.hspeed or 0)
  local vspeed = self.vspeed - (instance.vspeed or 0)

  -- penetration speed
  local penetration_speed = hspeed * normalX + vspeed * normalY

  -- penetration component
  local penetration_x = normalX * penetration_speed
  local penetration_y = normalY * penetration_speed

  -- tangent component
  local tangent_x = hspeed - penetration_x 
  local tangent_y = vspeed - penetration_y

  -- restitution
  local restitution = 1 + math.max(self.bounce, instance.bounce or 0)

  -- friction
  local friction = math.min(self.friction, instance.friction or 0)

  -- change the velocity of shape a
  self.hspeed = hspeed - penetration_x * restitution + tangent_x * friction
  self.vspeed = vspeed - penetration_y * restitution + tangent_y * friction

  if penetration_speed <= 0 then 
    self.x = self.x + separation_x
    self.y = self.y + separation_y
  end
end

function Object:_apply_velocities()
  local dt = love.timer.getDelta()

  -- Apply forces that modify vspeed/hspeed
  self:_apply_gravity()
  self:_apply_speed()

  self.x = self.x + self.hspeed * dt
  self.y = self.y + self.vspeed * dt
end

return Object