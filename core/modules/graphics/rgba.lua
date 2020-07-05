-- rgba:
-- Transform rgba to unit rgba
function rgba(red, green, blue, alpha)
  local convertUnit = function (unit) return (unit or 255) * (1 / 255) end


  -- Convert colors
  local r = convertUnit(red)
  local g = convertUnit(green)
  local b = convertUnit(blue)
  local a = convertUnit(alpha or 255)

  return { r, g, b, a }
end
