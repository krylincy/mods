local function createBerryPrefab(tag, name)
    return function(Sim)
        local inst = CreateEntity()
        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        MakeInventoryPhysics(inst)

        if name == "berries_blue" then
            inst.AnimState:SetBank("berriesblue")
            inst.AnimState:SetBuild("berriesblue")
        else
            inst.AnimState:SetBank("berriespink")
            inst.AnimState:SetBuild("berriespink")
        end

        inst.AnimState:PlayAnimation("idle")

        inst:AddComponent("edible")
        inst:AddComponent("perishable")

        inst.components.edible.healthvalue = 0
        inst.components.edible.hungervalue = TUNING.CALORIES_TINY
        inst.components.edible.sanityvalue = 0
        inst.components.perishable:SetPerishTime(TUNING.PERISH_FAST)

        inst.components.edible.foodtype = "VEGGIE"
        inst.components.edible.foodstate = "RAW"

        inst.components.perishable:StartPerishing()
        inst.components.perishable.onperishreplacement = "spoiled_food"

        inst:AddComponent("stackable")
        inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

        inst:AddTag(tag)

        inst:AddComponent("inspectable")
        inst:AddComponent("inventoryitem")

        inst.components.inventoryitem.atlasname =
            "images/inventoryimages/" .. name .. ".xml"
        inst.components.inventoryitem.imagename = name

        MakeSmallBurnable(inst)
        MakeSmallPropagator(inst)

        MakeInventoryFloatable(inst, "idle_water", "idle")

        inst:AddComponent("bait")
        inst:AddComponent("tradable")

        inst:AddTag("noautopickup")

        return inst
    end
end

local assets = {Asset("ANIM", "anim/berriespink.zip"),
                Asset("ANIM", "anim/berriesblue.zip"),
                Asset("IMAGE", "images/inventoryimages/berries_blue.tex"),
                Asset("ATLAS", "images/inventoryimages/berries_blue.xml"),
                Asset("IMAGE", "images/inventoryimages/berries_pink.tex"),
                Asset("ATLAS", "images/inventoryimages/berries_pink.xml")}


return Prefab("common/inventory/berries_blue", createBerryPrefab("doydoypetfood_blue", "berries_blue"), assets),
    Prefab("common/inventory/berries_pink",
        createBerryPrefab("doydoypetfood_pink", "berries_pink"),
        assets)
