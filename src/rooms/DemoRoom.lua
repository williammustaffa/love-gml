local DemoRoom = LGML.Room('DemoRoom')

local Player = require('src.objects.Player')
local Block = require('src.objects.Block')

function DemoRoom:create()
  self.width = 960
  self.height = love.graphics.getHeight()

  -- Place player
  for x=0, self.width / 64 do
    self:place_object(Block, x * 64, self.height - 64) 
  end

  -- Place floor
  for y=0, (self.height - 128) / 64 do
    for x=0, self.width / 64 do
      if math.random() > 0.8 then
        self:place_object(Block, x * 64, y * 64) 
      end
    end
  end

  self:place_object(Player, 0, 0)
end

return DemoRoom