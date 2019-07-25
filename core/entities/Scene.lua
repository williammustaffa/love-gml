-- File: Scene.lua
local Scene = class('entity.Scene')

-- Scene:initialize
-- Mostly like an constructor
function Scene:initialize()
  -- Scene creation
  self.objects = {}
  self.instances = {}
end

-- Scene:placeObject
-- Place objects in room for giving coordinates
function Scene:placeObject(class, x, y)
  local objectData = {}
  local options = { x = x, y = y }

  objectData.instantiate = function ()
    return class:new(options)
  end

  table.insert(self.objects, objectData)
end

-- Scene:init
-- Start executing the room instances
function Scene:init()
  print('init')
  -- Reset table
  self.instances = {}

  -- Instantiate actors
  for index,object in ipairs(self.objects) do
    table.insert(self.instances, object.instantiate())
  end
end

-- Scene:kill
-- Remove all instances from room
function Scene:kill()
  self.instances = {}
end

-- Scene:update
-- Update instances accordingly its update method
function Scene:update(dt)
  -- Scene update
  for index,instance in ipairs(self.instances) do
    instance:update(dt)
  end
end

-- Scene:draw
-- Update instances accordingly its draw method
function Scene:draw()
  -- Scene drawing
  for index,instance in ipairs(self.instances) do
    instance:draw()
  end
end

return Scene