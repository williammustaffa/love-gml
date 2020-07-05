local Sprite = require 'core.entities.Sprite'

local SampleSprite = Sprite:subclass('SampleSprite')

function SampleSprite:create()
  self.source = 'src/assets/images/sample-sprite.png'
end

return SampleSprite