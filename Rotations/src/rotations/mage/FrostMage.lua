function PhineRotations:FrostMage()

  local talents = {}

  local single = { {
    ability = "Frozen Orb"
  }, {
    ability = "Icy Veins"
  }, {
    conditions = { {
      type = "charges",
      buff = "Fingers of Frost",
      operator = ">",
      value = 0
    } },
    ability = "Ice Lance"
  }, {
    conditions = { {
      type = "buff",
      name = "Brain Freeze",
      active = true
    } },
    ability = "Flurry"
  }, {
    conditions = { {
      type = "buff",
      name = "Brain Freeze",
      active = false
    } },
    ability = "Ebonbolt"
  }, {
    ability = "Frostbolt"
  } }

  local multi = { {
    ability = "Frozen Orb"
  }, {
    ability = "Icy Veins"
  }, {
    conditions = { {
      type = "charges",
      ability = "Fingers of Frost",
      operator = ">",
      value = 0
    } },
    ability = "Ice Lance"
  }, {
    conditions = { {
      type = "buff",
      name = "Brain Freeze",
      active = true
    } },
    ability = "Flurry"
  }, {
    conditions = { {
      type = "buff",
      name = "Brain Freeze",
      active = false
    } },
    ability = "Ebonbolt"
  }, {
    ability = "Blizzard"
  }, {
    ability = "Frostbolt"
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
