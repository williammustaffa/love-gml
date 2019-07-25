-- Global libraries
Tick = require 'libs.tick'
class = require 'libs.middleclass'
debugger = require 'libs.debugger'

-- Global entities
local Scene = require 'core.entities.Scene'

local App = class('App')

-- App:initialize:
-- Constructor method
function App:initialize()
  self.sceneIndex = 1
  self.scenes = {}
  self.scene = false

  self:addScene(require('scenes.DemoStage'))
  self:setScene('DemoStage')
end

function App:addScene(scene)
  self.scenes[scene.name] = scene:new()
end

-- App:setScene:
-- Changes current scene based on its name
function App:setScene(sceneName)
  local nextScene = self.scenes[sceneName]

  if nextScene then
    print('Successfuly set scene up: ' .. sceneName)
    self.scene = nextScene
    self.scene:init()
  else
    print('Scene <' .. sceneName .. '> not found.')
    self.scene = false
  end
end

-- App:update:
-- Call current scene update method
function App:update(dt)
  if self.scene and self.scene:isInstanceOf(Scene) then
    self.scene:update(dt)
  end
end

-- App:draw:
-- Call current scene draw method
function App:draw()
  if self.scene and self.scene:isInstanceOf(Scene) then
    self.scene:draw()
  end
end

return App