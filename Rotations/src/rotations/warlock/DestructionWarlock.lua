function PhineRotations:DestructionWarlock()

  local talents = {}

  local single = { {
    conditions = { {
      type = "debuff",
      name = "Immolate",
      active = false
    } },
    ability = "Immolate"
  }, {
    ability = "Conflagrate"
  }, {
    ability = "Chaos Bolt"
  }, {
    ability = "Channel Demonfire"
  }, {
    ability = "Grimoire: Imp"
  }, {
    ability = "Soul Harvest"
  }, {
    conditions = { {
      type = "charges",
      operator = "==",
      value = 3
    } },
    ability = "Dimensional Rift"
  }, {
    ability = "Incinerate"
  } }

  local multi = { {
    conditions = { {
      type = "debuff",
      name = "Immolate",
      active = false
    } },
    ability = "Immolate"
  }, {
    ability = "Conflagrate"
  }, {
    ability = "Rain of Fire"
  }, {
    ability = "Chaos Bolt"
  }, {
    ability = "Channel Demonfire"
  }, {
    ability = "Grimoire: Imp"
  }, {
    ability = "Soul Harvest"
  }, {
    conditions = { {
      type = "charges",
      operator = "==",
      value = 3
    } },
    ability = "Dimensional Rift"
  }, {
    ability = "Incinerate"
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
