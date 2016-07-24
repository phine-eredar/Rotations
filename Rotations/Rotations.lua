local f = function(self, event, unit, name, rank, target)

  local br = IsUsableSpell("Berserker Rage")
  local bt = IsUsableSpell("Bloodthirst")
  local rb = IsUsableSpell("Raging Blow")
  local ws = IsUsableSpell("Wild Strike")
  local ex = IsUsableSpell("Execute")
  local rv = IsUsableSpell("Ravage")
  local sb = IsUsableSpell("Storm Bolt")
  local sbr = IsUsableSpell("Siegebreaker")
  local dr = IsUsableSpell("Dragon Roar")

  local brCooldown = GetSpellCooldown("Berserker Rage")
  local sbCooldown = GetSpellCooldown("Storm Bolt")
  local sbrCooldown = GetSpellCooldown("Siegebreaker")
  local btStart, btDuration = GetSpellCooldown("Bloodthirst")
  
  if not btStart then
    self.text:SetText("")
    return
  end
  
  local btReady = btStart + btDuration - GetTime() <= 1
  local recklessness = GetSpellCooldown("Battle Cry")
    
  local enrage = UnitBuff("player", "Enrage") == "Enrage"
  local bloodsurge = UnitBuff("player", "Bloodsurge") == "Bloodsurge"
  local suddenDeath = UnitBuff("player", "Sudden Death") == "Sudden Death"
  local _, _, _, ragingBlowCount = UnitBuff("player", "Raging Blow!")

  local hasUnquenchableThirst = GetSpellInfo("Unquenchable Thirst") == "Unquenchable Thirst"
  local hasFuriousStrikes = GetSpellInfo("Furious Strikes") == "Furious Strikes"

  local power = UnitPower("player")
  
  local targetHealth = UnitHealth("target")
  local targetHealthMax = UnitHealthMax("target")

  local spell = ""
  
  if targetHealth > 0 and targetHealth / targetHealthMax >= 0.2 then

    if brCooldown == 0 and not enrage and not btReady then
      spell = "Berserker Rage"
    elseif suddenDeath then
      spell = "Execute"
    elseif power > 90 then
      spell = "F2"
    elseif ragingBlowCount == 2 then
      spell = "2"
    elseif btReady and not enrage and (hasUnquenchableThirst or power < 80) then
      spell = "4"
    elseif bloodsurge then
      spell = "F2 (Bloodsurge)"
    elseif rv then
      spell = "Ravager"
    elseif sbr and sbrCooldown == 0 then
      spell = "Siegebreaker"
    elseif sb and sbCooldown == 0 then
      spell = "1"
    --elseif dr then
    --  spell = "Dragon Roar"
    elseif rb then
      spell = "2"
    elseif enrage and power >= 45 then
      spell = "F2"
    elseif btReady then
      spell = "4"
    elseif hasFuriousStrikes and power >= 20 then
      spell = "F2"
    else
      spell = "(4)"
    end
  
  elseif targetHealth > 0 then
  
    if brCooldown == 0 and not enrage then
      spell = "Berserker Rage"
    elseif suddenDeath or power > 90 then
      spell = "Execute"
    elseif btReady and not enrage and (hasUnquenchableThirst or power < 90) then
      spell = "4"
    elseif rv then
      spell = "Ravager"
    elseif sb and sbCooldown == 0 then
      spell = "1"
    --elseif dr then
    --  spell = "Dragon Roar"
    elseif enrage and power >= 30 then
      spell = "Execute"
    elseif bloodsurge then
      spell = "F2 (Bloodsurge)"
    elseif rb then
      spell = "2"
    elseif btReady then
      spell = "4"
    end
  
  end
  
  if recklessness <= 0 then
    self.text:SetFontObject("GameFontRedLarge");
  else
    self.text:SetFontObject("GameFontGreenLarge");
  end

  self.text:SetText(spell)

end

local frame = CreateFrame("Frame")
frame:RegisterEvent("COMBAT_TEXT_UPDATE")
frame:RegisterEvent("SPELL_UPDATE_USABLE")
frame:SetScript("OnEvent", f)
frame:ClearAllPoints()
frame:SetHeight(300)
frame:SetWidth(300)
frame.text = frame:CreateFontString(nil, "BACKGROUND", "PVPInfoTextFont")
frame.text:SetTextHeight(32)
frame.text:SetAllPoints()
frame:SetPoint("CENTER", 0, 0)