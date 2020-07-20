local class  = require('core.libs.middleclass')
local Camera = require'core.libs.Camera'
local Object = require'core.entities.Object'

-- Create class
local Room = class('entity.Room')

-- Room:initialize
-- Room constructor
function Room:initialize()
  -- Room creation
  self.objects = {}
  self.instances = {}
  self.viewports = {}
  self.viewport = false
  self.viewport_target = false
  self.width = 640
  self.height = 480

  self:add_viewport('default', {})

  -- Execute setup
  if type(self.setup) == 'function' then
    self:setup()
  end
end

-- Room:update
-- Update instances accordingly its update method
function Room:__step()
  self:__update_viewport()
  self:__update_instances()

  if type(self.step) == 'function' then
    self:step()
  end
end

-- Room:draw
-- Update instances accordingly its draw method
function Room:__draw()
  -- Room drawing
  if self.viewport then
    self.viewport:attach()

    -- Draw inside viewport
    self:__draw_instances()

    if type(self.draw) == 'function' then
      self:draw()
    end

    self.viewport:detach()

    -- Added for library features support
    self.viewport:draw()
  else
    -- Fallback
    self:__draw_instances()
  end
end

-- Room:init
-- Start executing the room instances
function Room:init()
  self:kill() -- Reset room
  self:set_viewport('default') -- Set default viewport
  self:__create_instances() -- create instances
end

-- Room:kill
-- Reset room data
function Room:kill()
  self:__reset_viewport()
  self:__destroy_instances()
end

function Room:get_height()
  return math.max(self.height, love.graphics.getHeight())
end

function Room:get_width()
  return math.max(self.width, love.graphics.getWidth())
end

-- Room:add_viewport
-- Add a viewport to the room viewport list
function Room:add_viewport(name, options)
  if not self.viewports[name] then
    self.viewports[name] = Camera(unpack(options))
  else
    print('[Room:add_viewport] Viewport already added: ', name)
  end
end

-- Room:__reset_viewport
-- Set viewport to its initial state
function Room:__reset_viewport()
  self.viewport = false
end

-- Room:set_viewport
-- set current app viewport
function Room:set_viewport(name)
  local viewport = self.viewports[name]

  if viewport then
    self.viewport = viewport
    print('[Room:add_viewport] Viewport set: ' .. name)
  else
    self:__reset_viewport()
    print('[Room:add_viewport] Viewport not found: ' .. name)
  end
end

-- Room:getViewport
-- Exposes viewport
function Room:getViewport()
  return self.viewport
end

-- Room:__update_viewport
-- Execute update method safely
function Room:__update_viewport()
  local dt = love.timer.getDelta()

  if self.viewport then
    self.viewport:update(dt)

    if self.viewport_target then
        -- Viewport target
      local xTarget = self.viewport_target.x
      local yTarget = self.viewport_target.y

      local roomWidth = self:get_width()
      local roomHeight = self:get_height()

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

      xTarget = math.round(xTarget)
      yTarget = math.round(yTarget)

      self.viewport:follow(xTarget, yTarget)
    end
  end
end

-- Room:place_object
-- Place objects in room for giving coordinates
function Room:place_object(ObjDefinition, x, y)
  if ObjDefinition and ObjDefinition:isSubclassOf(Object) then
    table.insert(self.objects, { ObjDefinition, x, y })
  else
    print('Object is not instance of Object')
  end
end

-- Room:set_viewport_target
-- Set instance to be followed by viewport
function Room:set_viewport_target(instance)
  self.viewport_target = instance
end

-- Room:create_instanceFromObject
-- Create single instance from object item from objects array
function Room:create_instance(ObjDefinition, x, y)
  if ObjDefinition and ObjDefinition:isSubclassOf(Object) then
    local ninstances = table.getn(self.instances)
    local id = ninstances + 1000

    local instance = ObjDefinition:new({
      id = id,
      x = x,
      y = y,
      room = self
    })

    table.insert(self.instances, instance)
  end
end

-- Room:__create_instances
-- Loop though all objects and instantiate them
function Room:__create_instances()
  for index, object in ipairs(self.objects) do
    self:create_instance(unpack(object))
  end

  print('[Room:createIntances] Creating instances for: ' .. Room.name)
end

-- Room:destroy instances
-- Reset instances table
function Room:__destroy_instances()
  for index in pairs(self.instances) do
    self.instances[index] = nil
  end
end

-- Depth sorting method
function depth_sorter(t, a, b)
  return t[b].depth < t[a].depth
end

-- Room:__draw_instances
-- loop though instances and draw them
function Room:__draw_instances()
  for index, instance in spairs(self.instances, depth_sorter) do
    instance:__draw()
  end
end

-- Room:__update_instances
-- loop though instances and update them
function Room:__update_instances()
  for index, instance in ipairs(self.instances) do
    instance:__step()
  end
  for index, instance in ipairs(self.instances) do
    instance:__handle_collision()
  end
end

return Room