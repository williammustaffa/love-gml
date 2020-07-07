local Sprite = require 'core.entities.Sprite'

local SpriteIdle = Sprite:subclass('SpriteIdle')

function SpriteIdle:create()
  self.source = 'src/assets/images/sprite-idle.png'
  -- self.left = 5
  self.border = 0.6
  self.h_frames = 16
  self.v_frames = 1
  self.frame_map = { '1-16', 1 }
end

return SpriteIdle:new()