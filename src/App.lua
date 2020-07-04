
--Object information
local Game = require 'core.entities.Game'

local App = Game:subclass('App')

-- App:initialize:
-- Constructor method
function App:initialize(options)
  Game.initialize(self, options)

  self:addRoom(require('src.rooms.DemoRoom'))
  self:setRoom('DemoRoom')
end

return App