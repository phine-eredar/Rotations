function PhineRotations:ShadowPriest()

  local talents = {
    ["Misery"] = {
      tier = 6,
      column = 2
    }
  }

  local single = { {
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
      type = "and",
      children = { {
        type = "talent",
        name = "Misery",
        active = false
      }, {
        type = "debuff",
        name = "Shadow Word: Pain",
        active = false
      } }
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

  local multi = { {
    conditions = { {
      type = "buff",
      name = "Voidform",
      active = true
    } },
    ability = "Void Bolt"
  },  {
    conditions = { {
      type = "buff",
      name = "Voidform",
      active = true
    } },
    ability = "Shadow Crash"
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
      type = "and",
      children = { {
        type = "talent",
        name = "Misery",
        active = false
      }, {
        type = "debuff",
        name = "Shadow Word: Pain",
        active = false
      } }
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

  return {
    talents = function() return talents end,
    single = function() return single end,
    multi = function() return multi end
  }

end
