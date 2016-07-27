require("src/Rotations")

local wow = function(data)
  data.buffs = data.buffs or {}
  data.spellCooldowns = data.spellCooldowns or {}
  data.usableSpells = data.usableSpells or {}
  return {
    GetSpellCooldown = function(name)
      return unpack(data.spellCooldowns[name])
    end,
    GetTime = function()
      return data.time
    end,
    IsUsableSpell = function(name)
      return data.usableSpells[name]
    end,
    UnitBuff = function(name)
      return data.buffs[name]
    end
  }
end

spec("RotationsTest", function()

    describe("Fury Warrior, single target", function()

        describe("When not enraged", function()

            it("Should return Rampage", function()

                assert_equal(Rotations(wow({
                  time = 0,
                  usableSpells = {
                    Rampage = true
                  },
                  spellCooldowns = {
                    Rampage = {0, 0}
                  }
                })).next(furyWarriorSingle), "Rampage")

            end)

        end)

    end)

end)
