function PhineRotations:MarksmanshipHunter()

  local talents = {
    Sidewinders = {
      tier = 7,
      column = 1
    }
  }

  local single = { {
    conditions = { {
      type = "and",
      children = { {
        type = "buff",
        name = "Vulnerable",
        active = false
      } }
    } },
    ability = "Marked Shot"
  }, {
    ability = "Barrage"
  }, {
    conditions = { {
      type = "and",
      children = {  {
        type = "debuff",
        name = "Vulnerable",
        active = true
      } }
    } },
    ability = "Aimed Shot"
  }, {
    conditions = { {
      type = "and",
      children = { {
        type = "talent",
        name = "Sidewinders",
        active = true
      }, {
        type = "charges",
        name = "Sidewinder",
        operator = ">=",
        value = 2
      } },
    } },
    ability = "Sidewinders"
  }, {
    conditions = { {
      type = "and",
      children = { {
        type = "talent",
        name = "Sidewinders",
        active = true
      }, {
        type = "buff",
        name = "Marking Targets",
        active = true
      }, {
        type = "power",
        powerType = 2,
        operator = ">=",
        value = 60
      } }
    } },
    ability = "Sidewinders"
  }, {
    conditions = { {
      type = "and",
      children = { {
        type = "talent",
        name = "Sidewinders",
        active = false
      }, {
        type = "buff",
        name = "Marking Targets",
        active = true
      } }
    } },
    ability = "Arcane Shot"
  } }

  local multi = {}

  return {
    talents = function() return talents end,
    single = function() return single end,
    multi = function() return multi end
  }

end
