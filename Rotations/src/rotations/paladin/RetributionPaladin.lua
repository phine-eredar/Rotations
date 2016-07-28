function PhineRotations:RetributionPaladin()

  local talents = {}

  local single = { {
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
    ability = "Blade of Wrath"
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
  }, {
    ability = "Execution Sentence"
  }, {
    conditions = { {
      type = "buff",
      name = "Divine Purpose",
      active = true
    } },
    ability = "Justicar's Vengeance"
  }, {
    ability = "Templar's Verdict"
  } }

  local multi = { {
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
    ability = "Blade of Wrath"
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
  }, {
    ability = "Execution Sentence"
  }, {
    conditions = { {
      type = "buff",
      name = "Divine Purpose",
      active = true
    } },
    ability = "Justicar's Vengeance"
  }, {
    ability = "Divine Storm"
  } }

  return {
    talents = function() return talents end,
    single = function() return single end,
    multi = function() return multi end
  }

end
