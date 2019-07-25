-- Load libs
Object = require("libs.classic")
Tick = require("libs.tick")
Debugger = require("libs.debugger")

-- Local entities
Actor = require("core.entities.Actor")
Background = require("core.entities.Background")
Scene = require("core.entities.Scene")
Sound = require("core.entities.Sound")
Sprite = require("core.entities.Sprite")
Tileset = require("core.entities.Tileset")
Viewport = require("core.entities.Viewport")

-- Core app
App = require('App')

-- Debugger options
Debugger.auto_where = 2

function love.load()
  app = App()
end

function love.update(dt)
  app:update(dt)
end

function love.draw()
  app:draw()
end