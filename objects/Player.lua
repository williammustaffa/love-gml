-- Actor information
-- here we will create all the actor information and actions

local Player = Actor:extend()

function Player:new()
  -- Player creation
end

function Player:update(dt)
  -- Player update
  self.x = self.x + 1;
end

function Player:update(dt)
  -- Player update
  -- Testing actor drawing
  love.graphics.rectangle("line", self.x, self.y, self.width, self.height)
end

return Player