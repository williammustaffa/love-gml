-- File: Scene.lua
local Camera = require('core.libs.Camera')

-- Create class
local Scene = class('entity.Scene')

-- Scene:initialize
-- Mostly like an constructor
function Scene:initialize()
  -- Scene creation
  self.objects = {}
  self.instances = {}
  self.viewports = {}
  self.viewport = false

  self:addViewport('default', {})
end

-- Scene:init
-- Start executing the room instances
function Scene:init()
  self:kill() -- Reset scene
  self:setViewport('default') -- Set default viewport
  self:createInstances() -- create instances
end

-- Scene:kill
-- Reset room data
function Scene:kill()
  self:resetViewport()
  self:destroyInstances()
end

-- Scene:addViewport
-- Add a viewport to the scene viewport list
function Scene:addViewport(name, options)
  if not self.viewports[name] then
    self.viewports[name] = Camera(unpack(options))
  else
    print('[Scene:addViewport] Viewport name already exists: ', name)
  end
end

-- Scene:resetViewport
-- Set viewport to its initial state
function Scene:resetViewport()
  self.viewport = false
end

-- Scene:setViewport
-- set current app viewport
function Scene:setViewport(name)
  local viewport = self.viewports[name]

  if viewport then
    self.viewport = viewport
  else
    print('[Scene:addViewport] Viewport not found: ', name)
    self:resetViewport()
  end
end

-- Scene:getViewport
-- Exposes viewport
function Scene:getViewport()
  return self.viewport
end

-- Scene:attachViewport
-- Execute attach method safely
function Scene:attachViewport()
  local viewport = self:getViewport()

  if viewport then viewport:attach() end
end

-- Scene:detachViewport
-- Execute detach method safely
function Scene:detachViewport()
  local viewport = self:getViewport()

  if viewport then viewport:detach() end
end

-- Scene:updateViewport
-- Execute update method safely
function Scene:updateViewport(dt)
  local viewport = self:getViewport()

  if viewport then viewport:update() end
end

-- Scene:drawViewport
-- Execute draw method safely
function Scene:drawViewport()
  local viewport = self:getViewport()

  if viewport then viewport:draw() end
end

-- Scene:placeObject
-- Place objects in room for giving coordinates
function Scene:placeObject(class, x, y)
  local data = {}
  data.createInstance = function ()
    return class:new({ x = x, y = y, scene = self })
  end
  table.insert(self.objects, data)
end

-- Scene:createInstances
-- Loop though all objects and instantiate them
function Scene:createInstances()
  -- Instantiate actors
  for index,object in ipairs(self.objects) do
    table.insert(self.instances, object.createInstance())
  end
end

-- Scene:destroy instances
-- Reset instances table
function Scene:destroyInstances()
  self.instances = {}
end

-- Scene:drawInstances
-- loop though instances and draw them
function Scene:drawInstances()
  for index,instance in ipairs(self.instances) do
    instance:draw()
  end
end

-- Scene:updateInstances
-- loop though instances and update them
function Scene:updateInstances(dt)
  -- Scene update
  for index,instance in ipairs(self.instances) do
    instance:update(dt)
  end
end

-- Scene:update
-- Update instances accordingly its update method
function Scene:update(dt)
  self:updateViewport(dt)
  self:updateInstances(dt)
end

-- Scene:draw
-- Update instances accordingly its draw method
function Scene:draw()
  local viewport = self:getViewport()

  -- Scene drawing
  if viewport then
    self:attachViewport()
    self:drawInstances()
    self:detachViewport()
    -- Added for library features support
    self:drawViewport()
  else
    -- Fallback
    self:drawInstances()
  end
end

return Scene