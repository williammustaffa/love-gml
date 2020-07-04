-- Global entities
local Room = require 'core.entities.Room'
local Game = class('entities.Game')

-- Game:initialize:
-- Constructor method
function Game:initialize()
  self.rooms = {}
  self.room = false
end

function Game:addRoom(room)
  print('[App:addRoom] Added new room: ' .. Room.name)
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

-- Game:update:
function Game:update()
  if self.room and self.room:isInstanceOf(Room) then
    self.room:update()
  end
end

-- Game:draw:
-- Call current room draw method
function Game:draw()
  if self.room and self.room:isInstanceOf(Room) then
    self.room:draw()
  end
end

return Game