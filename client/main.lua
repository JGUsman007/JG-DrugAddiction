
local drugdesire = 11


CreateThread(function()
while true do
    if drugdesire > 0 then
        drugdesire = drugdesire - 1
    end
    Wait(80000)
   end
end)


RegisterNetEvent('JG-DrugAddiction:encrementdrug', function()
    ESX.TriggerServerCallback('JG:getdrugconsumption', function(drugconsumption)
    if drugconsumption < Config.itemsrequired then
        ESX.TriggerServerCallback('JG:adddrugconsumption', function()end)
    elseif drugconsumption == Config.itemsrequired and drugdesire < Config.itemsrequired then
            drugdesire = drugdesire + 2
        end
    print(drugconsumption,drugdesire)
end)
end)

RegisterNetEvent('JG-DrugAddiction:reducedesire', function()
    ESX.TriggerServerCallback('JG:getdrugconsumption', function(drugconsumption)
     end)
end)


RegisterNetEvent('JG-DrugAddiction:Cure', function()
    Wait(1000)
    drugdesire = 11
    SetTimecycleModifier('AMBIENTPUSH')
    StopScreenEffect('PeyoteEndOut')
    StopScreenEffect('Dont_tazeme_bro')
    StopScreenEffect('MP_race_crash')
end)



CreateThread(function()
    while true do
local player = PlayerPedId()

local health = GetEntityHealth(player)
        ESX.TriggerServerCallback('JG-DrugAddiction:getdrugconsumption', function(drugconsumption)
        if drugconsumption == Config.itemsrequired then
            if drugdesire > 3 then
                SetTimecycleModifier('AMBIENTPUSH')
                StopScreenEffect('PeyoteEndOut')
                StopScreenEffect('Dont_tazeme_bro')
                StopScreenEffect('MP_race_crash')
            end
            if drugdesire == 3 then
                ESX.ShowNotification("Your body desire drugs")
                StartScreenEffect('PeyoteEndOut', 0, true)
                SetPedToRagdoll(player, 5000, 1, 2)
            elseif drugdesire == 2 then
                ESX.ShowNotification("Your body desire drugs")
                StartScreenEffect('MP_race_crash', 0, true)
                SetPedToRagdoll(player, 5000, 1, 2)
            elseif drugdesire == 1 then
                ESX.ShowNotification("Your body desire drugs")
                ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.08) 
				SetPedToRagdoll(player, 5000, 1, 2)
                SetEntityHealth(player,health - 4)
            elseif drugdesire == 0 then
                ESX.ShowNotification("Your body desire drugs")
                ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.08) 
				SetPedToRagdoll(player, 5000, 1, 2)
                StartScreenEffect('MP_race_crash', 0, true)
                SetEntityHealth(player,health - 10)
            end
        end
    end)
    Wait(10000)
    
end
end)


