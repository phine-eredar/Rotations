function PhineRotations:FrostDeathKnight()

  local talents = {}

  local single = { {
    conditions = { {
      type = "and",
      children = { {
        type = "buff",
        name = "Obliterate",
        active = false
      }, {
        type = "buff",
        name = "Killing Machine",
        active = false
      }, {
        type = "power",
        powerType = 6,
        operator = ">=",
        value = 50
      } }
    } },
    ability = "Obliteration"
  }, {
    conditions = { {
      type = "and",
      children = { {
        type = "buff",
        name = "Obliterate",
        active = true
      }, {
        type = "buff",
        name = "Rime",
        active = true
      } }
    } },
    ability = "Howling Blast"
  }, {
    conditions = { {
      type = "and",
      children = { {
        type = "buff",
        name = "Obliterate",
        active = true
      }, {
        type = "buff",
        name = "Killing Machine",
        active = true
      } }
    } },
    ability = "Obliterate"
  }, {
    conditions = { {
      type = "and",
      children = { {
        type = "buff",
        name = "Obliterate",
        active = true
      }, {
        type = "buff",
        name = "Killing Machine",
        active = false
      } }
    } },
    ability = "Frost Strike"
  }, {
    conditions = { {
      type = "debuff",
      name = "Frost Fever",
      active = false
    } },
    ability = "Howling Blast"
  }, {
    conditions = { {
      type = "power",
      powerType = 6,
      operator = "<=",
      value = 80
    } },
    ability = "Obliterate"
  }, {
    conditions = { {
      type = "buff",
      name = "Rime",
      active = true
    } },
    ability = "Howling Blast"
  }, {
    ability = "Frost Strike"
  }, {
    conditions = { {
      type = "and",
      children = { {
        type = "power",
        powerType = 6,
        operator = "<=",
        value = 80
      }, {
        type = "runes",
        operator = "<=",
        value = 4
      } }
    } },
    ability = "Horn of Winter"
  } }

  local multi = {}

  return {
    talents = function() return talents end,
    single = function() return single end,
    multi = function() return multi end
  }

end
