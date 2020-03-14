--------------------------------------------------------------------------------
------------------------------Death System--------------------------------------
--------------------------------------------------------------------------------

IsDead = false
local secondsRemaining = 150 --< Change this to what ever you want in seconds. this will be the amount of time before it will let them respawn.

-- Functions --
function drawTxt(x,y,width,height,scale, text, r,g,b,a, outline)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    if(outline)then
    SetTextOutline()
    end
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end


function startT(source)
    local helth = GetEntityHealth(GetPlayerPed(-1))
	if secondsRemaining > 1 then 
 	drawTxt(0.66, 1.4, 1.0,1.0,0.4, "~w~Dead! ~r~" .. secondsRemaining .. "~w~ seconds remaining untill you can respawn", 255, 255, 255, 255)
	end
   	if secondsRemaining < 1 then 
   drawTxt(0.66, 1.4, 1.0,1.0,0.4, "~w~Press ~w~[~r~E~w~] to respawn, or wait for EMS!", 255, 255, 255, 255)
   end 
        	if IsControlJustReleased(1, 38) and secondsRemaining < 1 then 
        	IsDead = false
        	DoScreenFadeOut(3000)
        	Citizen.Wait(3000)
        	SetEntityHealth(GetPlayerPed(-1), 200)      
        	SetEntityCoords(GetPlayerPed(-1), 1853.0, 3710.9, 33.5)
        	DoScreenFadeIn(3000)
        	FreezeEntityPosition(GetPlayerPed(-1), false)
        	ResetPedVisibleDamage(GetPlayerPed(-1))
        	secondsRemaining = 15 --< Make sure you change this one too.

    end
end

-- Code -- 


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        if secondsRemaining > 0 and IsDead == true then 
            secondsRemaining = secondsRemaining -1
        end
    end
end)



Citizen.CreateThread(function()
    while true do
    	local health = GetEntityHealth(GetPlayerPed(-1))
        Citizen.Wait(0)
		if health < 2 then
		IsDead = true    
	    end
	end
end)


Citizen.CreateThread(function()
    while true do
    	local player = GetPlayerPed(-1)
        Citizen.Wait(0)
        	if IsDead == true then
    exports.spawnmanager:setAutoSpawn(false)                
        	startT()
        	SetEntityHealth(player, 200) 
			loadAnimDict( "dead" )
			TaskPlayAnim(GetPlayerPed(-1), "dead", "dead_a", 1.0, 1.0, -1, 1, 0, 0, 0, 0)            
 	   end
	end
end)


--Die Command--

RegisterCommand("die", function(source, args, rawCommand)
	IsDead = true
end)



RegisterCommand("revive", function(source, args, rawCommand)
    local player = GetPlayerPed(-1)
    local coords = GetEntityCoords(player)    
    if IsDead == true then 
    secondsRemaining = 150  -- < change this one too!
    IsDead = false
    DoScreenFadeOut(3000)
    Citizen.Wait(3000)
    SetPlayerInvisibleLocally(player, true)
    Wait(300)
    ClearPedTasks(player)
    SetPlayerInvisibleLocally(player, false)        
    SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z, false, false, false, true)
    NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, true, false)
    DoScreenFadeIn(3000)     
    end      
end)

