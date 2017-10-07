function PhineRotations:EnhancementShaman()

  local talents = {
    Hailstorm = {
      tier = 4,
      column = 3
    },
    Landslide = {
      tier = 7,
      columnn = 1
    }
  }

  local single = { {
    conditions = { {
      type = "or",
      children = { {
        type = "buff",
        name = "Landslide",
        active = false
      }, {
        type = "charges",
        operator = "==",
        value = 2
      } }
    } },
    ability = "Rockbiter"
  }, {
    conditions = { {
      type = "buff",
      name = "Flametongue",
      active = false
    } },
    ability = "Flametongue"
  }, {
    ability = "Doom Winds"
  }, {
    ability = "Stormstrike"
  }, {
    conditions = { {
      type = "power",
      operator = "<",
      value = 40
    } },
    ability = "Rockbiter"
  }, {
    ability = "Lava Lash"
  } }

  local multi = { {
    conditions = { {
      type = "or",
      children = { {
        type = "buff",
        name = "Landslide",
        active = false
      }, {
        type = "charges",
        operator = "==",
        value = 2
      } }
    } },
    ability = "Rockbiter"
  }, {
    ability = "Crash Lightning"
  }, {
    conditions = { {
      type = "buff",
      name = "Flametongue",
      active = false
    } },
    ability = "Flametongue"
  }, {
    ability = "Doom Winds"
  }, {
    ability = "Stormstrike"
  }, {
    conditions = { {
      type = "power",
      operator = "<",
      value = 40
    } },
    ability = "Rockbiter"
  }, {
    ability = "Lava Lash"
  } }

  return {
    talents = function() return talents end,
    single = function() return single end,
    multi = function() return multi end
  }

end
