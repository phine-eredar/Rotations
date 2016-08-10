function PhineRotations:HavocDemonHunter()

  local talents = {
    ["Fel Mastery"] = {
      tier = 1,
      column = 1
    },
    Prepared = {
      tier = 2,
      column = 1
    }
  }

  local single = { {
    conditions = { {
      type = "or",
      children = { {
        type = "power",
        powerType = 17,
        operator = "<=",
        value = 85
      }, {
        type = "talent",
        name = "Prepared",
        active = true
      } }
    } },
    ability = "Vengeful Retreat"
  }, {
    conditions = { {
      type = "or",
      children = { {
        type = "and",
        children = { {
          type = "talent",
          name = "Fel Mastery",
          active = true
        }, {
          type = "power",
          powerType = 17,
          operator = "<=",
          value = 70
        } }
      }, {
        type = "charges",
        operator = "==",
        value = 2
      } }
    } },
    ability = "Fel Rush"
  }, {
    conditions = { {
      type = "power",
      powerType = 17,
      operator = ">=",
      value = 70
    } },
    ability = "Annihilation"
  }, {
    conditions = { {
      type = "power",
      powerType = 17,
      operator = ">=",
      value = 70
    } },
    ability = "Chaos Strike"
  }, {
    ability = "Demon's Bite"
  }, {
    ability = "Throw Glaive"
  } }

  local multi = {}

  return {
    talents = function() return talents end,
    single = function() return single end,
    multi = function() return multi end
  }

end
