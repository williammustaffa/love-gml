local Sprite = require 'core.entities.Sprite'

local SpriteIdle = Sprite:subclass('SpriteIdle')

function SpriteIdle:create()
  self.source = 'src/assets/images/sprite-idle.png'
  -- self.left = 5
  self.border = 0.6
  self.hFrames = 16
  self.vFrames = 1
  self.frameMap = { '1-16', 1 }
end

return SpriteIdle:new()