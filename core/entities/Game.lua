local class = require('core.libs.middleclass')
local Room  = require('core.entities.Room')
local Game  = class('entities.Game')

-- Game constructor
function Game:initialize()
  self.rooms = {}
  self.room = false

  self:__create()
end

function Game:__create()
  if type(self.create) == 'function' then
    self:create()
  end
end

-- Game:update:
function Game:__step()
  if self.room and self.room:isInstanceOf(Room) then
    self.room:__step()
  end
end

-- Game:draw:
-- Call current room draw method
function Game:__draw()
  if self.room and self.room:isInstanceOf(Room) then
    self.room:__draw()
  end
end

function Game:add_room(room)
  print('[App:add_room] Added new room: ' .. room.name)
  self.rooms[room.name] = room:new()
end

-- Game:set_room:
-- Changes current room based on its name
function Game:set_room(roomName)
  local nextRoom = self.rooms[roomName]

  if self.room then
    self.room:kill()
  end

  if nextRoom then
    print('[Game:set_room] Running room: ' .. roomName)
    self.room = nextRoom
    self.room:init()
  else
    print('[Game:set_room] Failed running room: ' .. roomName)
    self.room = false
  end
end

return Game