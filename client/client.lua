ESX = exports["es_extended"]:getSharedObject()

local case = nil
local isInVehicle = false
local weaponInHand = false

local disabledSprint = false
local disabledWeapon = false

CreateThread(function ()
    while true do
        local playerPed = PlayerPedId()
        local hasWeapon, weaponHash = GetCurrentPedWeapon(playerPed, true)

        if not Config.CanSprintWithCase then
            if case ~= nil then
                if not disabledSprint then
                    print("case is not nil, disabling sprint")
                    DisableControlAction(0, 21, true) -- Sprinten deaktivieren 
                    disabledSprint = true
                end
            else
                print("case is nil, enabling sprint")
                EnableControlAction(0, 21, true) -- Sprinten aktivieren
                disabledSprint = false
            end
        end

        if IsPedInAnyVehicle(playerPed, false) then
            if case ~= nil then
                print('player in car')
                DeleteEntity(case)
                case = nil
                isInVehicle = true
            end
        else
            if case == nil and isInVehicle == true then
                print('player left car')
                TriggerEvent("esx_case:spawnCase")
                isInVehicle = false
            end
        end


        -- Weapon Interactions

        if hasWeapon then
            if case ~= nil and not weaponInHand then
                print("player has a weapon, deleting case")
                DeleteEntity(case)
                case = nil
                weaponInHand = true
            end
        else
            weaponInHand = false
            TriggerEvent("esx_case:spawnCase")

        end

        if not Config.CanHoldWeaponWithCase then
            if case ~= nil then
                if not disabledWeapon then
                    print("case is not nil, disabling weapon")
                    DisableControlAction(0, 37, true) -- Disable weapon wheel
                    DisableControlAction(0, 157, true) -- Disable select weapon 1
                    DisableControlAction(0, 158, true) -- Disable select weapon 2
                    DisableControlAction(0, 159, true) -- Disable select weapon 3
                    DisableControlAction(0, 160, true) -- Disable select weapon 4
                    DisableControlAction(0, 161, true) -- Disable select weapon 5
                    DisableControlAction(0, 162, true) -- Disable select weapon 6
                    DisableControlAction(0, 163, true) -- Disable select weapon 7
                    DisableControlAction(0, 164, true) -- Disable select weapon 8
                    DisableControlAction(0, 165, true) -- Disable select weapon 9
                    disabledWeapon = true
                end
            else
                EnableControlAction(0, 37, true) -- Enable weapon wheel
                EnableControlAction(0, 157, true) -- Enable select weapon 1
                EnableControlAction(0, 158, true) -- Enable select weapon 2
                EnableControlAction(0, 159, true) -- Enable select weapon 3
                EnableControlAction(0, 160, true) -- Enable select weapon 4
                EnableControlAction(0, 161, true) -- Enable select weapon 5
                EnableControlAction(0, 162, true) -- Enable select weapon 6
                EnableControlAction(0, 163, true) -- Enable select weapon 7
                EnableControlAction(0, 164, true) -- Enable select weapon 8
                EnableControlAction(0, 165, true) -- Enable select weapon 9
                disabledWeapon = false
            end
        end
        
        Wait(Config.Wait)
    end
end)



RegisterNetEvent("esx_case:spawnCase")
AddEventHandler("esx_case:spawnCase", function()
    if case == nil and isInVehicle == false and weaponInHand == false then
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
