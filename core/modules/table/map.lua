function map(t, f)
  local newTable = {}

  for index, value in ipairs(t) do
    local processedValue = f(value, index)

    table.insert(newTable, processedValue)
  end

  return newTable
end