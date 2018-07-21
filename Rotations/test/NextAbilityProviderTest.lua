require("src/package")
require("src/Rotation")
require("src/rotations/warrior/FuryWarrior")
require("src/NextAbilityProvider")

--local unpack = table.unpack;

--local wow = function(data)
--  data.buffs = data.buffs or {}
--  data.spellCooldowns = data.spellCooldowns or {}
--  data.talentInfo = data.talentInfo or {}
--  data.usableSpells = data.usableSpells or {}
--  return {
--    GetSpellCharges = function()
--      return
--    end,
--    GetSpellCooldown = function(name)
--      return unpack(data.spellCooldowns[name])
--    end,
--    GetTalentInfo = function(tier, column)
--      return unpack(data.talentInfo[tier][column])
--    end,
--    GetTime = function()
--      return data.time
--    end,
--    IsUsableSpell = function(name)
--      return data.usableSpells[name]
--    end,
--    UnitBuff = function(unit, name)
--      return data.buffs[name]
--    end,
--    UnitPower = function(unit)
--      return data.power
--    end
--  }
--end

describe("RotationsTest", function()

end)
