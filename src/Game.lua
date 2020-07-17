
local App = LGML.Game('App')

-- App:initialize:
-- Constructor method
function App:create(options)
  self:add_room(require('src.rooms.DemoRoom'))
  self:set_room('DemoRoom')
end

return App