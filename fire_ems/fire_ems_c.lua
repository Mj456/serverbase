IsEMS = false




-- General Functions -- 

function loadAnimDict(dict)
    RequestAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do        
        Citizen.Wait(1)
    end
end


function DrawText3Ds(x, y, z, text)
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local px,py,pz=table.unpack(GetGameplayCamCoords())

	SetTextScale(0.35, 0.35)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 215)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
end


function drawTxt(x,y ,width,height,scale, text, r,g,b,a, outline)
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




--------------------------------------------------------------------------------
------------------------------EMS/FIRE System-----------------------------------
--------------------------------------------------------------------------------


--Functions--

function fireonduty()
	    IsEMS = true
  		local player = GetPlayerPed(-1)
        local model = GetHashKey("s_m_y_fireman_01") -- Change model name here <-
        IsCop = false
        		RequestModel(model)
        		while not HasModelLoaded(model) do
            	RequestModel(model)
            	Citizen.Wait(0)
        	end
       			SetPlayerModel(PlayerId(), model)
        		SetModelAsNoLongerNeeded(model)
				SetPlayerModel(player, GetHashKey(model))
        		SetModelAsNoLongerNeeded(model)					
				GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_FLASHLIGHT"), 1000, false)
				GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_FLASHLIGHT"), 1000, false)

end

function emsonduty()
	    IsEMS = true
  		local player = GetPlayerPed(-1)
        local model = GetHashKey("s_m_m_paramedic_01") -- Change model name here <-
        IsCop = false
        		RequestModel(model)
        		while not HasModelLoaded(model) do
            	RequestModel(model)
            	Citizen.Wait(0)
        	end
       			SetPlayerModel(PlayerId(), model)
        		SetModelAsNoLongerNeeded(model)
				SetPlayerModel(player, GetHashKey(model))
        		SetModelAsNoLongerNeeded(model)					
				GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_FLASHLIGHT"), 1000, false)
				GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_FLASHLIGHT"), 1000, false)

end

local vehs = {
		[1] = {["x"] = 1710.89, ["y"] = 3594.51, ["z"] = 35.42, "ambulance"},
}

-- Citizen.CreateThread(function()
-- 	local ped = GetPlayerPed(-1)
-- 	local coords = GetEntityCoords(ped)
-- 	while true do	
-- 		Wait(0)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsPlayerFreeAiming(GetPlayerPed(-1)) then 
			print("aiming")
		end
	end 
end)


function emsoffduty()
	IsEMS = false
	        local model = GetHashKey("mp_m_freemode_01") -- Change model name here <-
        		RequestModel(model)
        		while not HasModelLoaded(model) do
            	RequestModel(model)
            	Citizen.Wait(0)
        	end
       			SetPlayerModel(PlayerId(), model)
        		SetModelAsNoLongerNeeded(model)
				SetPlayerModel(player, GetHashKey(model))
        		SetModelAsNoLongerNeeded(model)
				SetPedComponentVariation(GetPlayerPed(-1), 8, 1, 0, 0) --shirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 3, 7, 0) --torso2 (shirt/jacket)
				SetPedComponentVariation(GetPlayerPed(-1), 9, 13, 0, 0) --armour
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 0) --arms
				SetPedComponentVariation(GetPlayerPed(-1), 4, 35, 0, 0) --trousers
				SetPedComponentVariation(GetPlayerPed(-1), 7, 8, 0, 0) --chain
				SetPedComponentVariation(GetPlayerPed(-1), 5, 0, 0, 0) --gloves
				SetPedComponentVariation(GetPlayerPed(-1), 6, 3, 0, 0) --shoes
				local player = GetPlayerPed(-1)
				RemoveAllPedWeapons(player, true)
end

-- Sandy Spawn --

function spawnambo()
local model = "ambulance" -- <-- Change the Model Name here for custom vehicles --
local player = GetPlayerPed(-1)
local pl = GetEntityCoords(player)
local heading = GetEntityHeading(player)
RequestModel(model)
while not HasModelLoaded(model) do
RequestModel(model)
Citizen.Wait(0)
end
local ve = CreateVehicle(model, 1709.11, 3594.16, 35.42, 207.8)
SetModelAsNoLongerNeeded(model)
SetPedIntoVehicle(player, ve, -1) 
end 
  	
function spawnfire()
local model = "firetruk" -- <-- Change the Model Name here for custom vehicles --
local player = GetPlayerPed(-1)
local pl = GetEntityCoords(player)
local heading = GetEntityHeading(player)
RequestModel(model)
while not HasModelLoaded(model) do
RequestModel(model)
Citizen.Wait(0)
end
local ve = CreateVehicle(model, 1709.11, 3594.16, 35.42, 207.8)
SetModelAsNoLongerNeeded(model)
SetPedIntoVehicle(player, ve, -1) 
end

-- Paleto Spawn -- 

function spawnambo2()
local model = "ambulance" -- <-- Change the Model Name here for custom vehicles --
local player = GetPlayerPed(-1)
local pl = GetEntityCoords(player)
local heading = GetEntityHeading(player)
RequestModel(model)
while not HasModelLoaded(model) do
RequestModel(model)
Citizen.Wait(0)
end
local ve = CreateVehicle(model, -369.52, 6126.9, 31.44, 43.21)
SetModelAsNoLongerNeeded(model)
SetPedIntoVehicle(player, ve, -1) 
end 
  	
function spawnfire2()
local model = "firetruk" -- <-- Change the Model Name here for custom vehicles --
local player = GetPlayerPed(-1)
local pl = GetEntityCoords(player)
local heading = GetEntityHeading(player)
RequestModel(model)
while not HasModelLoaded(model) do
RequestModel(model)
Citizen.Wait(0)
end
local ve = CreateVehicle(model, -370.4, 6127.5, 31.44, 43.21)
SetModelAsNoLongerNeeded(model)
SetPedIntoVehicle(player, ve, -1) 
end

-- City Spawn --

function spawnambo3()
local model = "ambulance" -- <-- Change the Model Name here for custom vehicles --
local player = GetPlayerPed(-1)
local pl = GetEntityCoords(player)
local heading = GetEntityHeading(player)
RequestModel(model)
while not HasModelLoaded(model) do
RequestModel(model)
Citizen.Wait(0)
end
local ve = CreateVehicle(model, 365.57, -593.25, 28.69, 338.26)
SetModelAsNoLongerNeeded(model)
SetPedIntoVehicle(player, ve, -1) 
end 
  	
function spawnfire3()
local model = "firetruk" -- <-- Change the Model Name here for custom vehicles --
local player = GetPlayerPed(-1)
local pl = GetEntityCoords(player)
local heading = GetEntityHeading(player)
RequestModel(model)
while not HasModelLoaded(model) do
RequestModel(model)
Citizen.Wait(0)
end
local ve = CreateVehicle(model, 365.57, -593.25, 28.69, 338.26)
SetModelAsNoLongerNeeded(model)
SetPedIntoVehicle(player, ve, -1) 
end

--Sign on/off--

-- Coords to save --


-- 1690.08, 3581.64, 35.62 <-- Sandy Shores Sign on/off--
-- 1701.03, 3587.56, 35.55 <-- Sandy Shores Spawner -- 

-- -379.95, 6118.63, 31.85 <-- Paleto Sign On/off -- 
-- -369.52, 6126.9, 31.44 <-- Paleto selector  --
-- -369.52, 6126.9, 31.44 <-- Paleto Spawner  --

Citizen.CreateThread(function()
	while true do
		local player = GetPlayerPed(-1)
		local pl = GetEntityCoords(player, true)
		Wait(0)
			if Vdist2(pl.x, pl.y, pl.z, -379.95, 6118.63, 31.85) < 1.0 and IsEMS == false then 
			DrawText3Ds(-379.95, 6118.63, 31.85, "~w~Press [~g~E~w~] To go on duty as EMS OR [~g~G~w~] To go onduty as fire")
			if IsControlJustReleased(1, 38) then 
				emsonduty()
			elseif 
				IsControlJustReleased(1, 183) then 
				fireonduty()
			end
			elseif
			Vdist2(pl.x, pl.y, pl.z, 1690.08, 3581.64, 35.62) < 1.0 and IsEMS == false then 
			DrawText3Ds(1690.08, 3581.64, 35.62, "~w~Press [~g~E~w~] To go on duty as EMS OR [~g~G~w~] To go onduty as fire")
			if IsControlJustReleased(1, 38) then 
				emsonduty()
			elseif
			IsControlJustReleased(1, 183) then
				fireonduty()	
			end
			elseif 
			Vdist2(pl.x, pl.y, pl.z, 356.9, -593.86, 28.78) < 1.0 and IsEMS == false then 
			DrawText3Ds(356.9, -593.86, 28.78, "~w~Press [~g~E~w~] To go on duty as EMS OR [~g~G~w~] To go onduty as fire")
			if IsControlJustReleased(1, 38) then 
				emsonduty()
			elseif 
				IsControlJustReleased(1, 183) then 
				fireonduty()
			end			
			elseif
			Vdist2(pl.x, pl.y, pl.z, 1690.08, 3581.64, 35.62) < 1.0 and IsEMS == true then 
			DrawText3Ds(1690.08, 3581.64, 35.62, "~w~Press [~g~E~w~] To go off duty ")
			if IsControlJustReleased(1, 38) then 
			emsoffduty()
			end
			elseif
			Vdist2(pl.x, pl.y, pl.z, -379.95, 6118.63, 31.85) < 1.0 and IsEMS == true then 
			DrawText3Ds(-379.95, 6118.63, 31.85, "~w~Press [~g~E~w~] To go off duty ")
			if IsControlJustReleased(1, 38) then 
			emsoffduty()
			end
			elseif
			Vdist2(pl.x, pl.y, pl.z, 356.9, -593.86, 28.78) < 1.0 and IsEMS == true then 
			DrawText3Ds(356.9, -593.86, 28.78, "~w~Press [~g~E~w~] To go off duty ")
			if IsControlJustReleased(1, 38) then 
			emsoffduty()
			end							
		end
	end
end)

-- Revive Command --

-- RegisterCommand("revive", function(source, args, rawCommand)
--     local player = GetPlayerPed(-1)
--     -- local target = args[1] = PlayerPedId()
--         SetEntityHealth(target, 200)
--         Citizen.Wait(100)
--         ClearPedTasksImmediately(target)
-- end)


-- Ambulance Spawn -- 


Citizen.CreateThread(function()
	while true do
		local player = GetPlayerPed(-1)
		local pl = GetEntityCoords(player)
			Citizen.Wait(0)
			if IsEMS == true then
			if Vdist2(pl.x, pl.y, pl.z, 1701.03, 3587.56, 35.55) < 2.0 then
				   DrawText3Ds(1701.03, 3587.56, 35.55, "~w~Press [~g~E~w~] To spawn an ambulance or Press [~g~G~w~] To spawn a Firetruck")
			if IsControlJustReleased(1, 38) then 
				spawnambo()
			elseif IsControlJustReleased(1, 183) then 
				spawnfire()
				end
			elseif
				Vdist2(pl.x, pl.y, pl.z, -376.89, 6124.55, 31.44) < 2.0 and IsEMS == true then
				DrawText3Ds(-376.89, 6124.55, 31.44, "~w~Press [~g~E~w~] To spawn an ambulance or Press [~g~G~w~] To spawn a Firetruck")
 			if IsControlJustReleased(1, 38) then
 				spawnambo2()
			elseif
				IsControlJustReleased(1, 183) then
				spawnfire2()
				end
			elseif
				Vdist2(pl.x, pl.y, pl.z, 358.38, -589.35, 28.8) < 2.0 and IsEMS == true then
				DrawText3Ds(358.38, -589.35, 28.8, "~w~Press [~g~E~w~] To spawn an ambulance or Press [~g~G~w~] To spawn a Firetruck")
 			if IsControlJustReleased(1, 38) then
 				spawnambo3()
			elseif
				IsControlJustReleased(1, 183) then
				spawnfire3()
				end				
			end
		end
	end
end)


