function PhineRotations:ShadowPriest()

  local talents = {}
  
  local single = { {
    conditions = { {
      type = "debuff",
      name = "Vampiric Touch",
      active = false
    } },
    ability = "Vampiric Touch"
  }, {
    conditions = { {
      type = "debuff",
      name = "Shadow Word: Pain",
      active = false
    } },
    ability = "Shadow Word: Pain"
  }, {
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
    ability = "Mind Blast"
  }, {
    conditions = { {
      type = "buff",
      name = "Voidform",
      active = true
    } },
    ability = "Void Torrent"
  }, {
    conditions = { {
      type = "buff",
      name = "Voidform",
      active = true
    } },
    ability = "Mindbender"
  }, {
    conditions = { {
      type = "buff",
      name = "Voidform",
      active = true
    } },
    ability = "Shadowfiend"
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
    ability = "Mind Flay"
  } }

  local multi = {}

  return {
    talents = function() return talents end,
    single = function() return single end,
    multi = function() return multi end
  }

end