-- File: Actor.lua
local Actor = class('entity.Actor')

function Actor:initialize(options)
  -- Actor creation
  self.x = options and options.x or 0
  self.y = options and options.y or 0
  self.width = 100
  self.height = 100
end

function Actor:update(dt)
  -- Actor update
end

function Actor:draw()
  -- Actor drawing
end

return Actor