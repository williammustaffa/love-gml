-- File: Sprite.lua
local Camera = require 'core.libs.Camera'
local anim8 = require 'core.libs.anim8'

local Sprite = class('entity.Sprite')

function Sprite:initialize()
  self:create()

  -- Sprite creation
  self.image = love.graphics.newImage(self.source)

  -- Grid variables
  self._image_width = self.image:getWidth()
  self._image_height = self.image:getHeight()
  self._frame_width = math.floor(self._image_width / self.h_frames)
  self._frame_height = math.floor(self._image_height / self.v_frames)
  self.left = self.left or 0
  self.top = self.top or 0
  self.border = self.border or 0

  -- Create grid
  local grid = anim8.newGrid(
    self._frame_width,
    self._frame_height,
    self._image_width,
    self._image_height,
    self.left,
    self.top,
    self.border
  )

  -- Animation variables
  self.frames = grid:getFrames(unpack(self.frame_map))
  self.speed = 0.05
  self.onLoop = nil

  -- Generate animation from grid
  self.animation = anim8.newAnimation(self.frames, self.speed, self.onLoop)
end

function Sprite:_runStep()
  local dt = love.timer.getDelta()
  self.animation:update(dt)
end

function Sprite:_runDraw(instance)
  self.animation:draw(
    self.image, -- love image
    instance.x, -- x position
    instance.y, -- y position
    instance.image_angle, -- angle
    instance.image_xscale, -- x scale
    instance.image_yscale, -- y scale
    instance.sprite_xoffset, -- x offset
    instance.sprite_yoffset -- y offset
    -- axis x,
    -- axis y
  )
end

return Sprite