local Sprite = require 'core.entities.Sprite'

local SampleSprite = Sprite:subclass('SampleSprite')

function SampleSprite:create()
  self.source = 'src/assets/images/sample-sprite.png'
  self.frameWidth = 74
  self.frameHeight = 86
end

return SampleSprite