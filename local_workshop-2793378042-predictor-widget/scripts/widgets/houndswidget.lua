local Widget = require "widgets/widget"
local TimeManager = require "services/timeservice"
local WidgetService = require "services/widgetservice"

local HoundsWidget = Class(Widget, function(self, owner)
	Widget._ctor(self, "HoundsWidget")
	
	local icon = "hound"
	if (SaveGameIndex.IsModeShipwrecked ~= nil and SaveGameIndex:IsModeShipwrecked()) then
		icon = "crocodog"
	elseif (SaveGameIndex.IsModePorkland ~= nil and SaveGameIndex:IsModePorkland()) then
		icon = "bat"
	end

	WidgetService.CreateWidget(self, owner, icon)
end)

function HoundsWidget:CanInstantiate()
	if (GetWorld().IsCave ~= nil and GetWorld():IsCave()) then
		return false
	end

	if (GetWorld().IsRuins ~= nil and GetWorld():IsRuins()) then
		return false
	end
	
	if (GetWorld().IsVolcano ~= nil and GetWorld():IsVolcano()) then
		return false
	end 

	return true
end

function HoundsWidget:UpdateTimer()
	local houndsManager = GetWorld().components.hounded
	if (houndsManager == nil) then
		houndsManager = GetWorld().components.batted
	end

	if (houndsManager == nil) then
		self:Hide()
		return
	end

	local timeToAttack = houndsManager.timetoattack
	if (timeToAttack == nil or timeToAttack <= 0) then
		self:Hide()
		return
	end

	WidgetService.ChangeLabel(self, TimeManager.TimeToString(timeToAttack))
	self:Show()
end

return HoundsWidget