-- Core app
App = require('App')

function love.load()
  app = App:new()
end

function love.update(dt)
  app:update(dt)
end

function love.draw()
  app:draw()
end