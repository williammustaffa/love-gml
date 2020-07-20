
local room_0 = require('src.rooms.room_0')

local game = LGML.Game('game')

function game:setup()
  self:add_room(room_0)
end

return game