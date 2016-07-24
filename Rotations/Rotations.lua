local furyWarrior = { {
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

local evaluateCondition
evaluateCondition = function(condition)
	
	local met = false

	if condition.type == "and" then
	
		for i, child in ipairs(condition.children) do
			met = met and evaluateCondition(child)
		end

	elseif condition.type == "buff" then
	
		local buffed = UnitBuff("player", condition.name) == condition.name
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
	
		local power = UnitPower("player")
	
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
		else
			print("Unsupported operator: " .. condition.operator)
		end
	
	end
	
	return met
	
end

local evaluateRule = function(rule)

	local usable = IsUsableSpell(rule.ability)
	if not usable then
		return
	end
	
	local start, duration = GetSpellCooldown(rule.ability)
	local ready = start + duration - GetTime() <= 1.5
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

local next = function()

	local targetHealth = UnitHealth("target")
	if targetHealth == nil or targetHealth == 0 then
		return
	end
	
	local rotation = furyWarrior;
	
	for i, rule in ipairs(rotation) do
		local ability = evaluateRule(rule)
		if ability ~= nil then
			return ability
		end
	end
	
	return ""
	
end

local f = function (self, event, unit, name, rank, target)
	self.text:SetFontObject("GameFontGreenLarge");
	self.text:SetText(next())
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
frame:SetPoint("CENTER", -100, -100)