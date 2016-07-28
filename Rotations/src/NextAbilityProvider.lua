function PhineRotations:NextAbilityProvider(wow)

  local evaluateCondition
  evaluateCondition = function(condition, talents)

    local met = false

    if condition.type == "and" then

      met = true

      for i, child in ipairs(condition.children) do
        met = met and evaluateCondition(child, talents)
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
        met = met or evaluateCondition(child, talents)
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

  local evaluateRule = function(rule, talents)

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
        if not evaluateCondition(condition, talents) then
          return
        end
      end
    end

    return rule.ability

  end

  return {
    next = function(rotation, talents)
      for i, rule in ipairs(rotation) do
        local ability = evaluateRule(rule, talents)
        if ability ~= nil then
          return ability
        end
      end
      return ""
    end
  }

end