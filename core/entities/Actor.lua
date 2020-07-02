-- File: Actor.lua
local Actor = class('entity.Actor')

function Actor:initialize(options)
  -- Actor creation
  -- TODO: create safe get function in helpers
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
  self.scene = options and options.scene or false
  self.dynamic = options and options.type or false
  self.bounce = options and options.bounce or 0
  self.friction = options and options.friction or 0
end

function Actor:checkCollision(x1, y1, w1, h1, x2, y2, w2, h2)
  return x1 < x2 + w2 and
         x2 < x1 + w1 and
         y1 < y2 + h2 and
         y2 < y1 + h1
end

function Actor:placeFree(x, y)
  local collision = false

  if self.scene then
    local instances = self.scene.instances

    local findCollision = function(instance)
      return instance.solid and instance.id ~= self.id and self:checkCollision(x, y, self.width, self.height, instance.x, instance.y, instance.width, instance.height)
    end

    collision = table.find(instances, findCollision)
  end

  return not Boolean(collision)
end

function Actor:applyGravity()
  self.vspeed = self.vspeed - self.gravity * math.sin(self.gravityDirection * math.pi / 180);
  self.hspeed = self.hspeed + self.gravity * math.cos(self.gravityDirection * math.pi / 180);
end

function Actor:applyDirectionalSpeed()
  self.vspeed = self.vspeed - self.speed * math.sin(self.direction * math.pi / 180)
  self.hspeed = self.hspeed + self.speed * math.cos(self.direction * math.pi / 180)
end

function Actor:calculateVelocities()
  -- Apply gravity
  self:applyGravity()
  self:applyDirectionalSpeed()
end


function Actor:handleCollision()
  if self.scene and self.dynamic == true then
    local instances = self.scene.instances

    local mapCollision = function(instance)
      if instance.id == self.id then
        return
      end

      local separationX, separationY = self:calculateSeparators(instance)

      if separationX and separationY then
        instance.color = {rgba(125, 116, 0)}
        print('Logging collision instance', instance)
        print('Logging collision separator X', separationX)
        print('Logging collision separator Y', separationY)
        self:resolveCollision(instance, separationX, separationY)
      else
        instance.color = {rgba(116, 125, 140)}
      end
    end

    table.map(instances, mapCollision)
  end
end

function Actor:calculateSeparators(instance)
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

function Actor:resolveCollision(instance, separationX, separationY)
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

  print('self.vspeed', self.vspeed)
  if penetrationSpeed <= 0 then 
    self.x = self.x + separationX
    self.y = self.y + separationY
  end
end

function Actor:applyVelocities()
  self.x = self.x + self.hspeed
  self.y = self.y + self.vspeed
end

function Actor:update()
  -- Actor update
end

function Actor:draw()
  -- Actor drawing
end

return Actor