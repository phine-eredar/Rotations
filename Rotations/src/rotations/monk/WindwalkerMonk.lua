function PhineRotations:WindwalkerMonk()

  local talents = {}

  local single = { {
    ability = "Fists of Fury"
  }, {
    ability = "Whirling Dragon Punch"
  }, {
    conditions = { {
      type = "and",
      children = { {
        type = "power",
        powerType = 12,
        operator = "<",
        value = 4
      }, {
        type = "power",
        powerType = 3,
        operator = ">=",
        value = 90
      } }
    } },
    ability = "Tiger Palm"
  }, {
    ability = "Rising Sun Kick"
  }, {
    ability = "Chi Wave"
  }, {
    ability = "Blackout Kick"
  }, {
    ability = "Tiger Palm"
  } }

  local multi = {}

  return {
    talents = function() return talents end,
    single = function() return single end,
    multi = function() return multi end
  }

end
