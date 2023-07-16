local Widget = require "widgets/widget"
local TimeManager = require "services/timeservice"
local WidgetService = require "services/widgetservice"

local DepthsWormsWidget = Class(Widget, function(self, owner)
	Widget._ctor(self, "DepthsWormsWidget")

	WidgetService.CreateWidget(self, owner, "depthsworm")
end)

function DepthsWormsWidget:CanInstantiate()
	if (GetWorld().IsCave ~= nil and GetWorld():IsCave()) then
		return true
	end

	if (GetWorld().IsRuins ~= nil or GetWorld():IsRuins()) then
		return true
	end

	return false
end

function DepthsWormsWidget:UpdateTimer()
	local periodicthreat = GetWorld().components.periodicthreat
	if (periodicthreat == nil) then
		self:Hide()
		return
	end

	local threats = periodicthreat.threats
	if (threats == nil) then
		self:Hide()
		return
	end

	local threatsWorm = threats.WORM
	if (threatsWorm == nil) then
		self:Hide()
		return
	end

	local timeToAttack = threatsWorm.timer
	if (timeToAttack == nil or timeToAttack <= 0) then
		self:Hide()
		return
	end

	WidgetService.ChangeLabel(self, TimeManager.TimeToString(timeToAttack))
	self:Show()
end

return DepthsWormsWidget