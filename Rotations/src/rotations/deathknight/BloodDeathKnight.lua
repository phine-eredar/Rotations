function PhineRotations:BloodDeathKnight()

  local talents = {}

  local single = { {
    conditions = { {
      type = "charges",
      buff = "Bone Shield",
      operator = "==",
      value = 0
    } },
    ability = "Marrowrend"
  }, {
    conditions = { {
      type = "debuff",
      name = "Blood Plague",
      active = false
    } },
    ability = "Blood Boil"
  }, {
    conditions = { {
      type = "health",
      unit = "player",
      operator = "<=",
      value = UnitHealthMax("player") / 2
    } },
    ability = "Death Strike"
  }, {
    conditions = { {
      type = "buff",
      name = "Crimson Scourge",
      active = true
    } },
    ability = "Death and Decay"
  }, {
    conditions = { {
      type = "power",
      powerType = 6,
      operator = ">=",
      value = 0.8 * UnitPowerMax("player", 6)
    } },
    ability = "Death Strike"
  }, {
    conditions = { {
      type = "charges",
      buff = "Bone Shield",
      operator = "<=",
      value = 6
    } },
    ability = "Marrowrend"
  }, {
     conditions = { {
       type = "runes",
       operator = "<=",
       value = 3
     } },
     ability = "Death and Decay"
   }, {
     conditions = { {
       type = "or",
       children = { {
         type = "runes",
         operator = ">=",
         value = 3
       }, {
         type = "power",
         powerType = 6,
         operator = "<=",
         value = 45
       } }
     } },
     ability = "Heart Strike"
   }, {
     ability = "Consumption"
   }, {
     ability = "Blood Boil"
   } }

  local multi = {}

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
