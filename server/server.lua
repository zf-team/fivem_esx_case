ESX = exports["es_extended"]:getSharedObject()

CreateThread(function ()
    while true do
        local playerCount = GetNumPlayerIndices()

        if playerCount > 0 then
            for k, playerid in pairs(GetPlayers()) do
                local xPlayer = ESX.GetPlayerFromId(playerid)

                if xPlayer ~= nil and (xPlayer.getAccount('money').money >= Config.Amount) then
                    TriggerClientEvent('esx_case:spawnCase', playerid)            
                else
                    TriggerClientEvent('esx_case:deleteCase', playerid)
                end
            end
        end

        Wait(Config.Wait)
    end
end)


AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        for k, playerid in pairs(GetPlayers()) do
            TriggerClientEvent('esx_case:deleteCase', playerid)
        end
    end
end)