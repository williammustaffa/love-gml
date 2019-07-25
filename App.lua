local Room = require('scenes.Room')
local App = Object:extend()

-- new:
-- constructor method
function App:new()
  self.sceneIndex = 1
  self.scenes = {}

  self:addScene(Room)
  self:setScene(Room.name)
end

-- addScene:
-- add scenes as eligible scene
function App:addScene(scene)
  self.scenes[scene.name] = scene
end

-- setScene:
-- changes current scene based on its name
function App:setScene(sceneName)
  local nextScene = self.scenes[sceneName]

  if nextScene then
    print('Successfuly set scene up: ' .. sceneName)
    self.scene = nextScene
  else
    print('Error setting up scene: ' .. sceneName)
    self.scene = nil
  end
end

-- update
-- Call current scene update method
function App:update(dt)
  if self.scene then
    self.scene:update(dt)
  end
end

-- draw
-- Call current scene draw method
function App:draw()
  if self.scene then
    self.scene:draw()
  end
end

return App