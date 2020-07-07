-- Global libraries
class = require 'core.libs.middleclass'
debugger = require 'core.libs.debugger'

-- Include helpers
require 'core.modules.keyboard.utils'
require 'core.modules.graphics.utils'
require 'core.modules.table.utils'
require 'core.modules.math.utils'
require 'core.modules.string.utils'
require 'core.modules.type.utils'

-- Aliases
keyboard = love.keyboard

-- App
App = require(__conf__.entry)

function love.load()
  app = App:new()
end

function love.update()
  app:_runStep()
end

function love.draw()
  app:_runDraw()
end