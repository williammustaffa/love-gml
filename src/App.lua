-- Global libraries
Tick = require 'core.libs.tick'
class = require 'core.libs.middleclass'
debugger = require 'core.libs.debugger'

-- Include helpers
require 'core.modules.graphics.utils'
require 'core.modules.table.utils'
require 'core.modules.math.utils'
require 'core.modules.string.utils'
require 'core.modules.type.utils'

-- Global entities
local Scene = require 'core.entities.Scene'

local App = class('App')

-- App:initialize:
-- Constructor method
function App:initialize()
  self.scenes = {}
  self.scene = false
  -- Fps control
  self.updatesPerSecond = 30
  self.ellapsed = 0

  self:addScene(require('src.scenes.DemoStage'))
  self:setScene('DemoStage')
end

function App:addScene(scene)
  print('[App:addScene] Added new scene: ' .. Scene.name)
  self.scenes[scene.name] = scene:new()
end

-- App:setScene:
-- Changes current scene based on its name
function App:setScene(sceneName)
  local nextScene = self.scenes[sceneName]

  if self.scene then
    self.scene:kill()
  end

  if nextScene then
    print('[App:setScene] Running scene: ' .. sceneName)
    self.scene = nextScene
    self.scene:init()
  else
    print('[App:setScene] Failed running scene: ' .. sceneName)
    self.scene = false
  end
end

-- App:update:
-- Call current scene update method
-- Also control updatesPerSecond using dt
function App:update(dt)
  local target = 1 / self.updatesPerSecond

  self.ellapsed = self.ellapsed + dt

  if self.ellapsed >= target then
    if self.scene and self.scene:isInstanceOf(Scene) then
      print('Update', dt);
      self.scene:update()
    end
    self.ellapsed = 0
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