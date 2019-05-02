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

end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	state.OffenseMode:options('None', 'Normal', 'Refresh')
	state.CastingMode:options('Normal', 'Resistant','Potency')
	state.IdleMode:options('Normal', 'DT', 'DeathMode')
	state.MagicBurst = M(false, 'Magic Burst')

	-- Additional local binds
	send_command('bind !` gs c toggle MagicBurst')
	send_command('bind !s gs c toggle Spaekona')

	select_default_macro_book()
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
	send_command('unbind !`')
	send_command('unbind !s')
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

	---- Precast Sets ----
	sets.precast.FC =
	{
		ammo="Sapience Orb",
		head="Vanya Hood", neck="Orunmila's Torque", lear="Etiolation Earring", rear="Loquac. Earring",
        	body="Shango Robe", hands="Telchine Gloves", lring="Kishar Ring", rring="Rahab Ring",
        	back="Swith Cape +1", waist="Witful Belt", legs="Psycloth Lappas", feet="Amalric Nails +1"
	}

	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC,
	{
		waist="Siegel Sash"
	})
	
	sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'],
	{
		head="Umuthi Hat",
		hands="Carapacho Cuffs"
	})

	sets.precast.FC['Elemental Magic'] = sets.precast.FC

	sets.precast.FC.Cures = set_combine(sets.precast.FC,
	{
		rear="Mendi. Earring"
	})

	sets.precast.FC.Curaga = sets.precast.FC.Cures

	sets.precast.FC.Impact = set_combine(sets.precast.FC,
	{
		head=empty,
		body="Twilight Cloak"
	})

	sets.precast.FC.Death =
	{
		main=gear.Grioavolr_Enf, sub="Enki Strap", ammo="Sapience Orb",
		head="Vanya Hood", neck="Orunmila's Torque", lear="Etiolation Earring", rear="Loquac. Earring",
        	body="Shango Robe", hands="Regal Cuffs", lring="Kishar Ring", rring="Mephitas's Ring +1",
        	back="Swith Cape +1", waist="Witful Belt", legs="Psycloth Lappas", feet="Amalric Nails +1"
	}


	-- Weaponskill sets
	sets.precast.WS =
	{
		ammo="Floestone",
		head="Jhakri Coronal +2", neck="Fotia Gorget", lear="Telos Earring", rear="Moonshade Earring",
		body="Jhakri Robe +2", hands="Jhakri Cuffs +2", lring="Rufescent Ring", rring="Shukuyu Ring",
		back="Taranus's Cape", legs="Jhakri Slops +2", feet="Jhakri Pigaches +2"
	}

	sets.precast.WS['Myrkr'] =
	{
		ammo="Psilomene",
		head="Pixie Hairpin +1", neck="Sanctity Necklace", lear="Etiolation Earring", rear="Moonshade Earring",
		body="Amalric Doublet +1", hands="Regal Cuffs", lring="Lebeche Ring", rring="Mephitas's Ring +1",
		back="Fi Follet Cape +1", waist="Luminary Sash", legs="Amalric Slops +1", feet="Amalric Nails +1"
	}


	---- Midcast Sets ----

	sets.midcast.FC = sets.precast.FC

	sets.midcast.Cures =
	{
		ammo="Esper Stone +1",
		head="Vanya Hood", neck="Incanter's Torque", lear="Gwati Earring", rear="Mendi. Earring",
        	body="Merlinic Jubbah", hands="Telchine Gloves", lring="Lebeche Ring", rring="Vocane Ring",
       		back="Solemnity Cape", waist="Gishdubar Sash", legs="Gyve Trousers", feet="Vanya Clogs"
	}

	sets.midcast.Curaga = sets.midcast.Cures

	sets.midcast.Cursna = set_combine(sets.precast.FC,
	{
		main="Gada", sub="Ammurapi Shield",
		neck="Debilis Medallion", lear="Beatific Earring",
        	hands="Hieros Mittens", lring="Haoma's Ring", rring="Menelaus's Ring",
        	back="Oretan. Cape +1", waist="Bishop's Sash", feet="Vanya Clogs"
	})

	sets.midcast.Duration =
	{
		main="Gada", sub="Ammurapi Shield", ammo="Pemphredo Tathlum",
		head="Telchine Cap", neck="Orunmila's Torque", lear="Etiolation Earring", rear="Loquac. Earring",
		body="Telchine Chas.", hands="Telchine Gloves", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
		back="Fi Follet Cape +1", waist="Witful Belt", legs="Telchine Braconi", feet="Telchine Pigaches"
	}

	
	sets.midcast.StatusRemoval = sets.midcast.FC

	sets.midcast['Enhancing Magic'] =
	{
		main="Gada", sub="Ammurapi Shield", ammo="Pemphredo Tathlum",
		head="Befouled Crown", neck="Incanter's Torque", lear="Andoaa Earring", rear="Augment. Earring",
		body="Telchine Chas.", hands="Telchine Gloves", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
		back="Fi Follet Cape +1", waist="Olympus Sash", legs="Telchine Braconi", feet="Telchine Pigaches"
	}

	sets.midcast.Stoneskin = set_combine(sets.midcast.Duration,
	{
		neck="Stone Gorget", rear="Earthcry Earring",
		waist="Siegel Sash", legs="Shedir Seraweels"
	})

	sets.midcast.Refresh = set_combine(sets.midcast.Duration,
	{
		head="Amalric Coif +1",
		back="Grapevine Cape", waist="Gishdubar Sash", feet="Inspirited Boots"
	})

	sets.midcast.Regen = set_combine(sets.midcast.Duration,
	{
		main="Bolelabunga"
	})

	sets.midcast.Aquaveil = set_combine(sets.midcast.Duration,
	{
		main="Vadose Rod",
		head="Amalric Coif +1",
		waist="Emphatikos Rope", legs="Shedir Seraweels"
	})

	sets.midcast.Statless = sets.midcast.Duration

	sets.midcast.Teleport = sets.midcast.FC

	sets.midcast.Storm = sets.midcast.Duration

	sets.midcast.Klimaform = sets.midcast.FC

	sets.midcast.Protect = sets.midcast.Duration
	
	sets.midcast.Protectra = sets.midcast.Protect

	sets.midcast.Shell = sets.midcast.Protect

	sets.midcast.Shellra = sets.midcast.Shell

	sets.midcast.Macc =
	{
		main="Maxentius", sub="Ammurapi Shield", ammo="Pemphredo Tathlum",
		head="Amalric Coif +1", neck="Erra Pendant", lear="Digni. Earring", rear="Barkaro. Earring",
		body="Jhakri Robe +2", hands="Regal Cuffs", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
		back="Taranus's Cape", waist="Luminary Sash", legs="Merlinic Shalwar", feet="Jhakri Pigaches +2"
	}
	
	sets.midcast['Enfeebling Magic'] = set_combine(sets.midcast.Macc,
	{
		head="Befouled Crown", neck="Incanter's Torque",
		lring="Kishar Ring"
	})
	
	sets.midcast['Enfeebling Magic'].Resistant = sets.midcast.Macc

	sets.midcast.ElementalDebuffs = sets.midcast.Macc

	sets.midcast['Dark Magic'] = set_combine(sets.midcast.Macc,
	{
		body="Shango Robe",
		waist="Fucho-no-Obi", feet="Jhakri Pigaches +2"
	})

	sets.midcast.Sap = set_combine(sets.midcast['Dark Magic'],
	{
		head="Pixie Hairpin +1",
		lring="Archon Ring", rring="Evanescence Ring", 
		feet=gear.NukeCrackows
	})

	sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'],
	{
		neck="Orunmila's Torque",
		body="Shango Robe",
		back="Taranus's Cape", waist="Witful Belt", legs="Psycloth Lappas"
	})
	
	sets.midcast.Stun.Resistant = sets.midcast.Macc

	-- Elemental Magic sets

	sets.midcast['Elemental Magic'] =
	{
		main="Lathi", sub="Niobid Strap", ammo="Pemphredo Tathlum",
		head=gear.NukeHood, neck="Sanctity Necklace", lear="Regal Earring", rear="Barkaro. Earring",
		body="Amalric Doublet +1", hands="Amalric Gages +1", lring={name="Shiva Ring +1", bag="wardrobe2"}, rring={name="Shiva Ring +1", bag="wardrobe3"},
		back="Taranus's Cape", waist="Refoccilation Stone", legs="Amalric Slops +1", feet="Amalric Nails +1"
	}

	sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'],
	{
		main="Maxentius", sub="Ammurapi Shield", 
		body="Jhakri Robe +2", 
		waist="Eschan Stone", legs="Merlinic Shalwar", feet="Jhakri Pigaches +2"
	})
	
	sets.midcast['Elemental Magic'].Potency = sets.midcast['Elemental Magic']

	sets.midcast.Comet = set_combine(sets.midcast['Elemental Magic'],
	{
		head="Pixie Hairpin +1",
		lring="Archon Ring",
	})

	sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'],
	{
		head=empty,
		body="Twilight Cloak",
		lring="Archon Ring",
	})

	sets.midcast.Death =
	{
		main="Lathi", sub="Niobid Strap", ammo="Psilomene",
		head="Pixie Hairpin +1", neck="Sanctity Necklace", lear="Friomisi Earring", rear="Barkaro. Earring",
        	body="Amalric Doublet +1", hands="Amalric Gages +1", lring="Archon Ring", rring="Mephitas's Ring +1",
        	back="Taranus's Cape", waist="Refoccilation Stone", legs="Amalric Slops +1", feet="Amalric Nails +1"
	}

	sets.midcast.Death.Resistant = set_combine(sets.midcast.Death,
	{
		main=gear.Grioavolr_Enf, ammo="Pemphredo Tathlum",
		head=gear.NukeHood,
        	body="Merlinic Jubbah",
        	back="Taranus's Cape", waist="Eschan Stone", legs="Merlinic Shalwar"
	})

	-- Idle sets

	sets.idle =
	{
		main="Lathi", sub="Kaja Grip", ammo="Staunch Tathlum +1",
		head="Befouled Crown", neck="Sanctity Necklace", lear="Dawn Earring", rear="Infused Earring",
		body="Witching Robe", hands="Amalric Gages +1", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
        	back="Moonbeam Cape", waist="Lieutenant's Sash", legs="Assid. Pants +1", feet="Amalric Nails +1"
	}

	sets.idle.DT = set_combine(sets.idle,
	{
		neck="Loricate Torque +1", lear="Etiolation Earring", rear="Odnowa Earring +1",
        	lring="Defending Ring", rring="Vocane Ring"
	})

	sets.idle.DeathMode =
	{
		main="Lathi", sub="Kaja Grip", ammo="Psilomene",
		head="Vanya Hood", neck="Sanctity Necklace", lear="Etiolation Earring", rear="Loquac. Earring",
        	body="Amalric Doublet +1", hands="Regal Cuffs", lring="Lebeche Ring", rring="Mephitas's Ring +1",
        	back="Fi Follet Cape +1", waist="Fucho-no-Obi", legs="Assid. Pants +1", feet="Amalric Nails +1"
	}

	sets.idle.Town = set_combine(sets.idle, 
	{
		feet="Crier's Gaiters"
	})
	
	sets.idle.AdoulinCity = set_combine(sets.idle,
	{
		body="Councilor's Garb"
	})
	
	sets.idle.Weak = sets.idle.DT

	-- Defense sets

	sets.defense.PDT =
	{
        	main="Mafic Cudgel", sub="Genmei Shield", ammo="Staunch Tathlum +1",
		head="Vanya Hood", neck="Loricate Torque +1", lear="Etiolation Earring", rear="Odnowa Earring +1",
		body="Merlinic Jubbah", hands="Amalric Gages +1", lring="Defending Ring", rring="Vocane Ring",
		back="Moonbeam Cape", waist="Lieutenant's Sash", legs="Artsieq Hose", feet="Wicce Sabots +1"
	}

	sets.defense.MDT = 
	{
		main="Lathi", sub="Irenic Strap +1", ammo="Staunch Tathlum +1",
		head="Vanya Hood", neck="Loricate Torque +1", lear="Etiolation Earring", rear="Odnowa Earring +1",
		body="Witching Robe", hands="Amalric Gages +1", lring="Defending Ring", rring="Vocane Ring",
		back="Moonbeam Cape", waist="Lieutenant's Sash", legs="Amalric Slops +1", feet="Amalric Nails +1"
	}

	sets.Kiting =
	{
		feet="Crier's Gaiters"
	}

	-- Buff sets: Gear that needs to be worn to actively enhance a current player buff.

	sets.buff['Mana Wall'] =
	{
		back="Taranus's Cape",
		feet="Wicce Sabots +1"
	}
	
	sets.buff.Doom = 
	{
		neck="Nicander's Necklace",
		lring="Saida Ring",
		waist="Gishdubar Sash"
	}

	sets.magic_burst =
	{
		main="Lathi", sub="Niobid Strap", ammo="Pemphredo Tathlum",
		head=gear.NukeHood, neck="Mizu. Kubikazari", lear="Regal Earring", rear="Static Earring",
		body="Merlinic Jubbah", hands="Amalric Gages +1", lring="Locus Ring", rring="Mujin Band",
		back="Taranus's Cape", waist="Refoccilation Stone", legs="Amalric Slops +1", feet="Jhakri Pigaches +2"
	}

	sets.magic_burst.Resistant = set_combine(sets.magic_burst,
	{
		main="Maxentius", sub="Ammurapi Shield",
		hands="Regal Cuffs", 
		waist="Eschan Stone", legs="Merlinic Shalwar"
	})

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------



-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_post_midcast(spell, action, spellMap, eventArgs)
    	if spell.action_type == 'Magic' then
		apply_abilities(spell, action, spellMap, eventArgs)
	end
	
	if spellMap == 'Cures' and spell.target.type == 'SELF' then
        equip(
		{
			rring="Vocane Ring",
			waist="Gishdubar Sash"
		})
	end
	
	if spellMap == 'Refresh' and spell.target.type == 'Self' then
		equip(
		{
			waist="Gishdubar Sash"
		})
	end

	if spell.skill == 'Elemental Magic' and state.MagicBurst.value and (state.CastingMode.value == 'Normal' or state.CastingMode.value == 'Potency') then
		if spell.element ~= 'Dark' then
			equip(sets.magic_burst)
		elseif spell.english == 'Comet' or spell.english == 'Noctohelix' then
			equip(set_combine(sets.magic_burst,
			{
				head="Pixie Hairpin +1",
				lring="Archon Ring"
			}))
		elseif spell.english =='Impact' then
			equip(set_combine(sets.magic_burst,
			{
				head=empty,
				body="Twilight Cloak", lring="Archon Ring"
			}))
		elseif spell.english =='Death' then
			equip(set_combine(sets.midcast.Death,
			{
				neck="Mizu. Kubikazari", lear="Static Earring",
				body="Merlinic Jubbah", rring="Mujin Band",
				feet=gear.NukeCrackows
			}))
		end
	elseif spell.skill == 'Elemental Magic' and state.MagicBurst.value and state.CastingMode.value == 'Resistant' then
		if spell.element ~= 'Dark' then
			equip(sets.magic_burst.Resistant)
		elseif spell.english == 'Comet' or spell.english == 'Noctohelix' then
			equip(set_combine(sets.magic_burst.Resistant,
			{
				lring="Archon Ring"
			}))
		elseif spell.english =='Impact' then
			equip(set_combine(sets.magic_burst.Resistant,
			{
				head=empty,
				body="Twilight Cloak", lring="Archon Ring"
			}))
		elseif spell.english =='Death' then
			equip(set_combine(sets.midcast.Death.Resistant,
			{
				neck="Mizu. Kubikazari", lear="Static Earring",
				body="Merlinic Jubbah", rring="Mujin Band",
				feet=gear.NukeCrackows
			}))
		end
	end
	
	if spell.skill == 'Elemental Magic' and state.Spaekona.value and spell.english ~= 'Death' then
		equip{body="Spae. Coat +1"}
	end

	if spell.skill == 'Elemental Magic' and (spell.element ~= world.day_element and spell.element ~= world.weather_element) then
		if spell.target.distance < (15 - spell.target.model_size) then
			equip{waist="Orpheus's Sash"}
		end
	elseif spell.skill == 'Elemental Magic' and (spell.element == world.day_element and spell.element == world.weather_element)
			or (spell.element == world.weather_element and get_weather_intensity() == 2) then
		if spellMap ~= 'Helix' then
			equip{waist="Hachirin-no-Obi"}
		elseif spell.target.distance < (15 - spell.target.model_size) then
			equip{waist="Orpheus's Sash"}
		end
	elseif spell.skill == 'Elemental Magic' and (spell.element == world.day_element or (spell.element == world.weather_element and get_weather_intensity() == 1)) then
		if spell.target.distance < (7 - spell.target.model_size) then
			equip{waist="Orpheus's Sash"}
		elseif spellMap ~= 'Helix' then
			equip{waist="Hachirin-no-Obi"}
		end
	end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------


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

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
	if state.Buff['Mana Wall'] then
		if state.IdleMode.value == 'Normal' then
			idleSet = set_combine(sets.idle, sets.buff['Mana Wall'])
		elseif state.IdleMode.value == 'PDT' then
			idleSet = set_combine(sets.idle.PDT, sets.buff['Mana Wall'])
		elseif state.IdleMode.value == 'MDT' then
			idleSet = set_combine(sets.idle.MDT, sets.buff['Mana Wall'])
		end
	end
	
	if player.mpp < 51 then
        	idleSet = set_combine(idleSet,
		{
			body="Jhakri Robe +2",
			waist="Fucho-no-Obi",
		})
    	end

	return idleSet
end

function job_update(cmdParams, eventArgs)
	update_wall()

	if gain then
		equip(sets.buff.Doom)
		disable('neck','lring','waist')
        else
		enable('neck','lring','waist')
		handle_equipping_gear(player.status)
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
function update_wall()
	state.Buff['Mana Wall'] = buffactive['Mana Wall'] or false
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(1, 3)
end
