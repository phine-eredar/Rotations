function PhineRotations:FeralDruid()

  local talents = {
    ["Balance Affinity"] = {
      tier = 3,
      column = 1
    },
    ["Sabertooth"] = {
      tier = 6,
      column = 1
    }
  }

  local single = { {
    conditions = { {
      type = "buff",
      name = "Savage Roar",
      active = false
    } },
    ability = "Savage Roar"
  }, {
    conditions = { {
      type = "debuff",
      name = "Rake",
      active = false
    } },
    ability = "Rake"
  }, {
    conditions = { {
      type = "or",
      children = { {
        type = "health",
        operator = "<",
        value = 25
      }, {
        type = "talent",
        name = "Sabertooth",
        active = true
      } }
    } },
    ability = "Ferocious Bite"
  }, {
    conditions = { {
      type = "and",
      children = { {
        type = "health",
        operator = ">=",
        value = 25
      }, {
        type = "debuff",
        name = "Rip",
        active = false
      } }
    } },
    ability = "Rip"
  }, {
    conditions = { {
      type = "talent",
      name = "Balance Affinity",
      active = true
    } },
    ability = "Moonfire"
  }, {
    conditions = { {
      type = "power",
      powerType = 3,
      operator = "<=",
      value = 20
    } },
    ability = "Tiger's Fury"
  }, {
    conditions = { {
      type = "buff",
      name = "Tiger's Fury",
      active = true
    } },
    ability = "Ashmane's Frenzy"
  }, {
    conditions = { {
      type = "and",
      children = { {
        type = "power",
        powerType = 3,
        operator = ">=",
        value = 50
      }, {
        type = "combo",
        operator = ">=",
        value = 5
      }, {
        type = "debuff",
        name = "Rip",
        active = true
      } }
    } },
    ability = "Ferocious Bite"
  }, {
    ability = "Shred"
  } }

  local multi = { {
    conditions = { {
      type = "debuff",
      name = "Thrash",
      active = false
    } },
    ability = "Thrash"
  }, {
    conditions = { {
      type = "debuff",
      name = "Rake",
      active = false
    } },
    ability = "Rake"
  }, {
    conditions = { {
      type = "debuff",
      name = "Rip",
      active = false
    } },
    ability = "Rip"
  }, {
    ability = "Swipe"
  } }

  return {
    talents = function() return talents end,
    single = function() return single end,
    multi = function() return multi end
  }

end
