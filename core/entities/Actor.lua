-- File: Actor.lua
local Actor = class('entity.Actor')

function Actor:initialize(options)
  -- Actor creation
  -- TODO: create safe get function in helpers
  self.x = options and options.x or 0
  self.y = options and options.y or 0
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
end

function Actor:checkCollision(x1, y1, w1, h1, x2, y2, w2, h2)
  return math.round(x1) < math.round(x2) + w2 and
         math.round(x2) < math.round(x1) + w1 and
         math.round(y1) < math.round(y2) + h2 and
         math.round(y2) < math.round(y1) + h1
end

function Actor:placeFree(x, y)
  local hasPlaceFree = true

  if self.scene then
    local instances = self.scene.instances

    -- Check for collission
    for index,instance in ipairs(instances) do
      if instance.solid and instance.id ~= self.id then
        if self:checkCollision(x, y, self.width, self.height, instance.x, instance.y, instance.width, instance.height) then
          hasPlaceFree = false
          break
        end
      end
    end
  end

  return hasPlaceFree
end

function Actor:processCollision(dt)
  -- Normalize ground landing
  local nextX = self.x + self.hspeed * dt
  local nextY = self.y + self.vspeed * dt

  if not self:placeFree(self.x, nextY) then
    while self:placeFree(self.x, math.round(self.y) + math.sign(self.vspeed)) do
      self.y = math.round(self.y) + math.sign(self.vspeed)
    end

    self.vspeed = 0
  end

  if not self:placeFree(nextX, self.y) then
    while self:placeFree(math.round(self.x) + math.sign(self.hspeed), self.y) do
      self.x = math.round(self.x) + math.sign(self.hspeed)
    end

    self.hspeed = 0
  end
end

function Actor:processPhyshics(dt)
  -- Apply gravity
  self.vspeed = self.vspeed - self.gravity * math.sin(self.gravityDirection * math.pi / 180) * dt;
  self.hspeed = self.hspeed + self.gravity * math.cos(self.gravityDirection * math.pi / 180) * dt;
end

function Actor:applyPhysics(dt)
  -- Apply hspeed and vspeed
  self.x = self.x + self.hspeed * dt
  self.y = self.y + self.vspeed * dt

  -- Apply speed and direction
  self.y = self.y + self.speed * math.sin(self.direction * math.pi / 180);
  self.x = self.x + self.speed * math.cos(self.direction * math.pi / 180);
end

function Actor:update(dt)
  -- Actor update
end

function Actor:afterUpdate(dt)
  self:processPhyshics(dt)
  self:processCollision(dt)
  self:applyPhysics(dt)
end

function Actor:draw()
  -- Actor drawing
end

return Actor