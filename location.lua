--Location Display--

-- CONFIG --
local showCompass = true
local displayTime = true
local useMilitaryTime = true

-- en for english translate
-- ru for russian translate
local lang = 'en' 

local timeAndDateString = nil
local hour
local minute

-- CODE --
function drawTxt2(x,y ,width,height,scale, text, r,g,b,a)
        SetTextFont(6)
        SetTextProportional(1)
        SetTextScale(0.0, 0.48)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(1, 0, 0, 0, 255)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        AddTextComponentString(text)
        DrawText(x, y)
end

function getCardinalDirectionFromHeading(heading)
    if ((heading >= 0 and heading < 45) or (heading >= 315 and heading < 360)) then
        if lang == 'en' then
            return "N" -- North
        elseif lang == 'ru' then
            return "Ð¡" -- North
        else
            return "~r~Err"
        end
    elseif (heading >= 45 and heading < 135) then
        if lang == 'en' then
            return "W" -- East
        elseif lang == 'ru' then
            return "Ð—" -- East
        else
            return "~r~Err"
        end
    elseif (heading >=135 and heading < 225) then
        if lang == 'en' then
            return "S" -- South
        elseif lang == 'ru' then
            return "Ð®" -- South
        else
            return "~r~Err"
        end
    elseif (heading >= 225 and heading < 315) then
        if lang == 'en' then
            return "E" -- West
        elseif lang == 'ru' then
            return "Ð’" -- West
        else
            return "~r~Err"
        end
    end
end

function CalculateTimeToDisplay()
	hour = GetClockHours()
	minute = GetClockMinutes()

	if useMilitaryTime == false then
		if hour == 0 or hour == 24 then
			hour = 12
		elseif hour >= 13 then
			hour = hour - 12
		end
	end

	if hour <= 9 then
		hour = "0" .. hour
	end
	if minute <= 9 then
		minute = "0" .. minute
	end
end


local lastStreet = nil
local zones_ru = { ['AIRP'] = "ÐœÐÐ›Ð¡", ['ALAMO'] = "ÐÐ»Ð°Ð¼Ð¾-Ð¡Ð¸", ['ALTA'] = "ÐÐ»ÑŒÑ‚Ð°", ['ARMYB'] = "Ð¤Ð¾Ñ€Ñ‚ Ð—Ð°Ð½ÐºÑƒÐ´Ð¾", ['BANHAMC'] = "Ð‘ÑÐ½Ñ…ÑÐ¼ Ð”Ñ€Ð°Ð¹Ð²", ['BANNING'] = "Ð‘ÑÐ½Ð½Ð¸Ð½Ð³", ['BEACH'] = "Ð’ÐµÑÐ¿ÑƒÑ‡Ñ‡Ð¸-Ð‘Ð¸Ñ‡", ['BHAMCA'] = "ÐšÐ°Ð½ÑŒÐ¾Ð½ Ð‘ÑÐ½Ñ…ÑÐ¼", ['BRADP'] = "ÐŸÐµÑ€ÐµÐ²Ð°Ð» Ð‘Ñ€ÑÐ´Ð´Ð¾ÐºÐ°", ['BRADT'] = "Ð¢Ð¾Ð½Ð½ÐµÐ»ÑŒ Ð‘Ñ€ÑÐ´Ð´Ð¾ÐºÐ°", ['BURTON'] = "Ð‘ÐµÑ€Ñ‚Ð¾Ð½", ['CALAFB'] = "ÐšÐ°Ð»Ð°Ñ„Ð¸Ð°-Ð‘Ñ€Ð¸Ð´Ð¶", ['CANNY'] = "ÐšÐ°Ð½ÑŒÐ¾Ð½ Ð Ð°Ñ‚Ð¾Ð½", ['CCREAK'] = "ÐšÑÑÑÐ¸Ð´Ð¸-ÐšÑ€Ð¸Ðº", ['CHAMH'] = "Ð§ÐµÐ¼Ð±ÐµÑ€Ð»ÐµÐ½-Ð¥Ð¸Ð»Ð»Ð·", ['CHIL'] = "Ð’Ð°Ð¹Ð½Ð²ÑƒÐ´-Ð¥Ð¸Ð»Ð»Ð·", ['CHU'] = "Ð§ÑƒÐ¼Ð°Ñˆ", ['CMSW'] = "Ð—Ð°Ð¿Ð¾Ð²ÐµÐ´Ð½Ð¸Ðº Ð“Ð¾Ñ€Ñ‹ Ð§Ð¸Ð»Ð¸Ð°Ð´", ['CYPRE'] = "Ð¡Ð°Ð¹Ð¿Ñ€ÐµÑÑ-Ð¤Ð»ÑÑ‚Ñ", ['DAVIS'] = "Ð”ÑÐ²Ð¸Ñ", ['DELBE'] = "Ð”ÐµÐ»ÑŒ-ÐŸÐµÑ€Ñ€Ð¾-Ð‘Ð¸Ñ‡", ['DELPE'] = "Ð”ÐµÐ»ÑŒ-ÐŸÐµÑ€Ñ€Ð¾", ['DELSOL'] = "Ð›Ð°-ÐŸÑƒÑÑ€Ñ‚Ð°", ['DESRT'] = "ÐŸÑƒÑÑ‚Ñ‹Ð½Ñ Ð“Ñ€Ð°Ð½Ð´-Ð¡ÐµÐ½Ð¾Ñ€Ð°", ['DOWNT'] = "Ð¦ÐµÐ½Ñ‚Ñ€", ['DTVINE'] = "Ð¦ÐµÐ½Ñ‚Ñ€ Ð’Ð°Ð¹Ð½Ð²ÑƒÐ´", ['EAST_V'] = "Ð—Ð°Ð¿Ð°Ð´Ð½Ñ‹Ð¹ Ð’Ð°Ð¹Ð½Ð²ÑƒÐ´", ['EBURO'] = "Ð­Ð»ÑŒ-Ð‘ÑƒÑ€Ñ€Ð¾-Ð¥Ð°Ð¹Ñ‚Ñ", ['ELGORL'] = "ÐœÐ°ÑÐº Ð­Ð»ÑŒ-Ð“Ð¾Ñ€Ð´Ð¾", ['ELYSIAN'] = "Ð­Ð»Ð¸Ð·Ð¸Ð°Ð½-ÐÐ¹Ð»ÐµÐ½Ð´", ['GALFISH'] = "Ð“Ð°Ð»Ð¸Ð»ÐµÐ¾", ['GOLF'] = "Ð“Ð¾Ð»ÑŒÑ„-ÐšÐ»ÑƒÐ±", ['GRAPES'] = "Ð“Ñ€ÐµÐ¹Ð¿ÑÐ¸Ð´", ['GREATC'] = "Ð“Ñ€ÐµÐ¹Ñ‚-Ð§Ð°Ð¿Ð°Ñ€Ñ€Ð°Ð»", ['HARMO'] = "Ð¥Ð°Ñ€Ð¼Ð¾Ð½Ð¸", ['HAWICK'] = "Ð¥Ð°Ð²Ð¸Ðº", ['HORS'] = "Ð“Ð¾Ð½Ð¾Ñ‡Ð½Ð°Ñ Ñ‚Ñ€Ð°ÑÑÐ° Ð’Ð°Ð¹Ð½Ð²ÑƒÐ´Ð°", ['HUMLAB'] = "Ð›Ð°Ð±Ð¾Ñ€Ð°Ñ‚Ð¾Ñ€Ð¸Ñ Humane Labs and Research", ['JAIL'] = "Ð¢ÑŽÑ€ÑŒÐ¼Ð° Ð‘Ð¾Ð»Ð¸Ð½Ð³Ð±Ñ€Ð¾ÑƒÐº", ['KOREAT'] = "ÐœÐ°Ð»ÐµÐ½ÑŒÐºÐ¸Ð¹ Ð¡ÐµÑƒÐ»", ['LACT'] = "Ð›ÑÐ½Ð´-Ð­ÐºÑ‚-Ð ÐµÐ·ÐµÑ€Ð²ÑƒÐ°Ñ€", ['LAGO'] = "Ð›Ð°Ð³Ð¾-Ð—Ð°Ð½ÐºÑƒÐ´Ð¾", ['LDAM'] = "Ð›ÑÐ½Ð´-Ð­ÐºÑ‚-Ð”ÑÐ¼", ['LEGSQU'] = "ÐŸÐ»Ð¾Ñ‰Ð°Ð´ÑŒ Ð›ÐµÐ³Ð¸Ð¾Ð½Ð°", ['LMESA'] = "Ð›Ð°-ÐœÐµÑÐ°", ['LOSPUER'] = "Ð›Ð°-ÐŸÑƒÑÑ€Ñ‚Ð°", ['MIRR'] = "ÐœÐ¸Ñ€Ñ€Ð¾Ñ€-ÐŸÐ°Ñ€Ðº", ['MORN'] = "ÐœÐ¾Ñ€Ð½Ð¸Ð½Ð³Ð²ÑƒÐ´", ['MOVIE'] = "ÐšÐ¸Ð½Ð¾ÑÑ‚ÑƒÐ´Ð¸Ñ Richards Majestic", ['MTCHIL'] = "Ð“Ð¾Ñ€Ð° Ð§Ð¸Ð»Ð¸Ð°Ð´", ['MTGORDO'] = "Ð“Ð¾Ñ€Ð° Ð“Ð¾Ñ€Ð´Ð¾", ['MTJOSE'] = "Ð“Ð¾Ñ€Ð° Ð”Ð¶Ð¾ÑÐ°Ð¹Ñ", ['MURRI'] = "ÐœÑƒÑ€ÑŒÐµÑ‚Ð°-Ð¥Ð°Ð¹Ñ‚Ñ", ['NCHU'] = "Ð¡ÐµÐ²ÐµÑ€Ð½Ñ‹Ð¹ Ð§ÑƒÐ¼Ð°Ñˆ", ['NOOSE'] = "Ð¦ÐµÐ½Ñ‚Ñ€ Ð.Ð£.ÐŸ.", ['OCEANA'] = "Ð¢Ð¸Ñ…Ð¸Ð¹ ÐžÐºÐµÐ°Ð½", ['PALCOV'] = "Ð‘ÑƒÑ…Ñ‚Ð° ÐŸÐ°Ð»ÐµÑ‚Ð¾", ['PALETO'] = "ÐŸÐ°Ð»ÐµÑ‚Ð¾-Ð‘ÑÐ¹", ['PALFOR'] = "Ð›ÐµÑ ÐŸÐ°Ð»ÐµÑ‚Ð¾", ['PALHIGH'] = "ÐÐ°Ð³Ð¾Ñ€ÑŒÑ ÐŸÐ°Ð»Ð°Ð¼Ð¸Ð½Ð¾", ['PALMPOW'] = "Ð­Ð»ÐµÐºÑ‚Ñ€Ð¾ÑÑ‚Ð°Ð½Ñ†Ð¸Ñ ÐŸÐ°Ð»Ð¼ÐµÑ€-Ð¢ÑÐ¹Ð»Ð¾Ñ€", ['PBLUFF'] = "ÐŸÐ°ÑÐ¸Ñ„Ð¸Ðº-Ð‘Ð»Ð°Ñ„Ñ„Ñ", ['PBOX'] = "ÐŸÐ¸Ð»Ð»Ð±Ð¾ÐºÑ-Ð¥Ð¸Ð»Ð»", ['PROCOB'] = "ÐŸÑ€Ð¾ÐºÐ¾Ð¿Ð¸Ð¾-Ð‘Ð¸Ñ‡", ['RANCHO'] = "Ð Ð°Ð½Ñ‡Ð¾", ['RGLEN'] = "Ð Ð¸Ñ‡Ð¼Ð°Ð½-Ð“Ð»ÐµÐ½", ['RICHM'] = "Ð Ð¸Ñ‡Ð¼Ð°Ð½", ['ROCKF'] = "Ð Ð¾ÐºÑ„Ð¾Ñ€Ð´-Ð¥Ð¸Ð»Ð»Ð·", ['RTRAK'] = "Ð¢Ñ€Ð°ÑÑÐ° Redwood Lights", ['SANAND'] = "Ð¡Ð°Ð½-ÐÐ½Ð´Ñ€ÐµÐ°Ñ", ['SANCHIA'] = "Ð¡Ð°Ð½-Ð¨Ð°Ð½ÑŒÑÐºÐ¸Ð¹ Ð“Ð¾Ñ€Ð½Ñ‹Ð¹ Ð¥Ñ€ÐµÐ±ÐµÑ‚", ['SANDY'] = "Ð¡ÑÐ½Ð´Ð¸-Ð¨Ð¾Ñ€Ñ", ['SKID'] = "ÐœÐ¸ÑˆÐ½-Ð Ð¾Ñƒ", ['SLAB'] = "Ð¡Ñ‚ÑÐ±-Ð¡Ð¸Ñ‚Ð¸", ['STAD'] = "ÐÑ€ÐµÐ½Ð° Maze Bank", ['STRAW'] = "Ð¡Ñ‚Ñ€Ð¾Ð±ÐµÑ€Ñ€Ð¸", ['TATAMO'] = "Ð¢Ð°Ñ‚Ð°Ð²Ð¸Ð°Ð¼ÑÐºÐ¸Ðµ Ð³Ð¾Ñ€Ñ‹", ['TERMINA'] = "Ð¢ÐµÑ€Ð¼Ð¸Ð½Ð°Ð»", ['TEXTI'] = "Ð¢ÐµÐºÑÑ‚Ð°Ð¹Ð»-Ð¡Ð¸Ñ‚Ð¸", ['TONGVAH'] = "Ð¢Ð¾Ð½Ð³Ð²Ð°-Ð¥Ð¸Ð»Ð»Ð·", ['TONGVAV'] = "Ð”Ð¾Ð»Ð¸Ð½Ð° Ð¢Ð¾Ð½Ð³Ð²Ð°", ['VCANA'] = "ÐšÐ°Ð½Ð°Ð»Ñ‹ Ð’ÐµÑÐ¿ÑƒÑ‡Ñ‡Ð¸", ['VESP'] = "Ð’ÐµÑÐ¿ÑƒÑ‡Ñ‡Ð¸", ['VINE'] = "Ð’Ð°Ð¹Ð½Ð²ÑƒÐ´", ['WINDF'] = "Ð’ÐµÑ‚Ñ€ÑÐ½Ð°Ñ Ð¤ÐµÑ€Ð¼Ð° Ron Alternates", ['WVINE'] = "Ð’Ð¾ÑÑ‚Ð¾Ñ‡Ð½Ñ‹Ð¹ Ð’Ð°Ð¹Ð½Ð²ÑƒÐ´", ['ZANCUDO'] = "Ð ÐµÐºÐ° Ð—Ð°Ð½ÐºÑƒÐ´Ð¾", ['ZP_ORT'] = "ÐŸÐ¾Ñ€Ñ‚ Ð®Ð¶Ð½Ð¾Ð³Ð¾ Ð›Ð¾Ñ-Ð¡Ð°Ð½Ñ‚Ð¾ÑÐ°", ['ZQ_UAR'] = "Ð”ÑÐ²Ð¸Ñ-ÐšÐ²Ð°Ñ€Ñ†" }

local zones_en = { ['AIRP'] = "LSIA", ['ALAMO'] = "Alamo Sea", ['ALTA'] = "Alta", ['ARMYB'] = "Fort Zancudo", ['BANHAMC'] = "Banham Canyon Dr", ['BANNING'] = "Banning", ['BEACH'] = "Vespucci Beach", ['BHAMCA'] = "Banham Canyon", ['BRADP'] = "Braddock Pass", ['BRADT'] = "Braddock Tunnel", ['BURTON'] = "Burton", ['CALAFB'] = "Calafia Bridge", ['CANNY'] = "Raton Canyon", ['CCREAK'] = "Cassidy Creek", ['CHAMH'] = "Chamberlain Hills", ['CHIL'] = "Vinewood Hills", ['CHU'] = "Chumash", ['CMSW'] = "Chiliad Mountain State Wilderness", ['CYPRE'] = "Cypress Flats", ['DAVIS'] = "Davis", ['DELBE'] = "Del Perro Beach", ['DELPE'] = "Del Perro", ['DELSOL'] = "La Puerta", ['DESRT'] = "Grand Senora Desert", ['DOWNT'] = "Downtown", ['DTVINE'] = "Downtown Vinewood", ['EAST_V'] = "East Vinewood", ['EBURO'] = "El Burro Heights", ['ELGORL'] = "El Gordo Lighthouse", ['ELYSIAN'] = "Elysian Island", ['GALFISH'] = "Galilee", ['GOLF'] = "GWC and Golfing Society", ['GRAPES'] = "Grapeseed", ['GREATC'] = "Great Chaparral", ['HARMO'] = "Harmony", ['HAWICK'] = "Hawick", ['HORS'] = "Vinewood Racetrack", ['HUMLAB'] = "Humane Labs and Research", ['JAIL'] = "Bolingbroke Penitentiary", ['KOREAT'] = "Little Seoul", ['LACT'] = "Land Act Reservoir", ['LAGO'] = "Lago Zancudo", ['LDAM'] = "Land Act Dam", ['LEGSQU'] = "Legion Square", ['LMESA'] = "La Mesa", ['LOSPUER'] = "La Puerta", ['MIRR'] = "Mirror Park", ['MORN'] = "Morningwood", ['MOVIE'] = "Richards Majestic", ['MTCHIL'] = "Mount Chiliad", ['MTGORDO'] = "Mount Gordo", ['MTJOSE'] = "Mount Josiah", ['MURRI'] = "Murrieta Heights", ['NCHU'] = "North Chumash", ['NOOSE'] = "N.O.O.S.E", ['OCEANA'] = "Pacific Ocean", ['PALCOV'] = "Paleto Cove", ['PALETO'] = "Paleto Bay", ['PALFOR'] = "Paleto Forest", ['PALHIGH'] = "Palomino Highlands", ['PALMPOW'] = "Palmer-Taylor Power Station", ['PBLUFF'] = "Pacific Bluffs", ['PBOX'] = "Pillbox Hill", ['PROCOB'] = "Procopio Beach", ['RANCHO'] = "Rancho", ['RGLEN'] = "Richman Glen", ['RICHM'] = "Richman", ['ROCKF'] = "Rockford Hills", ['RTRAK'] = "Redwood Lights Track", ['SANAND'] = "San Andreas", ['SANCHIA'] = "San Chianski Mountain Range", ['SANDY'] = "Sandy Shores", ['SKID'] = "Mission Row", ['SLAB'] = "Stab City", ['STAD'] = "Maze Bank Arena", ['STRAW'] = "Strawberry", ['TATAMO'] = "Tataviam Mountains", ['TERMINA'] = "Terminal", ['TEXTI'] = "Textile City", ['TONGVAH'] = "Tongva Hills", ['TONGVAV'] = "Tongva Valley", ['VCANA'] = "Vespucci Canals", ['VESP'] = "Vespucci", ['VINE'] = "Vinewood", ['WINDF'] = "Ron Alternates Wind Farm", ['WVINE'] = "West Vinewood", ['ZANCUDO'] = "Zancudo River", ['ZP_ORT'] = "Port of South Los Santos", ['ZQ_UAR'] = "Davis Quartz" }

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local pos = GetEntityCoords(GetPlayerPed(-1))

        if(GetStreetNameFromHashKey(var1) and GetNameOfZone(pos.x, pos.y, pos.z))then
        	x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
            lastStreet = GetStreetNameAtCoord(x, y, z)
            lastStreetName = GetStreetNameFromHashKey(lastStreet)
            compass = getCardinalDirectionFromHeading(GetEntityHeading(GetPlayerPed(-1)))
            timeAndDateString = ""
            CalculateTimeToDisplay()
            timeAndDateString = timeAndDateString .. hour .. ":" .. minute

            if lang == 'en' then
                if(zones_en[GetNameOfZone(pos.x, pos.y, pos.z)] and tostring(GetStreetNameFromHashKey(var1)))then
                    drawTxt2(0.165, 0.955, 1.0,1.0,0.4,compass.." ~p~|~w~ "..lastStreetName.." ~p~|~w~ "..zones_en[GetNameOfZone(pos.x, pos.y, pos.z)].." ~p~|~w~ "..timeAndDateString, 255, 255, 255, 255)
                end
            end
		end
	end
end)