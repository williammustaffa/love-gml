-- Global entities
local Room = require 'core.entities.Room'
local Game = class('entities.Game')

-- Register custom methods
function Game:create() end 
function Game:step() end 
function Game:draw() end 

-- Game:initialize:
-- Game constructor
function Game:initialize()
  self.rooms = {}
  self.room = false

  self:create()
end

-- Game:update:
function Game:runStep()
  if self.room and self.room:isInstanceOf(Room) then
    self.room:runStep()
  end
end

-- Game:draw:
-- Call current room draw method
function Game:runDraw()
  if self.room and self.room:isInstanceOf(Room) then
    self.room:runDraw()
  end

  self:draw()
end

function Game:addRoom(room)
  print('[App:addRoom] Added new room: ' .. room.name)
  self.rooms[room.name] = room:new()
end

-- Game:setRoom:
-- Changes current room based on its name
function Game:setRoom(roomName)
  local nextRoom = self.rooms[roomName]

  if self.room then
    self.room:kill()
  end

  if nextRoom then
    print('[Game:setRoom] Running room: ' .. roomName)
    self.room = nextRoom
    self.room:init()
  else
    print('[Game:setRoom] Failed running room: ' .. roomName)
    self.room = false
  end
end

return Game