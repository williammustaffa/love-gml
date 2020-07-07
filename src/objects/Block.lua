--Object information
local Object = require 'core.entities.Object'

local Block = Object:subclass('Block')

function Block:create(options)
  -- Block creation
  self.solid = true
  self.height = 32
  self.width = 32
end

function Block:step()
  -- Block update
end

function Block:draw()
  -- Block draw
  love.graphics.setColor(rgba(100, 100, 100))
  love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
  love.graphics.setColor(rgba(255, 255, 255, 255))
end

return Block