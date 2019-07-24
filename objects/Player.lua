-- Actor information
-- here we will create all the actor information and actions

Player = Scene:extend()

function Player:new()
  -- Player creation
end

function Player:update(dt)
  -- Player update
  -- Testing actor drawing
  love.graphics.rectangle("line", self.x, self.y, self.width, self.height)
end