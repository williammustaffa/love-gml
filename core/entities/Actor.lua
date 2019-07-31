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
  return x1 < x2 + w2 and
         x2 < x1 + w1 and
         y1 < y2 + h2 and
         y2 < y1 + h1
end

function Actor:placeFree(x, y)
  local hasPlaceFree = true

  if self.scene then
    local instances = self.scene.instances

    -- Check for collission
    for index,instance in ipairs(instances) do
      if instance.solid then
        if
          x < instance.x + instance.width and
          instance.x < x + self.width and
          y < instance.y + instance.height and
          instance.y < y + self.height
        then
          hasPlaceFree = false
          break
        end
      end
    end
  end

  return hasPlaceFree
end

function Actor:update(dt)
  -- Actor update
  self.x = self.x + self.hspeed * dt
  self.y = self.y + self.vspeed * dt
end

function Actor:draw()
  -- Actor drawing
end

return Actor