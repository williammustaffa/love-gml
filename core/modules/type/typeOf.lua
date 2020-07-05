function typeOf(var)
  local _type = type(var);
  if(_type ~= "table" and _type ~= "userdata") then
      return _type;
  end
  local _meta = getmetatable(var);
  if(_meta ~= nil and _meta._NAME ~= nil) then
      return _meta._NAME;
  else
      return _type;
  end
end