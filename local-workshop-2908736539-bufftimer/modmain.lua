GLOBAL.setmetatable(env,{__index=function(t,k) return GLOBAL.rawget(GLOBAL,k) end})

-----------------------------------

if not (IsDLCEnabled(3) or IsDLCEnabled(2) or IsDLCEnabled(1)) then
    return -- It doesn't need to run in the base game!
end

local GetConfig = GetModConfigData

local configs = {"ALWAYS_SHOW_TIMER", "LEFT_OFFSET", "TOP_OFFSET", "IMAGE_SIZE", "MARGIN", "FONT_SIZE_TIMELEFT", "FONT_SIZE_MOD"}

GLOBAL.BUFF_TIMERS_MOD_GLOBAL_CONFIGS = {}

for _, key in pairs(configs) do
    GLOBAL.BUFF_TIMERS_MOD_GLOBAL_CONFIGS[key] = GetConfig(key)
end

-----------------------------------

local Buffs = require("Buffs")

AddClassPostConstruct("widgets/controls", function(controls)
    controls.inst:DoTaskInTime(0, function ()
        controls.buff_timers = controls.top_root:AddChild(Buffs())
    end)
end)

-----------------------------------

local function SafeUpdateDebuffs(key, is_add)
    local player = GetPlayer()
    if player and player.HUD and player.HUD.controls and player.HUD.controls.buff_timers then
        GetPlayer().HUD.controls.buff_timers:UpdateBuffs(key, is_add)
    end
end

local function LocomotorPostInit(inst)
    local self = inst.components.locomotor
    
    local AddSpeedModifier_Additive    = self.AddSpeedModifier_Additive
    local RemoveSpeedModifier_Additive = self.RemoveSpeedModifier_Additive

    function self:AddSpeedModifier_Additive(key, ...)
        SafeUpdateDebuffs(key, true)
        AddSpeedModifier_Additive(self, key, ...)
    end

    function self:RemoveSpeedModifier_Additive(key, ...)
        SafeUpdateDebuffs(key, false)
        RemoveSpeedModifier_Additive(self, key, ...)
    end
end

-----------------------------------

local function OnEat(player, data)
    if data.food.components.edible.temperaturedelta then
        SafeUpdateDebuffs("FOOD_TEMP_HOT")
    end
    if data.food.components.edible.antihistamine and player.components.hayfever and player.components.hayfever.enabled then
        player.components.hayfever.using_antihistamine = true
        SafeUpdateDebuffs("HAYFEVER")
    end
end

AddPlayerPostInit(function(inst)
    inst:DoTaskInTime(0, LocomotorPostInit)

    inst:ListenForEvent("oneatsomething", OnEat)
end)

-----------------------------------

AddComponentPostInit("playerlightningtarget", function(self)
    local _DoStrike = self.DoStrike

    function self:DoStrike(...)
        _DoStrike(self, ...)
        SafeUpdateDebuffs("WX_CHARGE", true)
    end
end)

AddComponentPostInit("hayfever", function(self)
    self.using_antihistamine = false

    local OnSave = self.OnSave
    local OnLoad = self.OnLoad

    function self:OnSave()
        local data = OnSave(self)
        data.using_antihistamine = self.using_antihistamine

        return data
    end

    function self:OnLoad(data)
        OnLoad(self, data)

        if data.using_antihistamine then
            self.using_antihistamine = data.using_antihistamine
        end
    end
end)


configs, GetConfig = nil, nil