function PhineRotations:ProtectionWarrior()

  local talents = {
    Vengeance = {
      tier = 6,
      column = 1
    }
  }

  local single = { {
    conditions = { {
      type = "power",
      powerType = 1,
      operator = ">=",
      value = 60
    } },
    ability = "Ignore Pain"
  }, {
    conditions = { {
      type = "buff",
      name = "Shield Block",
      active = false
    } },
    ability = "Shield Block"
  }, {
    ability = "Shield Slam"
  }, {
    ability = "Revenge"
  }, {
    ability = "Devastate"
  } }

  local multi = { {
    conditions = { {
      type = "power",
      powerType = 1,
      operator = ">=",
      value = 60
    } },
    ability = "Ignore Pain"
  }, {
    conditions = { {
      type = "buff",
      name = "Shield Block",
      active = false
    } },
    ability = "Shield Block"
  }, {
    ability = "Revenge"
  }, {
    ability = "Thunder Clap"
  }, {
    ability = "Shield Slam"
  }, {
    ability = "Devastate"
  } }

  return {
    talents = function() return talents end,
    single = function() return single end,
    multi = function() return multi end
  }

end
