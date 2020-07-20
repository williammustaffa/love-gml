local spr_run = LGML.Sprite('spr_run')

function spr_run:setup()
  self.source = 'src/assets/images/sprite-run.png'
  self.frame_width = 60
  self.frame_height = 64
  self.frame_xoffset = 30
  self.frame_yoffset = 32
  self.grid_map = { '1-20', 1 }
end

return spr_run:new()