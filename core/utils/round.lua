function math.round(v, bracket)
  bracket = bracket or 1
  return math.floor(v/bracket + math.sign(v) * 0.5) * bracket
end