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

local robbers = {}

function get3DDistance(x1, y1, z1, x2, y2, z2)
	return math.sqrt(math.pow(x1 - x2, 2) + math.pow(y1 - y2, 2) + math.pow(z1 - z2, 2))
end


RegisterServerEvent('fx_bank:toofar')
AddEventHandler('fx_bank:toofar', function(robb)
	if(robbers[source])then
		TriggerClientEvent('fx_bank:toofarlocal', source)
		robbers[source] = nil	
	end
end)

RegisterServerEvent('fx_bank:rob')
AddEventHandler('fx_bank:rob', function(robb)
	if banks[robb] then
	end

		local bank = banks[robb]

		if (os.time() - bank.lastrobbed) < 600 and bank.lastrobbed ~= 0 then
			TriggerClientEvent('chatMessage', source, '[ROBBERY]', {255, 0, 0}, "This has already been robbed recently. Please wait another: ^2" .. (1200 - (os.time() - bank.lastrobbed)) .. "^0 seconds.")
			return
		end
		TriggerClientEvent('chatMessage', source, '^7[^1ROBBERY^7]', {255, 0, 0}, "You started a robbery at: ^1" .. bank.nameofbank .. "^0, do not get too far away from this point!")
		TriggerClientEvent('fx_bank:currentlyrobbing', source, robb)
		TriggerClientEvent("fx_bank:sendalert", -1, bank.nameofbank)
		print(name)
		banks[robb].lastrobbed = os.time()
		robbers[source] = robb
		local savedSource = source
		SetTimeout(300000, function()
			if(robbers[savedSource])then
				local reward = math.random(100, bank.reward)
				TriggerClientEvent('fx_bank:robberycomplete', savedSource, job)
					if(target) then		
					end
				end
			end)


end)

