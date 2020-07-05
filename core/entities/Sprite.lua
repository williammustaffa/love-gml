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
  self.frameWidth = math.floor(self.imageWidth / self.hFrames)
  self.frameHeight = math.floor(self.imageHeight / self.vFrames)
  self.left = self.left or 0
  self.top = self.top or 0
  self.border = self.border or 0

  print ('source', self.source)
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
  self.frames = grid:getFrames(unpack(self.frameMap))
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
  self.animation:draw(
    self.image, -- love image
    instance.x + instance.width / 2, -- x position
    instance.y + instance.height / 2, -- y position
    0, -- angle
    instance.xScale, -- x scale
    instance.yScale, -- y scale
    self.frameWidth / 2, -- x offset
    self.frameHeight / 2 -- y offset, axis x, axis y
  )
end

return Sprite