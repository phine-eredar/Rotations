function PhineRotations:HavocDemonHunter()

  local talents = {}

  local single = { {
    conditions = { {
      type = "charges",
      operator = "==",
      value = 2
    } },
    ability = "Fel Rush"
  }, {
    ability = "Nemesis"
  }, {
    ability = "Chaos Blades"
  }, {
    ability = "Fury of the Illidari"
  }, {
    ability = "Fel Barrage"
  }, {
    conditions = { {
      type = "power",
      powerType = 17,
      operator = "<=",
      value = 110
    } },
    ability = "Felblade"
  }, {
    conditions = { {
      type = "power",
      powerType = 17,
      operator = ">=",
      value = 80
    } },
    ability = "Metamorphosis"
  }, {
    conditions = { {
      type = "power",
      powerType = 17,
      operator = ">=",
      value = 40
    } },
    ability = "Annihilation"
  }, {
    conditions = { {
      type = "power",
      powerType = 17,
      operator = ">=",
      value = 40
    } },
    ability = "Chaos Strike"
  } }

  local multi = { {
    conditions = { {
      type = "charges",
      operator = "==",
      value = 2
    } },
    ability = "Fel Rush"
  }, {
    ability = "Nemesis"
  }, {
    ability = "Chaos Blades"
  }, {
    ability = "Fury of the Illidari"
  }, {
    ability = "Fel Barrage"
  }, {
    ability = "Eye Beam"
  }, {
    conditions = { {
      type = "power",
      powerType = 17,
      operator = "<=",
      value = 110
    } },
    ability = "Felblade"
  }, {
    conditions = { {
      type = "power",
      powerType = 17,
      operator = ">=",
      value = 80
    } },
    ability = "Metamorphosis"
  }, {
    conditions = { {
      type = "power",
      powerType = 17,
      operator = ">=",
      value = 35
    } },
    ability = "Death Sweep"
  }, {
    conditions = { {
      type = "power",
      powerType = 17,
      operator = ">=",
      value = 35
    } },
    ability = "Blade Dance"
  }, {
    conditions = { {
      type = "power",
      powerType = 17,
      operator = ">=",
      value = 40
    } },
    ability = "Annihilation"
  }, {
    conditions = { {
      type = "power",
      powerType = 17,
      operator = ">=",
      value = 40
    } },
    ability = "Chaos Strike"
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
