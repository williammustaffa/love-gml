-- File: Sprite.lua
local Camera = require 'core.libs.Camera'
local anim8 = require 'core.libs.anim8'

local Sprite = class('entity.Sprite')

function Sprite:initialize()
  -- Initial variables
  self.frame_width = 0
  self.frame_height = 0
  self.frame_xoffset = 0
  self.frame_yoffset = 0
  self.frame_border = 0

  -- Call definitions
  self:setup()

  -- Load image
  self.image = love.graphics.newImage(self.source)

  if typeOf(self.image_height) ~= 'number' then
    self.image_height = self.image:getHeight()
  end

  if typeOf(self.image_width) ~= 'number' then
    self.image_width = self.image:getWidth()
  end

  if __conf__.debug == true then
    print("Loaded image ", self.source, self.image_width .. 'x' .. self.image_height)
  end

  -- Create grid
  local grid = anim8.newGrid(
    self.frame_width,
    self.frame_height,
    self.image_width,
    self.image_height,
    0,
    0,
    self.frame_border
  )

  -- Animation variables
  self.frames = grid:getFrames(unpack(self.grid_map))
  self.speed = 0.05
  self.onLoop = nil

  -- Generate animation from grid
  self.animation = anim8.newAnimation(self.frames, self.speed, self.onLoop)

end

function Sprite:__step(instance)
  local dt = love.timer.getDelta()
  self.animation:update(dt)
end

function Sprite:__draw(instance)
  local xoffset = self.frame_xoffset + instance.sprite_xoffset
  local yoffset = self.frame_yoffset + instance.sprite_yoffset

  self.animation:draw(
    self.image, -- love image
    instance.x + xoffset, -- x position
    instance.y + yoffset, -- y position
    instance.image_angle, -- angle
    instance.image_xscale, -- x scale
    instance.image_yscale, -- y scale
    xoffset, -- x offset
    yoffset -- y offset
  )
end

return Sprite