local convert_unit = function (unit) return (unit or 255) * (1 / 255) end

function rgba(red, green, blue, alpha)
  return { 
    convert_unit(red),
    convert_unit(green),
    convert_unit(blue), 
    convert_unit(alpha or 255)
  }
end
