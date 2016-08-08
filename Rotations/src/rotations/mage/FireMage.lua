function PhineRotations:FireMage()

  local talents = {}

  local single = { {
    conditions = { {
      type = "cooldown",
      name = "Combustion",
      operator = "<=",
      value = 0
    } },
    ability = "Rune of Power"
  }, {
    ability = "Combustion"
  }, {
    conditions = { {
      type = "charges",
      operator = ">=",
      value = 2
    } },
    ability = "Rune of Power"
  }, {
    conditions = { {
      type = "buff",
      name = "Hot Streak!",
      active = true
    } },
    ability = "Pyroblast"
  }, {
    ability = "Meteor"
  }, {
    conditions = { {
      type = "and",
      children = { {
        type = "bufftime",
        name = "Combustion",
        operator = "<=",
        value = 3
      }, {
        type = "distance",
        distance = "Duel"
      } }
    } },
    ability = "Dragon's Breath"
  }, {
    conditions = { {
      type = "charges",
      ability = "Fire Blast",
      operator = "==",
      value = 0
    } },
    ability = "Flame On"
  }, {
    conditions = { {
      type = "distance",
      distance = "Duel"
    } },
    ability = "Dragon's Breath"
  }, {
    conditions = { {
      type = "buff",
      name = "Heating Up",
      active = true
    } },
    ability = "Fire Blast"
  }, {
    ability = "Fireball"
  } }

  local multi = {}

  return {
    talents = function() return talents end,
    single = function() return single end,
    multi = function() return multi end
  }

end
