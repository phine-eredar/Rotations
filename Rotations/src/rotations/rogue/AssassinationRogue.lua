function PhineRotations:AssassinationRogue()

  local talents = {}

  local single = { {
    conditions = { {
      type = "and",
      children = { {
        type = "combo",
        operator = ">=",
        value = 4
      }, {
        type = "debuff",
        name = "Rupture",
        value = false
      } }
    } },
    ability = "Rupture"
  }, {
    conditions = { {
      type = "debuff",
      name = "Garrote",
      value = false
    } },
    ability = "Garrote"
  }, {
    ability = "Vendetta"
  }, {
    ability = "Kingsbane"
  }, {
    ability = "Toxic Blade"
  }, {
    conditions = { {
      type = "combo",
      operator = ">=",
      value = 5
    } },
    ability = "Vanish"
  }, {
    conditions = { {
      type = "buff",
      name = "Vanish",
      active = true
    } },
    ability = "Rupture"
  }, {
    conditions = { {
      type = "combo",
      operator = ">=",
      value = 4
    } },
    ability = "Envenom"
  }, {
    conditions = { {
      type = "combo",
      operator = "<",
      value = 5
    } },
    ability = "Mutilate"
  } }

  local multi = { {
    conditions = { {
      type = "and",
      children = { {
        type = "combo",
        operator = ">=",
        value = 4
      }, {
        type = "debuff",
        name = "Rupture",
        value = false
      } }
    } },
    ability = "Rupture"
  }, {
    conditions = { {
      type = "debuff",
      name = "Garrote",
      value = false
    } },
    ability = "Garrote"
  }, {
    ability = "Vendetta"
  }, {
    ability = "Kingsbane"
  }, {
    ability = "Toxic Blade"
  }, {
    conditions = { {
      type = "combo",
      operator = ">=",
      value = 5
    } },
    ability = "Vanish"
  }, {
    conditions = { {
      type = "buff",
      name = "Vanish",
      active = true
    } },
    ability = "Rupture"
  }, {
    conditions = { {
      type = "combo",
      operator = ">=",
      value = 4
    } },
    ability = "Envenom"
  }, {
    conditions = { {
      type = "combo",
      operator = "<",
      value = 5
    } },
    ability = "Fan of Knives"
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
