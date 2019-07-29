-- Actor information
local Actor = require 'core.entities.Actor'

local Player = Actor:subclass('Player')

function Player:initialize(options)
  Actor.initialize(self, options)
  -- Player creation
  self.x = love.graphics.getWidth() / 2 - 16
  self.y = love.graphics.getHeight() / 2 - 16
  self.height = 32
  self.width = 32
  self.speed = 200
end

function Player:update(dt)
  Actor.update(self, dt)
  -- Player update
  if love.keyboard.isDown('right') then
    self.x = self.x + self.speed * dt
  end

  if love.keyboard.isDown('left') then
    self.x = self.x - self.speed * dt
  end

  if love.keyboard.isDown('up') then
    self.y = self.y - self.speed * dt
  end

  if love.keyboard.isDown('down') then
    self.y = self.y + self.speed * dt
  end
end

function Player:draw(dt)
  Actor.draw(self)
  -- Player draw
  love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end

return Player