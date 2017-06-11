function PhineRotations:RetributionPaladin()

  local talents = {}

  local single = { {
    conditions = { {
      type = "debuff",
      name = "Judgment",
      active = true
    } },
    ability = "Templar's Verdict"
  }, {
    conditions = { {
      type = "debuff",
      name = "Judgment",
      active = true
    } },
    ability = "Execution Sentence"
  }, {
    conditions = { {
      type = "and",
      children = { {
        type = "power",
        powerType = 9,
        operator = "<=",
        value = 4
      }, {
        type = "charges",
        operator = "==",
        value = 2
      } }
    } },
    ability = "Crusader Strike"
  }, {
    conditions = { {
      type = "power",
      powerType = 9,
      operator = "<=",
      value = 3
    } },
    ability = "Divine Hammer"
  }, {
    conditions = { {
      type = "power",
      powerType = 9,
      operator = "<=",
      value = 3
    } },
    ability = "Blade of Justice"
  }, {
    conditions = { {
      type = "power",
      powerType = 9,
      operator = "<=",
      value = 4
    } },
    ability = "Crusader Strike"
  }, {
    ability = "Judgment"
  } }

  local multi = { {
    conditions = { {
      type = "debuff",
      name = "Judgment",
      active = true
    } },
    ability = "Divine Storm"
  }, {
    conditions = { {
      type = "debuff",
      name = "Judgment",
      active = true
    } },
    ability = "Execution Sentence"
  }, {
    conditions = { {
      type = "and",
      children = { {
        type = "power",
        powerType = 9,
        operator = "<=",
        value = 4
      }, {
        type = "charges",
        operator = "==",
        value = 2
      } }
    } },
    ability = "Crusader Strike"
  }, {
    conditions = { {
      type = "power",
      powerType = 9,
      operator = "<=",
      value = 3
    } },
    ability = "Divine Hammer"
  }, {
    conditions = { {
      type = "power",
      powerType = 9,
      operator = "<=",
      value = 3
    } },
    ability = "Blade of Justice"
  }, {
    conditions = { {
      type = "power",
      powerType = 9,
      operator = "<=",
      value = 4
    } },
    ability = "Crusader Strike"
  }, {
    ability = "Judgment"
  } }

  return {
    talents = function() return talents end,
    single = function() return single end,
    multi = function() return multi end
  }

end
