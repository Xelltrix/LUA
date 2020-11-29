-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------
 
-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
 
    -- Load and initialize the include file.
    include('Mote-Include.lua')
end
 
-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------
 function job_setup()
	state.EnmityDown = M(false)
	
	determine_haste_group()
	customize_idle_set()

end
 
 
-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	state.OffenseMode:options('Normal','High','STP')
	state.HybridMode:options('Normal','DT')
	state.WeaponskillMode:options('Normal','High','Capped')
	state.IdleMode:options('Normal','Twilight')
	
	state.WeaponSet = M{['description']='Weapon Set','Trishula','Shining','Malignance'}
	
	state.GripSet = M{['description']='Grip Set','Utu','Khonsu'}
    
	send_command('bind numpad. gs c toggle EnmityDown')
	
	send_command('bind pageup gs c cycle WeaponSet')
	send_command('bind pagedown gs c cycleback WeaponSet')
	
	send_command('bind ^pageup gs c cycle GripSet')
	send_command('bind ^pagedown gs c cycleback GripSet')
	
    apply_job_change()
end

function user_unload()
	send_command('unbind numpad.')
	
	send_command('unbind pageup')
	send_command('unbind pagedown')
		
	send_command('unbind ^pageup')
	send_command('unbind ^pagedown')
end
 
function init_gear_sets()

----------------------------------------------------------------------------
--------------------									--------------------
------------							 						------------
--------					Precast Gear Sets						--------
------------							 						------------
--------------------									--------------------
----------------------------------------------------------------------------

	
	-------------------
	-- Job Abilities --
	------------------- 
	
		sets.precast.JA['Spirit Surge'] = { body="Ptero. Mail +3" }
		
		sets.precast.JA['Call Wyvern'] = { body="Ptero. Mail +3" }
		
		sets.precast.JA['Ancient Circle'] = { legs="Vishap Brais +3" }
		
		sets.precast.JA['Spirit Link'] =
		{
			head="Vishap Armet +1",
			hands="Pel. Vambraces +1",
			feet="Ptero. Greaves +3"
		}
		
		sets.precast.JA['Angon'] =
		{
			ammo="Angon",
			hands="Ptero. Fin. G. +3"
		}
		
		sets.precast.JA['Jump'] =
		{
			ammo="Aurgelmir Orb +1",
			head="Flam. Zucchetto +2", neck="Anu Torque", lear="Telos Earring", rear="Sherida Earring",
			body="Ptero. Mail +3", hands="Vishap F. G. +1", lring="Niqmaddu Ring", rring={name="Chirich Ring +1", bag="wardrobe3"},
			back=gear.DRGCape_STP, waist="Sailfi Belt +1", legs="Ptero. Brais +3", feet="Ostro Greaves"
		}
		
		sets.precast.JA['Spirit Jump'] = set_combine(sets.precast.JA['Jump'],
		{
			legs="Peltast's Cuissots +1", feet="Pelt. Schyn. +1"
		})
		
		sets.precast.JA['High Jump'] = sets.precast.JA['Jump']
		
		sets.precast.JA['Soul Jump'] = set_combine(sets.precast.JA['Jump'],
		{
			legs="Peltast's Cuissots +1"
		})

		
	-------------------
	-- Precast Magic --
	------------------- 
	
	
		sets.precast.FC = 
		{
			ammo="Sapience Orb",
			head="Carmine Mask +1", neck="Orunmila's Torque", lear="Loquac. Earring", rear="Etiolation Earring",
			body="Sacro Breastplate", hands="Leyline Gloves", lring="Defending Ring", rring="Weather. Ring +1",
			back="Moonlight Cape", waist="Flume Belt +1", legs="Carmine Cuisses +1", feet="Carmine Greaves +1"
		}

	
----------------------------------------------------------------------------
--------------------									--------------------
------------							 						------------
--------					Midcast Gear Sets						--------
------------							 						------------
--------------------									--------------------
----------------------------------------------------------------------------	
	
	
	--------------------------------------
	-- Base Midcast sets
	--------------------------------------	
		
		
		sets.midcast.FC = sets.precast.FC


	--------------------------------------
	-- Wyvern Midcast sets
	--------------------------------------	
	
		sets.midcast.Pet.Breath =
		{
			head="Ptero. Armet +3",
			back=gear.DRGCape_DA, legs="Vishap Brais +3", feet="Ptero. Greaves +3"
		}
	

----------------------------------------------------------------------------
--------------------									--------------------
------------							 						------------
--------					  Other Gear Sets						--------
------------							 						------------
--------------------									--------------------
----------------------------------------------------------------------------
	
	
	------------------------------------------------------------------------------------------------
	------------------------------------------ Idle Sets -------------------------------------------
	------------------------------------------------------------------------------------------------
	
		sets.idle =
		{
			ammo="Staunch Tathlum +1",
			head="Hjarrandi Helm", neck="Warder's Charm +1", lear="Odnowa Earring +1", rear="Genmei Earring",
			body="Sacro Breastplate", hands="Volte Bracers", lring="Defending Ring", rring="Moonlight Ring",
			back="Moonlight Cape", waist="Carrier's Sash", legs="Carmine Cuisses +1", feet="Sulev. Leggings +2"
		}
		
		sets.idle.Twilight = set_combine(sets.idle,
		{
			head="Twilight Helm",
			body="Twilight Mail"
		})

		sets.idle.Town = sets.idle
		
		sets.idle.Adoulin = set_combine(sets.idle,
		{
			body="Councilor's Garb"
		})
	
	
	------------------------------------------------------------------------------------------------
	--------------------------------------- Defense Sets -------------------------------------------
	------------------------------------------------------------------------------------------------

	
	--------------------------------------
	-- Defensive Sets
	--------------------------------------
		sets.defense.PDT =
		{
			ammo="Staunch Tathlum +1",
			head="Hjarrandi Helm", neck="Warder's Charm +1", lear="Eabani Earring", rear="Sanare Earring",
			body="Tartarus Platemail", hands="Sulev. Gauntlets +2", lring="Defending Ring", rring="Moonlight Ring",
			back="Moonlight Cape", waist="Carrier's Sash", legs="Carmine Cuisses +1", feet="Sulev. Leggings +2"
		}

		sets.defense.MDT = 
		{
			ammo="Staunch Tathlum +1",
			head="Hjarrandi Helm", neck="Warder's Charm +1", lear="Eabani Earring", rear="Sanare Earring",
			body="Sacro Breastplate", hands="Volte Bracers", lring="Defending Ring", rring="Shadow Ring",
			back="Moonlight Cape", waist="Carrier's Sash", legs="Sulev. Cuisses +2", feet="Sulev. Leggings +2"
		}


	
	
	------------------------------------------------------------------------------------------------
	----------------------------------------- Weapon Sets ------------------------------------------
	------------------------------------------------------------------------------------------------
	
		sets.Trishula 	= { 	main="Trishula" 		}
		
		sets.Shining 	= { 	main="Shining One" 		}
		
		sets.Malignance = {  	main="Malignance Pole"	}
		
		sets.Utu 		= { 	sub="Utu Grip" 			}
	
		sets.Khonsu 	= { 	sub="Khonsu" 			}


	--------------------------------------
	-- Special Sets
	--------------------------------------

		sets.Kiting = { legs="Carmine Cuisses +1" }
		
		sets.TreasureHunter =
		{
			hands="Volte Bracers",
			waist="Chaac Belt", legs="Volte Hose"
		}
		
		sets.EnmityDown =
		{
			rear="Novia Earring",
			lring="Lebeche Ring", rring="Kuchekula Ring"
		}

	---Buffs
		sets.buff.Doom = 
		{
			neck="Nicander's Necklace",
			lring={name="Eshmun's Ring", bag="wardrobe2"}, rring={name="Eshmun's Ring", bag="wardrobe3"},
			waist="Gishdubar Sash"
		}

		

----------------------------------------------------------------------------
--------------------									--------------------
------------							 						------------
--------					 Combat Gear Sets						--------
------------							 						------------
--------------------									--------------------
----------------------------------------------------------------------------
	
	-------------------------
	-- Weaponskill Sets
	-------------------------	
		sets.precast.WS = 
		{
			ammo="Knobkierrie",
			head="Valorous Mask", neck="Fotia Gorget", lear="Thrud Earring", rear="Moonshade Earring",
			body=gear.VMail_WSD, hands="Ptero. Fin. G. +3", lring="Niqmaddu Ring", rring="Epaminondas's Ring",
			back=gear.DRGCape_WSD, waist="Fotia Belt", legs="Vishap Brais +3", feet="Sulev. Leggings +2"
		}
		
		sets.precast.WS['Stardiver'] = set_combine(sets.precast.WS,
		{
			ammo="Voluspa Tathlum",
			head="Ptero. Armet +3", rear="Sherida Earring",
			body=gear.VMail_DA, hands="Sulev. Gauntlets +2", rring="Regal Ring",
			back=gear.DRGCape_DA, legs="Sulev. Cuisses +2", feet="Flam. Gambieras +2"
		})
		
		sets.precast.WS['Stardiver'].High = set_combine(sets.precast.WS['Stardiver'],
		{
			neck="Dgn. Collar +2",
			legs="Vishap Brais +3"
		})
		
		sets.precast.WS['Stardiver'].Capped = set_combine(sets.precast.WS['Stardiver'],
		{
			head="Flam. Zucchetto +2", neck="Dgn. Collar +2"
		})
		
		sets.precast.WS['Penta Thrust'] = sets.precast.WS['Stardiver']
		
		sets.precast.WS['Drakesbane'] = set_combine(sets.precast.WS,
		{
			head="Blistering Sallet +1", neck="Dgn. Collar +2", lear="Thrud Earring", rear="Sherida Earring",
			body="Hjarrandi Breast.", hands="Flam. Manopolas +2", rring="Regal Ring",
			back=gear.DRGCape_Crit, waist="Windbuffet Belt +1", legs="Peltast's Cuissots +1", feet="Valorous Greaves"
		})
		
		sets.precast.WS['Drakesbane'].High = set_combine(sets.precast.WS['Drakesbane'],
		{
			lear="Telos Earring",
			legs="Vishap Brais +3"
		})
		
		sets.precast.WS['Drakesbane'].Capped = set_combine(sets.precast.WS['Drakesbane'],
		{
			head="Flam. Zucchetto +2",
		})
		
		sets.precast.WS['Camlann\'s Torment'] = set_combine(sets.precast.WS,
		{
			rear="Ishvara Earring",
			waist="Sailfi Belt +1"
		})
		
		sets.precast.WS['Skewer'] = sets.precast.WS['Drakesbane']
		
		sets.precast.WS['Wheeling Thrust'] = sets.precast.WS['Camlann\'s Torment']
		
		sets.precast.WS['Sonic Thrust'] = sets.precast.WS['Camlann\'s Torment']
		
		sets.precast.WS['Impulse Drive'] = set_combine(sets.precast.WS,
		{
			neck="Dgn. Collar +2",
			body="Hjarrandi Breast."
			
		})
		
		sets.precast.WS['Vorpal Thrust'] = sets.precast.WS['Impulse Drive']
		
		sets.precast.WS['Leg Sweep'] =
		{
			ammo="Pemphredo Tathlum",
			head="Carmine Mask +1", neck="Sanctity Necklace", lear="Digni. Earring", rear="Gwati Earring",
			body="Ptero. Mail +3", hands="Flam. Manopolas +2", lring="Weather. Ring +1", rring={name="Stikini Ring +1", bag="wardrobe3"},
			back=gear.DRGCape_WSD, waist="Fotia Belt", legs="Ptero. Brais +3", feet="Flam. Gambieras +2"
		}
	
		sets.precast.WS['Thunder Thrust'] =
		{
			ammo="Pemphredo Tathlum", 
			head="Valorous Mask", neck="Sanctity Necklace", lear="Thrud Earring", rear="Moonshade Earring",
			body="Sacro Breastplate", hands="Carmine Fin. Ga. +1", lring="Shiva Ring +1", rring="Epaminondas's Ring",
			back=gear.DRGCape_WSD, waist="Orpheus's Sash", legs="Vishap Brais +3", feet="Sulev. Leggings +2"
		}
		
		sets.precast.WS['Raiden Thrust'] = sets.precast.WS['Thunder Thrust']
		
		--- Staff
		
		sets.precast.WS['Shell Crusher'] = sets.precast.WS['Leg Sweep']
		
		

	--------------------------------------
	-- Melee sets
	--------------------------------------
	
		----------------------------------------------------------
		-- No JA Haste
		----------------------------------------------------------			
		sets.engaged =
		{
			ammo="Aurgelmir Orb +1",
			head="Ptero. Armet +3", neck="Dgn. Collar +2", lear="Brutal Earring", rear="Sherida Earring",
			body=gear.VMail_DA, hands="Flam. Manopolas +2", lring="Niqmaddu Ring", rring="Moonlight Ring",
			back=gear.DRGCape_DA, waist="Sailfi Belt +1", legs="Sulev. Cuisses +2", feet="Flam. Gambieras +2"
		}
		
		sets.engaged.High = set_combine(sets.engaged,
		{
			lear={name="Mache Earring +1", bag="wardrobe2"}, rear={name="Mache Earring +1", bag="wardrobe3"},
			lring="Regal Ring",
			back=gear.DRGCape_STP, legs="Vishap Brais +3"
		})
		
		sets.engaged.STP = set_combine(sets.engaged,
		{
			head="Flam. Zucchetto +2", lear="Telos Earring",
			body=gear.VMail_DA, hands="Acro Gauntlets",
			back=gear.DRGCape_STP, legs="Ptero. Brais +3"
		})
		
		
		----------------------------------------------------------
		-- Maximum Haste
		----------------------------------------------------------			
		sets.engaged.Max =
		{
			ammo="Aurgelmir Orb +1",
			head="Hjarrandi Helm", neck="Dgn. Collar +2", lear="Brutal Earring", rear="Sherida Earring",
			body="Hjarrandi Breast.", hands="Sulev. Gauntlets +2", lring="Niqmaddu Ring", rring="Moonlight Ring",
			back=gear.DRGCape_DA, waist="Sailfi Belt +1", legs="Sulev. Cuisses +2", feet="Flam. Gambieras +2"
		}
		
		sets.engaged.High.Max = set_combine(sets.engaged.Max,
		{
			head="Flam. Zucchetto +2", lear={name="Mache Earring +1", bag="wardrobe2"}, rear={name="Mache Earring +1", bag="wardrobe3"},
			hands="Flam. Manopolas +2", lring="Regal Ring",
			back=gear.DRGCape_STP, legs="Vishap Brais +3"
		})
		
		sets.engaged.STP.Max = set_combine(sets.engaged.Max,
		{
			head="Flam. Zucchetto +2", neck="Anu Torque", lear="Dedition Earring",
			hands="Acro Gauntlets",
			back=gear.DRGCape_DA, legs="Sulev. Cuisses +2", 
		})



	------------------------------------------------------------------------------------------------
	---------------------------------------  Hybrid Sets -------------------------------------------
	------------------------------------------------------------------------------------------------	
	
	---Base Hybrid Set
		sets.engaged.Hybrid = 
		{
			ammo="Staunch Tathlum +1",
			neck="Dgn. Collar +2",
			body="Hjarrandi Breast.",
			lring="Defending Ring", rring="Moonlight Ring",
		}
		
		
	---Hybrid Combat
		sets.engaged.DT 						=	set_combine(sets.engaged,
		{
			ammo="Staunch Tathlum +1",
			neck="Dgn. Collar +2",
			body="Sacro Breastplate", lring="Defending Ring", rring="Moonlight Ring",
			legs="Sulev. Cuisses +2"
		})
		sets.engaged.High.DT					=	set_combine(sets.engaged.High, 	sets.engaged.Hybrid)

		
		sets.engaged.DT.Max 					= 	set_combine(sets.engaged.Max,
		{
			ammo="Staunch Tathlum +1",
			body="Sacro Breastplate", lring="Defending Ring"
		})
		sets.engaged.High.DT.Max				=	set_combine(sets.engaged.High.Max,
		{
			ammo="Staunch Tathlum +1",
			head="Hjarrandi Helm", neck="Dgn. Collar +2",
			hands="Sulev. Gauntlets +2",
			legs="Sulev. Cuisses +2"
		})

 
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_precast(spell, action, spellMap, eventArgs)
    -- Wyvern Commands
    if spell.name == 'Dismiss' and pet.hpp < 100 then        
        eventArgs.cancel = true
        add_to_chat(50, 'Cancelling Dismiss! ' ..pet.name.. ' is below full HP! [ ' ..pet.hpp.. '% ]')
	end
end
	
	
	
function job_post_precast(spell, action, spellMap, eventArgs)
	if state.EnmityDown.value and spell.type == 'WeaponSkill' then
		equip(sets.EnmityDown)
	end
	
	if spell.type == 'WeaponSkill' and magical_ws:contains(spell.name) then
		if spell.element ~= world.day_element and spell.element ~= world.weather_element then
			if spell.target.distance < (15 - spell.target.model_size) then
				equip { waist="Orpheus's Sash" }
			end
		elseif (spell.element == world.day_element and spell.element == world.weather_element)
				or (spell.element == world.weather_element and get_weather_intensity() == 2 and world.day_element ~= elements.strong_to[spell.element]) then
			equip { waist="Hachirin-no-Obi" }
		elseif (spell.element == world.day_element or (spell.element == world.weather_element and get_weather_intensity() == 1)
				or (spell.element == world.weather_element and get_weather_intensity() == 2 and world.day_element == elements.strong_to[spell.element])) then
			equip { waist="Hachirin-no-Obi" }
		end	
	end
	
	if state.TreasureMode.value ~= 'None' and spell.action_type == 'Ability' and spell.target.type == 'MONSTER' then
		equip(sets.TreasureHunter)
	end
end

function job_post_midcast(spell, action, spellMap, eventArgs)

	if spell.action_type == 'Magic' then
		if player.hpp < 50 and (player.sub_job == "WHM" or player.sub_job == "BLU" or player.sub_job == "RDM" or player.sub_job == "SCH") then
			equip { head="Vishap Armet +1" }
		elseif player.hpp < 33 and player.sub_job == "NIN" then
			equip { head="Vishap Armet +1" }
		end
	end

end


function job_post_pet_midcast(spell, action, spellMap, eventArgs)
	if spell.name:startswith('Healing Breath') then
		equip(sets.midcast.Pet.Breath)
	end
end


function job_aftercast(spell,action, spellMap, eventArgs)
	equip(sets[state.WeaponSet.current])
	equip(sets[state.GripSet.current])
end



function customize_idle_set(idleSet)
	if player.hpp < 80 then
		if state.IdleMode.value == 'Normal' then
			idleSet = set_combine(idleSet, 
			{
				neck="Sanctity Necklace", lear="Dawn Earring", rear="Infused Earring",
				lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"}
			})
		end
	elseif player.mpp < 80 and (player.sub_job == "BLU" or player.sub_job == "WHM" or player.sub_job == "RDM" or player.sub_job == "SCH") then
		if state.IdleMode.value == 'Normal' then
			idleSet = set_combine(idleSet, 
			{
				lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"}
			})
		end
	end

	return idleSet
end





-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff,gain)
-- If we gain or lose any flurry buffs, adjust gear.
	if state.Buff[buff] ~= nil then
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end
	
    if buff == "doom" then
        if gain then
            equip(sets.buff.Doom)
            disable('neck','lring','rring','waist')
        else
            enable('neck','lring','rring','waist')
            handle_equipping_gear(player.status)
        end
    end
	
	-- If we gain or lose any haste buffs, adjust which gear set we target.
	if S{'haste','march','embrava','hasso','last resort','spirit surge','haste samba','mighty guard','geo-haste','indi-haste','slow','indi-slow','elegy'}:contains(buff:lower()) then
		determine_haste_group()
		handle_equipping_gear(player.status)
	elseif state.Buff[buff] ~= nil then
        handle_equipping_gear(player.status)
	end	
	
	if buff == "sleep" then
		if gain then
			equip({head="Frenzy Sallet"})
		else
			handle_equipping_gear(player.status)
		end
	end
	
end

function job_state_change(stateField, newValue, oldValue)
	equip(sets[state.WeaponSet.current])
	equip(sets[state.GripSet.current])
end

function job_status_change(new_status, old_status)
	if new_status == 'Engaged' then
		determine_haste_group()
		handle_equipping_gear(player.status)
	end
end


function job_pet_status_change(newStatus, oldStatus, eventArgs)
    if pet.isvalid then
		determine_haste_group()
        handle_equipping_gear(player.status, newStatus)
    end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------
-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
	
	determine_haste_group()
	th_update(cmdParams, eventArgs)
	
	equip(sets[state.WeaponSet.current])
	equip(sets[state.GripSet.current])
end	


-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
	local msg = '[IDLE: ' .. state.IdleMode.value .. ']'

	msg = msg .. '  --' .. state.OffenseMode.value .. '--'
	
	if state.HybridMode.value ~= 'Normal' then
		msg = msg .. ' [' .. state.HybridMode.value .. '] '
	end
	
	msg = msg .. ' [WS: ' .. state.WeaponskillMode.value .. '] '

	if state.DefenseMode.value ~= 'None' then
		msg = msg .. ', ' .. 'Defense: ' .. state.DefenseMode.value .. ' (' .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ')'
	end
	
	if state.Kiting.value == true then
		msg = msg .. '  ~KITING~  '
	end
	
	if state.TreasureMode.has_value then
		msg = msg .. ', TH: ' .. state.TreasureMode.value
	end

	add_to_chat(122, msg)

	eventArgs.handled = true
end



--Adjusts gear based on the level of magical haste received.
function determine_haste_group()
--[[
				buffactive[1]	= Weakness
				buffactive[13]	= Slow
				buffactive[33]	= Haste
				buffactive[51]	= Last Resort
				buffactive[126]	= Spirit Surge
				buffactive[194]	= Elegy
				buffactive[214]	= March
				buffactive[228]	= Embrava
				buffactive[353] = Hasso
				buffactive[370]	= Haste Samba
				buffactive[580]	= Geo-Haste
				buffactive[604]	= Mighty Guard							]]
	
	classes.CustomMeleeGroups:clear()

	if buffactive[1] or buffactive[13] or buffactive[194] then
		classes.CustomMeleeGroups:append('')						-- Slow Status Effect
		--add_to_chat(8, '*********Slowed Status Effect Set***********')
	else
		if (pet.isvalid and (buffactive[353] or buffactive[51])) or buffactive[126] then		-- Job Ability Haste
			if (((buffactive[33] or buffactive[580] or buffactive[228]) and (buffactive[214] or buffactive[604])) or
				(buffactive[33] and (buffactive[580] or buffactive[228])) or ((buffactive[33] and buffactive[580]) and buffactive[228])
				or (buffactive.march == 2)) then
			classes.CustomMeleeGroups:append('Max')							-- 43.75% Magical Haste
			--add_to_chat(8, '*********Maximum Haste Set***********')
			end
		else
			classes.CustomMeleeGroups:append('')							-- No Magical Haste
			--add_to_chat(8, '*********Insufficient JA Haste***********')
		end
	end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------




 
-- Select default macro book on initial load or subjob change.
function apply_job_change()
    set_macro_page(1, 14)
	
	send_command('wait 3; input /lockstyleset 14')
end