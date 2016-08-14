function PhineRotations:ArmsWarrior()

  local talents = {
    ["Fervor of Battle"] = {
      tier = 3,
      column = 1
    }
  }

  local single = { {
    conditions = { {
      type = "debuff",
      name = "Colossus Smash",
      active = true
    } },
    ability = "Execute"
  },{
    ability = "Rend"
  }, {
    ability = "Colossus Smash"
  }, {
    ability = "Overpower"
  }, {
    ability = "Mortal Strike"
  }, {
    conditions = { {
      type = "talent",
      name = "Fervor of Battle",
      active = true
    } },
    ability = "Whirlwind"
  }, {
    conditions = { {
      type = "talent",
      name = "Fervor of Battle",
      active = false
    } },
    ability = "Slam"
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
