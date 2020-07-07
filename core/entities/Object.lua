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
  self.id = 'xasd'
  self.solid = false
  self.visible = true -- TODO
  self.persistent = true -- TODO
  self.depth = 0 -- TODO
  self.alarm = {} -- TODO
  self.object_index = 0 -- TODO
  self.room = properties.room

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
  self:_runCreate()
end

function Object:_runCreate()
  self:create()
end

function Object:_runStep()
  if self.sprite_index and self.sprite_index:isInstanceOf(Sprite) then
    self.sprite_index:_runStep()

    self.sprite_width = self.sprite_index._frame_width
    self.sprite_height = self.sprite_index._frame_height
  end

  self:step()
  self:_applyVelocities()
end

function Object:_runDraw()
  if __conf__.debug == true then
    love.graphics.rectangle('line', self.x, self.y, self.sprite_height, self.sprite_width)
  end

  -- Object drawing
  if self.sprite_index and self.sprite_index:isInstanceOf(Sprite) then
    self.sprite_index:_runDraw(self)
  end

  self:draw()
end

function Object:_checkCollision(x1, y1, w1, h1, x2, y2, w2, h2)
  return x1 < x2 + w2 and
         x2 < x1 + w1 and
         y1 < y2 + h2 and
         y2 < y1 + h1
end

function Object:placeFree(x, y)
  local collision = false

  if self.room then
    local instances = self.room.instances

    local findCollision = function(instance)
      return instance.solid and instance.id ~= self.id and self:_checkCollision(x, y, self.width, self.height, instance.x, instance.y, instance.width, instance.height)
    end

    collision = table.find(instances, findCollision)
  end

  return not toBoolean(collision)
end

function Object:_applyGravity()
  local radians = math.rad(self.gravity_direction)
  local vacceleration = self.gravity * math.sin(radians);
  local hacceleration = self.gravity * math.cos(radians);

  self.vspeed = self.vspeed - vacceleration
  self.hspeed = self.hspeed + hacceleration
end

function Object:_applySpeed()
  local radians = math.rad(self.direction)
  local vacceleration = self.speed * math.sin(radians);
  local hacceleration = self.speed * math.cos(radians);

  self.vspeed = self.vspeed - vacceleration
  self.hspeed = self.hspeed + hacceleration
end

function Object:_handleCollision()
  if self.room and self.solid == false then
    local instances = self.room.instances

    local mapCollision = function(instance)
      if instance.id == self.id then
        return
      end

      local separationX, separationY = self:_calculateSeparators(instance)

      if separationX and separationY then
        self:_resolveCollision(instance, separationX, separationY)
      end
    end

    table.map(instances, mapCollision)
  end
end

function Object:_calculateSeparators(instance)
  -- Calculate enter x and center y
  local sxx = self.x + (self.width / 2)
  local ixx = instance.x + (instance.width / 2)
  local syy = self.y + (self.height / 2)
  local iyy = instance.y + (instance.height / 2)

  -- distance between the rects
  local distanceX = sxx - ixx
  local distanceY = syy - iyy

  local absDistanceX = math.abs(distanceX)
  local absDistanceY = math.abs(distanceY)

  -- sum of the extents
  local sumHalfWidth = (self.width + instance.width) / 2
  local sumHalfHeight = (self.height + instance.height) / 2

  if absDistanceX >= sumHalfWidth or absDistanceY >= sumHalfHeight then
    -- no collision
    return
  end

  -- shortest separation
  local separationX = sumHalfWidth - absDistanceX
  local separationY = sumHalfHeight - absDistanceY

  if separationX < separationY then
    if separationX > 0 then
      separationY = 0
    end
  else
    if separationY > 0 then
      separationX = 0
    end
  end

  -- correct sign
  if distanceX < 0 then
    separationX = -separationX
  end

  if distanceY < 0 then
    separationY = -separationY
  end

  return separationX, separationY
end

function Object:_resolveCollision(instance, separationX, separationY)
  -- find the collision normal
  local delta = math.sqrt(separationX * separationX + separationY * separationY)

  local normalX = separationX / delta
  local normalY = separationY / delta

  -- relative velocity
  local hspeed = self.hspeed - (instance.hspeed or 0)
  local vspeed = self.vspeed - (instance.vspeed or 0)

  -- penetration speed
  local penetrationSpeed = hspeed * normalX + vspeed * normalY

  -- penetration component
  local penetrationX = normalX * penetrationSpeed
  local penetrationY = normalY * penetrationSpeed

  -- tangent component
  local tangentX = hspeed - penetrationX 
  local tangentY = vspeed - penetrationY

  -- restitution
  local restitution = 1 + math.max(self.bounce, instance.bounce or 0)

  -- friction
  local friction = math.min(self.friction, instance.friction or 0)

  -- change the velocity of shape a
  self.hspeed = hspeed - penetrationX * restitution + tangentX * friction
  self.vspeed = vspeed - penetrationY * restitution + tangentY * friction

  if penetrationSpeed <= 0 then 
    self.x = self.x + separationX
    self.y = self.y + separationY
  end
end

function Object:_applyVelocities()
  local dt = love.timer.getDelta()

  -- Apply forces that modify vspeed/hspeed
  self:_applyGravity()
  self:_applySpeed()

  self.x = self.x + self.hspeed * dt
  self.y = self.y + self.vspeed * dt
end

return Object