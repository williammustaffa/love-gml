-- Actor information
local Actor = require 'core.entities.Actor'

local Player = Actor:subclass('Player')

function Player:initialize(options)
  Actor.initialize(self, options)
  -- Player creation
  self.height = 32
  self.width = 32
  self.speed = 200
end

function Player:update(dt)
  Actor.update(self, dt)
  -- Player update

  -- Gravity
  if self:placeFree(self.x, self.y + self.vspeed + 2 * dt) then
    self.vspeed = self.vspeed + 5 * dt
  else
    self.vspeed = 0
  end

  -- Normalize ground landing
  while not self:placeFree(self.x, self.y) do
    self.y = self.y - 0.5
  end

  if love.keyboard.isDown('right') and self:placeFree(self.x + self.speed * dt, self.y) then
    self.x = self.x + self.speed * dt
  end

  if love.keyboard.isDown('left') and self:placeFree(self.x - self.speed * dt, self.y) then
    self.x = self.x - self.speed * dt
  end

  if love.keyboard.isDown('up') and self:placeFree(self.x, self.y - self.speed * dt) then
    self.vspeed = -150 * dt
  end
end

function Player:draw(dt)
  Actor.draw(self)
  -- Player draw
  love.graphics.setColor(rgba(255, 165, 0))
  love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end

return Player