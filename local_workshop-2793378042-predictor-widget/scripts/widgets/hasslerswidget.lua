local Widget = require "widgets/widget"
local TimeManager = require "services/timeservice"
local WidgetService = require "services/widgetservice"

local HasslersWidget = Class(Widget, function(self, owner)
	Widget._ctor(self, "HasslersWidget")

	local icon = "deerclops"
	if (SaveGameIndex.IsModeShipwrecked ~= nil and SaveGameIndex:IsModeShipwrecked()) then
		icon = "twister"
	end

	WidgetService.CreateWidget(self, owner, icon)
end)

function HasslersWidget:CanInstantiate()
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

function HasslersWidget:UpdateTimer()
	local hassler = GetWorld().components.basehassler
	local shortestTimeToAttack = nil
	local spawnedHassler = nil
	local spawnedHasslerStatus = nil
	local spawnedHasslerWarnDuration = nil

	if (hassler.hasslers == nil) then
		if (hassler.timetoattack ~= nil) then
			shortestTimeToAttack = hassler.timetoattack
			spawnedHassler = "deerclops"
		end
	else
		if (hassler.hasslers.TWISTER ~= nil) then
			local twister = hassler.hasslers.TWISTER
			if (twister.done_for_season == false) then
				shortestTimeToAttack = twister.timer
				spawnedHassler = "twister"
				spawnedHasslerStatus = twister.HASSLER_STATE
				spawnedHasslerWarnDuration = twister.warnduration
			end
		end
		
		if (hassler.hasslers.DEERCLOPS ~= nil and (shortestTimeToAttack == nil or shortestTimeToAttack > bearger.timer)) then
			local deerclops = hassler.hasslers.DEERCLOPS
			if (deerclops.done_for_season == false) then
				shortestTimeToAttack = deerclops.timer
				spawnedHassler = "deerclops"
				spawnedHasslerStatus = deerclops.HASSLER_STATE
				spawnedHasslerWarnDuration = deerclops.warnduration
			end
		end

		if (hassler.hasslers ~= nil and hassler.hasslers.BEARGER ~= nil) then
			local bearger = hassler.hasslers.BEARGER
			if (bearger.done_for_season == false and (shortestTimeToAttack == nil or shortestTimeToAttack > bearger.timer)) then
				shortestTimeToAttack = bearger.timer
				spawnedHassler = "bearger"
				spawnedHasslerStatus = bearger.HASSLER_STATE
				spawnedHasslerWarnDuration = bearger.warnduration
			end
		end

		if (hassler.hasslers ~= nil and hassler.hasslers.GOOSEMOOSE ~= nil) then
			local goosemoose = hassler.hasslers.GOOSEMOOSE
			if (goosemoose.done_for_season == false and (shortestTimeToAttack == nil or shortestTimeToAttack > goosemoose.timer)) then
				shortestTimeToAttack = goosemoose.timer
				spawnedHassler = "goosemoose"
				spawnedHasslerStatus = goosemoose.HASSLER_STATE
				spawnedHasslerWarnDuration = goosemoose.warnduration
			end
		end

		if (hassler.hasslers ~= nil and hassler.hasslers.DRAGONFLY ~= nil) then
			local dragonfly = hassler.hasslers.DRAGONFLY
			if (dragonfly.done_for_season == false and (shortestTimeToAttack == nil or shortestTimeToAttack > dragonfly.timer)) then
				shortestTimeToAttack = dragonfly.timer
				spawnedHassler = "dragonfly"
				spawnedHasslerStatus = dragonfly.HASSLER_STATE
			    spawnedHasslerWarnDuration = dragonfly.warnduration
			end
		end
	end

	if (shortestTimeToAttack == nil or spawnedHassler == nil) then
		self:Hide()
		return
	end

	if (spawnedHasslerWarnDuration ~= nil and spawnedHasslerStatus == "WAITING") then
		shortestTimeToAttack = shortestTimeToAttack + spawnedHasslerWarnDuration
	end

	if (shortestTimeToAttack <= 0) then
		self:Hide()
		return
	end

	WidgetService.ChangeLabel(self, TimeManager.TimeToString(shortestTimeToAttack))
	WidgetService.ChangeIcon(self, spawnedHassler)
	self:Show()
end

return HasslersWidget