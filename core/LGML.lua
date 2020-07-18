math.randomseed(os.time())

require('core.modules.window.utils')
require('core.modules.keyboard.alias')
require('core.utils.rgba')
require('core.utils.round')
require('core.utils.sign')
require('core.utils.spairs')

LGML = setmetatable({}, {
  __call = function (t, options)
    t.__entry = require(options.entry)
    t.__debug = options.debug or false
  end
})

LGML.Game = function (name)
  return require('core.entities.Game'):subclass(name)
end

LGML.Room   = function (name) 
  return require('core.entities.Room'):subclass(name)
end

LGML.Object = function (name)
  return require('core.entities.Object'):subclass(name)
end

LGML.Sprite = function (name)
  return require('core.entities.Sprite'):subclass(name)
end

function love.load()
  LGML.__instance = LGML.__entry:new()
end

function love.update()
  LGML.__instance:__step()
end

function love.draw()
  LGML.__instance:__draw()
end

-- Exiting game
function love.keypressed(key)
  if key == 'escape' then
     love.event.quit()
  end
end

return LGML