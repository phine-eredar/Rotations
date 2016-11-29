function PhineRotations:ProtectionWarrior()

  local talents = {
    Vengeance = {
      tier = 6,
      column = 1
    }
  }

  local single = { {
    ability = "Shield Slam"
  }, {
    ability = "Revenge"
  }, {
    ability = "Devastate"
  } }

  local multi = { {
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
