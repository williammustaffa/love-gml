
--Object information
local Game = require 'core.entities.Game'

local App = Game:subclass('App')

-- App:initialize:
-- Constructor method
function App:create(options)
  self:add_room(require('src.rooms.DemoRoom'))
  self:set_room('DemoRoom')
end

return App