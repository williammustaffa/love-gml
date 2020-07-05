local Sprite = require 'core.entities.Sprite'

local SpriteRun = Sprite:subclass('SpriteRun')

function SpriteRun:create()
  self.source = 'src/assets/images/sprite-run.png'
  self.hFrames = 20
  self.vFrames = 1
  self.frameMap = { '1-20', 1 }
end

return SpriteRun:new()