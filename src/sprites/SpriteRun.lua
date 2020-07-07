local Sprite = require 'core.entities.Sprite'

local SpriteRun = Sprite:subclass('SpriteRun')

function SpriteRun:create()
  self.source = 'src/assets/images/sprite-run.png'
  self.h_frames = 20
  self.v_frames = 1
  -- self.sprite_xoffset = self.sprite_width / 2
  -- self.sprite_yoffset = self.sprite_height / 2
  self.frame_map = { '1-20', 1 }
end

return SpriteRun:new()