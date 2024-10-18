ESX = exports["es_extended"]:getSharedObject()

local case = nil
local isInVehicle = false

CreateThread(function ()
    while true do
        local playerPed = PlayerPedId()

        if not Config.CanSprintWithCase then
            if case ~= nil then
                print("case is not nil, disabling sprint")
                DisableControlAction(0, 21, true) -- Sprinten deaktivieren
            else
                print("case is nil, enabling sprint")
                EnableControlAction(0, 21, true) -- Sprinten aktivieren
            end
        end

        if IsPedInAnyVehicle(playerPed, false) then
            if case ~= nil then
                print('player in car')
                DeleteEntity(case)
                case = nil
                isInVehicle = true
            end
        end
        Wait(Config.Wait)
    end
end)



RegisterNetEvent("esx_case:spawnCase")
AddEventHandler("esx_case:spawnCase", function()
    if case == nil and isInVehicle == false then
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)

        local caseModel = GetHashKey("prop_security_case_01")
        local new_case = CreateObject(caseModel, playerCoords.x, playerCoords.y, playerCoords.z, true, true, true)

        local hand = GetEntityBoneIndexByName(playerPed, "IK_R_Hand")

        AttachEntityToEntity(new_case, playerPed, hand, 0.1, 0.0, 0.0, 0.0, -90.0, 45.0, true, true, false, true, 1, true)

        case = new_case
    end

    

    
end)

RegisterNetEvent("esx_case:deleteCase")
AddEventHandler("esx_case:deleteCase", function()
    if case ~= nil then
        DeleteEntity(case)
        case = nil
    end
end)


AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        if case ~= nil then
            DeleteEntity(case)
            case = nil
        end
    end
end)