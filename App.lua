-- Global libraries
Tick = require 'libs.tick'
class = require 'libs.middleclass'
debugger = require 'libs.debugger'

-- Global entities
local Scene = require 'core.entities.Scene'

local App = class('App')

-- new:
-- Constructor method
function App:initialize()
  self.sceneIndex = 1
  self.scenes = {}
  self.scene = false

  -- Scenes
  self:addScene(require('scenes.DemoStage'))
  -- Select scene by the class name
  self:setScene('DemoStage')
end

-- addScene:
-- Add scenes as eligible scene
function App:addScene(scene)
  self.scenes[scene.name] = scene:new()
end

-- setScene:
-- Changes current scene based on its name
function App:setScene(sceneName)
  local nextScene = self.scenes[sceneName]

  if nextScene then
    print('Successfuly set scene up: ' .. sceneName)
    self.scene = nextScene
  else
    print('Error setting up scene: ' .. sceneName)
    self.scene = false
  end
end

-- update
-- Call current scene update method
function App:update(dt)
  if self.scene and self.scene:isInstanceOf(Scene) then
    self.scene:update(dt)
  end
end

-- draw
-- Call current scene draw method
function App:draw()
  if self.scene and self.scene:isInstanceOf(Scene) then
    self.scene:draw()
  end
end

return App