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
  self.width = 640
  self.height = 480

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

function Scene:getHeight()
  return math.max(self.height, love.graphics.getHeight())
end

function Scene:getWidth()
  return math.max(self.width, love.graphics.getWidth())
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
    print('[Scene:addViewport] Viewport set: ' .. name)
  else
    self:resetViewport()
    print('[Scene:addViewport] Viewport not found: ' .. name)
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

  if viewport then
    viewport:update(dt)

    -- Viewport target
    if self.viewportTarget then
      local xTarget = self.viewportTarget.x
      local yTarget = self.viewportTarget.y

      local sceneWidth = self:getWidth()
      local sceneHeight = self:getHeight()

      local halfScreenWidth = love.graphics.getWidth() / 2
      local halfScreenHeight = love.graphics.getHeight() / 2

      if xTarget < halfScreenWidth then
        xTarget = halfScreenWidth
      end

      if yTarget < halfScreenHeight then
        yTarget = halfScreenHeight
      end

      if xTarget > sceneWidth - halfScreenWidth then
        xTarget = sceneWidth - halfScreenWidth
      end

      if yTarget > sceneHeight - halfScreenHeight then
        yTarget = sceneHeight - halfScreenHeight
      end

      viewport:follow(xTarget, yTarget)
    end
  end
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
  local object = { class = class, x = x, y = y }

  table.insert(self.objects, object)

  print('[Scene:placeObject] New object registered: ' .. class.name)
end

-- Scene:setViewportTarget
-- Set instance to be followed by viewport
function Scene:setViewportTarget(instance)
  self.viewportTarget = instance
end

-- Scene:createInstanceFromObject
-- Create single instance from object item from objects array
function Scene:createInstance(class, x, y)
  local instance = class:new({ x = x, y = y, scene = self })

  table.insert(self.instances, instance)
end

-- Scene:createInstances
-- Loop though all objects and instantiate them
function Scene:createInstances()
  -- Instantiate actors
  map(self.objects, function(object) self:createInstance(object.class, object.x, object.y) end)

  print('[Scene:createIntances] Creating instances for: ' .. Scene.name)
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