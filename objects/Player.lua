-- Actor information
-- here we will create all the actor information and actions
local Actor = require 'core.entities.Actor'

local Player = Actor:subclass('Player')

function Player:initialize()
  Actor.initialize(self)
  -- Player creation
end

function Player:update(dt)
  Actor.update(self)
  -- Player update
  self.x = self.x + 1;
end

function Player:draw(dt)
  Actor.draw(self)
  -- Player update
  -- Testing actor drawing
  love.graphics.rectangle("line", self.x, self.y, self.width, self.height)
end

return Player