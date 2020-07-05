__conf__ = {}

function love.conf(t)
  t.entry = 'src.App'
  t.debug = false

  t.identity = "GtGLG"
  t.version = "11.2"

  t.window.title = "Generic App"
  t.window.width = 640
  t.window.height = 480

  t.window.fsaa = 4
  t.window.vsync = true
  -- export config
  __conf__ = t
end