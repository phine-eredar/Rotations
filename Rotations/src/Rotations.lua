local wow = {
  CheckInteractDistance = CheckInteractDistance,
  GetComboPoints = GetComboPoints,
  GetRuneCooldown = GetRuneCooldown,
  GetSpecialization = GetSpecialization,
  GetSpecializationInfo = GetSpecializationInfo,
  GetSpellCharges = GetSpellCharges,
  GetSpellCooldown = GetSpellCooldown,
  GetTalentInfo = GetTalentInfo,
  GetTime = GetTime,
  GetTotemInfo = GetTotemInfo,
  IsUsableSpell = IsUsableSpell,
  print = print,
  UnitBuff = UnitBuff,
  UnitCastingInfo = UnitCastingInfo,
  UnitClass = UnitClass,
  UnitDebuff = UnitDebuff,
  UnitFullName = UnitFullName,
  UnitHealth = UnitHealth,
  UnitHealthMax = UnitHealthMax,
  UnitPower = UnitPower
}
local rotationFactory = PhineRotations:RotationFactory(wow)
local nextAbilityProvider = PhineRotations:NextAbilityProvider(wow)

local inCinematic = nil

local updateInCinematic = function(self, event)
  if event == "CINEMATIC_START" then inCinematic = 1
  elseif event == "CINEMATIC_STOP" then inCinematic = nil
  end
end

local updateSingle = function(self, event, unit, name, rank, target)
  local text = ""
  self.text:SetFontObject("GameFontGreenLarge")
  local rotation = rotationFactory.newRotation()
  if not inCinematic and rotation then
    text = nextAbilityProvider.next(rotation.single(), rotation.talents())
  end
  self.text:SetText(text)
end

local updateMulti = function(self, event, unit, name, rank, target)
  local text = ""
  self.text:SetFontObject("GameFontGreenLarge")
  local rotation = rotationFactory.newRotation()
  if not inCinematic and rotation then
    text = nextAbilityProvider.next(rotation.multi(), rotation.talents())
  end
  self.text:SetText(text)
end

local cinematic = CreateFrame("Frame")
cinematic:RegisterEvent("CINEMATIC_START")
cinematic:RegisterEvent("CINEMATIC_STOP")
cinematic:SetScript("OnEvent", updateInCinematic)

local single = CreateFrame("Frame")
single:RegisterEvent("CINEMATIC_START")
single:RegisterEvent("CINEMATIC_STOP")
single:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
single:RegisterEvent("COMBAT_TEXT_UPDATE")
single:RegisterEvent("SPELL_UPDATE_COOLDOWN")
single:RegisterEvent("SPELL_UPDATE_USABLE")
single:RegisterEvent("UNIT_COMBAT")
single:RegisterEvent("UNIT_SPELLCAST_SENT")
single:RegisterEvent("UNIT_SPELLCAST_START")
single:RegisterEvent("UNIT_SPELLCAST_STOP")
single:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
single:SetScript("OnEvent", updateSingle)
single:ClearAllPoints()
single:SetHeight(300)
single:SetWidth(300)
single.text = single:CreateFontString(nil, "BACKGROUND", "PVPInfoTextFont")
single.text:SetTextHeight(32)
single.text:SetAllPoints()
single:SetPoint("CENTER", -150, -100)

local multi = CreateFrame("Frame")
multi:RegisterEvent("CINEMATIC_START")
multi:RegisterEvent("CINEMATIC_STOP")
multi:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
multi:RegisterEvent("COMBAT_TEXT_UPDATE")
multi:RegisterEvent("SPELL_UPDATE_COOLDOWN")
multi:RegisterEvent("SPELL_UPDATE_USABLE")
multi:RegisterEvent("UNIT_COMBAT")
multi:RegisterEvent("UNIT_SPELLCAST_SENT")
multi:RegisterEvent("UNIT_SPELLCAST_START")
multi:RegisterEvent("UNIT_SPELLCAST_STOP")
multi:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
multi:SetScript("OnEvent", updateMulti)
multi:ClearAllPoints()
multi:SetHeight(300)
multi:SetWidth(300)
multi.text = multi:CreateFontString(nil, "BACKGROUND", "PVPInfoTextFont")
multi.text:SetTextHeight(32)
multi.text:SetAllPoints()
multi:SetPoint("CENTER", 150, -100)

local function updater()
  updateSingle(single)
  updateMulti(multi)
  C_Timer.After(0.5, updater)
end
updater()