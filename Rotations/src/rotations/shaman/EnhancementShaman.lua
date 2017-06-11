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
      type = "buff",
      name = "Landslide",
      active = false
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
    conditions = { {
      type = "buff",
      name = "Stormbringer",
      active = true
    } },
    ability = "Stormstrike"
  }, {
    ability = "Windsong"
  }, {
    ability = "Doom Winds"
  }, {
    conditions = { {
      type = "buff",
      name = "Hot Hands",
      active = true
    } },
    ability = "Lava Lash"
  }, {
    ability = "Stormstrike"
  }, {
    conditions = { {
      type = "power",
      operator = "<",
      value = 80
    } },
    ability = "Rockbiter"
  }, {
    ability = "Lava Lash"
  } }

  local multi = { {
    conditions = { {
      type = "buff",
      name = "Landslide",
      active = false
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
    conditions = { {
      type = "buff",
      name = "Stormbringer",
      active = true
    } },
    ability = "Stormstrike"
  }, {
    ability = "Windsong"
  }, {
    ability = "Doom Winds"
  }, {
    conditions = { {
      type = "buff",
      name = "Hot Hands",
      active = true
    } },
    ability = "Lava Lash"
  }, {
    ability = "Stormstrike"
  }, {
    conditions = { {
      type = "power",
      operator = "<",
      value = 80
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
