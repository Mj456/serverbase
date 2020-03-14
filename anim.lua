
local PlayerData 				= {}
local mp_pointing = false
local keyPressed = false
local radioActive = false
	

	Citizen.CreateThread( function()

		while true do
			Citizen.Wait(0)
			if (IsControlJustPressed(0,73))  then
				local ped = GetPlayerPed(-1)
				--TriggerEvent('chatMessage', 'TESTING ANIMATION')
	
				if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) then 
					--radioActive = true
	
					--if radioActive then
	
						RequestAnimDict( "random@mugging3" )
	
						while ( not HasAnimDictLoaded( "random@mugging3" ) ) do 
							Citizen.Wait( 100 )
						end
	
						if IsEntityPlayingAnim(ped, "random@mugging3", "generic_radio_chatter", 3) then
							ClearPedSecondaryTask(ped)
						else
							TaskPlayAnim(ped, "random@mugging3", "handsup_standing_base", 2.0, 2.5, -1, 49, 0, 0, 0, 0 )
							local prop_name = prop_name
							local secondaryprop_name = secondaryprop_name
							DeleteObject(prop)
							DeleteObject(secondaryprop)
							--SetPedCurrentWeaponVisible(ped, 0, 1, 1, 1)
						end
					--end
				end
			end
		end
	end)


RegisterCommand("e",function(source, args)

	if tostring(args[1]) == nil then
		print("Invalid syntax, correct syntax is: /e <animation> ")
		return
	else
		if tostring(args[1]) ~= nil then
            local argh = tostring(args[1])

			if argh == 'surrender' then
				local surrendered = false
				local player = PlayerPedId()
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
					loadAnimDict( "random@arrests" )
					loadAnimDict( "random@arrests@busted" )
					if ( IsEntityPlayingAnim( player, "random@arrests@busted", "idle_a", 3 ) ) then 
						TaskPlayAnim( player, "random@arrests@busted", "exit", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
						Wait (3000)
						TaskPlayAnim( player, "random@arrests", "kneeling_arrest_get_up", 8.0, 1.0, -1, 128, 0, 0, 0, 0 )
						surrendered = false
					else
						TaskPlayAnim( player, "random@arrests", "idle_2_hands_up", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
						Wait (4000)
						TaskPlayAnim( player, "random@arrests", "kneeling_arrest_idle", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
						Wait (500)
						TaskPlayAnim( player, "random@arrests@busted", "enter", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
						Wait (1000)
						TaskPlayAnim( player, "random@arrests@busted", "idle_a", 8.0, 1.0, -1, 9, 0, 0, 0, 0 )
						Wait(100)
						surrendered = true
					end     
				end

				Citizen.CreateThread(function() --disabling controls while surrendured
					while surrendered do
						Citizen.Wait(0)
						if IsEntityPlayingAnim(GetPlayerPed(PlayerId()), "random@arrests@busted", "idle_a", 3) then
							DisableControlAction(1, 140, true)
							DisableControlAction(1, 141, true)
							DisableControlAction(1, 142, true)
							DisableControlAction(0,21,true)
						end
					end
				end)


			elseif argh == 'salute' then
				local ad = "anim@mp_player_intuppersalute"
				local player = PlayerPedId()
				
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
					loadAnimDict( ad )
					if ( IsEntityPlayingAnim( player, ad, "idle_a", 3 ) ) then 
						TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
						Wait (600)
						ClearPedSecondaryTask(PlayerPedId())
					else
						TaskPlayAnim( player, ad, "idle_a", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
						Wait (500)
					end     
				end
			elseif argh == 'finger' then
				local ad = "anim@mp_player_intselfiethe_bird"
				local player = PlayerPedId()
				
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
					loadAnimDict( ad )
					if ( IsEntityPlayingAnim( player, ad, "idle_a", 3 ) ) then 
						TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
						Wait (100)
						ClearPedSecondaryTask(PlayerPedId())
					else
						TaskPlayAnim( player, ad, "idle_a", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
						Wait (500)
					end     
				end
			elseif argh == 'finger2' then
				local ad = "anim@mp_player_intupperfinger"
				local player = PlayerPedId()
				
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
					loadAnimDict( ad )
					if ( IsEntityPlayingAnim( player, ad, "idle_a", 3 ) ) then 
						TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
						Wait (100)
						ClearPedSecondaryTask(PlayerPedId())
					else
						TaskPlayAnim( player, ad, "idle_a", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
						Wait (500)
					end     
				end
			elseif argh == 'palm' then
				local ad = "anim@mp_player_intupperface_palm"
				local player = PlayerPedId()
				
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
					loadAnimDict( ad )
					if ( IsEntityPlayingAnim( player, ad, "idle_a", 3 ) ) then 
						TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
						Wait (100)
						ClearPedSecondaryTask(PlayerPedId())
					else
						TaskPlayAnim( player, ad, "idle_a", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
						Wait (500)
					end     
				end
			elseif argh == 'notes' then
				local ad = "missheistdockssetup1clipboard@base"
				local player = PlayerPedId()
				local prop_name = prop_name or 'prop_notepad_01'
				local secondaryprop_name = secondaryprop_name or 'prop_pencil_01'
				
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
					loadAnimDict( ad )
					if ( IsEntityPlayingAnim( player, ad, "base", 3 ) ) then 
						TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
						Wait (100)
						ClearPedSecondaryTask(PlayerPedId())
						DeleteObject(prop)
						DeleteObject(secondaryprop)
						notes = false
					else
						local x,y,z = table.unpack(GetEntityCoords(player))
						prop = CreateObject(GetHashKey(prop_name), x, y, z+0.2,  true,  true, true)
						secondaryprop = CreateObject(GetHashKey(secondaryprop_name), x, y, z+0.2,  true,  true, true)
						AttachEntityToEntity(prop, player, GetPedBoneIndex(player, 18905), 0.1, 0.02, 0.05, 10.0, 0.0, 0.0, true, true, false, true, 1, true) -- notepad
						AttachEntityToEntity(secondaryprop, player, GetPedBoneIndex(player, 58866), 0.12, 0.0, 0.001, -150.0, 0.0, 0.0, true, true, false, true, 1, true) -- pencil
						TaskPlayAnim( player, ad, "base", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
						Wait (500)
						notes = true
					end     
				end
			elseif argh == 'callphone' then
				local ad = "cellphone@"
				local player = PlayerPedId()
				local prop_name = prop_name or 'prop_player_phone_01'
				
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
					loadAnimDict( ad )
					if ( IsEntityPlayingAnim( player, ad, "cellphone_call_listen_base", 3 ) ) then 
						TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
						Wait (100)
						ClearPedSecondaryTask(PlayerPedId())
						DeleteObject(prop)
					else
						local x,y,z = table.unpack(GetEntityCoords(player))
						prop = CreateObject(GetHashKey(prop_name), x, y, z+0.2,  true,  true, true)
						AttachEntityToEntity(prop, player, GetPedBoneIndex(player, 57005), 0.15, 0.02, -0.01, 105.0, -20.0, 90.0, true, true, false, true, 1, true)
						TaskPlayAnim( player, ad, "cellphone_call_listen_base", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
						Wait (500)
					end 
				end
			elseif argh == 'foldarms2' then
				local ad = "missfbi_s4mop"
				local player = PlayerPedId()
				
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
					loadAnimDict( ad )
					if ( IsEntityPlayingAnim( player, ad, "guard_idle_a", 3 ) ) then 
						TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
						Wait (100)
					else
						TaskPlayAnim( player, ad, "guard_idle_a", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
						Wait (500)
					end 
				end
			elseif argh == 'umbrella' then
				local ad = "amb@world_human_drinking@coffee@male@base"
				local player = PlayerPedId()
				local prop_name = prop_name or 'p_amb_brolly_01'
				
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
					loadAnimDict( ad )
					if ( IsEntityPlayingAnim( player, ad, "base", 3 ) ) then 
						TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
						Wait (100)
						DeleteObject(prop)
						ClearPedSecondaryTask(PlayerPedId())
					else
						local x,y,z = table.unpack(GetEntityCoords(player))
						prop = CreateObject(GetHashKey(prop_name), x, y, z+0.2,  true,  true, true)
						AttachEntityToEntity(prop, player, GetPedBoneIndex(player, 57005), 0.15, 0.005, -0.02, 80.0, -20.0, 175.0, true, true, false, true, 1, true)
						TaskPlayAnim( player, ad, "base", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
						Wait (500)
					end 
				end
			elseif argh == 'brief' then
				local player = PlayerPedId()
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
					GiveWeaponToPed(player, 0x88C78EB7, 1, false, true);
				end
			elseif argh == 'brief2' then
				local player = PlayerPedId()
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
					GiveWeaponToPed(player, 0x01B79F17, 1, false, true);
				end
			elseif argh == 'foldarms' then
				local ad = "oddjobs@assassinate@construction@"
				local player = PlayerPedId()
				
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
					loadAnimDict( ad )
					if ( IsEntityPlayingAnim( player, ad, "unarmed_fold_arms", 3 ) ) then 
						TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
						Wait (100)
					else
						TaskPlayAnim( player, ad, "unarmed_fold_arms", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
						Wait (500)

					end     
				end
			elseif argh == 'damn' then
				local ad = "gestures@m@standing@casual"
				local player = PlayerPedId()
				
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
					loadAnimDict( ad )
					if ( IsEntityPlayingAnim( player, ad, "gesture_damn", 3 ) ) then 
						TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
						Wait (100)
						notes = false
					else
						TaskPlayAnim( player, ad, "gesture_damn", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
						Wait (500)
						notes = true
					end     
				end
			elseif argh == 'fail' then
				local ad = "random@car_thief@agitated@idle_a"
				local player = PlayerPedId()
				
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
					loadAnimDict( ad )
					if ( IsEntityPlayingAnim( player, ad, "agitated_idle_a", 3 ) ) then 
						TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
						Wait (100)
						notes = false
					else
						TaskPlayAnim( player, ad, "agitated_idle_a", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
						Wait (500)
						notes = true
					end     
				end
			elseif argh == 'gang1' then
				local ad = "mp_player_int_uppergang_sign_a"
				local player = PlayerPedId()
				
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
					loadAnimDict( ad )
					if ( IsEntityPlayingAnim( player, ad, "mp_player_int_gang_sign_a", 3 ) ) then 
						TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
						Wait (100)
						notes = false
					else
						TaskPlayAnim( player, ad, "mp_player_int_gang_sign_a", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
						Wait (500)
						notes = true
					end     
				end
			elseif argh == 'gang2' then
				local ad = "mp_player_int_uppergang_sign_b"
				local player = PlayerPedId()
				
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
					loadAnimDict( ad )
					if ( IsEntityPlayingAnim( player, ad, "mp_player_int_gang_sign_b", 3 ) ) then 
						TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
						Wait (100)
						notes = false
					else
						TaskPlayAnim( player, ad, "mp_player_int_gang_sign_b", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
						Wait (500)
						notes = true
					end     
				end
			elseif argh == 'no' then
				local ad = "mp_player_int_upper_nod"
				local player = PlayerPedId()
				
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
					loadAnimDict( ad )
					if ( IsEntityPlayingAnim( player, ad, "mp_player_int_nod_no", 3 ) ) then 
						TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
						Wait (100)
						notes = false
					else
						TaskPlayAnim( player, ad, "mp_player_int_nod_no", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
						Wait (500)
						notes = true
					end     
				end
			elseif argh == 'pickbutt' then
				local ad = "mp_player_int_upperarse_pick"
				local player = PlayerPedId()
				
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
					loadAnimDict( ad )
					if ( IsEntityPlayingAnim( player, ad, "mp_player_int_arse_pick", 3 ) ) then 
						TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
						Wait (100)
						notes = false
					else
						TaskPlayAnim( player, ad, "mp_player_int_arse_pick", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
						Wait (500)
						notes = true
					end     
				end
			elseif argh == 'grabcrotch' then
				local ad = "mp_player_int_uppergrab_crotch"
				local player = PlayerPedId()
				
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
					loadAnimDict( ad )
					if ( IsEntityPlayingAnim( player, ad, "mp_player_int_grab_crotch", 3 ) ) then 
						TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
						Wait (100)
						notes = false
					else
						TaskPlayAnim( player, ad, "mp_player_int_grab_crotch", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
						Wait (500)
						notes = true
					end     
				end
			elseif argh == 'peace' then
				local ad = "mp_player_int_upperpeace_sign"
				local player = PlayerPedId()
				
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
					loadAnimDict( ad )
					if ( IsEntityPlayingAnim( player, ad, "mp_player_int_peace_sign", 3 ) ) then 
						TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
						Wait (100)
						notes = false
					else
						TaskPlayAnim( player, ad, "mp_player_int_peace_sign", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
						Wait (500)
						notes = true
					end     
				end
			elseif argh == 'cigar' then
				local cigar_name = cigar_name or 'prop_cigar_02' --noprop
				local playerPed = PlayerPedId()
				
				if ( DoesEntityExist( playerPed ) and not IsEntityDead( playerPed )) then 
					if IsCigar then
						Wait(500)
						DeleteObject(cigar)
						IsCigar = false
					else
						IsCigar = true
						Wait(500)
						local x,y,z = table.unpack(GetEntityCoords(playerPed))
						cigar = CreateObject(GetHashKey(cigar_name), x, y, z+0.2,  true,  true, true)
						AttachEntityToEntity(cigar, playerPed, GetPedBoneIndex(playerPed, 47419), 0.015, -0.0001, 0.003, 55.0, 0.0, -85.0, true, true, false, true, 1, true)
					end     
				end
			elseif argh == 'cigar2' then
				local cigar_name = cigar_name or 'prop_cigar_01' --noprop
				local playerPed = PlayerPedId()
				
				if ( DoesEntityExist( playerPed ) and not IsEntityDead( playerPed )) then 
					if IsCigar then
						Wait(500)
						DeleteObject(cigar)
						IsCigar = false
					else
						IsCigar = true
						Wait(500)
						local x,y,z = table.unpack(GetEntityCoords(playerPed))
						cigar = CreateObject(GetHashKey(cigar_name), x, y, z+0.2,  true,  true, true)
						AttachEntityToEntity(cigar, playerPed, GetPedBoneIndex(playerPed, 47419), 0.015, -0.0001, 0.003, 55.0, 0.0, -85.0, true, true, false, true, 1, true)
					end     
				end
			elseif argh == 'joint' then
				local cigar_name = cigar_name or 'p_cs_joint_02' --noprop
				local playerPed = PlayerPedId()
				
				if ( DoesEntityExist( playerPed ) and not IsEntityDead( playerPed )) then 
					if IsCigar then
						Wait(500)
						DeleteObject(cigar)
						IsCigar = false
					else
						IsCigar = true
						Wait(500)
						local x,y,z = table.unpack(GetEntityCoords(playerPed))
						cigar = CreateObject(GetHashKey(cigar_name), x, y, z+0.2,  true,  true, true)
						AttachEntityToEntity(cigar, playerPed, GetPedBoneIndex(playerPed, 47419), 0.015, -0.009, 0.003, 55.0, 0.0, 110.0, true, true, false, true, 1, true)
					end     
				end
			elseif argh == 'cig' then
				local cigar_name = cigar_name or 'prop_amb_ciggy_01' --noprop
				local playerPed = PlayerPedId()
				
				if ( DoesEntityExist( playerPed ) and not IsEntityDead( playerPed )) then 
					if IsCigar then
						Wait(500)
						DeleteObject(cigar)
						IsCigar = false
					else
						IsCigar = true
						Wait(500)
						local x,y,z = table.unpack(GetEntityCoords(playerPed))
						cigar = CreateObject(GetHashKey(cigar_name), x, y, z+0.2,  true,  true, true)
						AttachEntityToEntity(cigar, playerPed, GetPedBoneIndex(playerPed, 47419), 0.015, -0.009, 0.003, 55.0, 0.0, 110.0, true, true, false, true, 1, true)
					end     
				end
			elseif argh == 'holdcigar' then
				local cigar_name = cigar_name or 'prop_cigar_03' --noprop
				local playerPed = PlayerPedId()
				
				if ( DoesEntityExist( playerPed ) and not IsEntityDead( playerPed )) then 
					if IsCigar then
						Wait(500)
						DeleteObject(cigar)
						IsCigar = false
					else
						IsCigar = true
						Wait(500)
						local x,y,z = table.unpack(GetEntityCoords(playerPed))
						cigar = CreateObject(GetHashKey(cigar_name), x, y, z+0.2,  true,  true, true)
						AttachEntityToEntity(cigar, playerPed, GetPedBoneIndex(playerPed, 26611), 0.045, -0.05, -0.010, -75.0, 0.0, 65.0, true, true, false, true, 1, true)
					end     
				end
			elseif argh == 'holdcig' then
				local cigar_name = cigar_name or 'prop_amb_ciggy_01' --noprop
				local playerPed = PlayerPedId()
				
				if ( DoesEntityExist( playerPed ) and not IsEntityDead( playerPed )) then 
					if IsCigar then
						Wait(500)
						DeleteObject(cigar)
						IsCigar = false
					else
						IsCigar = true
						Wait(500)
						local x,y,z = table.unpack(GetEntityCoords(playerPed))
						cigar = CreateObject(GetHashKey(cigar_name), x, y, z+0.2,  true,  true, true)
						AttachEntityToEntity(cigar, playerPed, GetPedBoneIndex(playerPed, 26611), 0.035, -0.01, -0.010, 100.0, 0.0, -100.0, true, true, false, true, 1, true)
					end     
				end
			elseif argh == 'holdjoint' then
				local cigar_name = cigar_name or 'p_cs_joint_02' --noprop
				local playerPed = PlayerPedId()
				
				if ( DoesEntityExist( playerPed ) and not IsEntityDead( playerPed )) then 
					if IsCigar then
						Wait(500)
						DeleteObject(cigar)
						IsCigar = false
					else
						IsCigar = true
						Wait(500)
						local x,y,z = table.unpack(GetEntityCoords(playerPed))
						cigar = CreateObject(GetHashKey(cigar_name), x, y, z+0.2,  true,  true, true)
						AttachEntityToEntity(cigar, playerPed, GetPedBoneIndex(playerPed, 26611), 0.035, -0.01, -0.010, 100.0, 0.0, -100.0, true, true, false, true, 1, true)
					end     
				end
			elseif argh == 'dead' then
				local ad = "misslamar1dead_body"
				local player = PlayerPedId()
				
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
					loadAnimDict( ad )
					if ( IsEntityPlayingAnim( player, ad, "dead_idle", 3 ) ) then 
						TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 33, 0, 0, 0, 0 )
						Wait (100)
					else
						TaskPlayAnim( player, ad, "dead_idle", 8.0, 1.0, -1, 33, 0, 0, 0, 0 )
						Wait (500)
					end     
				end
			elseif argh == 'holster' then
				local ad = "move_m@intimidation@cop@unarmed"
				local player = PlayerPedId()
				
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
					loadAnimDict( ad )
					if ( IsEntityPlayingAnim( player, ad, "idle", 3 ) ) then 
						TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
						Wait (100)
					else
						TaskPlayAnim( player, ad, "idle", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
						Wait (500)
					end     
				end
			elseif argh == 'aim' then
				local ad = "move_weapon@pistol@copa"
				local player = PlayerPedId()
				
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
					loadAnimDict( ad )
					if ( IsEntityPlayingAnim( player, ad, "idle", 3 ) ) then 
						TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
						Wait (100)
					else
						TaskPlayAnim( player, ad, "idle", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
						Wait (500)
					end     
				end
			elseif argh == 'aim2' then
				local ad = "move_weapon@pistol@cope"
				local player = PlayerPedId()
				
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
					loadAnimDict( ad )
					if ( IsEntityPlayingAnim( player, ad, "idle", 3 ) ) then 
						TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
						Wait (100)
					else
						TaskPlayAnim( player, ad, "idle", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
						Wait (500)
					end     
				end

			elseif argh == 'guard' then
				local ad = "rcmepsilonism8"
				local player = PlayerPedId()
				
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
					loadAnimDict( ad )
					if ( IsEntityPlayingAnim( player, ad, "base_carrier", 3 ) ) then 
						TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
						Wait (100)
					else
						TaskPlayAnim( player, ad, "base_carrier", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
						Wait (500)
					end
			elseif argh == 'cancel' then
				local ped = GetPlayerPed(-1)
					ClearPedTasksImmediately(ped)			
					end     
				end
			end
		end
end, false)


----Uncomment this to add a /testa command, you can use this to easily test new animations---

--RegisterCommand("testa",function(source, args)
--
--	local ad = "missheist_agency3aig_20"
--	local player = PlayerPedId()
--
--	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
--		if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
--			loadAnimDict( ad )
--			if ( IsEntityPlayingAnim( player, ad, "idle_a_keyboard", 3 ) ) then 
--				TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 49, 0, 0, 0, 0 )
--				ClearPedSecondaryTask(player)
--				Wait (100)
--			else
--				TaskPlayAnim( player, ad, "idle_a_keyboard", 3.0, 1.0, -1, 49, 0, 0, 0, 0 )
--				Wait (500)
--			end       
--		end
--	end
--end, false)

	
----------------------------------------------------------------------------------------------------------------------------
------------------------------------------------ functions -----------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function(prop_name, secondaryprop_name)
	while true do
		Citizen.Wait(500)
		if IsPedRagdoll(PlayerPedId()) then 
			local playerPed = PlayerPedId()
			local prop_name = prop_name
			local secondaryprop_name = secondaryprop_name
			DeleteObject(prop)
			DeleteObject(secondaryprop)
		end
	end
end)	

function Notification(message)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(message)
	DrawNotification(0, 0)
end

function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(5)
	end
end

