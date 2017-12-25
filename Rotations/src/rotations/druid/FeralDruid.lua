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
    ability = "Berserk"
  }, {
    conditions = { {
      type = "or",
      children = { {
        type = "power",
        powerType = 3,
        operator = "<=",
        value = 30
      }, {
        type = "buff",
        name = "Berserk",
        active = true
      } }
    } },
    ability = "Tiger's Fury"
  }, {
    conditions = { {
      type = "buff",
      name = "Tiger's Fury",
      active = true
    } },
    ability = "Ashamane's Frenzy"
  }, {
    conditions = { {
      type = "debuff",
      name = "Rake",
      active = false
    } },
    ability = "Rake"
  }, {
    conditions = { {
      type = "and",
      children = { {
        type = "combo",
        operator = ">=",
        value = 5
      }, {
        type = "debuff",
        name = "Rip",
        active = false
      } }
    } },
    ability = "Rip"
  }, {
    conditions = { {
      type = "and",
      children = { {
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
    ability = "Berserk"
  }, {
    conditions = { {
      type = "or",
      children = { {
        type = "power",
        powerType = 3,
        operator = "<=",
        value = 30
      }, {
        type = "buff",
        name = "Berserk",
        active = true
      } }
    } },
    ability = "Tiger's Fury"
  }, {
    conditions = { {
      type = "buff",
      name = "Tiger's Fury",
      active = true
    } },
    ability = "Ashamane's Frenzy"
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
      name = "Thrash",
      active = false
    } },
    ability = "Thrash"
  }, {
    conditions = { {
      type = "and",
      children = { {
        type = "combo",
        operator = ">=",
        value = 5
      }, {
        type = "debuff",
        name = "Rip",
        active = false
      } }
    } },
    ability = "Rip"
  }, {
    conditions = { {
      type = "and",
      children = { {
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
    ability = "Swipe"
  }, {
    ability = "Shred"
  } }

  return {
    talents = function()
      return talents
    end,
    single = function()
      return single
    end,
    multi = function()
      return multi
    end
  }

end
