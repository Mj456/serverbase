

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
------------------------------Disable Weapon Dot--------------------------------
--------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local player = GetPlayerPed(-1)
            HideHudComponentThisFrame( 14 )
            ShowHudComponentThisFrame( 19 )                        

	end
end)

--------------------------------------------------------------------------------
------------------------------CAR SCRIPT----------------------------------------
--------------------------------------------------------------------------------

RegisterCommand("car", function(source, args, rawCommand)
        local model = args[1]
        local player = GetPlayerPed(-1)
        local pl = GetEntityCoords(player)
        local heading = GetEntityHeading(player)
        		RequestModel(model)
        		while not HasModelLoaded(model) do
            	RequestModel(model)
            	Citizen.Wait(0)
        	end
        	local ve = CreateVehicle(model, pl.x, pl.y, pl.z, heading)
        	SetModelAsNoLongerNeeded(model)
    		SetPedIntoVehicle(player, ve, -1)    	
end)




--------------------------------------------------------------------------------
------------------------------Disable Cops and EMS------------------------------
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
------------------------------HandsUp-------------------------------------------
--------------------------------------------------------------------------------

Citizen.CreateThread(function()
    local dict = "missminuteman_1ig_2"
    
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(100)
    end
    local handsup = false
    while true do
        Citizen.Wait(0)
        if IsControlJustPressed(1, 323) then --Start holding X
            if not handsup then
                TaskPlayAnim(GetPlayerPed(-1), dict, "handsup_enter", 8.0, 8.0, -1, 50, 0, false, false, false)
                handsup = true
            else
                handsup = false
                ClearPedTasks(GetPlayerPed(-1))
            end
        end
    end
end)

--------------------------------------------------------------------------------
------------------------------Enable PVP----------------------------------------
--------------------------------------------------------------------------------

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        SetCanAttackFriendly(GetPlayerPed(-1), true, false)
        NetworkSetFriendlyFireOption(true)
    end
end)


--------------------------------------------------------------------------------
------------------------------Location Dispaly----------------------------------
--------------------------------------------------------------------------------
-- Citizen.CreateThread(function()
-- 	while true do
-- 		Citizen.Wait(0)
-- local player = GetPlayerPed(-1)
-- local pl = GetEntityCoords(player)
-- local pos GetStreetNameAtCoord(pl.x, pl.y, pl.z)
	



--------------------------------------------------------------------------------
------------------------------Car Commands-------------------------------------------
--------------------------------------------------------------------------------

--Fix /Repair vehicle--

RegisterCommand("fix", function(source, args, rawCommand)
	local ped = GetPlayerPed(-1)
	local car = GetVehiclePedIsIn(ped, false)
	SetVehicleFixed(car)
end)


--Change the vehicle livery--

RegisterCommand("livery", function(source, args, rawCommand)
	local ped = GetPlayerPed(-1)
	local car = GetVehiclePedIsIn(ped, false)
	local livery = tonumber(args[1])
	SetVehicleLivery(car, livery)
end)

RegisterCommand("window", function(source, args, rawCommand)
	local ped = GetPlayerPed(-1)
	local car = GetVehiclePedIsIn(ped, false)
	if args[1] == "down" then
	RollDownWindows(car)
	elseif args[1] == "up" then 
	RollUpWindow(car, -1)
	RollUpWindow(car, 1)
	RollUpWindow(car, 2)
	RollUpWindow(car, 3)
end
end)

-- DV --

RegisterCommand("dv", function(source, args, rawCommand)
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    SetEntityAsMissionEntity(vehicle, true, true)
    DeleteVehicle(vehicle)
end)




--------------------------------------------------------------------------------
------------------------------Never Wanted--------------------------------------
--------------------------------------------------------------------------------

Citizen.CreateThread(function()
    while true do
    	local player = GetPlayerPed(-1)
    	local level = GetPlayerWantedLevel(player)
        Citizen.Wait(0)
        if level > 0 then
        SetMaxWantedLevel(0)
        print("clearing wanted level")
    	end
	end
end)



-- Coords --

local coordsVisible = false

function DrawGenericText(text)
        SetTextColour(186, 186, 186, 255)
        SetTextFont(7)
        SetTextScale(0.578, 0.578)
        SetTextWrap(0.0, 1.0)
        SetTextCentre(false)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(1, 0, 0, 0, 205)
        SetTextEntry("STRING")
        AddTextComponentString(text)
        DrawText(0.40, 0.00)
end

Citizen.CreateThread(function()
    while true do
                local sleepThread = 250

                if coordsVisible then
                        sleepThread = 5

                        local playerPed = PlayerPedId()
                        local playerX, playerY, playerZ = table.unpack(GetEntityCoords(playerPed))
                        local playerH = GetEntityHeading(playerPed)

                        DrawGenericText(("~g~X~w~: %s ~g~Y~w~: %s ~g~Z~w~: %s ~g~H~w~: %s"):format(FormatCoord(playerX), FormatCoord(playerY), FormatCoord(playerZ), FormatCoord(playerH)))
                end

                Citizen.Wait(sleepThread)
        end
end)

FormatCoord = function(coord)
        if coord == nil then
                return "unknown"
        end

        return tonumber(string.format("%.2f", coord))
end

ToggleCoords = function()
        coordsVisible = not coordsVisible
end

RegisterCommand("c", function()
    ToggleCoords()
end)


--------------------------------------------------------------------------------
------------------------------Extra Toggle--------------------------------------
--------------------------------------------------------------------------------


RegisterCommand("extra", function(source, args, rawCommand)
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped, false)
    local extraID = tonumber(args[1])
    local toggle = tostring(args[2])
    if toggle == "true" then
        toggle = 0
    end
    if veh ~= nil and veh ~= 0 and veh ~= 1 then
        if extraID == "99" then
            SetVehicleAutoRepairDisabled(veh, true)
        SetVehicleExtra(veh, 1, toggle)
        SetVehicleExtra(veh, 2, toggle)
        SetVehicleExtra(veh, 3, toggle)
        SetVehicleExtra(veh, 4, toggle)
        SetVehicleExtra(veh, 5, toggle)             
        SetVehicleExtra(veh, 6, toggle)
        SetVehicleExtra(veh, 7, toggle)
        SetVehicleExtra(veh, 8, toggle)
        SetVehicleExtra(veh, 9, toggle)                             
        SetVehicleExtra(veh, 10, toggle)
        SetVehicleExtra(veh, 11, toggle)
        SetVehicleExtra(veh, 12, toggle)
        SetVehicleExtra(veh, 13, toggle)
        SetVehicleExtra(veh, 14, toggle)
        SetVehicleExtra(veh, 15, toggle)
        SetVehicleExtra(veh, 16, toggle)
        SetVehicleExtra(veh, 17, toggle)
        SetVehicleExtra(veh, 18, toggle)
        SetVehicleExtra(veh, 19, toggle)
        SetVehicleExtra(veh, 20, toggle)
        else
            SetVehicleAutoRepairDisabled(Vehicle, true)
            SetVehicleExtra(veh, extraID, toggle)
        end
    
    end
end, false)



