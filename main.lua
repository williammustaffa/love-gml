-- Global libraries
class = require 'core.libs.middleclass'
debugger = require 'core.libs.debugger'

-- Include helpers
require 'core.modules.graphics.utils'
require 'core.modules.table.utils'
require 'core.modules.math.utils'
require 'core.modules.string.utils'
require 'core.modules.type.utils'

App = require(__conf__.entry)

function love.load()
  app = App:new()
end

function love.update()
  app:update()
end

function love.draw()
  app:draw()
end