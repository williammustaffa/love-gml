-- File: Room.lua
local Camera = require'core.libs.Camera'

-- Create class
local Room = class('entity.Room')

-- Register custom method
function Room:create() print('room create') end
function Room:step() end
function Room:draw() end

-- Room:initialize
-- Room constructor
function Room:initialize()
  -- Room creation
  self.objects = {}
  self.instances = {}
  self.viewports = {}
  self.viewport = false
  self.width = 640
  self.height = 480

  self:addViewport('default', {})
  self:create()
end

-- Room:update
-- Update instances accordingly its update method
function Room:runStep()
  self:updateViewport()
  self:updateInstances()

  -- Call custom method
  self:step()
end

-- Room:draw
-- Update instances accordingly its draw method
function Room:runDraw()
  local viewport = self:getViewport()

  -- Room drawing
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

  self:draw()
end

-- Room:init
-- Start executing the room instances
function Room:init()
  self:kill() -- Reset room
  self:setViewport('default') -- Set default viewport
  self:createInstances() -- create instances
end

-- Room:kill
-- Reset room data
function Room:kill()
  self:resetViewport()
  self:destroyInstances()
end

function Room:getHeight()
  return math.max(self.height, love.graphics.getHeight())
end

function Room:getWidth()
  return math.max(self.width, love.graphics.getWidth())
end

-- Room:addViewport
-- Add a viewport to the room viewport list
function Room:addViewport(name, options)
  if not self.viewports[name] then
    self.viewports[name] = Camera(unpack(options))
  else
    print('[Room:addViewport] Viewport already added: ', name)
  end
end

-- Room:resetViewport
-- Set viewport to its initial state
function Room:resetViewport()
  self.viewport = false
end

-- Room:setViewport
-- set current app viewport
function Room:setViewport(name)
  local viewport = self.viewports[name]

  if viewport then
    self.viewport = viewport
    print('[Room:addViewport] Viewport set: ' .. name)
  else
    self:resetViewport()
    print('[Room:addViewport] Viewport not found: ' .. name)
  end
end

-- Room:getViewport
-- Exposes viewport
function Room:getViewport()
  return self.viewport
end

-- Room:attachViewport
-- Execute attach method safely
function Room:attachViewport()
  local viewport = self:getViewport()

  if viewport then viewport:attach() end
end

-- Room:detachViewport
-- Execute detach method safely
function Room:detachViewport()
  local viewport = self:getViewport()

  if viewport then viewport:detach() end
end

-- Room:updateViewport
-- Execute update method safely
function Room:updateViewport()
  local dt = love.timer.getDelta()
  local viewport = self:getViewport()

  if viewport then
    viewport:update(dt)

    -- Viewport target
    if self.viewportTarget then
      local xTarget = self.viewportTarget.x
      local yTarget = self.viewportTarget.y

      local roomWidth = self:getWidth()
      local roomHeight = self:getHeight()

      local halfScreenWidth = love.graphics.getWidth() / 2
      local halfScreenHeight = love.graphics.getHeight() / 2

      if xTarget < halfScreenWidth then
        xTarget = halfScreenWidth
      end

      if yTarget < halfScreenHeight then
        yTarget = halfScreenHeight
      end

      if xTarget > roomWidth - halfScreenWidth then
        xTarget = roomWidth - halfScreenWidth
      end

      if yTarget > roomHeight - halfScreenHeight then
        yTarget = roomHeight - halfScreenHeight
      end

      viewport:follow(xTarget, yTarget)
    end
  end
end

-- Room:drawViewport
-- Execute draw method safely
function Room:drawViewport()
  local viewport = self:getViewport()

  if viewport then viewport:draw() end
end

-- Room:placeObject
-- Place objects in room for giving coordinates
function Room:placeObject(class, x, y)
  local object = { class = class, x = x, y = y }

  table.insert(self.objects, object)
end

-- Room:setViewportTarget
-- Set instance to be followed by viewport
function Room:setViewportTarget(instance)
  self.viewportTarget = instance
end

-- Room:createInstanceFromObject
-- Create single instance from object item from objects array
function Room:createInstance(class, x, y)
  local instance = class:new({ x = x, y = y, room = self })
  local id = #self.instances + 1

  instance.id = id

  self.instances[id] = instance
end

-- Room:createInstances
-- Loop though all objects and instantiate them
function Room:createInstances()
  -- Instantiate objects
  table.map(
    self.objects,
    function(object) self:createInstance(object.class, object.x, object.y) end
  )

  print('[Room:createIntances] Creating instances for: ' .. Room.name)
end

-- Room:destroy instances
-- Reset instances table
function Room:destroyInstances()
  self.instances = {}
end

-- Room:drawInstances
-- loop though instances and draw them
function Room:drawInstances()
  table.map(
    self.instances,
    function(instance) 
      instance:runDraw()
    end
  )
end

-- Room:updateInstances
-- loop though instances and update them
function Room:updateInstances()
  -- Room update
  -- Update positions
  table.map(
    self.instances,
    function(instance)
      instance:runStep()
      instance:applyVelocities()
    end
  )

  -- handle intersected objects
  table.map(
    self.instances,
    function(instance)
      instance:handleCollision()
    end
  )
end

return Room