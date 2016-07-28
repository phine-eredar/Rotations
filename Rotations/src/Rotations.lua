local wow = {
  GetSpecialization = GetSpecialization,
  GetSpecializationInfo = GetSpecializationInfo,
  GetSpellCharges = GetSpellCharges,
  GetSpellCooldown = GetSpellCooldown,
  GetTalentInfo = GetTalentInfo,
  GetTime = GetTime,
  IsUsableSpell = IsUsableSpell,
  UnitBuff = UnitBuff,
  UnitPower = UnitPower
}
local rotationFactory = PhineRotations:RotationFactory(wow)
local nextAbilityProvider = PhineRotations:NextAbilityProvider(wow)

local updateSingle = function(self, event, unit, name, rank, target)
  self.text:SetFontObject("GameFontGreenLarge")
  local rotation = rotationFactory.newRotation()
  if not rotation then return end
  self.text:SetText(nextAbilityProvider.next(rotation.single(), rotation.talents()))
end

local updateMulti = function(self, event, unit, name, rank, target)
  self.text:SetFontObject("GameFontGreenLarge")
  local rotation = rotationFactory.newRotation()
  if not rotation then return end
  self.text:SetText(nextAbilityProvider.next(rotation.multi(), rotation.talents()))
end

local single = CreateFrame("Frame")
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
single:SetPoint("CENTER", -100, -100)

local multi = CreateFrame("Frame")
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
multi:SetPoint("CENTER", 100, -100)
