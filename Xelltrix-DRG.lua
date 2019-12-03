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
	include('Mote-TreasureHunter')
	
	state.EnmityDown = M(false)
	
	determine_haste_group()
	customize_idle_set()
	
	lockstyleset = 16
end
 
 
-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	state.OffenseMode:options('Normal', 'Low', 'Mid', 'High')
	state.HybridMode:options('Normal', 'DT')
	state.WeaponskillMode:options('Normal', 'Low', 'Mid', 'High')
	
	send_command('bind ^= gs c cycle treasuremode')
    
	send_command('bind numpad. gs c toggle EnmityDown')
	
    apply_job_change()
end

function user_unload()
	send_command('unbind ^=')
	send_command('unbind numpad.')
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
	
		sets.precast.JA['Spirit Surge'] = { body="Pteroslaver Mail +1" }
		
		sets.precast.JA['Call Wyvern'] = { body="Pteroslaver Mail +1" }
		
		sets.precast.JA['Ancient Circle'] = { legs="Vishap Brais +2" }
		
		sets.precast.JA['Spirit Link'] =
		{
			head="Vishap Armet +1",
			hands="Pel. Vambraces +1",
			feet="Ptero. Greaves +1"
		}
		
		sets.precast.JA['Angon'] =
		{
			ammo="Angon",
			hands="Ptero. Fin. G. +1"
		}
		
		sets.precast.JA['Jump'] =
		{
			ammo="Ginsen",
			head="Flam. Zucchetto +2", neck="Anu Torque", lear="Sherida Earring", rear="Telos Earring",
			body="Hjarrandi Breast.", hands="Vishap F. G. +1", lring="Niqmaddu Ring", rring={name="Chirich Ring +1", bag="wardrobe3"},
			back=gear.DRGCape_STP, waist="Windbuffet Belt +1", legs="Sulev. Cyusses +2", feet="Ostro Greaves"
		}
		
		sets.precast.JA['Spirit Jump'] = set_combine(sets.precast.JA['Jump'],
		{
			legs="Peltast's Cuissots +1", feet="Pelt. Schyn. +1"
		})
		
		sets.precast.JA['High Jump'] = set_combine(sets.precast.JA['Jump'],
		{
			legs="Vishap Brais +2"
		})
		
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
			body=gear.TBody_Phalanx, hands="Leyline Gloves", lring="Defending Ring", rring="Weather. Ring +1",
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
			back=gear.DRGCape_DA, legs="Vishap Brais +2", feet="Ptero. Greaves +1"
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
			head="Hjarrandi Helm", neck="Warder's Charm +1", lear="Eabani Earring", rear="Sanare Earring",
			body="Tartarus Platemail", hands="Sulev. Gauntlets +2", lring="Defending Ring", rring="Moonlight Ring",
			back="Moonlight Cape", waist="Carrier's Sash", legs="Carmine Cuisses +1", feet="Sulev. Leggings +2"
		}

		sets.idle.Town = sets.idle
		
		sets.idle.Adoulin = set_combine(sets.idle,
		{
			body="Councilor's Garb"
		})

		sets.idle.Weak = sets.idle
	
	
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
			body="Tartarus Platemail", hands="Sulev. Gauntlets +2", lring="Defending Ring", rring="Moonlight Ring",
			back="Moonlight Cape", waist="Carrier's Sash", legs="Carmine Cuisses +1", feet="Sulev. Leggings +2"
		}

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
			head="Valorous Mask", neck="Fotia Gorget", lear="Ishvara Earring", rear="Moonshade Earring",
			body=gear.VMail_WSD, hands="Sulev. Gauntlets +2", lring="Niqmaddu Ring", rring="Epaminondas's Ring",
			back=gear.DRGCape_WSD, waist="Fotia Belt", legs="Vishap Brais +2", feet="Sulev. Leggings +2"
		}
		
		sets.precast.WS['Stardiver'] = set_combine(sets.precast.WS,
		{
			head="Ptero. Armet +3", lear="Sherida Earring",
			body=gear.VMail_DA, rring="Regal Ring",
			back=gear.DRGCape_DA, legs="Sulev. Cuisses +2", feet="Flam. Gambieras +2"
		})
		
		sets.precast.WS['Drakesbane'] = set_combine(sets.precast.WS,
		{
			head="Ptero. Armet +3", lear="Sherida Earring",
			body="Hjarrandi Breast.", hands="Flam. Manopolas +2", rring="Begrudging Ring",
			back=gear.DRGCape_DA, waist="Windbuffet Belt +1", legs="Peltast's Cuissots +1", feet="Thereoid Greaves"
		})
		
		sets.precast.WS['Camlann\'s Torment'] = set_combine(sets.precast.WS,
		{
			lear="Sherida Earring", rear="Ishvara Earring",
			back=gear.DRGCape_WSD
		})
		
		sets.precast.WS['Skewer'] = sets.precast.WS['Drakesbane']
		
		sets.precast.WS['Wheeling Thrust'] = sets.precast.WS['Camlann\'s Torment']
	
		sets.precast.WS['Thunder Thrust'] =
		{
			ammo="Pemphredo Tathlum", 
			head="Valorous Mask", neck="Sanctity Necklace", lear="Friomisi Earring", rear="Moonshade Earring",
			body="Carm. Sc. Mail +1", hands="Carmine Fin. Ga. +1", lring={name="Shiva Ring +1", bag="wardrobe2"}, rring="Epaminondas's Ring",
			back=gear.DRGCape_WSD, waist="Orpheus's Sash", legs="Vishap Brais +2", feet="Sulev. Leggings +2"
		}
		
		sets.precast.WS['Raiden Thrust'] = sets.precast.WS['Thunder Thrust']

	--------------------------------------
	-- Melee sets
	--------------------------------------
	
		----------------------------------------------------------
		-- No JA Haste
		----------------------------------------------------------			
		sets.engaged =
		{
			ammo="Ginsen",
			head="Flam. Zucchetto +2", neck="Anu Torque", lear="Sherida Earring", rear="Brutal Earring",
			body="Hjarrandi Breast.", hands="Flam. Manopolas +2", lring="Niqmaddu Ring", rring={name="Chirich Ring +1", bag="wardrobe3"},
			back=gear.DRGCape_DA, waist="Ioskeha Belt +1", legs="Valorous Hose", feet="Flam. Gambieras +2"
		}
		
		sets.engaged.Low = set_combine(sets.engaged,
		{
			head="Ptero. Armet +3", rear="Telos Earring",
			legs="Sulev. Cuisses +2"
		})
		
		sets.engaged.Mid = set_combine(sets.engaged.Low,
		{
			neck="Combatant's Torque", lear={name="Mache Earring +1", bag="wardrobe2"}, rear={name="Mache Earring +1", bag="wardrobe3"},
			back=gear.DRGCape_STP,
		})
		
		----------------------------------------------------------
		-- Maximum Haste
		----------------------------------------------------------			
		sets.engaged.Max =
		{
			ammo="Ginsen",
			head="Hjarrandi Helm", neck="Anu Torque", lear="Sherida Earring", rear="Brutal Earring",
			body="Hjarrandi Breast.", hands="Sulev. Gauntlets +2", lring="Niqmaddu Ring", rring={name="Chirich Ring +1", bag="wardrobe3"},
			back=gear.DRGCape_DA, waist="Ioskeha Belt +1", legs="Sulev. Cuisses +2", feet="Flam. Gambieras +2"
		}
		
		sets.engaged.Low.Max = set_combine(sets.engaged.Max,
		{
			neck="Combatant's Torque", rear="Telos Earring",
			hands="Flam. Manopolas +2"
		})
		
		sets.engaged.Mid.Max = set_combine(sets.engaged.Low.Max,
		{
			head="Ptero. Armet +3", lear={name="Mache Earring +1", bag="wardrobe2"}, rear={name="Mache Earring +1", bag="wardrobe3"},
			back=gear.DRGCape_STP,
		})


	--------------------------------------
	-- Hybrid Sets
	--------------------------------------
	
		sets.engaged.Hybrid = 
		{
			ammo="Staunch Tathlum +1",
			neck="Loricate Torque +1",
			rring="Moonlight Ring"
		}

 
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
	if S{'haste','march','embrava','hasso','spirit surge','haste samba', 'mighty guard', 'geo-haste', 'indi-haste', 'slow', 'indi-slow', 'elegy',}:contains(buff:lower()) then
		determine_haste_group()
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
		if (pet.isvalid and buffactive[353]) or buffactive[126] then		-- Job Ability Haste
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
    set_macro_page(1, 13)
	
	send_command('wait 3; input /lockstyleset ' .. lockstyleset)
end