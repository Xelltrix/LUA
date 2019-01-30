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

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Low', 'Mid', 'High')
    state.HybridMode:options('Normal', 'DT')
    state.IdleMode:options('Normal', 'DT', 'Movement')

	select_default_macro_book()
end

function user_unload()
	send_command('unbind !`')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    
----------------------------------------------------------------------------
--------------------									--------------------
------------							 						------------
--------					Precast Gear Sets						--------
------------							 						------------
--------------------									--------------------
----------------------------------------------------------------------------

		sets.Enmity =
		{
			ammo="Sapience Orb",
			lear="Friomisi Earring",
			body="Emet Harness +1", hands="Futhark Mitons +1", lring="Petrov Ring", rring="Begrudging Ring",
			back="Reiki Cloak", legs="Eri. Leg Guards +1", feet="Erilaz Greaves +1"
		}
		
	-------------------
	-- Job Abilities --
	------------------- 

		sets.precast.JA['Swipe'] =
		{
			ammo="Seeth. Bomblet +1",
			head="Herculean Helm", neck="Sanctity Necklace", lear="Friomisi Earring", rear="Novio Earring",
			body="Samnuha Coat", hands="Leyline Gloves", lring="Acumen Ring",
			back="Evasionist's Cape", waist="Eschan Stone", legs="Samnuha Tights", feet=gear.HBoots_TP
		}

		sets.precast.JA['Lunge'] = sets.precast.Swipe

		sets.precast.JA['Gambit'] =
		{
			hands="Runeist Mitons +1"
		}

		sets.precast.JA['Rayke'] =
		{
			feet="Futhark Boots +1"
		}

		sets.precast.Swordplay = set_combine(sets.Enmity,
		{
			hands="Futhark Mitons +1"
		})

		sets.precast.JA['Vallation'] = set_combine(sets.Enmity,
		{
			body="Runeist Coat +1",
			back="Ogma's Cape"
		})

		sets.precast.JA['Valiance'] = set_combine(sets.Enmity,
		{
			body="Runeist Coat +1",
			back="Ogma's Cape"
		})

		sets.precast.JA['Pflug'] = set_combine(sets.Enmity,
		{
			feet="Runeist Bottes +1"
		})

		sets.precast.JA['Battuta'] = set_combine(sets.Enmity,
		{
			head="Fu. Bandeau +1"
		})

		sets.precast.JA['Liement'] = set_combine(sets.Enmity,
		{
			body="Futhark Coat +1"
		})

		sets.precast.JA['Vivacious Pulse'] = set_combine(sets.Enmity,
		{
			head="Erilaz Galea +1", neck="Incanter's Torque",
			lring="Stikini Ring", rring="Stikini Ring",
			legs="Rune. Trousers +1"
		})

		sets.precast.JA['Elemental Sforzo'] = set_combine(sets.Enmity,
		{
			body="Futhark Coat +1"
		})
		
		sets.precast.JA['Odyllic Subterfuge'] = sets.Enmity
		
		sets.precast.JA['One For All'] = set_combine(sets.Enmity,
		{
			head="Erilaz Galea +1", lear="Etiolation Earring", rear="Odnowa Earring +1",
			body="Runeist Coat +1", hands="Runeist Mitons +1", lring="Ilabrat Ring", rring="Regal Ring",
			waist="Eschan Stone", feet="Runeist Bottes +1"
		})

		sets.precast.JA['Provoke'] = sets.Enmity

		sets.precast.JA['Warcry'] = sets.Enmity

		sets.precast.JA['Last Resort'] = sets.Enmity

		sets.precast.JA['Souleater'] = sets.Enmity

		sets.precast.JA['Weapon Bash'] = sets.Enmity

		sets.precast.JA['Sentinel'] = sets.Enmity
	
	-------------------
	-- Precast Magic --
	------------------- 
	
		sets.precast.FC =
		{
			ammo="Sapience Orb",
			head="Rune. Bandeau +1", neck="Orunmila's Torque", lear="Etiolation Earring", rear="Loquac. Earring",
			body="Samnuha Coat", hands="Leyline Gloves", lring="Evanescence Ring", rring="Rahab Ring",
			back=gear.RUNCape_FC, waist="Luminary Sash", legs="Aya. Cosciales +2", feet="Carmine Greaves +1"
		}

		sets.precast.Utsusemi = set_combine(sets.precast.FC,
		{
			neck="Magoraga Beads",
			body="Passion Jacket"
		})

		sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC,
		{
			waist="Siegel Sash",
			legs="Futhark Trousers +1"
		})

		sets.precast.FC['Dark Magic'] = sets.precast.FC
		
		sets.precast.FC['Blue Magic'] = sets.precast.FC
		
		sets.precast.FC.Cures = set_combine(sets.precast.FC,
		{
			lear="Mendi. Earring"
		})


----------------------------------------------------------------------------
--------------------									--------------------
------------							 						------------
--------					Midcast Gear Sets						--------
------------							 						------------
--------------------									--------------------
----------------------------------------------------------------------------


		sets.midcast.FastRecast = sets.precast.FC

	
	--------------------------------------
	-- Buffing Midcast sets
	--------------------------------------	
	
		sets.midcast.Regen =
		{
			ammo="Staunch Tathlum",
			head="Rune. Bandeau +1", neck="Incanter's Torque", lear="Gwati Earring", rear="Mendi. Earring",
			body="Futhark Coat +1", hands="Rawhide Gloves", lring="Defending Ring", rring="Evanescence Ring",
			back=gear.RUNCape_FC, waist="Hachirin-no-Obi", legs="Carmine Cuisses +1", feet="Carmine Greaves +1"
		}

		sets.midcast.Refresh =
		{
			ammo="Staunch Tathlum",
			head="Erilaz Galea +1", neck="Incanter's Torque", lear="Gwati Earring", rear="Mendi. Earring",
			body="Emet Harness +1", hands="Rawhide Gloves", lring="Defending Ring", rring="Vocane Ring",
			back=gear.RUNCape_FC, waist="Gishdubar Sash", legs="Futhark Trousers +1", feet="Carmine Greaves +1"
		}

		sets.midcast.Phalanx =
		{
			ammo="Staunch Tathlum",
			head="Fu. Bandeau +1", neck="Incanter's Torque", lear="Andoaa Earring", rear="Augment. Earring",
			body=gear.TBody_Phalanx, hands=gear.THands_Phalanx, lring="Stikini Ring", rring="Stikini Ring",
			back=gear.RUNCape_FC, waist="Olympus Sash", legs=gear.TLegs_Phalanx, feet=gear.TFeet_Phalanx
		}

		sets.midcast.Temper = sets.midcast.Phalanx

		sets.midcast.BarElement = 
		{
			ammo="Pemphredo Tathlum",
			head="Erilaz Galea +1", neck="Incanter's Torque", lear="Andoaa Earring", rear="Augment. Earring",
			body="Futhark Coat +1", hands="Runeist Mitons +1", lring="Stikini Ring", rring="Stikini Ring",
			back=gear.RUNCape_FC, waist="Olympus Sash", legs="Futhark Trousers +1", feet="Erilaz Greaves +1"
		}

		sets.midcast.BarStatus = sets.midcast.BarElement

		sets.midcast.Stoneskin =
		{
			ammo="Staunch Tathlum",
			head="Erilaz Galea +1", neck="Stone Gorget", lear="Earthcry Earring", rear="Loquac. Earring",
			body="Futhark Coat +1", hands="Stone Mufflers", lring="Stikini Ring", rring="Stikini Ring",
			back=gear.RUNCape_FC, waist="Olympus Sash", legs="Futhark Trousers +1", feet="Carmine Greaves +1"
		}

		sets.midcast.Duration =
		{
			ammo="Staunch Tathlum",
			head="Erilaz Galea +1", neck="Incanter's Torque", lear="Gwati Earring", rear="Mendi. Earring",
			body="Emet Harness +1", hands="Rawhide Gloves", lring="Defending Ring", rring="Vocane Ring",
			back=gear.RUNCape_FC, waist="Luminary Sash", legs="Futhark Trousers +1", feet="Carmine Greaves +1"
		}

		sets.midcast.Aquaveil = sets.midcast.Duration

		sets.midcast.Statless = sets.midcast.Duration

		sets.midcast['Enhancing Magic'] = sets.midcast.Duration
		
		sets.midcast.Utsusemi = sets.midcast.FastRecast

		sets.midcast.Protect = set_combine(sets.midcast.Duration,
		{
			lring="Sheltered Ring",
		})

		sets.midcast.Shell = sets.midcast.Protect
		
		sets.midcast.Buffs = sets.midcast.FastRecast


    --------------------------------------
	-- Enmity Midcast sets
	--------------------------------------		
	
		sets.midcast.Flash = set_combine(sets.Enmity,
		{
			head="Carmine Mask +1", neck="Incanter's Torque", rear="Loquac. Earring",
			hands="Leyline Gloves",
			back=gear.RUNCape_FC, waist="Luminary Sash", feet="Carmine Greaves +1"
		})
		
		sets.midcast.Stun = sets.midcast.Flash
		
		sets.midcast['Enfeebling Magic'] = sets.midcast.Flash
		
		sets.midcast['Blue Magic'] = sets.midcast.Flash

	
	
	--------------------------------------
	-- Misc. Job Midcast sets
	--------------------------------------	
	
		sets.midcast.Macc =
		{
			ammo="Pemphredo Tathlum",
			head="Aya. Zucchetto +2", neck="Incanter's Torque", lear="Digni. Earring", rear="Gwati Earring",
			body="Samnuha Coat", hands="Leyline Gloves", lring="Stikini Ring", rring="Stikini Ring",
			waist="Luminary Sash", legs="Aya. Cosciales +2", feet="Aya. Gambieras +2"
		}

		sets.midcast.Curaga = sets.midcast.Cures

		sets.midcast.StatusRemoval = sets.midcast.FastRecast

		sets.midcast.Cursna = set_combine(sets.midcast.FastRecast,
		{
			neck="Debilis Medallion",
			lring="Haoma's Ring", rring="Haoma's Ring",
		})
		
		sets.midcast.Teleport = sets.midcast.FastRecast

		sets.midcast.Raise = sets.midcast.FastRecast

		sets.midcast.Reraise = sets.midcast.FastRecast
		
		sets.midcast.Protectra = sets.midcast.Protect

		sets.midcast.Shellra = sets.midcast.Shell

		

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
			main="Aettir", ammo="Homiliary",
			head="Rawhide Mask", neck="Sanctity Necklace", lear="Dawn Earring", rear="Infused Earring",
			body="Runeist Coat +1", hands="Runeist Mitons +1", lring="Sheltered Ring", rring="Paguroidea Ring",
			back=gear.RUNCape_STP, waist="Fucho-no-Obi", legs="Rawhide Trousers", feet="Erilaz Greaves +1"
		}

		sets.idle.Movement = set_combine(sets.idle,
		{
			legs="Carmine Cuisses +1"
		})

		sets.idle.DT = 
		{
			main="Aettir", sub="Refined Grip +1", ammo="Staunch Tathlum",
			head="Aya. Zucchetto +2", neck="Loricate Torque +1", lear="Etiolation Earring", rear="Odnowa Earring +1",
			body="Futhark Coat +1", hands="Aya. Manopolas +2", lring="Defending Ring", rring="Vocane Ring",
			back="Reiki Cloak", waist="Flume Belt", legs="Eri. Leg Guards +1", feet="Erilaz Greaves +1"
		}

		sets.idle.Town = set_combine(sets.idle,
		{
			legs="Carmine Cuisses +1"
		})
		
		sets.idle.AdoulinCity = set_combine(sets.idle,
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
			main="Aettir", sub="Refined Grip +1", ammo="Staunch Tathlum",
			head="Aya. Zucchetto +2", neck="Loricate Torque +1", lear="Etiolation Earring", rear="Odnowa Earring +1",
			body="Futhark Coat +1", hands="Aya. Manopolas +2", lring="Defending Ring", rring="Vocane Ring",
			back=gear.RUNCape_STP, waist="Flume Belt", legs="Eri. Leg Guards +1", feet="Erilaz Greaves +1"
		}
		
		
		sets.defense.MDT = 
		{
			main="Aettir", sub="Irenic Strap +1", ammo="Staunch Tathlum",
			head="Dampening Tam", neck="Loricate Torque +1", lear="Etiolation Earring", rear="Odnowa Earring +1",
			body="Futhark Coat +1", hands="Aya. Manopolas +2", lring="Defending Ring", rring="Vocane Ring",
			back="Reiki Cloak", waist="Flume Belt", legs="Eri. Leg Guards +1", feet="Erilaz Greaves +1"
		}

	
	--------------------------------------
	-- Special Sets
	--------------------------------------
    	sets.buff.Doom = 
		{
			waist="Gishdubar Sash"
		}
		
		sets.buff['Embolden'] =
		{
			back="Evasionist's Cape"
		}
	
		sets.Kiting =
		{
			legs="Carmine Cuisses +1"
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
			head="Lilitu Headpiece", neck="Fotia Gorget", lear="Sherida Earring", rear="Moonshade Earring",
			body="Herculean Vest", hands="Meg. Gloves +2", lring="Niqmaddu Ring", rring="Regal Ring",
			back=gear.RUNCape_STP, waist="Fotia Belt", legs="Herculean Trousers", gear.HBoots_WSD
		}
		
		sets.precast.WS.High =
		{
			ammo="Seeth. Bomblet +1",
			head="Carmine Mask +1", lear="Telos Earring",
			body="Adhemar Jacket +1", legs="Carmine Cuisses +1", feet="Aya. Gambieras +2"
		}

    ---Dimidation
		sets.precast.WS['Dimidiation'] = sets.precast.WS
		
		sets.precast.WS['Dimidiation'].Low = set_combine(sets.precast.WS['Dimidiation'],
		{
			body="Adhemar Jacket +1"
		})
		
		sets.precast.WS['Dimidiation'].Mid = set_combine(sets.precast.WS['Dimidiation'].Low,
		{
			ammo="Falcon Eye",
			head="Carmine Mask +1"
		})
		
		sets.precast.WS['Dimidiation'].High= set_combine(sets.precast.WS['Dimidiation'].Mid,
		{
			lear="Telos Earring",
			legs="Carmine Cuisses +1", feet="Aya. Gambieras +2"
		})
	
	---Ground Strike
		sets.precast.WS['Ground Strike'] = sets.precast.WS
		
		sets.precast.WS['Ground Strike'].Low = set_combine(sets.precast.WS['Ground Strike'],
		{
			lear="Ishvara Earring",
			body="Adhemar Jacket +1"
		})
		
		sets.precast.WS['Ground Strike'].Mid = set_combine(sets.precast.WS['Ground Strike'].Low,
		{
			ammo="Seeth. Bomblet +1",
			head="Carmine Mask +1"
		})
		
		sets.precast.WS['Ground Strike'].High = set_combine(sets.precast.WS['Ground Strike'].Mid,
		{
			lear="Telos Earring",
			legs="Carmine Cuisses +1", feet="Aya. Gambieras +2"
		})

	---Spinning Slash
		sets.precast.WS['Spinning Slash'] = sets.precast.WS['Ground Strike']
		
		sets.precast.WS['Spinning Slash'].Low = sets.precast.WS['Ground Strike'].Low
		
		sets.precast.WS['Spinning Slash'].Mid = sets.precast.WS['Ground Strike'].Mid
		
		sets.precast.WS['Spinning Slash'].High = sets.precast.WS['Ground Strike'].High
		
	---Resolution
		sets.precast.WS['Resolution'] = set_combine(sets.precast.WS,
		{
			ammo="Seeth. Bomblet +1",
			head="Adhemar Bonnet +1", 
			body="Adhemar Jacket +1", hands="Adhemar Wrist. +1", rring="Epona's Ring",
			legs="Samnuha Tights", feet=gear.HBoots_TP
		})
		
		sets.precast.WS['Resolution'].Low = set_combine(sets.precast.WS['Resolution'],
		{
			rring="Regal Ring"
		})
		
		sets.precast.WS['Resolution'].Mid = set_combine(sets.precast.WS['Resolution'].Low,
		{
			head="Carmine Mask +1"
		})
		
		sets.precast.WS['Resolution'].High = set_combine(sets.precast.WS['Resolution'].Mid,
		{
			lear="Telos Earring",
			legs="Carmine Cuisses +1", feet="Aya. Gambieras +2"
		})
	
	
	
	--------------------------------------
	-- Melee sets
	--------------------------------------

		sets.engaged =
		{
			sub="Utu Grip", ammo="Yamarang",
			head="Adhemar Bonnet +1", neck="Anu Torque", lear="Sherida Earring", rear="Brutal Earring",
			body="Adhemar Jacket +1", hands="Adhemar Wrist. +1", lring="Niqmaddu Ring", rring="Epona's Ring",
			back=gear.RUNCape_STP, waist="Windbuffet Belt +1", legs="Samnuha Tights", feet=gear.HBoots_TP
		}

		sets.engaged.Low = set_combine(sets.engaged,
		{
			ammo="Seeth. Bomblet +1",
			neck="Combatant's Torque", lear="Telos Earring"
		})

		sets.engaged.Mid = set_combine(sets.engaged.Low,
		{
			head="Carmine Mask +1",
			hands="Aya. Manopolas +2", 
			feet="Carmine Greaves +1"
		})

		sets.engaged.High = set_combine(sets.engaged.Mid,
		{
			rring="Ilabrat Ring",
			waist="Kentarch Belt +1", legs="Carmine Cuisses +1"
		})
		
		
	------------------------------------------------------------------------------------------------
	---------------------------------------  Hybrid Sets -------------------------------------------
	------------------------------------------------------------------------------------------------	
	
	---Base Hybrid Set
		sets.engaged.Hybrid =
		{
			ammo="Staunch Tathlum",
			head="Aya. Zucchetto +2", neck="Loricate Torque +1",
			body="Ayanmo Corazza +2", lring="Defending Ring", rring="Vocane Ring",
			back=gear.RUNCape_STP, legs="Aya. Cosciales +2",
		}
		
	---Hybrid Combat
		sets.engaged.DT 			= set_combine(sets.engaged, 		sets.engaged.Hybrid)
		sets.engaged.Low.DT 		= set_combine(sets.engaged.Low, 	sets.engaged.Hybrid)
		sets.engaged.Mid.DT			= set_combine(sets.engaged.Mid, 	sets.engaged.Hybrid)
		sets.engaged.High.DT		= set_combine(sets.engaged.High, 	sets.engaged.Hybrid)



end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
function job_precast(spell, action, spellMap, eventArgs)
    if spellMap == 'Utsusemi' then
        if buffactive['Copy Image (3)'] or buffactive['Copy Image (4+)'] then
            cancel_spell()
            add_to_chat(123, '**!! '..spell.english..' Canceled: [3+ IMAGES] !!**')
            eventArgs.handled = true
            return
        elseif buffactive['Copy Image'] or buffactive['Copy Image (2)'] then
            send_command('cancel 66; cancel 444; cancel Copy Image; cancel Copy Image (2)')
        end
    end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.english == 'Lunge' or spell.english == 'Swipe' then
        if (spell.element == world.day_element or spell.element == world.weather_element) then
            equip{waist="Hachirin-no-Obi"}
        end
    end
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------
function job_buff_change(buff,gain)
	if buff == "doom" then
        if gain then
            equip(sets.buff.Doom)
             disable('waist')
        else
            enable('waist')
            handle_equipping_gear(player.status)
        end
    end
end
-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command.

-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
	local msg = 'Melee'

	if state.CombatForm.has_value then
		msg = msg .. ' (' .. state.CombatForm.value .. ')'
	end

	msg = msg .. ': '

	msg = msg .. state.OffenseMode.value
	if state.HybridMode.value ~= 'Normal' then
		msg = msg .. '/' .. state.HybridMode.value
	end
	msg = msg .. ', WS: ' .. state.WeaponskillMode.value

	if state.DefenseMode.value ~= 'None' then
		msg = msg .. ', ' .. 'Defense: ' .. state.DefenseMode.value .. ' (' .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ')'
	end

	if state.Kiting.value == true then
		msg = msg .. ', Kiting'
	end

	if state.PCTargetMode.value ~= 'default' then
		msg = msg .. ', Target PC: '..state.PCTargetMode.value
	end

	if state.SelectNPCTargets.value == true then
		msg = msg .. ', Target NPCs'
	end

	add_to_chat(122, msg)

	eventArgs.handled = true
end
-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
function update_active_abilities()
	state.Buff['Embolden'] = buffactive['Embolden'] or false
end

function apply_ability_bonuses(spell, action, spellMap)
	if state.Buff['Embolden'] and spell.skill == 'Enhancing Magic' then
		equip(sets.buff['Embolden'])
	end
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 14)
end
