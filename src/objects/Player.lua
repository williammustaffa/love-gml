-- Actor information
local Actor = require 'core.entities.Actor'

local Player = Actor:subclass('Player')

function Player:initialize(options)
  Actor.initialize(self, options)
  -- Player creation
  self.x = love.graphics.getWidth() / 2 - 16
  self.y = 0
  self.height = 32
  self.width = 32
  self.speed = 0
  self.dynamic = true

  -- Set this object as viewport target
  self.scene:setViewportTarget(self)
end

function Player:update()
  Actor.update(self)

  -- Gravity
  if self:placeFree(self.x, self.y + 1) then
    self.gravity = 1
  else
    self.gravity = 0
    self.vspeed = 0
  end

  -- Moving right
  if love.keyboard.isDown('right') then
    if self:placeFree(self.x + 1, self.y) then
      self.hspeed = 5
    end
  end

  -- Moving left
  if love.keyboard.isDown('left') then
    if self:placeFree(self.x - 1, self.y) then
      self.hspeed = -5
    end
  end

  -- Canceling hspeed
  if not love.keyboard.isDown('right') and not love.keyboard.isDown('left') then
    self.hspeed = 0
  end

  if love.keyboard.isDown('up') and not self:placeFree(self.x, self.y + 1) then
    self.vspeed = -10
  end
end

function Player:draw()
  Actor.draw(self)
  -- Player draw
  love.graphics.setColor(rgba(50, 50, 255))
  love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end

return Player