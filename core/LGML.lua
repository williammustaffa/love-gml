-- Random seed for math.random
math.randomseed(os.time())
require('core.modules.window.utils')
require('core.modules.keyboard.alias')
require('core.utils.rgba')
require('core.utils.round')
require('core.utils.sign')
require('core.utils.spairs')

LGML = {
  Game   = function (name)
    return require('core.entities.Game'):subclass(name)
  end,
  Room   = function (name) 
    return require('core.entities.Room'):subclass(name)
  end,
  Object = function (name)
    return require('core.entities.Object'):subclass(name)
  end,
  Sprite = function (name)
    return require('core.entities.Sprite'):subclass(name)
  end,
}

local LGMLInstance

function love.load()
  LGMLInstance = require(__conf__.entry):new()
end

function love.update()
  LGMLInstance:__step()
end

function love.keypressed(key)
  if key == 'escape' then
     love.event.quit()
  end
end

function love.draw()
  LGMLInstance:__draw()
end