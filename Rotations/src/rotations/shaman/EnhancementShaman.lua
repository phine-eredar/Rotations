local Buffed = PhineRotations.Buffed
local Charges = PhineRotations.Charges
local Debuffed = PhineRotations.Debuffed
local Not = PhineRotations.Not
local Rotation = PhineRotations.Rotation

function PhineRotations:EnhancementShaman()
    local talents = {}

    local single = Rotation()
    --single.use("Windfury Weapon").when(Not(Buffed("Windfury Weapon")))
    --single.use("Flametongue Weapon").when(Not(Buffed("Flametongue Weapon")))
    single.use("Lightning Shield").when(Not(Buffed("Lightning Shield")))
    single.use("Flame Shock").when(Not(Debuffed("Flame Shock", 6)))
    single.use("Stormstrike")
    single.use("Lava Lash")
    single.use("Frost Shock")
    single.use("Crash Lightning")
    single.use("Lightning Bolt").when(Charges(">=", 5, "Maelstrom Weapon"))

    local multi = Rotation()
    --multi.use("Windfury Weapon").when(Not(Buffed("Windfury Weapon")))
    --multi.use("Flametongue Weapon").when(Not(Buffed("Flametongue Weapon")))
    multi.use("Lightning Shield").when(Not(Buffed("Lightning Shield")))
    multi.use("Crash Lightning")
    multi.use("Flame Shock").when(Not(Debuffed("Flame Shock", 6)))
    multi.use("Stormstrike")
    multi.use("Lava Lash")
    multi.use("Frost Shock")
    multi.use("Chain Lightning").when(Charges(">=", 5, "Maelstrom Weapon"))

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
