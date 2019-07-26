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