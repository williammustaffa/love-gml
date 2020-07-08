--Object information
local Object = require 'core.entities.Object'

-- Sample sprite
local SpriteRun = require 'src.sprites.SpriteRun'
local SpriteIdle = require 'src.sprites.SpriteIdle'

local Player = Object:subclass('Player')

function Player:create(options)
  self.solid = false
  self.gravity = 10
  self.gravity_direction = 270

  -- Sprites
  self.sprite_index = SpriteIdle
  -- self.image_xscale = 0.5
  -- self.image_yscale = 0.5
  self.height = 64 -- self.sprite_index._frame_height
  self.width = 32 -- self.sprite_index._frame_width

  -- Set this object as viewport target
  self.room:set_viewport_target(self)
end

function Player:step()
  -- Moving right
  if keyboard.isDown('right') then
    self.hspeed = 50
    -- self.image_xscale = 0.5
    self.sprite_index = SpriteRun
  end

  -- Moving left
  if keyboard.isDown('left') then
    self.hspeed = -50
    -- self.image_xscale = -0.5
    self.sprite_index = SpriteRun
  end

  -- Canceling hspeed
  if not keyboard.isDown('right') and not keyboard.isDown('left') then
    self.hspeed = 0
    self.sprite_index = SpriteIdle
  end

  if keyboard.isDown('up') and not self:place_free(self.x, self.y + 1) then
    self.vspeed = -250
  end
end

function Player:draw()
  -- Draw event
end

return Player