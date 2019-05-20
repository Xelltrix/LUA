	-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
	mote_include_version = 2

	-- Load and initialize the include file.
	include('Mote-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
	state.Buff['Afflatus Solace'] 	= buffactive['Afflatus Solace'] or false
	state.Buff['Afflatus Misery'] 	= buffactive['Afflatus Misery'] or false
	state.Buff['Light Arts'] 		= buffactive['Light Arts'] or false
	
	lockstyleset = 3
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	state.OffenseMode:options('None', 'Normal')
	state.CastingMode:options('Normal', 'Resistant')
	state.SaveMP = M(false, 'Save MP')
	state.MagicBurst = M(false, 'Magic Burst')
	state.PhysicalDefenseMode:options('PDT')
	state.IdleMode:options('Normal', 'DT')

	select_default_macro_book()
	
	set_lockstyle()
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

	
	-------------------
	-- Job Abilities --
	------------------- 
	
		sets.precast.JA.Benediction =
		{
			body="Piety Briault +3"
		}

	-------------------
	-- Precast Magic --
	------------------- 
	
		sets.precast.FC =
		{
			main="Sucellus", sub="Chanter's Shield", ammo="Sapience Orb",
			head="Vanya Hood", neck="Cleric's Torque", lear="Etiolation Earring", rear="Loquac. Earring",
			body="Pinga Tunic", hands="Fanatic Gloves", lring="Kishar Ring", rring="Rahab Ring",
			back="Alaunus's Cape", waist="Witful Belt", legs="Pinga Pants", feet="Telchine Pigaches"
		}

		sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC,
		{
			waist="Siegel Sash"
		})

		sets.precast.FC['Enfeebling Magic'] = sets.precast.FC

		sets.precast.FC['Divine Magic'] = sets.precast.FC['Enfeebling Magic']

		sets.precast.FC['Elemental Magic'] = sets.precast.FC['Divine Magic']

		sets.precast.FC['Healing Magic'] = set_combine(sets.precast.FC,
		{
			main="Queller Rod",
			legs="Ebers Pant. +1"
		})

		sets.precast.FC.StatusRemoval = set_combine(sets.precast.FC['Healing Magic'],
		{
			main="Yagrush"
		})

		sets.precast.FC.Cures = set_combine(sets.precast.FC['Healing Magic'],
		{
			main="Queller Rod",
			rear="Mendi. Earring",
			feet="Vanya Clogs"
		})

		sets.precast.FC.Curagas = sets.precast.FC.Cures

		sets.precast.FC.Teleport = sets.precast.FC

		sets.precast.FC.Reraise = sets.precast.FC

		sets.precast.FC.Raise = sets.precast.FC

		sets.precast.FC.Statless = sets.precast.FC

		sets.precast.FC.Impact = set_combine(sets.precast.FC,
		{
			head=empty,
			body="Twilight Cloak"
		})

	
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

		sets.midcast.FC = set_combine(sets.precast.FC,
		{
			legs="Aya. Cosciales +2"
		})

		sets.midcast.ConserveMP = set_combine(sets.midcast.FC,
		{
			ammo="Pemphredo Tathlum",
			neck="Incanter's Torque", lear="Gwati Earring", rear="Mendi. Earring",
			body="Chironic Doublet",
			back="Fi Follet Cape +1", waist="Luminary Sash", legs="Lengo Pants", feet="Medium's Sabots"
		})

		sets.midcast.Duration =
		{
			main="Gada", sub="Ammurapi Shield", ammo="Pemphredo Tathlum",
			head="Telchine Cap", neck="Cleric's Torque", lear="Etiolation Earring", rear="Loquac. Earring",
			body="Telchine Chas.", hands=gear.ENH_Gloves, lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back="Alaunus's Cape", waist="Olympus Sash", legs="Telchine Braconi", feet="Theo. Duckbills +3"
		}
		
		
    --------------------------------------
	-- Healing Midcast sets
	--------------------------------------	

		-- Cure Potency/II: 51%/9%			Enmity: -64		Healing Magic Skill: +110(573)	MND+193
		sets.midcast.Cures =
		{
			main="Queller Rod", sub="Sors Shield", ammo="Pemphredo Tathlum",
			head="Kaykaus Mitra", neck="Cleric's Torque", lear="Glorious Earring", rear="Mendi. Earring",
			body="Theo. Briault +2", hands="Theophany Mitts +2", lring="Lebeche Ring", rring={name="Stikini Ring +1", bag="wardrobe3"},
			back="Alaunus's Cape", waist="Luminary Sash", legs="Sifahir Slacks", feet="Vanya Clogs"
		}
		
		-- Cure Potency/II: 51%/6%			Enmity: -54		Healing Magic Skill: +114(580)	MND+221		Solace+24	
		sets.midcast.CureSolace =
		{
			main="Queller Rod", sub="Sors Shield", ammo="Pemphredo Tathlum",
			head="Kaykaus Mitra", neck="Cleric's Torque", lear="Glorious Earring", rear="Mendi. Earring",
			body="Ebers Bliaud +1", hands="Theophany Mitts +2", lring="Lebeche Ring", rring={name="Stikini Ring +1", bag="wardrobe3"},
			back="Alaunus's Cape", waist="Luminary Sash", legs="Sifahir Slacks", feet="Vanya Clogs"
		}
		
		sets.midcast.Curagas = sets.midcast.Cures
		
		-- Cure Potency/II: 50%/7%			Enmity: -54		Healing Magic Skill: +78(541)	MND+181
		sets.midcast.CuresWeather =
		{
			main="Chatoyant Staff", sub="Enki Strap", ammo="Pemphredo Tathlum",
			head="Kaykaus Mitra", neck="Cleric's Torque", lear="Glorious Earring", rear="Mendi. Earring",
			body="Theo. Briault +2", hands="Theophany Mitts +2", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back="Twilight Cape", waist="Hachirin-no-Obi", legs="Sifahir Slacks", feet="Kaykaus Boots"
		}
		
		-- Cure Potency/II: 50%/4%			Enmity: -54		Healing Magic Skill: +87(550)	MND+193		Solace+24	
		sets.midcast.CureSolaceWeather =
		{
			main="Chatoyant Staff", sub="Enki Strap", ammo="Pemphredo Tathlum",
			head="Kaykaus Mitra", neck="Cleric's Torque", lear="Glorious Earring", rear="Mendi. Earring",
			body="Ebers Bliaud +1", hands="Theophany Mitts +2", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back="Alaunus's Cape", waist="Hachirin-no-Obi", legs="Sifahir Slacks", feet="Kaykaus Boots"
		}
		
		sets.midcast.CuragaWeather = sets.midcast.CuresWeather

		--[[	Cursna Formula: (10 + Healing Magic Skill/30)*(1 + Cursna Success/100)*(1 + Cursna Received/100)
			(10 + 588/30)*(1 + 116/100)	=
		60% Success Rate																								]]
		sets.midcast.Cursna = set_combine(sets.precast.FC['Healing Magic'],
		{
			main="Yagrush", sub="Ammurapi Shield",
			head="Kaykaus Mitra", neck="Debilis Medallion", lear="Beatific Earring", rear="Healing Earring",
			body="Ebers Bliaud +1", lring="Haoma's Ring", rring="Menelaus's Ring",
			waist="Bishop's Sash", legs="Th. Pant. +3", feet="Vanya Clogs"
		})

		sets.midcast.StatusRemoval = set_combine(sets.precast.FC['Healing Magic'],
		{
			main="Yagrush",
			legs="Ebers Pant. +1"
		})
		
		sets.midcast.Erase = set_combine(sets.midcast.StatusRemoval,
		{
			neck="Cleric's Torque"
		})
		
--[[		sets.midcast.Esuna = set_combine(sets.midcast.FC,
		{
			main="Piety Wand"
		})]]

		sets.midcast['Healing Magic'] = sets.precast.FC
		
		sets.midcast.Reraise = sets.midcast.ConserveMP

		sets.midcast.Raise = sets.midcast.ConserveMP
		
		sets.midcast.Arise = sets.midcast.FC

	--------------------------------------
	-- Buffing Midcast sets
	--------------------------------------	
		


		sets.midcast.Stoneskin = set_combine(sets.midcast.Duration,
		{
			neck="Stone Gorget", rear="Earthcry Earring",
			lring="Kishar Ring", rring="Rahab Ring",
			waist="Siegel Sash", legs="Shedir Seraweels"
		})

		sets.midcast.Aquaveil = set_combine(sets.midcast.Duration,
		{
			main="Vadose Rod", sub="Ammurapi Shield",
			head="Chironic Hat", waist="Emphatikos Rope", legs="Shedir Seraweels"
		})

		sets.midcast.Auspice = set_combine(sets.midcast.Duration,
		{
			feet="Ebers Duckbills +1"
		})

		sets.midcast.BarElement =
		{
			main="Beneficus", sub="Ammurapi Shield", ammo="Pemphredo Tathlum",
			head="Ebers Cap +1", neck="Incanter's Torque", lear="Andoaa Earring", rear="Augment. Earring",
			body="Ebers Bliaud +1", hands="Dynasty Mitts", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back="Alaunus's Cape", waist="Olympus Sash", legs="Piety Pantaln. +2", feet="Ebers Duckbills +1"
		}
		
		sets.midcast.BarElementLA = set_combine(sets.midcast.BarElement,
		{
			hands="Ebers Mitts +1"
		})

		sets.midcast.BarStatus = set_combine(sets.midcast.Duration,
		{
			neck="Incanter's Torque", lear="Andoaa Earring", rear="Augment. Earring",
			hands="Dynasty Mitts",
			back="Fi Follet Cape +1",
		})

		sets.midcast.BarStatusLA = set_combine(sets.midcast.BarStatus,
		{
			hands=gear.ENH_Gloves
		})
	
		sets.midcast.BoostStat =
		{
			main="Gada", sub="Ammurapi Shield", ammo="Pemphredo Tathlum",
			head="Telchine Cap", neck="Incanter's Torque", lear="Andoaa Earring", rear="Augment. Earring",
			body="Telchine Chas.", hands="Dynasty Mitts", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back="Fi Follet Cape +1", waist="Olympus Sash", legs="Telchine Braconi", feet="Theo. Duckbills +3"
		}

		sets.midcast.BoostStatLA = set_combine(sets.midcast.BoostStat,
		{
			hands=gear.ENH_Gloves
		})

		sets.midcast.Regen = set_combine(sets.midcast.Duration,
		{
			main="Bolelabunga", sub="Ammurapi Shield", ammo="Pemphredo Tathlum",
			head="Inyanga Tiara +2", neck="Incanter's Torque", lear="Gwati Earring", rear="Mendi. Earring",
			body="Piety Briault +3", hands="Ebers Mitts +1", lring="Lebeche Ring", rring="Rahab Ring",
			back="Fi Follet Cape +1", waist="Luminary Sash", legs="Th. Pant. +3", feet="Theo. Duckbills +3"
		})

		sets.midcast.Refresh = set_combine(sets.midcast.Duration,
		{
			lear="Gwati Earring", rear="Mendi. Earring",
			ring="Lebeche Ring", rring="Rahab Ring",
		})

		sets.midcast.Statless = sets.midcast.Duration

		sets.midcast.Storm = sets.midcast.Duration

		sets.midcast.Protection = set_combine(sets.midcast.Duration,
		{
			neck="Incanter's Torque", lear="Gwati Earring", rear="Mendi. Earring",
			back="Fi Follet Cape +1", waist="Luminary Sash"
		})
		sets.midcast.Teleport = sets.midcast.ConserveMP


	--------------------------------------
	-- Offensive Midcast sets
	--------------------------------------    
	
	---Enfeebling Magic	
		sets.midcast.Macc =
		{
			main="Maxentius", sub="Ammurapi Shield", ammo="Pemphredo Tathlum",
			head="Inyanga Tiara +2", neck="Incanter's Torque", lear="Regal Earring", rear="Digni. Earring", 
			body="Theo. Briault +2", hands="Inyan. Dastanas +2", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back="Alaunus's Cape", waist="Luminary Sash", legs="Chironic Hose", feet="Theo. Duckbills +3"
		}
		
		sets.midcast['Enfeebling Magic'] = set_combine(sets.midcast.Macc,
		{
			hands="Kaykaus Cuffs +1", lring="Kishar Ring",
		})
	
		sets.midcast.Static = set_combine(sets.midcast['Enfeebling Magic'],
		{
			hands="Regal Cuffs", lring="Kishar Ring"
		})

		sets.midcast['Dia'] = sets.midcast.FastRecast
		
		sets.midcast['Dia II'] = sets.midcast.FastRecast

		sets.midcast['Divine Magic'] = sets.midcast.Macc
	
	---Dark Magic	
		sets.midcast['Dark Magic'] = set_combine(sets.midcast.Macc,
		{
			body="Shango Robe", lring="Archon Ring"
		})

		sets.midcast.Sap = set_combine(sets.midcast['Dark Magic'],
		{
			head="Pixie Hairpin +1",
			body="Chironic Doublet", rring="Evanescence Ring",
			waist="Fucho-no-Obi"
		})
		
		
	-- Elemental Magic	
		sets.midcast.DivineNuke =
		{
			main="Maxentius", sub="Ammurapi Shield", ammo="Pemphredo Tathlum",
			head="Chironic Hat", neck="Sanctity Necklace", lear="Friomisi Earring", rear="Regal Earring",
			body="Chironic Doublet", hands="Fanatic Gloves", lring={name="Shiva Ring +1", bag="wardrobe2"}, rring={name="Shiva Ring +1", bag="wardrobe3"},
			back="Alaunus's Cape", waist="Orpheus's Sash", legs="Chironic Hose", feet="Chironic Slippers"
		}

		sets.midcast['Elemental Magic'] = sets.midcast.DivineNuke
		
		sets.midcast.Impact = set_combine(sets.midcast.Macc,
		{
			head=empty,
			body="Twilight Cloak", lring="Archon Ring"
		})


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
			main="Bolelabunga", sub="Genmei Shield", ammo="Homiliary",
			head="Befouled Crown", neck="Sanctity Necklace", lear="Dawn Earring", rear="Infused Earring",
			body="Piety Briault +3", hands="Chironic Gloves", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back="Alaunus's Cape", waist="Lieutenant's Sash", legs="Assid. Pants +1", feet="Chironic Slippers"
		}
		
		sets.idle.DT = set_combine(sets.idle,
		{
			head="Inyanga Tiara +2", neck="Loricate Torque +1", lear="Etiolation Earring", rear="Static Earring",
			lring="Defending Ring", rring="Gelatinous Ring +1"
		})

		sets.idle.Town = set_combine(sets.idle,
		{
			feet="Crier's Gaiters"
		})
		
		sets.idle.Adoulin = set_combine(sets.idle,
		{
			body="Councilor's Garb"
		})

		sets.idle.Weak = sets.idle.MDT
	
	------------------------------------------------------------------------------------------------
	--------------------------------------- Defense Sets -------------------------------------------
	------------------------------------------------------------------------------------------------
	

	--------------------------------------
	-- Defensive Sets
	--------------------------------------
		
		sets.defense.PDT = 
		{
			main="Mafic Cudgel", sub="Genmei Shield", ammo="Staunch Tathlum +1",
			head="Inyanga Tiara +2", neck="Loricate Torque +1", lear="Eabani Earring", rear="Static Earring",
			body="Inyanga Jubbah +2", hands="Inyan. Dastanas +2", lring="Defending Ring", rring="Gelatinous Ring +1",
			back="Moonbeam Cape", waist="Carrier's Sash", legs="Inyanga Shalwar +2", feet="Inyan. Crackows +2"
		}

		sets.defense.MDT = set_combine(sets.defense.PDT,
		{
			neck="Warder's Charm +1",
			waist="Carrier's Sash"
		})
	
	
	--------------------------------------
	-- Special Sets
	--------------------------------------
		
		sets.Kiting =
		{
			feet="Crier's Gaiters"
		}

		sets.buff['Divine Caress'] =
		{
			hands="Ebers Mitts +1",
			back="Mending Cape"
		}
		
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
			head="Aya. Zucchetto +2", neck="Fotia Gorget", lear="Brutal Earring", rear="Ishvara Earring",
			body="Ayanmo Corazza +2", hands="Aya. Manopolas +2", lring="Rufescent Ring", rring="Karieyh Ring +1",
			back="Alaunus's Cape", waist="Fotia Belt", legs="Telchine Braconi", feet="Aya. Gambieras +2"
		}
	
	--------------------------------------
	-- Melee sets
	--------------------------------------
		
		sets.engaged =
		{
			main="Maxentius", sub="Genmei Shield", ammo="Floestone",
			head="Aya. Zucchetto +2", neck="Combatant's Torque", lear={name="Mache Earring +1", bag="wardrobe2"}, rear={name="Mache Earring +1", bag="wardrobe3"},
			body="Ayanmo Corazza +2", hands="Aya. Manopolas +2", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"},
			back="Alaunus's Cape", waist="Windbuffet Belt +1", legs="Aya. Cosciales +2", feet="Aya. Gambieras +2"
		}
	
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_post_midcast(spell, action, spellMap, eventArgs)
	-- Apply Divine Caress boosting items as highest priority over other gear, if applicable.
	if spellMap == 'StatusRemoval' and buffactive['Divine Caress'] then
		equip(sets.buff['Divine Caress'])
	end
	
	if spellMap == 'Cures' and spell.target.type == 'SELF' then
        	equip
		{
			waist="Gishdubar Sash"
		}
	end
	
	if spellMap == 'Refresh' and spell.target.type == 'SELF' then
		equip
		{
			back="Grapevine Cape", waist="Gishdubar Sash", feet="Inspirited Boots"
		}
	end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------
function job_buff_change(buff,gain)
	if buff == "doom" then
        if gain then
            equip(sets.buff.Doom)
             disable('neck','lring','rring','waist')
        else
			enable('neck','lring','rring','waist')
            handle_equipping_gear(player.status)
        end
    end
end


-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
	if stateField == 'Offense Mode' then
		if newValue == 'Normal' then
			disable('main','sub','range')
		else
			enable('main','sub','range')
		end
	end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
	if spell.action_type == 'Magic' then
		if default_spell_map == 'Cures' then
            if buffactive['Afflatus Solace'] then
                if (world.weather_element == 'Light' or world.day_element == 'Light') then
                    return "CureSolaceWeather"
                else
                    return "CureSolace"
                end
            else
                if (world.weather_element == 'Light' or world.day_element == 'Light') then
                    return "CuresWeather"
                else
                    return "Cures"
                end
            end
        elseif default_spell_map == 'Curagas' then
            if (world.weather_element == 'Light' or world.day_element == 'Light') then
                return "CuragaWeather"
            else
                return "Curagas"
            end
		elseif default_spell_map == 'BarElement'then
			if buffactive['Light Arts'] then
				return "BarElementLA"
			end
		elseif default_spell_map == 'BarStatus' then
			if buffactive['Light Arts'] then
				return "BarStatusLA"
			end
		elseif default_spell_map == 'BoostStat' then
			if buffactive['Light Arts'] then
				return "BoostStatLA"
			end
		end
	end
end

-- Function to display the current relevant user state when doing an update.
function display_current_job_state(eventArgs)
	display_current_caster_state()
	eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	set_macro_page(1, 2)
end

function set_lockstyle()
    send_command('wait 3; input /lockstyleset ' .. lockstyleset)
end