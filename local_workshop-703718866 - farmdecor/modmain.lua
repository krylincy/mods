local decors = {}
if(GLOBAL.IsDLCEnabled(GLOBAL.REIGN_OF_GIANTS) or GLOBAL.IsDLCEnabled(GLOBAL.CAPY_DLC))
then
    decors = {"fencepost", "fencepostright", "burntfencepostright", "burntfencepost"}
else
    decors = {"fencepost", "fencepostright"}
end
for _, v in pairs(decors)
do
    AddPrefabPostInit(
        v,
        function(inst)
            inst:DoTaskInTime(
                0,
                function(inst)
                    if(inst and inst:IsValid())
                    then
                        inst:Hide()
                    end
                end
            )
        end
    )
end