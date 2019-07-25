-- Room information
-- here we will create the room information
-- place objects, set backgrounds and tilesets
-- Player = require('objects.Player')

-- Important to set the subclass name as it will be used in the scene navigation
local Scene = require 'core.entities.Scene'
local Player = require 'objects.Player'

local Stage = Scene:subclass('DemoStage')

function Stage:initialize()
  Scene.initialize(self)

  self:placeObject(Player, 0, 0)
  self:placeObject(Player, 0, 25)
  self:placeObject(Player, 0, 50)
  self:placeObject(Player, 0, 75)
end

return Stage