local room_0 = LGML.Room('room_0')

local o_player = require('src.objects.o_player')
local o_block = require('src.objects.o_block')

function room_0:setup()
  self.width = 960
  self.height = love.graphics.getHeight()

  -- Place player
  for x=0, self.width / 64 do
    self:place_object(o_block, x * 64, self.height - 64) 
  end

  -- Place floor
  for y=0, (self.height - 128) / 64 do
    for x=0, self.width / 64 do
      if math.random() > 0.8 then
        self:place_object(o_block, x * 64, y * 64) 
      end
    end
  end

  self:place_object(o_player, 0, 0)
end

return room_0