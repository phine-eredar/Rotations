function PhineRotations:FuryWarrior()

  local talents = {
    ["Inner Rage"] = {
      tier = 6,
      column = 3
    },
    Massacre = {
      tier = 5,
      column = 1
    }
  }

  local single = { {
    conditions = { {
      type = "or",
      children = { {
        type = "buff",
        name = "Enrage",
        active = false
      }, {
        type = "power",
        operator = ">=",
        value = 100
      } }
    } },
    ability = "Rampage"
  }, {
    conditions = { {
      type = "buff",
      name = "Enrage",
      active = false
    } },
    ability = "Bloodthirst"
  }, {
    conditions = { {
      type = "talent",
      name = "Massacre",
      active = true
    } },
    ability = "Execute"
  }, {
    conditions = { {
      type = "buff",
      name = "Wrecking Ball",
      active = true
    } },
    ability = "Whirlwind"
  }, {
    conditions = { {
      type = "and",
      children = { {
        type = "talent",
        name = "Massacre",
        active = false
      }, {
        type = "buff",
        name = "Enrage",
        active = true
      } }
    } },
    ability = "Execute"
  }, {
    conditions = { {
      type = "or",
      children = { {
        type = "talent",
        name = "Inner Rage",
        active = true
      }, {
        type = "buff",
        name = "Enrage",
        active = true
      } }
    } },
    ability = "Raging Blow"
  }, {
    ability = "Bloodthirst"
  }, {
    ability = "Furious Slash"
  } }

  local multi = { {
    conditions = { {
      type = "buff",
      name = "Meat Cleaver",
      active = false
    } },
    ability = "Whirlwind"
  }, {
    conditions = { {
      type = "or",
      children = { {
        type = "buff",
        name = "Enrage",
        active = false
      }, {
        type = "power",
        operator = ">=",
        value = 100
      } }
    } },
    ability = "Rampage"
  }, {
    conditions = { {
      type = "buff",
      name = "Enrage",
      active = false
    } },
    ability = "Bloodthirst"
  }, {
    conditions = { {
      type = "buff",
      name = "Wrecking Ball",
      active = true
    } },
    ability = "Whirlwind"
  }, {
    ability = "Raging Blow"
  }, {
    ability = "Bloodthirst"
  }, {
    ability = "Whirlwind"
  } }

  return {
    talents = function() return talents end,
    single = function() return single end,
    multi = function() return multi end
  }

end
