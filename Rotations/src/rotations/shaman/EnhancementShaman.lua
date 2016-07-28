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
    conditions = {
      type = "buff",
      name = "Boulderfist",
      active = false
    },
    ability = "Boulderfist"
  }, {
    conditions = { {
      type = "and",
      children = { {
        type = "talent",
        name = "Landslide",
        active = true
      }, {
        type = "buff",
        name = "Landslide",
        active = false
      } }
    } },
    ability = "Boulderfist"
  }, {
    conditions = { {
      type = "and",
      children = { {
        type = "talent",
        name = "Hailstorm",
        active = true
      }, {
        type = "buff",
        name = "Frostbrand",
        active = false
      } }
    } },
    ability = "Frostbrand"
  }, {
    conditions = { {
      type = "and",
      children = { {
        type = "power",
        operator = "<",
        value = 130
      }, {
        type = "charges",
        operator = "=",
        value = 2
      } }
    } },
    ability = "Boulderfist"
  }, {
    conditions = {
      type = "buff",
      name = "Flametongue",
      active = false
    },
    ability = "Flametongue"
  }, {
    ability = "Stormstrike"
  }, {
    ability = "Crash Lightning"
  }, {
    conditions = { {
      type = "power",
      operator = ">",
      value = 110
    } },
    ability = "Lava Lash"
  }, {
    ability = "Boulderfist"
  }, {
    ability = "Flametongue"
  } }

  local multi = {
    }

  return {
    talents = function() return talents end,
    single = function() return single end,
    multi = function() return multi end
  }

end
