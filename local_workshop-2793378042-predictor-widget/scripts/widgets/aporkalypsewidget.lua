local Widget = require "widgets/widget"
local TimeManager = require "services/timeservice"
local WidgetService = require "services/widgetservice"

local AporkalypseWidget = Class(Widget, function(self, owner)
	Widget._ctor(self, "AporkalypseWidget")

	WidgetService.CreateWidget(self, owner, "aporkalypse")
end)

function AporkalypseWidget:CanInstantiate()
	if (SaveGameIndex.IsModePorkland == nil or SaveGameIndex:IsModePorkland() == false) then
		return false
	end

	return true
end

function AporkalypseWidget:UpdateTimer()
	local aporkalypseManager = GetWorld().components.aporkalypse
	if aporkalypseManager == nil then
		self:Hide()
		return
	end

	if aporkalypseManager:IsActive() then
		WidgetService.ChangeLabel(self, "Active")
		self:Show()
		return
	end 
	
	local aporkalypseBeginDate = aporkalypseManager.begin_date	
	if aporkalypseBeginDate == nil then
		self:Hide()
		return
	end

	local timeBeforeAporkalypse = aporkalypseBeginDate - GetClock():GetTotalTime()
	if timeBeforeAporkalypse <= 0 then
		self:Hide()
		return
	end
	
	WidgetService.ChangeLabel(self, TimeManager.TimeToString(timeBeforeAporkalypse))
	self:Show()
end

return AporkalypseWidget