function table.filter(t, f)
  local newTable = {}

  for index, value in ipairs(t) do
    local processedValue = f(value, index)

    if processedValue then
      table.insert(newTable, value)
    end
  end

  return newTable
end