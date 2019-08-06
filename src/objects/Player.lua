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

  -- Set this object as viewport target
  self.scene:setViewportTarget(self)
end

function Player:update(dt)
  Actor.update(self, dt)
  -- Player update
  self:applyCollision()

  -- Gravity
  if self:placeFree(self.x, self.y + 1) then
    self.gravity = 100
  else
    self.gravity = 0
    self.vspeed = 0
  end

  if love.keyboard.isDown('right') then
    if self:placeFree(self.x + 200 * dt, self.y) then
      self.hspeed = 200
    else
      self.hspeed = 0
      while self:placeFree(self.x + 0.1, self.y) do
        self.x = self.x + 0.1
      end
    end
  end

  if love.keyboard.isDown('left') then
    if self:placeFree(self.x - 200 * dt, self.y) then
      self.hspeed = -200
    else
      self.hspeed = 0
      while self:placeFree(self.x - 0.1, self.y) do
        self.x = self.x - 0.1
      end
    end
  end

  if not love.keyboard.isDown('right') and not love.keyboard.isDown('left') then
    self.hspeed = 0
  end

  if love.keyboard.isDown('up') and not self:placeFree(self.x, self.y + 1) then
    self.vspeed = -400
  end
end

function Player:draw(dt)
  Actor.draw(self)
  -- Player draw
  love.graphics.setColor(rgba(255, 165, 0))
  love.graphics.rectangle('line', self.x, self.y, self.width, self.height)
end

return Player