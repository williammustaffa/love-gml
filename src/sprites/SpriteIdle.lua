local SpriteIdle = LGML.Sprite('SpriteIdle')

function SpriteIdle:setup()
  self.source = 'src/assets/images/sprite-idle.png'
  -- self.left = 5
  self.frame_width = 58
  self.frame_height = 64
  self.frame_xoffset = 26
  self.frame_yoffset = 32
  self.frame_border = 0.6
  self.grid_map = { '1-16', 1 }
end

return SpriteIdle:new()