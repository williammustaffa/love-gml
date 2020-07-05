-- File:Object.lua
local Object = class('entity.Object')

-- Register custom method
function Object:create() end
function Object:step() end
function Object:draw() end

-- Object:initialize
-- Object constructor
function Object:initialize(options)
  self.x = options and options.x or 0
  self.y = options and options.y or 0
  self.xOffset = options and options.xOffset or 0
  self.yOffset = options and options.yOffset or 0
  self.solid = options and options.solid or false
  self.speed = options and options.speed or 0
  self.vspeed = options and options.vspeed or 0
  self.hspeed = options and options.hspeed or 0
  self.gravity = options and options.gravity or 0
  self.gravityDirection = options and options.gravityDirection or 270
  self.xScale = options and options.xScale or 1
  self.yScale = options and options.yScale or 1
  self.direction = options and options.direction or 0
  self.width = options and options.width or 0
  self.height = options and options.height or 0
  self.room = options and options.room or false
  self.dynamic = options and options.type or false
  self.bounce = options and options.bounce or 0
  self.friction = options and options.friction or 0
  self.sprite = option and options.sprite or false

  self:create()
end


function Object:runStep()
  -- Object update
  if self.sprite then
    self.sprite:runStep()
  end

  self:step()
end

function Object:runDraw()
  if __conf__.debug == true then
    love.graphics.rectangle('line', self.x, self.y, self.width, self.height)
  end

  -- Object drawing
  if self.sprite then
    self.sprite:runDraw(self)
  end

  self:draw()
end

function Object:checkCollision(x1, y1, w1, h1, x2, y2, w2, h2)
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
      return instance.solid and instance.id ~= self.id and self:checkCollision(x, y, self.width, self.height, instance.x, instance.y, instance.width, instance.height)
    end

    collision = table.find(instances, findCollision)
  end

  return not toBoolean(collision)
end

function Object:applyGravity()
  local radians = math.rad(self.gravityDirection)
  local vacceleration = self.gravity * math.sin(radians);
  local hacceleration = self.gravity * math.cos(radians);

  self.vspeed = self.vspeed - vacceleration
  self.hspeed = self.hspeed + hacceleration
end

function Object:ApplySpeed()
  local radians = math.rad(self.direction)
  local vacceleration = self.speed * math.sin(radians);
  local hacceleration = self.speed * math.cos(radians);

  self.vspeed = self.vspeed - vacceleration
  self.hspeed = self.hspeed + hacceleration
end

function Object:handleCollision()
  if self.room and self.dynamic == true then
    local instances = self.room.instances

    local mapCollision = function(instance)
      if instance.id == self.id then
        return
      end

      local separationX, separationY = self:calculateSeparators(instance)

      if separationX and separationY then
        self:resolveCollision(instance, separationX, separationY)
      end
    end

    table.map(instances, mapCollision)
  end
end

function Object:calculateSeparators(instance)
  -- distance between the rects
  local distanceX = self.x - instance.x
  local distanceY = self.y - instance.y

  local absDistanceX = math.abs(distanceX)
  local absDistanceY = math.abs(distanceY)

  -- sum of the extents
  local sumHalfWidth = self.width / 2 + instance.width / 2
  local sumHalfHeight = self.height / 2 + instance.height / 2

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

function Object:resolveCollision(instance, separationX, separationY)
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

function Object:applyVelocities()
  local dt = love.timer.getDelta()

  -- Apply forces that modify vspeed/hspeed
  self:applyGravity()
  self:ApplySpeed()

  self.x = self.x + self.hspeed * dt
  self.y = self.y + self.vspeed * dt
end

return Object