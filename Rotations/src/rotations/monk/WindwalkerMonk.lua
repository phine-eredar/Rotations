function PhineRotations:WindwalkerMonk()

  local talents = {}

  local single = { {
    ability = "Rising Sun Kick"
  }, {
    ability = "Fists of Fury"
  }, {
    ability = "Strikes of the Windlord"
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
    ability = "Blackout Kick"
  }, {
    ability = "Tiger Palm"
  } }

  local multi = { {
    ability = "Fists of Fury"
  }, {
    ability = "Strikes of the Windlord"
  }, {
    ability = "Spinning Crane Kick"
  }, {
    ability = "Blackout Kick"
  }, {
    ability = "Tiger Palm"
  } }

  return {
    talents = function()
      return talents
    end,
    single = function()
      return single
    end,
    multi = function()
      return multi
    end
  }

end
