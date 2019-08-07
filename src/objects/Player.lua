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

  -- Gravity
  if self:placeFree(self.x, self.y + 1) then
    self.gravity = 400
  else
    self.gravity = 0
    self.vspeed = 0
  end

  if love.keyboard.isDown('right') then
    if self:placeFree(self.x + 200 * dt, self.y) then
      self.hspeed = 200
    end
  end

  if love.keyboard.isDown('left') then
    if self:placeFree(self.x - 200 * dt, self.y) then
      self.hspeed = -200
    end
  end

  if not love.keyboard.isDown('right') and not love.keyboard.isDown('left') then
    self.hspeed = 0
  end

  if love.keyboard.isDown('up') and not self:placeFree(self.x, self.y + 1) then
    self.vspeed = -200
  end
end

function Player:draw()
  Actor.draw(self)
  -- Player draw
  local dt = love.timer.getDelta()
  love.graphics.setColor(rgba(255, 165, 0))
  love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
  love.graphics.setColor(rgba(100, 100, 255))
  love.graphics.rectangle('line', self.x + self.hspeed * dt, self.y + self.vspeed * dt, self.width, self.height)
end

return Player