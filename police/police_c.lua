local handcuff = false
IsCop = false


-- General Functions -- 

function dC()

	DisableControlAction(0, 24, true) -- Attack
	DisableControlAction(0, 257, true) -- Attack 2
	DisableControlAction(0, 25, true) -- Aim
	DisableControlAction(0, 263, true) -- Melee Attack 1
	-- DisableControlAction(0, 32, true) -- W
	-- DisableControlAction(0, 34, true) -- A
	-- DisableControlAction(0, 31, true) -- S
	-- DisableControlAction(0, 30, true) -- D

	DisableControlAction(0, 45, true) -- Reload
	-- DisableControlAction(0, 22, true) -- Jump
	DisableControlAction(0, 44, true) -- Cover
	DisableControlAction(0, 37, true) -- Select Weapon
	-- DisableControlAction(0, 23, true) -- Also 'enter vehice????

	DisableControlAction(0, 288,  true) -- Disable phone
	DisableControlAction(0, 289, true) -- Inventory
	DisableControlAction(0, 170, true) -- Animations
	DisableControlAction(0, 167, true) -- Job

	DisableControlAction(0, 0, true) -- Disable changing view
	DisableControlAction(0, 26, true) -- Disable looking behind
	DisableControlAction(0, 73, true) -- Disable clearing animation
	DisableControlAction(2, 199, true) -- Disable pause screen

	DisableControlAction(0, 59, true) -- Disable steering in vehicle
	DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
	DisableControlAction(0, 72, true) -- Disable reversing in vehicle

	DisableControlAction(2, 36, true) -- Disable going stealth

	DisableControlAction(0, 47, true)  -- Disable weapon
	DisableControlAction(0, 264, true) -- Disable melee
	DisableControlAction(0, 257, true) -- Disable melee
	DisableControlAction(0, 140, true) -- Disable melee
	DisableControlAction(0, 141, true) -- Disable melee
	DisableControlAction(0, 142, true) -- Disable melee
	DisableControlAction(0, 143, true) -- Disable melee
	-- body
end

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
------------------------------Police System-------------------------------------
--------------------------------------------------------------------------------


--Functions--

function onduty()
IsCop = true
local player = GetPlayerPed(-1)
local model = GetHashKey("s_m_y_sheriff_01") -- Change model name here <-
    RequestModel(model)
    while not HasModelLoaded(model) do
       RequestModel(model)
       IsEMS = false
       Citizen.Wait(0)
	end
       	SetPlayerModel(PlayerId(), model)
        SetModelAsNoLongerNeeded(model)
		SetPlayerModel(player, GetHashKey(model))
        SetModelAsNoLongerNeeded(model)					
		SetPedArmour(player, 200)
		GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_COMBATPISTOL"), 1000, false)
		GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_COMBATPISTOL"), GetHashKey("COMPONENT_AT_PI_FLSH"))
		GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_FLARE"), 5, false)
		GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_NIGHTSTICK"), 1000, false)
		GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_FLASHLIGHT"), 1000, false)
		GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_STUNGUN"), 1000, false)
end

function offduty()
	IsCop = false
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
				SetPedComponentVariation(GetPlayerPed(-1), 3, 16, 0, 0) --arms
				SetPedComponentVariation(GetPlayerPed(-1), 4, 35, 0, 0) --trousers
				SetPedComponentVariation(GetPlayerPed(-1), 7, 8, 0, 0) --chain
				SetPedComponentVariation(GetPlayerPed(-1), 5, 0, 0, 0) --gloves
				SetPedComponentVariation(GetPlayerPed(-1), 6, 3, 0, 0) --shoes
				local player = GetPlayerPed(-1)
				RemoveAllPedWeapons(player, true)
end


--Sign on/off--

Citizen.CreateThread(function()
	while true do
		local player = GetPlayerPed(-1)
		local pl = GetEntityCoords(player)
			Citizen.Wait(0)
				if GetDistanceBetweenCoords(pl.x, pl.y, pl.z, 1856.72, 3689.58, 34.27) < 1.0 and IsCop == false then -- <-- Sandy Shores --
				   DrawText3Ds(1856.72, 3689.58, 34.27, "~w~Press [~g~E~w~] To Go on duty")
				if IsControlJustReleased(1, 38) then 
				onduty()
			end
		elseif 
			Vdist2(pl.x, pl.y, pl.z, -449.85, 6016.22, 31.72) < 1.0 and IsCop == false then -- <-- Paleto Bay --
				 DrawText3Ds(-449.85, 6016.22, 31.72, "~w~Press [~g~E~w~] To Go on duty")
				if IsControlJustReleased(1, 38) then 
					onduty()
				end
		elseif 
			Vdist2(pl.x, pl.y, pl.z, 440.48, -976.32, 30.69) < 1.0 and IsCop == false then -- <-- Mission Row --
				 DrawText3Ds(440.48, -976.32, 30.69, "~w~Press [~g~E~w~] To Go on duty")
				if IsControlJustReleased(1, 38) then 
					onduty()
				end				
				elseif GetDistanceBetweenCoords(pl.x, pl.y, pl.z, 1856.72, 3689.58, 34.27) < 1.0 and IsCop == true then  
				DrawText3Ds(1856.72, 3689.58, 34.27, "~w~Press [~g~E~w~] To Go off duty")
			if IsControlJustReleased(1, 38) then 
				offduty()
				end
			elseif GetDistanceBetweenCoords(pl.x, pl.y, pl.z, -449.85, 60.22, 31.72) < 1.0 and IsCop == true then 
				DrawText3Ds(-449.85, 6016.22, 31.72, "~w~Press [~g~E~w~] To Go off duty")
			if IsControlJustReleased(1, 38) then 
				offduty()
				end
			elseif GetDistanceBetweenCoords(pl.x, pl.y, pl.z, 440.48, -976.32, 30.69) < 1.0 and IsCop == true then 
				DrawText3Ds(440.48, -976.32, 30.69, "~w~Press [~g~E~w~] To Go off duty")
			if IsControlJustReleased(1, 38) then 
				offduty()								
			end 		
		end
	end
end)




-- Unrack/Rack Script for police --

-- "/unrack 1" for Rifle -- 
-- "/unrack 2" for Shotgun -- 

RegisterCommand("unrack", function(source, args)
local player = GetPlayerPed(-1)
local loc = GetEntityCoords(PlayerPedId(), true)
	if args[1] == "1" and IsCop == true then
		print("giving weapon")
			Citizen.Wait(300)
			GiveWeaponToPed(player, GetHashKey("WEAPON_CARBINERIFLE"), 1000, false) 
			GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_CARBINERIFLE"), GetHashKey("COMPONENT_AT_AR_FLSH"))
			GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_CARBINERIFLE"), GetHashKey("COMPONENT_AT_AR_AFGRIP"))
			GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_CARBINERIFLE"), GetHashKey("COMPONENT_AT_SCOPE_MEDIUM"))
		elseif args[1] == "2" and IsCop == true then
			GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PUMPSHOTGUN"), 1000, false)
			GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PUMPSHOTGUN"), GetHashKey("COMPONENT_AT_AR_FLSH"))
	end
end) 
	
-- "/unrack 1" for Rifle -- 
-- "/unrack 2" for Shotgun --

	RegisterCommand("rack", function(source, args)
	local player = GetPlayerPed(-1)
	tonumber(args[1]) 
		if IsCop == true and args[1] == "1"and IsCop == true then
			RemoveWeaponFromPed(player, "WEAPON_CARBINERIFLE")
	elseif IsCop == true and args[1] == "2" and IsCop == true then 
		RemoveWeaponFromPed(player, "WEAPON_PUMPSHOTGUN")
		end 
	end) 

RegisterCommand("vest", function(source, args)
local pl = GetEntityCoords(GetPlayerPed(-1))
	if IsCop == true and GetDistanceBetweenCoords(pl.x, pl.y, pl.z, 1856.72, 3689.58, 34.27) < 3.0 then -- Only able to get vest at sandy PD
    SetPedArmour(GetPlayerPed(-1), 100)
    end
end)



function ShowHelp(text, bleep)
    BeginTextCommandDisplayHelp("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayHelp(0, false, bleep, -1)
end




function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end 


RegisterNetEvent("fx:c_cuff")
AddEventHandler("fx:c_cuff", function(id)
handcuff = true
local lPed = GetPlayerPed(-1)
	if DoesEntityExist(lPed) then
		if IsEntityPlayingAnim(lPed, "mp_arresting", "idle", 3) then
			ClearPedSecondaryTask(lPed)
			SetEnableHandcuffs(lPed, false)
			SetCurrentPedWeapon(lPed, GetHashKey("WEAPON_UNARMED"), true)
			handcuff = false
		else
			RequestAnimDict("mp_arresting")
			while not HasAnimDictLoaded("mp_arresting") do
			Citizen.Wait(100)
		end
			TaskPlayAnim(lPed, "mp_arresting", "idle", 8.0, -8, -1, 49, 0, 0, 0, 0)
			SetEnableHandcuffs(lPed, true)
			SetCurrentPedWeapon(lPed, GetHashKey("WEAPON_UNARMED"), true)
			handcuff = true	
		end
	end
end)




Citizen.CreateThread(function()
	while true do
		Wait(0)
		if handcuff then 
			dC()
		end
	end
end)


-- Cuff -- 

RegisterCommand("cuff", function(source, args)
	if IsCop then
		TriggerServerEvent("fx:cuff", tonumber(args[1]))		
	end
end, false)


