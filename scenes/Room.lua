-- Room information
-- here we will create the room information
-- place objects, set backgrounds and tilesets
-- Player = require('objects.Player')

Room = Scene:extend()

-- Important to set name for transition purposes
Room.name = "demoRoom"


function Room:new()
  Room.super:new()

  self:placeObject(Player, 0, 0)
  self:placeObject(Player, 2, 2)
  self:placeObject(Player, 3, 3)
  self:placeObject(Player, 4, 0)
end

function Room:update(dt)
  -- print('update scene')
  Room.super:update(dt)
end

function Room:draw()
  Room.super:draw()
end

return Room