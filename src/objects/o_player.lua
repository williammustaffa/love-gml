local spr_idle = require('src.sprites.spr_idle')
local spr_run = require('src.sprites.spr_run')

local o_player = LGML.Object('o_player')

function o_player:create()
  self.solid = false
  self.gravity = 10
  self.gravity_direction = 270

  -- Sprites
  self.sprite_index = spr_idle
  self.image_xscale = 1
  self.image_yscale = 1
  self.height = 64
  self.width = 64

  -- Set this object as viewport target
  self.room:set_viewport_target(self)

  -- Set alarm
  self.alarm[0] = 5
  self.alarm[1] = 10
end

function o_player:alarm0()
  print("Alarm 0 triggered and looping")
  self.alarm[0] = 5
end

function o_player:alarm1()
  print("Alarm 1 triggered")
end

function o_player:step()
  -- Moving right
  if keyboard.isDown('right') then
    self.hspeed = 100
    self.image_xscale = 1
    self.sprite_index = spr_run
  end

  -- Moving left
  if keyboard.isDown('left') then
    self.hspeed = -100
    self.image_xscale = -1
    self.sprite_index = spr_run
  end

  -- Canceling hspeed
  if not keyboard.isDown('right') and not keyboard.isDown('left') then
    self.hspeed = 0
    self.sprite_index = spr_idle
  end

  if keyboard.isDown('up') and not self:place_free(self.x, self.y + 1) then
    self.vspeed = -350
  end
end

function o_player:draw()
  -- Draw event
end

return o_player