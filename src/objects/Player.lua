--Object information
local Object = require 'core.entities.Object'

-- Sample sprite
local SpriteRun = require 'src.sprites.SpriteRun'
local SpriteIdle = require 'src.sprites.SpriteIdle'

local Player = Object:subclass('Player')

function Player:create(options)
  self.x = love.graphics.getWidth() / 2 - 16
  self.y = 0
  self.height = 32
  self.width = 20
  self.speed = 0
  self.dynamic = true
  self.gravity = 10

  self.sprite = SpriteIdle
  self.xScale = 0.5
  self.yScale = 0.5

  -- Set this object as viewport target
  self.room:setViewportTarget(self)
end

function Player:step()
  -- Moving right
  if love.keyboard.isDown('right') and self:placeFree(self.x + 1, self.y) then
    self.hspeed = 50
    self.xScale = 0.5
    self.sprite = SpriteRun
  end

  -- Moving left
  if love.keyboard.isDown('left') and self:placeFree(self.x - 1, self.y) then
    self.hspeed = -50
    self.xScale = -0.5
    self.sprite = SpriteRun
  end

  -- Canceling hspeed
  if not love.keyboard.isDown('right') and not love.keyboard.isDown('left') then
    self.hspeed = 0
    self.sprite = SpriteIdle
  end

  if love.keyboard.isDown('up') and not self:placeFree(self.x, self.y + 1) then
    self.vspeed = -250
  end
end

function Player:draw()
  -- love.graphics.setColor(rgba(50, 50, 255))
  -- love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end

return Player