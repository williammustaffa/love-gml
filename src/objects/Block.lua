--Object information
local Object = require 'core.entities.Object'

local Block = Object:subclass('Block')

function Block:initialize(options)
 Object.initialize(self, options)
  -- Block creation
  self.solid = true
  self.height = 32
  self.width = 32
  self.color = {rgba(116, 125, 140)}
  self.bounce = 0
  self.friction = 0
end

function Block:update()
 Object.update(self)
  -- Block update
end

function Block:draw()
 Object.draw(self)
  -- Block draw
  love.graphics.setColor(unpack(self.color))
  love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end

return Block