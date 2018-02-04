function PhineRotations:MarksmanshipHunter()

  local talents = {
    Sidewinders = {
      tier = 7,
      column = 1
    }
  }

  local single = { {
    ability = "Windburst"
  }, {
    conditions = { {
      type = "power",
      powerType = 2,
      operator = ">=",
      value = 73
    } },
    ability = "Marked Shot"
  }, {
    conditions = { {
      type = "buff",
      name = "Marking Targets",
      active = true
    } },
    ability = "Arcane Shot"
  }, {
    conditions = { {
      type = "power",
      powerType = 2,
      operator = ">=",
      value = 65
    } },
    ability = "Aimed Shot"
  }, {
    ability = "Arcane Shot"
  } }

  local multi = {}

  return {
    talents = function() return talents end,
    single = function() return single end,
    multi = function() return multi end
  }

end
