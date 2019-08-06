function table.reduce(t, f, i)
  local finalValue = i

  for index, value in ipairs(t) do
    finalValue = f(finalValue, value, index)
  end

  return finalValue
end