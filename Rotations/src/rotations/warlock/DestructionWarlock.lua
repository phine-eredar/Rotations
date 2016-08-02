function PhineRotations:DestructionWarlock()

  local talents = {
     Eradication = {
      tier = 4,
      column = 1
    }
  }

  local single = { {
    conditions = { {
      type = "debuff",
      name = "Immolate",
      active = false
    } },
    ability = "Immolate"
  }, {
    conditions = { {
      type = "power",
      powerType = 7,
      operator = ">=",
      value = 5
    } },
    ability = "Chaos Bolt"
  }, {
    ability = "Conflagrate"
  }, {
    ability = "Shadowburn"
  }, {
    ability = "Conflagrate"
  }, {
    conditions = { {
      type = "and",
      children = { {
        type = "talent",
        name = "Eradication",
        active = true
      }, {
        type = "debuff",
        name = "Eradication",
        active = false
      } }
    } },
    ability = "Chaos Bolt"
  }, {
    ability = "Incinerate"
  } }

  local multi = {}

  return {
    talents = function() return talents end,
    single = function() return single end,
    multi = function() return multi end
  }

end
