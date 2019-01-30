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
	state.OffenseMode:options('None', 'Normal')
	state.CastingMode:options('Normal', 'Spaekona', 'Resistant')
	state.IdleMode:options('Normal', 'Movement', 'DT', 'DeathMode')
	state.MagicBurst = M(false, 'Magic Burst')

	lowTierNukes = S{'Stone', 'Water', 'Aero', 'Fire', 'Blizzard', 'Thunder'}

	-- Additional local binds
	send_command('bind ^` input /ma Stun <t>')
	send_command('bind !` gs c toggle MagicBurst')

	select_default_macro_book()
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
	send_command('unbind ^`')
	send_command('unbind !`')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------

	---- Precast Sets ----
	sets.precast.FC =
	{
		ammo="Sapience Orb",
		head="Vanya Hood", neck="Orunmila's Torque", lear="Etiolation Earring", rear="Loquac. Earring",
        body="Shango Robe", hands="Telchine Gloves", lring="Kishar Ring", rring="Prolix Ring",
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

	sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC,
	{
		waist="Channeler's Stone"
	})

	sets.precast.FC.Cures = set_combine(sets.precast.FC,
	{
		rear="Mendi. Earring",
		waist="Channeler's Stone"
	})

	sets.precast.FC.Curaga = sets.precast.FC.Cures

	sets.precast.FC.Impact = set_combine(sets.precast.FC,
	{
		head=empty,
		body="Twilight Cloak",
		waist="Channeler's Stone"
	})

	sets.precast.FC.Death =
	{
		main=gear.Grioavolr_Enf, sub="Enki Strap", ammo="Sapience Orb",
		head="Vanya Hood", neck="Orunmila's Torque", lear="Etiolation Earring", rear="Loquac. Earring",
        body="Shango Robe", hands="Telchine Gloves", lring="Prolix Ring", rring="Mephitas's Ring +1",
        back="Swith Cape +1", waist="Channeler's Stone", legs="Psycloth Lappas", feet="Amalric Nails +1"
	}


	-- Weaponskill sets
	sets.precast.WS =
	{
		ammo="Floestone",
		neck="Fotia Gorget", lear="Telos Earring", rear="Moonshade Earring",
		body="Jhakri Robe +2", hands="Jhakri Cuffs +2",
		waist="Fotia Belt", feet="Jhakri Pigaches +2"
	}

	sets.precast.WS['Myrkr'] =
	{
		ammo="Psilomene",
		head="Pixie Hairpin +1", neck="Sanctity Necklace", lear="Etiolation Earring", rear="Moonshade Earring",
		body="Amalric Doublet +1", hands="Telchine Gloves", lring="Lebeche Ring", rring="Mephitas's Ring +1",
		back="Fi Follet Cape +1", waist="Luminary Sash", legs="Amalric Slops +1", feet="Amalric Nails +1"
	}


	---- Midcast Sets ----

	sets.midcast.FC = sets.precast.FC

	sets.midcast.Cures =
	{
		head="Vanya Hood", neck="Incanter's Torque", lear="Gwati Earring", rear="Mendi. Earring",
        body="Merlinic Jubbah", hands="Telchine Gloves", lring="Lebeche Ring", rring="Vocane Ring",
        back="Solemnity Cape", waist="Gishdubar Sash", legs="Gyve Trousers", feet="Vanya Clogs"
	}

	sets.midcast.Curaga = sets.midcast.Cures

	sets.midcast.Cursna = set_combine(sets.precast.FC,
	{
		neck="Debilis Medallion",
        hands="Hieros Mittens", lring="Haoma's Ring", rring="Menelaus's Ring",
        back="Oretan. Cape +1", feet="Vanya Clogs"
	})

	sets.midcast.StatusRemoval = sets.midcast.FC

	sets.midcast['Enhancing Magic'] =
	{
		main="Gada", sub="Ammurapi Shield", ammo="Pemphredo Tathlum",
		head="Befouled Crown", neck="Incanter's Torque", lear="Andoaa Earring", rear="Augment. Earring",
		body="Telchine Chas.", hands="Telchine Gloves", lring="Stikini Ring", rring="Stikini Ring",
		back="Fi Follet Cape +1", waist="Olympus Sash", legs="Telchine Braconi", feet="Telchine Pigaches"
	}

	sets.midcast.Stoneskin =
	{
		main="Gada", sub="Ammurapi Shield",
		head="Telchine Cap", neck="Stone Gorget", lear="Andoaa Earring", rear="Earthcry Earring",
		body="Telchine Chas.", hands="Telchine Gloves", lring="Stikini Ring", rring="Stikini Ring",
		back="Fi Follet Cape +1", waist="Witful Belt", legs="Shedir Seraweels", feet="Telchine Pigaches"
	}

	sets.midcast.Duration =
	{
		main="Gada", sub="Ammurapi Shield",
		head="Telchine Cap", neck="Orunmila's Torque", lear="Etiolation Earring", rear="Loquac. Earring",
		body="Telchine Chas.", hands="Telchine Gloves", lring="Stikini Ring", rring="Stikini Ring",
		back="Fi Follet Cape +1", waist="Witful Belt", legs="Telchine Braconi", feet="Telchine Pigaches"
	}

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

	sets.midcast.Protect = set_combine(sets.midcast.Duration,
	{
		lring="Sheltered Ring",
	})

	sets.midcast.Protectra = sets.midcast.Protect

	sets.midcast.Shell = sets.midcast.Protect

	sets.midcast.Shellra = sets.midcast.Shell

	sets.midcast.Macc =
	{
		main="Gada", sub="Ammurapi Shield", ammo="Pemphredo Tathlum",
		head="Amalric Coif +1", neck="Incanter's Torque", lear="Digni. Earring", rear="Barkaro. Earring",
		body="Jhakri Robe +2", hands="Jhakri Cuffs +2", lring="Stikini Ring", rring="Stikini Ring",
		back="Taranus's Cape", waist="Luminary Sash", legs="Merlinic Shalwar", feet="Jhakri Pigaches +2"
	}

	sets.midcast.MndEnfeebles = set_combine(sets.midcast.Macc,
	{
		head="Befouled Crown",
		body="Vanya Robe", hands="Jhakri Cuffs +2", lring="Kishar Ring",
		feet="Medium's Sabots"
	})

	sets.midcast.IntEnfeebles = set_combine(sets.midcast.Macc,
	{
		head="Befouled Crown",
		body="Vanya Robe", hands="Jhakri Cuffs +2", lring="Kishar Ring",
		feet="Medium's Sabots"
	})

	sets.midcast.ElementalDebuffs = sets.midcast.Macc

	sets.midcast['Dark Magic'] = set_combine(sets.midcast.Macc,
	{
		head="Pixie Hairpin +1",
		body="Shango Robe", lring="Stikini Ring", rring="Stikini Ring",
		waist="Fucho-no-Obi", feet="Jhakri Pigaches +2"
	})

	sets.midcast.Sap = set_combine(sets.midcast['Dark Magic'],
	{
		lring="Evanescence Ring", rring="Archon Ring",
		feet=gear.NukeCrackows
	})

	sets.midcast.Stun =
	{
		main=gear.Grioavolr_Enf, sub="Enki Strap", ammo="Pemphredo Tathlum",
		head="Amalric Coif +1", neck="Orunmila's Torque", lear="Digni. Earring", rear="Barkaro. Earring",
		body="Shango Robe", hands="Jhakri Cuffs +2", lring="Kishar Ring", rring="Stikini Ring",
		back="Taranus's Cape", waist="Witful Belt", legs="Psycloth Lappas", feet="Jhakri Pigaches +2"
	}

	-- Elemental Magic sets

	sets.midcast['Elemental Magic'] =
	{
		main=gear.Grioavolr_Enf, sub="Niobid Strap", ammo="Pemphredo Tathlum",
		head=gear.NukeHood, neck="Sanctity Necklace", lear="Friomisi Earring", rear="Regal Earring",
		body="Amalric Doublet +1", hands="Amalric Gages +1", lring="Acumen Ring", rring="Shiva Ring",
		back="Taranus's Cape", waist="Refoccilation Stone", legs="Amalric Slops +1", feet="Amalric Nails +1"
	}

	sets.midcast['Elemental Magic'].Resistant =
	{
		main=gear.Grioavolr_Enf, sub="Niobid Strap", ammo="Pemphredo Tathlum",
		head=gear.NukeHood, neck="Sanctity Necklace", lear="Regal Earring", rear="Barkaro. Earring",
		body="Jhakri Robe +2", hands="Amalric Gages +1", lring="Acumen Ring", rring="Shiva Ring",
		back="Taranus's Cape", waist="Eschan Stone", legs="Merlinic Shalwar", feet="Jhakri Pigaches +2"
	}


	sets.midcast['Elemental Magic'].Spaekona = set_combine(sets.midcast['Elemental Magic'],
	{
		body="Spae. Coat +1"
	})

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

	sets.midcast.Death.Resistant =
	{
		main=gear.Grioavolr_Enf, sub="Niobid Strap", ammo="Pemphredo Tathlum",
		head=gear.NukeHood, neck="Sanctity Necklace", lear="Friomisi Earring", rear="Barkaro. Earring",
        body="Merlinic Jubbah", hands="Amalric Gages +1", lring="Archon Ring", rring="Mephitas's Ring +1",
        back="Taranus's Cape", waist="Eschan Stone", legs="Merlinic Shalwar", feet="Amalric Nails +1"
	}

	-- Idle sets

	sets.idle =
	{
		main="Lathi", sub="Irenic Strap +1", ammo="Staunch Tathlum",
		head="Befouled Crown", neck="Sanctity Necklace", lear="Dawn Earring", rear="Infused Earring",
		body="Witching Robe", hands="Amalric Gages +1", lring="Sheltered Ring", rring="Paguroidea Ring",
        back="Solemnity Cape", waist="Fucho-no-Obi", legs="Assid. Pants +1", feet="Amalric Nails +1"
	}

	sets.idle.Movement = set_combine(sets.idle,
    {
        feet="Crier's Gaiters"
    })

	sets.idle.DT = set_combine(sets.idle,
	{
		neck="Loricate Torque +1", lear="Etiolation Earring",
        lring="Defending Ring", rring="Vocane Ring"
	})


	sets.idle.Town = set_combine(sets.idle, 
	{
		feet="Crier's Gaiters"
	})
	
	sets.idle.AdoulinCity = set_combine(sets.idle,
	{
		body="Councilor's Garb"
	})

	sets.idle.DeathMode =
	{
		main=gear.Grioavolr_Enf, sub="Irenic Strap +1", ammo="Psilomene",
		head="Vanya Hood", neck="Sanctity Necklace", lear="Etiolation Earring", rear="Loquac. Earring",
        body="Amalric Doublet +1", hands="Telchine Gloves", lring="Lebeche Ring", rring="Mephitas's Ring +1",
        back="Fi Follet Cape +1", waist="Fucho-no-Obi", legs="Assid. Pants +1", feet="Amalric Nails +1"
	}

	sets.idle.Weak = sets.idle.PDT

	-- Defense sets

	sets.defense.PDT =
	{
        main="Mafic Cudgel", sub="Genmei Shield", ammo="Staunch Tathlum",
		head="Vanya Hood", neck="Loricate Torque +1", lear="Etiolation Earring", rear="Odnowa Earring +1",
		body="Merlinic Jubbah", hands="Amalric Gages +1", lring="Defending Ring", rring="Vocane Ring",
		back="Solemnity Cape", waist="Channeler's Stone", legs="Artsieq Hose", feet="Wicce Sabots +1"
	}

	sets.defense.MDT = set_combine(sets.idle.MDT,
	{
		main="Lathi", sub="Irenic Strap +1", ammo="Staunch Tathlum",
		head="Vanya Hood", neck="Loricate Torque +1", lear="Etiolation Earring", rear="Odnowa Earring +1",
		body="Witching Robe", hands="Amalric Gages +1", lring="Defending Ring", rring="Vocane Ring",
		back="Solemnity Cape", waist="Channeler's Stone", legs="Amalric Slops +1", feet="Amalric Nails +1"
	})

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


	sets.magic_burst =
	{
		main="Lathi", sub="Niobid Strap", ammo="Pemphredo Tathlum",
		head=gear.NukeHood, neck="Mizu. Kubikazari", lear="Friomisi Earring", rear="Regal Earring",
		body="Merlinic Jubbah", hands="Amalric Gages +1", lring="Locus Ring", rring="Mujin Band",
		back="Taranus's Cape", waist="Refoccilation Stone", legs="Amalric Slops +1", feet=gear.NukeCrackows
	}

	sets.magic_burst.Spaekona =
	{
		main="Lathi", sub="Niobid Strap", ammo="Pemphredo Tathlum",
		head=gear.NukeHood, neck="Mizu. Kubikazari", lear="Static Earring", rear="Regal Earring",
		body="Spae. Coat +1", hands="Amalric Gages +1", lring="Locus Ring", rring="Mujin Band",
		back="Taranus's Cape", waist="Refoccilation Stone", legs="Merlinic Shalwar", feet=gear.NukeCrackows
	}

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



-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)

end

function job_post_midcast(spell, action, spellMap, eventArgs)
	if spell.skill == 'Elemental Magic' and state.MagicBurst.value then
		if spell.english ~= 'Impact' and (spell.element == world.day_element or spell.element == world.weather_element) then
			if state.CastingMode.value == 'Spaekona' then
				equip(set_combine(sets.magic_burst.Spaekona,
				{
					waist="Hachirin-no-Obi"
				}))
			else
				equip(set_combine(sets.magic_burst,
				{
					waist="Hachirin-no-Obi"
				}))
			end
		elseif spell.english == 'Comet' then
			if (world.weather_element == 'Dark' or world.day_element == 'Dark') then
				equip(set_combine(sets.magic_burst,
				{
					head="Pixie Hairpin +1",
					lring="Archon Ring",
					waist="Hachirin-no-Obi"
				}))
			else
				equip(set_combine(sets.magic_burst,
				{
					head="Pixie Hairpin +1",
					lring="Archon Ring"
				}))

			end
		elseif spell.english == 'Impact' then
			if (world.weather_element == 'Dark' or world.day_element == 'Dark') then
				equip(set_combine(sets.magic_burst,
				{
					head=empty,
					body="Twilight Cloak", lring="Archon Ring",
					waist="Hachirin-no-Obi"
				}))
			else
				equip(set_combine(sets.magic_burst,
				{
					head=empty,
					body="Twilight Cloak", lring="Archon Ring"
				}))
			end
		else
			if state.CastingMode.value == "Spaekona" then
				equip(sets.magic_burst.Spaekona)
			else
				equip(sets.magic_burst)
			end
		end

	elseif spell.english == 'Death' and state.MagicBurst.value then
		if (world.weather_element == 'Dark' or world.day_element == 'Dark') then
			equip(set_combine(sets.midcast.Death,
			{
				neck="Mizu. Kubikazari", lear="Static Earring",
				waist="Hachirin-no-Obi", feet=gear.NukeCrackows
			}))
		else
			equip(set_combine(sets.midcast.Death,
			{
				neck="Mizu. Kubikazari", lear="Static Earring",
				feet=gear.NukeCrackows
			}))
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

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
	if spell.action_type == 'Magic' then
		if spell.skill == "Enfeebling Magic" then
			if spell.type == "WhiteMagic" then
				return "MndEnfeebles"
			else
				return "IntEnfeebles"
			end
		end
	end
end

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

	return idleSet
end

function job_update(cmdParams, eventArgs)
	update_wall()
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
