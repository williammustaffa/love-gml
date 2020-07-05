-- File: Sprite.lua
local Camera = require 'core.libs.Camera'
local anim8 = require 'core.libs.anim8'

local Sprite = class('entity.Sprite')

function Sprite:initialize()
  self:create()

  -- Sprite creation
  self.image = love.graphics.newImage(self.source)

  -- Grid variables
  self.imageWidth = self.image:getWidth()
  self.imageHeight = self.image:getHeight()
  self.frameWidth = math.floor(self.imageWidth / 20)
  self.frameHeight = math.floor(self.imageHeight / 1)
  self.left = 0
  self.top = 0
  self.border = 0

  
  print('imageHeight', typeOf(self.imageHeight), self.imageHeight)
  print('imageWidth', typeOf(self.imageWidth), self.imageWidth)
  print('frameHeight', typeOf(self.frameHeight), self.frameHeight)
  print('frameWidth', typeOf(self.frameWidth), self.frameWidth)

  -- Create grid
  local grid = anim8.newGrid(
    self.frameWidth,
    self.frameHeight,
    self.imageWidth,
    self.imageHeight,
    self.left,
    self.top,
    self.border
  )

  -- Animation variables
  self.frames = grid:getFrames(
    '1-20', 1
  )
  self.speed = 0.05
  self.onLoop = nil

  -- Generate animation from grid
  self.animation = anim8.newAnimation(self.frames, self.speed, self.onLoop)
end

function Sprite:runStep()
  local dt = love.timer.getDelta()
  self.animation:update(dt)
end

function Sprite:runDraw(instance)
  -- animation:draw(image, x,y, angle, scalex, scaley, offsetx, offsety, axisx, axisy)
  self.animation:draw(self.image, instance.x, instance.y, 0, 0.5, 0.5)
end

return Sprite