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
  self:placeObject(Player, 2, 2)
  self:placeObject(Player, 3, 3)
  self:placeObject(Player, 4, 0)
end

function Stage:update(dt)
  Scene.update(self)
end

function Stage:draw()
  Scene.draw(self)
end

return Stage