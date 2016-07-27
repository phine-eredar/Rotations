local talents = {
  ["Inner Rage"] = {
    tier = 6,
    column = 3
  },
  Massacre = {
    tier = 5,
    column = 1
  }
}

furyWarriorSingle = { {
  conditions = { {
    type = "or",
    children = { {
      type = "buff",
      name = "Enrage",
      active = false
    }, {
      type = "power",
      operator = ">=",
      value = 100
    } }
  } },
  ability = "Rampage"
}, {
  conditions = { {
    type = "buff",
    name = "Enrage",
    active = false
  } },
  ability = "Bloodthirst"
}, {
  conditions = { {
    type = "talent",
    name = "Massacre",
    active = true
  } },
  ability = "Execute"
}, {
  conditions = { {
    type = "buff",
    name = "Wrecking Ball",
    active = true
  } },
  ability = "Whirlwind"
}, {
  conditions = { {
    type = "and",
    children = { {
      type = "talent",
      name = "Massacre",
      active = false
    }, {
      type = "buff",
      name = "Enrage",
      active = true
    } }
  } },
  ability = "Execute"
}, {
  conditions = { {
    type = "or",
    children = { {
      type = "talent",
      name = "Inner Rage",
      active = true
    }, {
      type = "buff",
      name = "Enrage",
      active = true
    } }
  } },
  ability = "Raging Blow"
}, {
  ability = "Bloodthirst"
}, {
  ability = "Furious Slash"
} }

local furyWarriorMulti = { {
  conditions = { {
    type = "buff",
    name = "Meat Cleaver",
    active = false
  } },
  ability = "Whirlwind"
}, {
  conditions = { {
    type = "or",
    children = { {
      type = "buff",
      name = "Enrage",
      active = false
    }, {
      type = "power",
      operator = ">=",
      value = 100
    } }
  } },
  ability = "Rampage"
}, {
  conditions = { {
    type = "buff",
    name = "Enrage",
    active = false
  } },
  ability = "Bloodthirst"
}, {
  conditions = { {
    type = "buff",
    name = "Wrecking Ball",
    active = true
  } },
  ability = "Whirlwind"
}, {
  ability = "Raging Blow"
}, {
  ability = "Bloodthirst"
}, {
  ability = "Whirlwind"
} }

function Rotations(wow)

  local evaluateCondition
  evaluateCondition = function(condition)

    local met = false

    if condition.type == "and" then

      met = true

      for i, child in ipairs(condition.children) do
        met = met and evaluateCondition(child)
      end

    elseif condition.type == "buff" then

      local buffed = wow.UnitBuff("player", condition.name) == condition.name

      if condition.active then
        met = buffed
      else
        met = not buffed
      end

    elseif condition.type == "or" then

      for i, child in ipairs(condition.children) do
        met = met or evaluateCondition(child)
      end

    elseif condition.type == "power" then

      local power = wow.UnitPower("player")

      if condition.operator == "<" then
        met = power < condition.value
      elseif condition.operator == "<=" then
        met = power <= condition.value
      elseif condition.operator == "==" then
        met = power == condition.value
      elseif condition.operator == ">=" then
        met = power >= condition.value
      elseif condition.operator == ">" then
        met = power > condition.value
      else print("Unsupported operator: " .. condition.operator)
      end

    elseif condition.type == "talent" then

      local talent = talents[condition.name]
      local _, _, _, selected = wow.GetTalentInfo(talent.tier, talent.column, 1)

      if (condition.active) then
        met = selected
      else
        met = not selected
      end

    else print("Unsupported condition type: " .. condition.type)

    end

    return met

  end

  local evaluateRule = function(rule)

    local usable = wow.IsUsableSpell(rule.ability)
    if not usable then
      return
    end

    local start, duration = wow.GetSpellCooldown(rule.ability)
    local ready = start + duration - wow.GetTime() <= 1.5
    if not ready then
      return
    end

    if rule.conditions then
      for i, condition in ipairs(rule.conditions) do
        if not evaluateCondition(condition) then
          return
        end
      end
    end

    return rule.ability

  end

  return {
    next = function(rotation)
      for i, rule in ipairs(rotation) do
        local ability = evaluateRule(rule)
        if ability ~= nil then
          return ability
        end
      end
      return ""
    end
  }

end

local wow = {
  GetSpellCooldown = GetSpellCooldown,
  GetTalentInfo = GetTalentInfo,
  GetTime = GetTime,
  IsUsableSpell = IsUsableSpell,
  UnitBuff = UnitBuff,
  UnitPower = UnitPower
}
local rotations = Rotations(wow)

local updateSingle = function (self, event, unit, name, rank, target)
  self.text:SetFontObject("GameFontGreenLarge");
  self.text:SetText(rotations.next(furyWarriorSingle))
end

local updateMulti = function (self, event, unit, name, rank, target)
  self.text:SetFontObject("GameFontGreenLarge");
  self.text:SetText(rotations.next(furyWarriorMulti))
end

if (CreateFrame) then
  local single = CreateFrame("Frame")
  single:RegisterEvent("COMBAT_TEXT_UPDATE")
  single:RegisterEvent("SPELL_UPDATE_USABLE")
  single:SetScript("OnEvent", updateSingle)
  single:ClearAllPoints()
  single:SetHeight(300)
  single:SetWidth(300)
  single.text = single:CreateFontString(nil, "BACKGROUND", "PVPInfoTextFont")
  single.text:SetTextHeight(32)
  single.text:SetAllPoints()
  single:SetPoint("CENTER", -100, -100)

  local multi = CreateFrame("Frame")
  multi:RegisterEvent("COMBAT_TEXT_UPDATE")
  multi:RegisterEvent("SPELL_UPDATE_USABLE")
  multi:SetScript("OnEvent", updateMulti)
  multi:ClearAllPoints()
  multi:SetHeight(300)
  multi:SetWidth(300)
  multi.text = multi:CreateFontString(nil, "BACKGROUND", "PVPInfoTextFont")
  multi.text:SetTextHeight(32)
  multi.text:SetAllPoints()
  multi:SetPoint("CENTER", 100, -100)
end
