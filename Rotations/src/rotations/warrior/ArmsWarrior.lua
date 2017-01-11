function PhineRotations:ArmsWarrior()

  local talents = {
    ["Fervor of Battle"] = {
      tier = 3,
      column = 1
    }
  }

  local single = { {
    conditions = { {
      type = "buff",
      name = "Shattered Defenses",
      active = false
    } },
    ability = "Colossus Smash"
  }, {
    conditions = { {
      type = "and",
      children = { {
        type = "debuff",
        name = "Colossus Smash",
        active = false
      }, {
        type = "buff",
        name = "Shattered Defenses",
        active = false
      } }
    } },
    ability = "Warbreaker"
  }, {
    ability = "Execute"
  }, {
    ability = "Mortal Strike"
  }, {
    conditions = { {
      type = "power",
      powerType = 1,
      operator = ">",
      value = 32
    } },
    ability = "Slam"
  }, {
    conditions = { {
      type = "power",
      powerType = 1,
      operator = ">=",
      value = 75
    } },
    ability = "Focused Rage"
  } }

  local multi = { {
    conditions = { {
      type = "buff",
      name = "Cleave",
      active = false
    } },
    ability = "Cleave"
  }, {
    ability = "Mortal Strike"
  }, {
    ability = "Whirlwind"
  }, {
    ability = "Colossus Smash"
  } }

  return {
    talents = function() return talents end,
    single = function() return single end,
    multi = function() return multi end
  }

end
