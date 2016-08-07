function PhineRotations:FeralDruid()

  local talents = {}

  local single = { {
    conditions = { {
      type = "and",
      children = { {
        type = "health",
        operator = "<",
        value = 25
      }, {
        type = "or",
        children = { {
          type = "and",
          children = { {
            type = "combo",
            operator = ">=",
            value = 5
          }, {
            type = "debuff",
            name = "Rip",
            active = true
          }  }
        }, {
          type = "and",
          children = { {
            type = "combo",
            operator = "<",
            value = 5
          }, {
            type = "debuff",
            name = "Rip",
            active = false
          }  }
        } }
      } }
    } },
    ability = "Ferocious Bite"
  }, {
    conditions = { {
      type = "and",
      children = { {
        type = "health",
        operator = ">=",
        value = 25
      }, {
        type = "combo",
        operator = ">=",
        value = 5
      }, {
        type = "debuff",
        name = "Rip",
        active = false
      } }
    } },
    ability = "Rip"
  }, {
    conditions = { {
      type = "and",
      children = { {
        type = "power",
        operator = ">=",
        value = 50
      }, {
        type = "combo",
        operator = ">=",
        value = 5
      }, {
        type = "debuff",
        name = "Rip",
        active = true
      } }
    } },
    ability = "Ferocious Bite"
  },  {
    conditions = { {
      type = "debuff",
      name = "Rake",
      active = false
    } },
    ability = "Rake"
  }, {
    ability = "Shred"
  } }

  local multi = {}

  return {
    talents = function() return talents end,
    single = function() return single end,
    multi = function() return multi end
  }

end
