local Widget = require "widgets/widget"
local TimeManager = require "services/timeservice"
local WidgetService = require "services/widgetservice"

local VolcanoWidget = Class(Widget, function(self, owner)
	Widget._ctor(self, "VolcanoWidget")

	WidgetService.CreateWidget(self, owner, "volcano")
end)

function VolcanoWidget:CanInstantiate()
	if (SaveGameIndex.IsModeShipwrecked == nil or SaveGameIndex:IsModeShipwrecked() == false) then
		return false
	end

	return true
end

function VolcanoWidget:UpdateTimer()
	local volcanoManager = GetWorld().components.volcanomanager
	if volcanoManager == nil then
		self:Hide()
		return
	end
	
	local segsUntilEruption = volcanoManager:GetNumSegmentsUntilEruption()	
	if segsUntilEruption == nil then
		self:Hide()
		return
	end

	if (segsUntilEruption == nil) then
		self:Hide()
		return
	end

	local actualTime = (TUNING.TOTAL_DAY_TIME * (GetClock():GetNormTime() * 100)) / 100
	local actualSeg = math.floor(actualTime / 30)
	local timeInSeg = actualTime - (actualSeg * 30)
	local timeSegs = (segsUntilEruption * 30) - timeInSeg

	if (timeSegs <= 0) then
		self:Hide()
		return
	end
	
	WidgetService.ChangeLabel(self, TimeManager.TimeToString(timeSegs))
	self:Show()
end

return VolcanoWidget