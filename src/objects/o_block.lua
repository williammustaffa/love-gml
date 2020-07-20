local o_block = LGML.Object('o_block')

function o_block:create(options)
  -- Block creation
  self.solid = true
  self.height = 64
  self.width = 64
end

function o_block:step()
  -- Block update
end

function o_block:draw()
  -- Block draw
  love.graphics.setColor(rgba(100, 100, 100))
  love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
  love.graphics.setColor(rgba(255, 255, 255, 255))
end

return o_block