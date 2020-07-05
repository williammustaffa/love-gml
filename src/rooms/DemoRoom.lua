-- Room information
-- here we will create the room information
-- place objects, set backgrounds and tilesets

-- Important to set the subclass name as it will be used in the room navigation
local Room = require 'core.entities.Room'
local Player = require 'src.objects.Player'
local Block = require 'src.objects.Block'

local DemoRoom = Room:subclass('DemoRoom')

function DemoRoom:create()
  self.width = 960
  self:placeObject(Player, 0, 0)

  -- Place player
  for x=0, love.graphics.getWidth() * 2 / 32 do
    self:placeObject(Block, x * 32, love.graphics.getHeight() - 32) 
  end

  -- Place floor
  for y=0, (love.graphics.getHeight() - 64) / 32 do
    for x=0, love.graphics.getWidth() * 2 / 32 do
      if math.random() > 0.8 then
        self:placeObject(Block, x * 32, y * 32) 
      end
    end
  end
end

return DemoRoom