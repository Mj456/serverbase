isLocked = nil
doorList = {1,2,3,4,5,6,7,8,9,10,11,12,13}


RegisterServerEvent('door:update')
AddEventHandler('door:update', function(id, isLocked)
    if (id ~= nil and isLocked ~= nil) then -- Make sure values got sent
        TriggerClientEvent('door:state', -1, id, isLocked)
        
    end
end)