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
  self.speed = 0
  self.gravity = 10
  self.gravityDirection = 270
end

function Player:update(dt)
  Actor.update(self, dt)
  -- Player update
  self:applyCollision()

  if love.keyboard.isDown('right') and self:placeFree(self.x + self.speed * dt, self.y) then
    self.x = self.x + 200 * dt
  end

  if love.keyboard.isDown('left') and self:placeFree(self.x - self.speed * dt, self.y) then
    self.x = self.x - 200 * dt
  end

  if love.keyboard.isDown('up') and not self:placeFree(self.x, self.y + 1) then
    self.vspeed = -400 * dt
  end
end

function Player:draw(dt)
  Actor.draw(self)
  -- Player draw
  love.graphics.setColor(rgba(255, 165, 0))
  love.graphics.rectangle('line', self.x, self.y, self.width, self.height)
end

return Player