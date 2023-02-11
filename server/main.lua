ESX = exports['es_extended']:getSharedObject()

ESX.RegisterServerCallback('JG-DrugAddiction:getdrugconsumption', function(src, cb)
   local xPlayer = ESX.GetPlayerFromId(src)
   if xPlayer then
    MySQL.scalar('SELECT drugconsumption FROM users WHERE identifier = ?', {xPlayer.identifier}, function(drugconsumption)
    cb(drugconsumption)
    end)
    end
end)

ESX.RegisterServerCallback('JG-DrugAddiction:adddrugconsumption', function(src)
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer then
        MySQL.update('UPDATE users SET drugconsumption = drugconsumption + 1 WHERE identifier = ?', {xPlayer.identifier})
     end
 end)
 


for k,v in pairs(Config.items) do 
    ESX.RegisterUsableItem(k, function(playerId)
       local xPlayer = ESX.GetPlayerFromId(playerId)
       xPlayer.triggerEvent('JG-DrugAddiction:encrementdrug')
       xPlayer.triggerEvent('JG-DrugAddiction:reducedesire')
    end)
end   



ESX.RegisterUsableItem('cureitem', function(playerId)
   local xPlayer = ESX.GetPlayerFromId(playerId)
   xPlayer.triggerEvent('JG-DrugAddiction:Cure')
   xPlayer.removeInventoryItem('cureitem', 1)
   xPlayer.showNotification('You are cured') 
   if xPlayer then
    MySQL.update('UPDATE users SET drugconsumption = 0 WHERE identifier = ?', {xPlayer.identifier})
   end
end)

