function table.find(t, f)
  local result = false

  for index, value in ipairs(t) do
    local resultMatch = f(value, index)

    if resultMatch then
      result = value
    end
  end

  return result
end