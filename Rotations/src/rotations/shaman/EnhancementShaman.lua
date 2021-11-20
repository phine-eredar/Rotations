local Buffed = PhineRotations.Buffed
local Charges = PhineRotations.Charges
local Debuffed = PhineRotations.Debuffed
local Not = PhineRotations.Not
local Rotation = PhineRotations.Rotation

function PhineRotations:EnhancementShaman()
    local talents = {}

    local single = Rotation()
    single.use("Lightning Shield").when(Not(Buffed("Lightning Shield")))
    single.use("Windfury Totem").when(Not(Buffed("Windfury Totem")))
    single.use("Flame Shock").when(Not(Debuffed("Flame Shock", 6)))
    single.use("Stormstrike")
    single.use("Lava Lash")
    single.use("Crash Lightning")
    single.use("Frost Shock")
    single.use("Lightning Bolt").when(Charges(">=", 5, "Maelstrom Weapon"))

    local multi = Rotation()
    multi.use("Lightning Shield").when(Not(Buffed("Lightning Shield")))
    multi.use("Windfury Totem").when(Not(Buffed("Windfury Totem")))
    multi.use('Sundering')
    multi.use("Chain Lightning").when(Charges(">=", 5, "Maelstrom Weapon"))
    multi.use("Crash Lightning")
    multi.use("Stormstrike")
    multi.use("Lava Lash")
    multi.use("Frost Shock")

    return {
        talents = function()
            return talents
        end,
        single = function()
            return single.get()
        end,
        multi = function()
            return multi.get()
        end
    }
end
