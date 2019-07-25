-- File: Scene.lua
local Scene = class('entity.Scene')

function Scene:initialize()
  -- Scene creation
  self.objects = {}
  self.instances = {}
end

function Scene:placeObject(class, x, y)
  local objectData = {}

  objectData.instantiate = function () return class:new() end
  objectData.x = x
  objectData.y = y

  table.insert(self.objects, objectData)
end

function Scene:init()
  print('init')
  -- Reset table
  self.instances = {}

  -- Instantiate actors
  for index,object in ipairs(self.objects) do
    table.insert(self.instances, object.instantiate())
  end
end

function Scene:kill()
  self.instances = {}
end

function Scene:update(dt)
  -- Scene update
  print('Scene update')
  for index,instance in ipairs(self.instances) do
    instance:update(dt)
  end
end

function Scene:draw()
  -- Scene drawing
  for index,instance in ipairs(self.instances) do
    instance:draw()
  end
end

return Scene