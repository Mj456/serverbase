isLocked = nil
doorList = {1,2,3,4,5,6,7,8,9,10,11,12,13}


RegisterCommand('cuff', function(source, args)
    if args[1] ~= nil then
        TriggerClientEvent('anim:cuff', tonumber(args[1]))
    
    else
        if source == 0 then
            print('You can\'t cuff from the console without specifying a player to cuff, you idiot!')
        
        else
            -- Cuff that idiot!
            TriggerClientEvent('anim:cuff', source)
        end
    end
    
end, true)



-- Doorlock -- 

RegisterServerEvent('door:update')
AddEventHandler('door:update', function(id, isLocked)
    if (id ~= nil and isLocked ~= nil) then -- Make sure values got sent
        TriggerClientEvent('door:state', -1, id, isLocked)
        
    end
end)



-- Handcuff --

RegisterServerEvent('fx:cuff')
AddEventHandler('fx:cuff', function(id)
    TriggerClientEvent("fx:c_cuff", id)
end)

RegisterServerEvent('fx:piv')
AddEventHandler('fx:piv', function(id)
    TriggerClientEvent("fx:c_piv", id)
end)

