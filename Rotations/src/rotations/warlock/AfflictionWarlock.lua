function PhineRotations:AfflictionWarlock()

  local talents = {}

  local single = {}

  local multi = {}

  return {
    talents = function() return talents end,
    single = function() return single end,
    multi = function() return multi end
  }

end
