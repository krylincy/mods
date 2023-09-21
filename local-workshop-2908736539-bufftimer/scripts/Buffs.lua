local Widget = require("widgets/widget")
local Image = require("widgets/image")
local Text = require("widgets/text")

require("fonts")

local LEFT_OFFSET        = BUFF_TIMERS_MOD_GLOBAL_CONFIGS["LEFT_OFFSET"       ] -- -100 to 200
local TOP_OFFSET         = BUFF_TIMERS_MOD_GLOBAL_CONFIGS["TOP_OFFSET"        ] -- -100 to 200
local IMAGE_SIZE         = BUFF_TIMERS_MOD_GLOBAL_CONFIGS["IMAGE_SIZE"        ] -- -100 to 200
local MARGIN             = BUFF_TIMERS_MOD_GLOBAL_CONFIGS["MARGIN"            ] -- -100 to 200
local FONT_SIZE_TIMELEFT = BUFF_TIMERS_MOD_GLOBAL_CONFIGS["FONT_SIZE_TIMELEFT"] -- -100 to 200
local FONT_SIZE_MOD      = BUFF_TIMERS_MOD_GLOBAL_CONFIGS["FONT_SIZE_MOD"     ] -- -100 to 200
local ALWAYS_SHOW_TIMER  = BUFF_TIMERS_MOD_GLOBAL_CONFIGS["ALWAYS_SHOW_TIMER" ] --  bool

local BG_SIZE = IMAGE_SIZE + 10
local FONT = NUMBERFONT

local WILSON_SPEED_DIVIDED_BY_100 = 100 / 6

local BUFF_IMAGES_LOOKUP = {
    CAFFEINE        = "coffee"
  , SURF            = "fish3"
  , AUTODRY         = "fish4"
  , WX_CHARGE       = "gears"
  , FOOD_TEMP_HOT   = "firepit"
  , FOOD_TEMP_COLD  = "coldfirepit"
  , HAYFEVER        = "nettlelosange"
}

local BUFF_IMAGE_SIZES_LOOKUP = {
    CAFFEINE        = IMAGE_SIZE + 7
  , SURF            = IMAGE_SIZE
  , AUTODRY         = IMAGE_SIZE
  , WX_CHARGE       = IMAGE_SIZE + 4
  , FOOD_TEMP_HOT   = IMAGE_SIZE
  , FOOD_TEMP_COLD  = IMAGE_SIZE
  , HAYFEVER        = IMAGE_SIZE + 3
}

local function BuffImage(key)
    local image = BUFF_IMAGES_LOOKUP[key] .. ".tex"
    local atlas = rawget(_G, "GetInventoryItemAtlas") and GetInventoryItemAtlas(image) or "images/inventoryimages.xml"

    return Image(atlas, image)
end

local Buff = Class(Widget, function(self, key, n, mod)
    Widget._ctor(self, "Buff_"..key)

    local img_size = BUFF_IMAGE_SIZES_LOOKUP[key]

    self:SetVAnchor(ANCHOR_TOP)
    self:SetHAnchor(ANCHOR_LEFT)

    self.bg = self:AddChild(Image("images/hud.xml", "inv_slot.tex"))
    self.bg:SetSize(BG_SIZE, BG_SIZE)

    self.image = self:AddChild(BuffImage(key))
    self.image:SetSize(img_size, img_size)

    self.timeLeft = self:AddChild(Text(FONT, FONT_SIZE_TIMELEFT))
    self.timeLeft:SetPosition(3, -IMAGE_SIZE+2)
    self.timeLeft:SetHAlign(ANCHOR_MIDDLE)

    if not ALWAYS_SHOW_TIMER then self.timeLeft:Hide() end
    
    self.blackoverlay = self:AddChild(Image("images/global.xml", "square.tex"))
    self.blackoverlay:SetSize(BG_SIZE, BG_SIZE)
    self.blackoverlay:SetClickable(false)
    self.blackoverlay:SetTint(0,0,0,.7)
    self.blackoverlay:Hide()

    if mod then
        self.hovertext = self:AddChild(Text(FONT, FONT_SIZE_MOD))
        self.hovertext:SetPosition(3, 0)
        self.hovertext:SetHAlign(ANCHOR_MIDDLE)
        self.hovertext:SetString(mod)
        self.hovertext:Hide()
    end

    self:SetPosition(LEFT_OFFSET + n * (BG_SIZE + MARGIN), -TOP_OFFSET)
end)

function Buff:OnGainFocus()
    if self.hovertext then self.hovertext:Show() end
    if not ALWAYS_SHOW_TIMER then self.timeLeft:Show() end
    self.blackoverlay:Show()
    self:ScaleTo(1.15, 1.15, .125)
end

function Buff:OnLoseFocus()
    if self.hovertext then self.hovertext:Hide() end
    if not ALWAYS_SHOW_TIMER then self.timeLeft:Hide() end
    self.blackoverlay:Hide()
    self:ScaleTo(1, 1, .125)
end

-----------------------------------------------------------------------------------------

local Buffs = Class(Widget, function(self)
    Widget._ctor(self, "Buffs")

    self.buff_add_timers = GetPlayer().components.locomotor.speed_modifiers_add_timer or {}
    self.buff_add_mods   = GetPlayer().components.locomotor.speed_modifiers_add or {}

    self.buff_mult_mods   = GetPlayer().components.locomotor.speed_modifiers_mult or {}

    self.shouldRebuild = true

    self.root = self:AddChild(Widget("root"))
    self.root:SetVAnchor(ANCHOR_TOP)
    self.root:SetHAnchor(ANCHOR_LEFT)

    self.root.buffs = self.root:AddChild(Widget("buffs"))
    self.root.buffs:SetVAnchor(ANCHOR_TOP)
    self.root.buffs:SetHAnchor(ANCHOR_LEFT)

    self.root.buffs.items = {}
    self.root.buffs.food_temp_widget = nil
    self.root.buffs.food_temp_taskinfo = nil

    self.root.buffs.hayfever_widget = nil

    self:StartUpdating()
end)

function Buffs:IsMonitoringBuff(buff)
    return buff ~= nil and BUFF_IMAGES_LOOKUP[buff] ~= nil
end

function Buffs:UpdateBuffs(buff, is_add)
    if not (is_add and self.root.buffs.items[buff]) and self:IsMonitoringBuff(buff) then
        self.shouldRebuild = true
    end
end

function Buffs:ResetWidgets()
    for key, widget in pairs(self.root.buffs.items) do
        widget:Kill()
        widget = nil
    end

    self.root.buffs.items = {}

    if self.root.buffs.food_temp_widget then
        self.root.buffs.food_temp_widget:Kill()
        self.root.buffs.food_temp_widget = nil
    end

    if self.root.buffs.hayfever_widget then
        self.root.buffs.hayfever_widget:Kill()
        self.root.buffs.hayfever_widget = nil
    end

    self.root.buffs.food_temp_taskinfo = nil
end

function Buffs:UpdateTimer(widget, timeLeft)
    if not widget then return end

    local timeLeft = math.max(0, timeLeft)
    local minutes = math.floor(timeLeft / 60)
    local seconds = round(timeLeft % 60)

    if minutes < 10 then
        minutes = "0" .. minutes
    end

    if seconds < 10 then
        seconds = "0" .. seconds
    end

    widget.timeLeft:SetString(minutes .. ":" .. seconds)
end

function Buffs:UpdateWidgets(player)
    for key, widget in pairs(self.root.buffs.items) do
        local new_time = self.buff_add_timers[key]

        if key == "WX_CHARGE" then
            new_time = player.charge_time

            if new_time <= 0 then
                self.shouldRebuild = true
                return
            end

            if self.buff_mult_mods[key] then -- If in SW/HAM
                widget.hovertext:SetString("+".. round(100 * self.buff_mult_mods[key]) .."%")
            end
        end

        self:UpdateTimer(widget, new_time)
    end

    if self.root.buffs.food_temp_widget then
        if player.food_temp_task.limit == 0 or player.recent_temperatured_food == 0 then
            self.shouldRebuild = true
            return
        end

        self:UpdateTimer(self.root.buffs.food_temp_widget, player:TimeRemainingInTask(self.root.buffs.food_temp_taskinfo))
    end

    if self.root.buffs.hayfever_widget then
        if player.components.hayfever.nextsneeze <= 0 or not player.components.hayfever.enabled then
            player.components.hayfever.using_antihistamine = false
            self.shouldRebuild = true
            return
        end

        self:UpdateTimer(self.root.buffs.hayfever_widget, player.components.hayfever.nextsneeze)
    end
end

function Buffs:CreateWidgets(player)
    local count = 1
    for key, time in pairs(self.buff_add_timers) do
        if self:IsMonitoringBuff(key) then
            local buff_mod = "+".. round(WILSON_SPEED_DIVIDED_BY_100 * self.buff_add_mods[key]) .."%"
            self.root.buffs.items[key] = self.root.buffs:AddChild(Buff(key, count, buff_mod))
            count = count + 1
        end
    end

    if player.charge_time and player.charge_time > 0 then
        local key = "WX_CHARGE"

        if self:IsMonitoringBuff(key) then
            local buff_mod = self.buff_mult_mods[key] and "+".. round(100 * self.buff_mult_mods[key]) .."%" or "+50%"
            self.root.buffs.items[key] = self.root.buffs:AddChild(Buff(key, count, buff_mod))
            count = count + 1
        end
    end

    -- Warming foods handler.
    local food_temperature = player.recent_temperatured_food
    if player and food_temperature ~= nil and food_temperature ~= 0 and player.food_temp_task  then
        local buff_type = food_temperature > 0 and "FOOD_TEMP_HOT" or "FOOD_TEMP_COLD"
        local buff_mod = food_temperature > 0  and "+"..food_temperature or food_temperature

        self.root.buffs.food_temp_widget = self.root.buffs:AddChild( Buff(buff_type, count, buff_mod) )
        self.root.buffs.food_temp_taskinfo = player:GetTaskInfo(player.food_temp_task.period)
        count = count + 1
    end
    
    if player.components.hayfever and player.components.hayfever.using_antihistamine and player.components.hayfever.enabled then
        self.root.buffs.hayfever_widget = self.root.buffs:AddChild( Buff("HAYFEVER", count) )
        count = count + 1
    end
end

function Buffs:OnUpdate(dt)
    local player = GetPlayer()

    if self.shouldRebuild then
        self:ResetWidgets()
        self:CreateWidgets(player)
    end

    self.shouldRebuild = false

    self:UpdateWidgets(player)
end

return Buffs
