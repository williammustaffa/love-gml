-- Actor information
local Actor = require 'core.entities.Actor'

local Block = Actor:subclass('Block')

function Block:initialize(options)
  Actor.initialize(self, options)
  -- Block creation
  self.solid = true
  self.height = 32
  self.width = 32
  self.color = {rgba(116, 125, 140)}
  self.bounce = 1
end

function Block:update(dt)
  Actor.update(self, dt)
  -- Block update
end

function Block:draw(dt)
  Actor.draw(self)
  -- Block draw
  love.graphics.setColor(unpack(self.color))
  love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end

return Block