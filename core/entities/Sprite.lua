-- File: Sprite.lua
local Camera = require 'core.libs.Camera'
local anim8 = require 'core.libs.anim8'

local Sprite = class('entity.Sprite')

function Sprite:initialize()
  self:create()

  -- Sprite creation
  self.image = love.graphics.newImage(self.source)

  -- Create grid
  local grid = anim8.newGrid(
    self.frameWidth,
    self.frameHeight,
    self.image:getWidth(),
    self.image:getHeight()
  )

  -- Generate animation from grid
  self.animation = anim8.newAnimation(
    grid:getFrames('1-7', '1-4'),
    0.1
  )
end

function Sprite:runStep()
  local dt = love.timer.getDelta()
  self.animation:update(dt)
end

function Sprite:runDraw()
  -- animation:draw(image, x,y, angle, sx, sy, ox, oy, kx, ky)
  self.animation:draw(self.image, self.frameWidth, self.frameHeight)
end

return Sprite