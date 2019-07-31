-- Room information
-- here we will create the room information
-- place objects, set backgrounds and tilesets

-- Important to set the subclass name as it will be used in the scene navigation
local Scene = require 'core.entities.Scene'
local Player = require 'src.objects.Player'
local Block = require 'src.objects.Block'

local Stage = Scene:subclass('DemoStage')

function Stage:initialize()
  Scene.initialize(self)

  self.canFlash = true
  self:placeObject(Player, 0, 0)

  -- Place floor
  for x=0,love.graphics.getWidth() / 32 do
    self:placeObject(Block, x * 32, love.graphics.getHeight() - 32) 
  end
end

function Stage:update(dt)
  Scene.update(self, dt)
  -- we can place global configuration here
  -- such as dynamic viewports, backgrounds, tilesets
  if self.canFlash and love.keyboard.isDown('return') then
    self:getViewport():flash(0.05, {0, 0, 0, 1})
    self.canFlash = false
  end
end

return Stage