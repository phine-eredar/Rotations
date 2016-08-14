function PhineRotations:ElementalShaman()

  local talents = {}

  local single = { {
    conditions = { {
      type = "debuff",
      name = "Flame Shock",
      active = false
    } },
    ability = "Flame Shock"
    }, {
    conditions = { {
      type = "power",
      powerType = 11,
      operator = ">=",
      value = 100
    } },
    ability = "Earth Shock"
  }, {
    ability = "Lava Burst"
  }, {
    conditions = { {
      type = "power",
      powerType = 11,
      operator = ">",
      value = 90
    } },
    ability = "Earth Shock"
  }, {
    ability = "Lightning Bolt"
  } }

  local multi = { {
    conditions = { {
      type = "debuff",
      name = "Flame Shock",
      active = false
    } },
    ability = "Flame Shock"
    }, {
    conditions = { {
      type = "power",
      powerType = 11,
      operator = ">=",
      value = 100
    } },
    ability = "Earth Shock"
  }, {
    ability = "Lava Burst"
  }, {
    ability = "Earthquake Totem"
  }, {
    conditions = { {
      type = "power",
      powerType = 11,
      operator = ">",
      value = 90
    } },
    ability = "Earth Shock"
  }, {
    ability = "Chain Lightning"
  } }


  return {
    talents = function() return talents end,
    single = function() return single end,
    multi = function() return multi end
  }

end
