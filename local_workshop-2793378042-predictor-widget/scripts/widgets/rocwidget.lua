local Widget = require "widgets/widget"
local TimeManager = require "services/timeservice"
local WidgetService = require "services/widgetservice"

local RocWidget = Class(Widget, function(self, owner)
	Widget._ctor(self, "RocWidget")

	WidgetService.CreateWidget(self, owner, "roc")
end)

function RocWidget:CanInstantiate()
	if (SaveGameIndex.IsModePorkland == nil or SaveGameIndex:IsModePorkland() == false) then
		return false
	end

	return true
end

function RocWidget:UpdateTimer()
	local rocManager = GetWorld().components.rocmanager
	if rocManager == nil or rocManager.disabled then
		self:Hide()
		return
	end

	local rocNextTime = rocManager.nexttime
	if rocNextTime == nil or rocNextTime <= 0 then
		WidgetService.ChangeLabel(self, "Spawning")
		self:Show()
		return
	end

	local rocUpdateFrenquency = TUNING.SEG_TIME/2
	local timeToAttack = rocNextTime + rocUpdateFrenquency - (rocNextTime % rocUpdateFrenquency)

	WidgetService.ChangeLabel(self, TimeManager.TimeToString(timeToAttack))
	self:Show()
end

return RocWidget