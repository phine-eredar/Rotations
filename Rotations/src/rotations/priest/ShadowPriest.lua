function PhineRotations:ShadowPriest()

  local talents = {}

  local single = { {
    conditions = { {
      type = "buff",
      name = "Voidform",
      active = true
    } },
    ability = "Void Bolt"
  }, {
    conditions = { {
      type = "buff",
      name = "Voidform",
      active = true
    } },
    ability = "Shadow Word: Death"
  }, {
    conditions = { {
      type = "buff",
      name = "Voidform",
      active = false
    } },
    ability = "Void Eruption"
  }, {
    ability = "Mind Blast"
  }, {
    conditions = { {
      type = "debuff",
      name = "Shadow Word: Pain",
      active = false
    } },
    ability = "Shadow Word: Pain"
  }, {
    conditions = { {
      type = "debuff",
      name = "Vampiric Touch",
      active = false
    } },
    ability = "Vampiric Touch"
  }, {
    ability = "Mind Flay"
  } }

  local multi = {}

  return {
    talents = function() return talents end,
    single = function() return single end,
    multi = function() return multi end
  }

end
