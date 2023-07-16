KnownModIndex = GLOBAL.KnownModIndex
local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS
local Widget = require "widgets/widget"
local HoundsWidget = require "widgets/houndswidget"
local DepthsWormsWidget = require "widgets/depthswormswidget"
local VolcanoWidget = require "widgets/volcanowidget"
local HasslersWidget = require "widgets/hasslerswidget"
local AporkalypseWidget = require "widgets/aporkalypsewidget"
local RocWidget = require "widgets/rocwidget"

local ENABLE_HOUNDS_PREDICTOR = GetModConfigData("ENABLE_HOUNDS_PREDICTOR")
local ENABLE_DEPTHS_WORMS_PREDICTOR = GetModConfigData("ENABLE_DEPTHS_WORMS_PREDICTOR")
local ENABLE_HASSLERS_PREDICTOR = GetModConfigData("ENABLE_HASSLERS_PREDICTOR")
local ENABLE_VOLCANO_PREDICTOR = GetModConfigData("ENABLE_VOLCANO_PREDICTOR")
local ENABLE_APORKALYPSE_PREDICTOR = GetModConfigData("ENABLE_APORKALYPSE_PREDICTOR")
local ENABLE_ROC_PREDICTOR = GetModConfigData("ENABLE_ROC_PREDICTOR")

Assets =
{
	Asset("ATLAS", "images/houndwidget.xml"),
	Asset("ATLAS", "images/crocodogwidget.xml"),
	Asset("ATLAS", "images/batwidget.xml"),
	Asset("ATLAS", "images/depthswormwidget.xml"),
	Asset("ATLAS", "images/volcanowidget.xml"),
	Asset("ATLAS", "images/aporkalypsewidget.xml"),
	Asset("ATLAS", "images/rocwidget.xml"),
	Asset("ATLAS", "images/deerclopswidget.xml"),
	Asset("ATLAS", "images/goosemoosewidget.xml"),
	Asset("ATLAS", "images/dragonflywidget.xml"),
	Asset("ATLAS", "images/beargerwidget.xml"),
	Asset("ATLAS", "images/twisterwidget.xml")
}

local function updateWidgetsPosition(self)
	local startingXPosition = 70
	
	if (self.houndsWidget ~= nil and self.houndsWidget.shown) then
		self.houndsWidget:SetPosition(startingXPosition, -70, 0.0)
		startingXPosition = startingXPosition + 120
	end
	if (self.depthsWormsWidget ~= nil and self.depthsWormsWidget.shown) then
		self.depthsWormsWidget:SetPosition(startingXPosition, -70, 0.0)
		startingXPosition = startingXPosition + 120
	end
	if (self.hasslersWidget ~= nil and self.hasslersWidget.shown) then
		self.hasslersWidget:SetPosition(startingXPosition, -70, 0.0)
		startingXPosition = startingXPosition + 120
	end
	if (self.volcanoWidget ~= nil and self.volcanoWidget.shown) then
		self.volcanoWidget:SetPosition(startingXPosition, -70, 0.0)
		startingXPosition = startingXPosition + 120
	end
	if (self.aporkalypseWidget ~= nil and self.aporkalypseWidget.shown) then
		self.aporkalypseWidget:SetPosition(startingXPosition, -70, 0.0)
		startingXPosition = startingXPosition + 120
	end
	if (self.rocWidget ~= nil and self.rocWidget.shown) then
		self.rocWidget:SetPosition(startingXPosition, -70, 0.0)
	end
end

local function updateWidgetsTimer(self)
	if (self.houndsWidget ~= nil) then
		self.houndsWidget:UpdateTimer()
	end
	if (self.depthsWormsWidget ~= nil) then
		self.depthsWormsWidget:UpdateTimer()
	end
	if (self.hasslersWidget ~= nil) then
		self.hasslersWidget:UpdateTimer()
	end
	if (self.volcanoWidget ~= nil) then
		self.volcanoWidget:UpdateTimer()
	end
	if (self.aporkalypseWidget ~= nil) then
		self.aporkalypseWidget:UpdateTimer()
	end
	if (self.rocWidget ~= nil) then
		self.rocWidget:UpdateTimer()
	end
end

local function initWidgets(self)
	if (ENABLE_HOUNDS_PREDICTOR and HoundsWidget:CanInstantiate()) then
		self.houndsWidget = self:AddChild(HoundsWidget(self))
		self.houndsWidget:SetHAnchor(GLOBAL.ANCHOR_LEFT)
		self.houndsWidget:SetVAnchor(GLOBAL.ANCHOR_TOP)
		self.houndsWidget:SetClickable(false)
		self.houndsWidget:SetScaleMode(GLOBAL.SCALEMODE_NONE)
	end

	if (ENABLE_DEPTHS_WORMS_PREDICTOR and DepthsWormsWidget:CanInstantiate()) then
		self.depthsWormsWidget = self:AddChild(DepthsWormsWidget(self))
		self.depthsWormsWidget:SetHAnchor(GLOBAL.ANCHOR_LEFT)
		self.depthsWormsWidget:SetVAnchor(GLOBAL.ANCHOR_TOP)
		self.depthsWormsWidget:SetClickable(false)
		self.depthsWormsWidget:SetScaleMode(GLOBAL.SCALEMODE_NONE)
	end

	if (ENABLE_HASSLERS_PREDICTOR and HasslersWidget:CanInstantiate()) then
		self.hasslersWidget = self:AddChild(HasslersWidget(self))
		self.hasslersWidget:SetHAnchor(GLOBAL.ANCHOR_LEFT)
		self.hasslersWidget:SetVAnchor(GLOBAL.ANCHOR_TOP)
		self.hasslersWidget:SetClickable(false)
		self.hasslersWidget:SetScaleMode(GLOBAL.SCALEMODE_NONE)
	end

	if (ENABLE_VOLCANO_PREDICTOR and VolcanoWidget:CanInstantiate()) then
		self.volcanoWidget = self:AddChild(VolcanoWidget(self))
		self.volcanoWidget:SetHAnchor(GLOBAL.ANCHOR_LEFT)
		self.volcanoWidget:SetVAnchor(GLOBAL.ANCHOR_TOP)
		self.volcanoWidget:SetClickable(false)
		self.volcanoWidget:SetScaleMode(GLOBAL.SCALEMODE_NONE)
	end

	if (ENABLE_APORKALYPSE_PREDICTOR and AporkalypseWidget:CanInstantiate()) then
		self.aporkalypseWidget = self:AddChild(AporkalypseWidget(self))
		self.aporkalypseWidget:SetHAnchor(GLOBAL.ANCHOR_LEFT)
		self.aporkalypseWidget:SetVAnchor(GLOBAL.ANCHOR_TOP)
		self.aporkalypseWidget:SetClickable(false)
		self.aporkalypseWidget:SetScaleMode(GLOBAL.SCALEMODE_NONE)
	end

	if (ENABLE_ROC_PREDICTOR and RocWidget:CanInstantiate()) then
		self.rocWidget = self:AddChild(RocWidget(self))
		self.rocWidget:SetHAnchor(GLOBAL.ANCHOR_LEFT)
		self.rocWidget:SetVAnchor(GLOBAL.ANCHOR_TOP)
		self.rocWidget:SetClickable(false)
		self.rocWidget:SetScaleMode(GLOBAL.SCALEMODE_NONE)
	end

	updateWidgetsTimer(self)
	updateWidgetsPosition(self)

	self.inst:DoPeriodicTask(
		1,
		function()
			updateWidgetsTimer(self)
			updateWidgetsPosition(self)
		end
	)
end

AddClassPostConstruct("widgets/controls", initWidgets)
