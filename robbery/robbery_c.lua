local robbing = false
local bank = ""
local secondsRemain = 0

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
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

local banks = {
	["blainecounty"] = {
		position = { ['x'] = -103.68, ['y'] = 6477.86, ['z'] = 30.66 },
		reward = 6000,
		nameofbank = "Blaine County Savings",
		lastrobbed = 0
	},
	["route68"] = {
		position = { ["x"] = 1177.17, ["y"] = 2711.8, ["z"] = 37.17 },
		reward = 6000,
		nameofbank = "Route 68 Fleeca",
		lastrobbed = 0
	},
	["sandy24/7"] = {
		position = { ['x'] = 1959.58, ['y'] = 3748.37, ['z'] = 31.40 },
		reward = 2500,
		nameofbank = "Sandy Shores 24/7",
		lastrobbed = 0
	},
	["route68 24/7"] = {
		position = { ['x'] = 546.41, ['y'] = 2663.58, ['z'] = 41.20 },
		reward = 2500,
		nameofbank = "Route 68 24/7",
		lastrobbed = 0
	},
	["yellowjack"] = {
		position = { ['x'] = 1994.53, ['y'] = 3049.57, ['z'] = 46.25 },
		reward = 2500,
		nameofbank = "Yellow Jack",
		lastrobbed = 0
	},
	["route68liquor"] = {
		position = { ['x'] = 1169.23, ['y'] = 2717.86, ['z'] = 36.16 },
		reward = 2500,
		nameofbank = "Scoops Liquor",
		lastrobbed = 0
	},
	["gsltd"] = {
		position = { ['x'] = 1707.52, ['y'] = 4920.09, ['z'] = 41.08 },
		reward = 2500,
		nameofbank = "GrapeSeed Gas LTD",
		lastrobbed = 0
	},
	["greatocean24/7"] = {
		position = { ['x'] = 1734.48, ['y'] = 6420.27, ['z'] = 34.06 },
		reward = 2500,
		nameofbank = "Great Ocean Highway 24/7",
		lastrobbed = 0
	},
		["lsltd"] = {
		position = { ['x'] = -709.75, ['y'] = -904.07, ['z'] = 18.25 },
		reward = 2500,
		nameofbank = "Little Seol LTD",
		lastrobbed = 0
	},
        ["robslsanandreas"] = {
		position = { x = -1220.8, y = -915.92, z = 10.55 },
		reward = 2500,
		nameofbank = "Robs Liquor San Andreas Avenue",
		lastrobbed = 0
	},
		["gsltd"] = {
		position = { x = -43.29, y = -1748.33, z = 28.44 },
		reward = 2500,
		nameofbank = "Grove Street LTD",
		lastrobbed = 0
    },
    	["flecals"] = {
		position = { x = 146.88, y = -1044.67, z = 28.50 },
		reward = 6000,
		nameofbank = "Fleeca Bank Legion Square",
		lastrobbed = 0	
}
}

RegisterNetEvent('fx_bank:sendalert')
AddEventHandler('fx_bank:sendalert', function(name)
	if IsCop then
	TriggerEvent('chatMessage', '^7[^4Dispatch^7]', {255, 0, 0}, "Robbery in progress at ^1" .. name)		
	end
end)

RegisterNetEvent('fx_bank:currentlyrobbing')
AddEventHandler('fx_bank:currentlyrobbing', function(robb)
	robbing = true
	bank = robb
	secondsRemain = 300
end)

RegisterNetEvent('fx_bank:toofarlocal')
AddEventHandler('fx_bank:toofarlocal', function(robb)
	robbing = false
	TriggerEvent('chatMessage', '[ROBBERY]', {255, 0, 0}, "The robbery was cancelled, you will receive nothing.")
	robbingName = ""
	secondsRemain = 0
	incircle = false
end)


RegisterNetEvent('fx_bank:robberycomplete')
AddEventHandler('fx_bank:robberycomplete', function(robb)
	robbing = false
	TriggerEvent('chatMessage', '[ROBBERY]', {255, 0, 0}, "Robbery done! Money added to your cash.")
	bank = ""
	secondsRemain = 0
	incircle = false
end)

Citizen.CreateThread(function()
	while true do
		if robbing then
			Citizen.Wait(1000)
			if(secondsRemain > 0)then
				secondsRemain = secondsRemain - 1
			end
		end

		Citizen.Wait(0)
	end
end)

incircle = false

Citizen.CreateThread(function()
	while true do
		local pos = GetEntityCoords(GetPlayerPed(-1), true)

		for k,v in pairs(banks)do
			local pos2 = v.position

			if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) < 15.0)then
				if not robbing then
					DrawMarker(27, v.position.x, v.position.y, v.position.z, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 1555, 0, 0,255, 0, 0, 0,0)
					
					if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) < 1.0)then
						if (incircle == false) then
							DisplayHelpText("Press ~INPUT_CONTEXT~ to rob ~b~" .. v.nameofbank .. "~w~ beware, the police will be alerted!")
						end
						incircle = true
						if(IsControlJustReleased(1, 51))then
							TriggerServerEvent('fx_bank:rob', k)
						end
					elseif(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) > 1.0)then
						incircle = false
					end
				end
			end
		end

		if robbing then
			
			drawTxt(0.66, 1.42, 1.0,1.0,0.4, "Robbing location: ~r~" .. secondsRemain .. "~w~ seconds remaining", 255, 255, 255, 255)
			
			local pos2 = banks[bank].position

			if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) > 7.5)then
				TriggerServerEvent('fx_bank:toofar', bank)
			end
		end

		Citizen.Wait(0)
	end
end)