-- File: Actor.lua
local Actor = class('entity.Actor')

function Actor:initialize()
  -- Actor creation
  self.x = 20
  self.y = 20
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