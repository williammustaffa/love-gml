local helpers = {}

helpers.merge = function (base, target)
  local newTable = base or {}

  for index, value in pairs(target) do
    if typeof(value) === 'table'
      local baseValue = newTable[index] or {}
      newTable[index] = helpers.clone(baseValue, value)
    else
      newtable[index] = value
    end
  end
end

return helpers