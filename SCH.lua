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
	info.addendumNukes = S{"Stone IV", "Water IV", "Aero IV", "Fire IV", "Blizzard IV", "Thunder IV",
		"Stone V", "Water V", "Aero V", "Fire V", "Blizzard V", "Thunder V"}

	state.Buff['Sublimation: Activated'] = buffactive['Sublimation: Activated'] or false
	update_active_strategems()
	
	lockstyleset = 4
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	state.OffenseMode:options('None', 'Normal', 'Refresh')
	state.CastingMode:options('Normal', 'Resistant')
	state.IdleMode:options('Normal', 'Movement', 'DT')

	state.MagicBurst = M(false, 'Magic Burst')

	-- Additional local binds
	send_command('bind !` gs c toggle MagicBurst')

	select_default_macro_book()
	
	set_lockstyle()

end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
	send_command('unbind !`')
end



-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------

	---- Precast Sets ----

	-- Precast sets to enhance JAs

   sets.precast.JA['Tabula Rasa'] =
    {
		ammo="Psilomene",
		head="Amalric Coif +1", neck="Sanctity Necklace", lear="Etiolation Earring", rear="Mendi. Earring",
		body="Acad. Gown +2", hands="Kaykaus Cuffs +1", lring="Lebeche Ring", rring="Mephitas's Ring +1",
		back="Fi Follet Cape +1", waist="Luminary Sash", legs="Amalric Slops +1", feet="Amalric Nails +1"
	}

	sets.precast.JA['Enlightenment'] =
	{
		body="Peda. Gown +3"
	}

	-- Fast cast sets for spells
	sets.precast.FC =
	{
		main="Vadose Rod", sub="Chanter's Shield", ammo="Sapience Orb",
		head="Amalric Coif +1", neck="Orunmila's Torque", lear="Etiolation Earring", rear="Loquac. Earring",
        body="Pinga Tunic", hands="Acad. Bracers +2", lring="Kishar Ring", rring="Rahab Ring",
        back=gear.SCHCape_ENF, waist="Witful Belt", legs="Pinga Pants", feet="Peda. Loafers +3"
	}

	sets.precast.FC.Grimoire =
	{
		head="Peda. M.Board +3",
		feet="Acad. Loafers +2"
	}

	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC,
	{
		waist="Siegel Sash"
	})

	sets.precast.Statless = sets.precast.FC['Enhancing Magic']

	sets.precast.FC['Enfeebling Magic'] = set_combine(sets.precast.FC,
	{
		waist="Channeler's Stone"
	})

	sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC,
	{
		waist="Channeler's Stone"
	})

	sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'],
	{
		hands="Carapacho Cuffs"
	})

	sets.precast.FC.Klimaform = sets.precast.FC

	sets.precast.FC.Teleport = sets.precast.FC

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

	sets.precast.FC.Reraise = sets.precast.FC

	sets.precast.FC.Raise = sets.precast.FC

	---- Precast Sets ----

	sets.midcast.FC = set_combine(sets.precast.FC,
	{
		head="Amalric Coif +1",
		legs="Lengo Pants", feet="Amalric Nails +1"
	})

	sets.midcast.ConserveMP = set_combine(sets.precast.FC,
	{
		ammo="Pemphredo Tathlum",
		head="Vanya Hood", neck="Incanter's Torque", lear="Gwati Earring", rear="Mendi. Earring",
		body="Kaykaus Bliaut",
		back="Fi Follet Cape +1", waist="Luminary Sash", legs="Lengo Pants", feet=gear.NukeCrackows
	})

	-- Cure Potency/II: 51%/3%		Enmity: -55		Healing Magic Skill: +55
	sets.midcast.Cures =
	{
		main="Gada", sub="Chanter's Shield", ammo="Esper Stone +1",
		head="Kaykaus Mitra", neck="Lasaia Pendant", lear="Novia Earring", rear="Mendi. Earring",
        body="Kaykaus Bliaut", hands="Peda. Bracers +3", lring="Lebeche Ring", rring={name="Stikini Ring +1", bag="wardrobe3"},
        back="Oretan. Cape +1", waist="Channeler's Stone", legs="Pinga Pants", feet="Vanya Clogs"
	}
	
	sets.midcast.CuresLocked =
	{
		ammo="Esper Stone +1",
		head="Kaykaus Mitra", neck="Lasaia Pendant", lear="Novia Earring", rear="Mendi. Earring",
        body="Kaykaus Bliaut", hands="Peda. Bracers +3", lring="Lebeche Ring", rring="Menelaus's Ring",
        back="Oretan. Cape +1", waist="Channeler's Stone", legs="Pinga Pants", feet="Kaykaus Boots"
	}

	sets.midcast.Curagas = sets.midcast.Cures

	-- Cure Potency/II: 54%/3%		Enmity: -56		Healing Magic Skill: +55
	sets.midcast.CuresWeather = set_combine(sets.midcast.Cures,
	{
		main="Chatoyant Staff", sub="Achaq Grip",
		neck="Incanter's Torque",
		rring="Menelaus's Ring",
		back="Twilight Cape", waist="Hachirin-no-Obi", legs="Acad. Pants +2", feet="Kaykaus Boots"
	})

	sets.midcast.CuragaWeather = sets.midcast.CuresWeather

	sets.midcast.Regen =
	{
		main="Bolelabunga", sub="Ammurapi Shield", ammo="Pemphredo Tathlum",
		head="Arbatel Bonnet +1", neck="Orunmila's Torque", lear="Gwati Earring", rear="Mendi. Earring",
        body="Telchine Chas.", hands="Telchine Gloves", lring="Lebeche Ring", rring="Rahab Ring",
        back=gear.SCHCape_ENF, waist="Luminary Sash", legs="Telchine Braconi", feet="Telchine Pigaches"
	}

	sets.midcast.Refresh =
	{
		main="Gada", sub="Ammurapi Shield", ammo="Pemphredo Tathlum",
		head="Amalric Coif +1", neck="Orunmila's Torque", lear="Gwati Earring", rear="Mendi. Earring",
        body="Peda. Gown +3", hands="Telchine Gloves", lring="Lebeche Ring", rring="Rahab Ring",
        back="Grapevine Cape", waist="Luminary Sash", legs="Telchine Braconi", feet="Telchine Pigaches"
	}

	sets.midcast.StatusRemoval = sets.midcast.FC

	sets.midcast.Cursna = set_combine(sets.precast.FC,
	{
		main="Gada", sub="Chanter's Shield", 
		head="Kaykaus Mitra", neck="Debilis Medallion", lear="Beatific Earring",
        body="Peda. Gown +3", hands="Hieros Mittens", lring="Haoma's Ring", rring="Menelaus's Ring",
        back="Oretan. Cape +1", legs="Acad. Pants +2", feet="Vanya Clogs"
	})

	sets.midcast.Duration =
	{
		main="Gada", sub="Ammurapi Shield",
		head="Telchine Cap", neck="Orunmila's Torque", lear="Etiolation Earring", rear="Loquac. Earring",
		body="Peda. Gown +3", hands="Telchine Gloves", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
		back=gear.SCHCape_ENF, waist="Witful Belt", legs="Telchine Braconi", feet="Telchine Pigaches"
	}
	
	sets.midcast['Enhancing Magic'] =
	{
		main="Gada", sub="Ammurapi Shield", ammo="Savant's Treatise",
		head="Befouled Crown", neck="Incanter's Torque", lear="Andoaa Earring", rear="Augment. Earring",
		body="Peda. Gown +3", hands="Telchine Gloves", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
		back="Fi Follet Cape +1", waist="Olympus Sash", legs="Telchine Braconi", feet="Telchine Pigaches"
	}

	sets.midcast.BarElement = set_combine(sets.midcast['Enhancing Magic'],
	{
		head="Telchine Cap",
		legs="Shedir Seraweels"
	})

	sets.midcast.BarStatus = sets.midcast.Duration

	sets.midcast.Stoneskin =
	{
		ammo="Staunch Tathlum +1",
		head="Telchine Cap", neck="Stone Gorget", lear="Andoaa Earring", rear="Earthcry Earring",
		body="Peda. Gown +3", hands="Telchine Gloves", lring="Evanescence Ring", rring="Rahab Ring",
		back=gear.SCHCape_ENF, waist="Witful Belt", legs="Shedir Seraweels", feet="Telchine Pigaches"
	}

	sets.midcast.Aquaveil = set_combine(sets.midcast.Duration,
	{
		main="Vadose Rod", ammo="Staunch Tathlum +1",
		head="Amalric Coif +1", 
		waist="Emphatikos Rope", legs="Shedir Seraweels"
	})

	sets.midcast.Statless = sets.midcast.Duration

	sets.midcast.Storm = set_combine(sets.midcast.Duration,
	{
		feet="Peda. Loafers +3",
	})

	sets.midcast.Protect = sets.midcast.Duration

	sets.midcast.Klimaform = sets.midcast.FC

	sets.midcast.Protectra = sets.midcast.Protect

	sets.midcast.Shell = sets.midcast.Protect

	sets.midcast.Shellra = sets.midcast.Shell

	-- Custom spell classes
	sets.midcast.Macc =
	{
		main="Maxentius", sub="Ammurapi Shield", ammo="Pemphredo Tathlum",
		head="Acad. Mortar. +2", neck="Erra Pendant", lear="Regal Earring", rear="Digni. Earring",
		body="Acad. Gown +2", hands="Kaykaus Cuffs +1", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
		back=gear.SCHCape_ENF, waist="Luminary Sash", legs="Chironic Hose", feet="Acad. Loafers +2"
	}

	sets.midcast['Enfeebling Magic'] = set_combine(sets.midcast.Macc,
	{
		neck="Incanter's Torque",
		lring="Kishar Ring",
		feet="Medium's Sabots"
	})

	sets.midcast['Enfeebling Magic'].Resistant = sets.midcast.Macc

	sets.midcast['Enfeebling Magic'].Potency = set_combine(sets.midcast['Enfeebling Magic'],
	{
		rear="Barkaro. Earring"
	})

	sets.midcast.ElementalDebuffs = sets.midcast.Macc

	sets.midcast['Dark Magic'] = set_combine(sets.midcast.Macc,
	{
		neck="Erra Pendant",
		legs="Peda. Pants +3"
	})

	sets.midcast.Kaustra =
	{
		main=gear.Grioavolr_Enf, sub="Niobid Strap", ammo="Pemphredo Tathlum",
		head="Pixie Hairpin +1", neck="Sanctity Necklace", lear="Regal Earring", rear="Barkaro. Earring",
		body="Amalric Doublet +1", hands="Amalric Gages +1", lring="Archon Ring", rring={name="Shiva Ring +1", bag="wardrobe3"},
		back=gear.SCHCape_Nuke, waist="Refoccilation Stone", legs="Amalric Slops +1", feet="Amalric Nails +1"
	}

	sets.midcast.Sap = set_combine(sets.midcast['Dark Magic'],
	{
		head="Pixie Hairpin +1",
		body="Chironic Doublet", lring="Archon Ring", rring="Evanescence Ring",
		waist="Fucho-no-Obi", feet=gear.NukeCrackows
	})

	sets.midcast.Stun =
	{
		main="Maxentius", sub="Chanter's Shield", ammo="Pemphredo Tathlum",
		head="Amalric Coif +1", neck="Orunmila's Torque", lear="Digni. Earring", rear="Barkaro. Earring",
		body="Shango Robe", hands="Kaykaus Cuffs +1", lring="Kishar Ring", rring={name="Stikini Ring +1", bag="wardrobe3"},
		back=gear.SCHCape_ENF, waist="Witful Belt", legs="Peda. Pants +3", feet="Peda. Loafers +3"
	}
	
	sets.midcast.Stun.Resistant = set_combine(sets.midcast.Stun,
	{
		sub="Ammurapi Shield",
		head="Acad. Mortar. +2", neck="Erra Pendant", lear="Regal Earring", rear="Digni. Earring",
		body="Acad. Gown +2", lring={name="Stikini Ring +1", bag="wardrobe2"},
		waist="Luminary Sash", feet="Acad. Loafers +2"
	})

	-- Elemental Magic
	sets.midcast['Elemental Magic'] =
	{
		main="Maxentius", sub="Ammurapi Shield", ammo="Pemphredo Tathlum",
		head="Peda. M.Board +3", neck="Sanctity Necklace", lear="Regal Earring", rear="Barkaro. Earring",
		body="Amalric Doublet +1", hands="Amalric Gages +1", lring={name="Shiva Ring +1", bag="wardrobe2"}, rring={name="Shiva Ring +1", bag="wardrobe3"},
		back=gear.SCHCape_Nuke, waist="Refoccilation Stone", legs="Amalric Slops +1", feet="Amalric Nails +1"
	}

	sets.midcast['Elemental Magic'].Resistant =
	{
		main="Maxentius", sub="Ammurapi Shield", ammo="Pemphredo Tathlum",
		head="Acad. Mortar. +2", neck="Sanctity Necklace", lear="Regal Earring", rear="Barkaro. Earring",
		body="Amalric Doublet +1", hands="Jhakri Cuffs +2", lring={name="Shiva Ring +1", bag="wardrobe2"}, rring={name="Shiva Ring +1", bag="wardrobe3"},
		back=gear.SCHCape_Nuke, waist="Eschan Stone", legs="Merlinic Shalwar", feet="Jhakri Pigaches +2"
	}

	sets.midcast.Impact = set_combine(sets.midcast.Kaustra,
	{
		main="Maxentius", sub="Ammurapi Shield",
		head=empty, lear="Digni. Earring",
		body="Twilight Cloak", rring={name="Stikini Ring +1", bag="wardrobe3"},
		waist="Eschan Stone", legs="Merlinic Shalwar", feet="Jhakri Pigaches +2"
	})

	sets.midcast.Helix = set_combine(sets.midcast['Elemental Magic'],
	{
		main="Akademos", sub="Niobid Strap"
	})

	sets.midcast.DarkHelix = set_combine(sets.midcast.Helix,
	{
		head="Pixie Hairpin +1",
		ring1="Archon Ring",
	})

	sets.midcast.Utsusemi = sets.midcast.FC

	------------------------------------------------------------------------------------------------
	------------------------------------------ Idle Sets -------------------------------------------
	------------------------------------------------------------------------------------------------

	sets.idle =
	{
		main="Akademos", sub="Kaja Grip", ammo="Homiliary",
		head="Befouled Crown", neck="Sanctity Necklace", lear="Dawn Earring", rear="Infused Earring",
		body="Jhakri Robe +2", hands="Chironic Gloves", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
        back=gear.SCHCape_Nuke, waist="Lieutenant's Sash", legs="Assid. Pants +1", feet="Chironic Slippers"
	}

	sets.idle.Movement = set_combine(sets.idle,
    {
        feet="Crier's Gaiters"
    })

	sets.idle.DT = set_combine(sets.idle,
	{
		ammo="Staunch Tathlum +1",
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
	------------------------------------------------------------------------------------------------
	---------------------------------------- Defense Sets ------------------------------------------
	------------------------------------------------------------------------------------------------

	sets.defense.PDT =
	{
        main="Akademos", sub="Kaja Grip", ammo="Staunch Tathlum +1",
		head="Befouled Crown", neck="Loricate Torque +1", lear="Etiolation Earring", rear="Odnowa Earring +1",
		body="Mallquis Saio +2", hands="Chironic Gloves", lring="Defending Ring", rring="Vocane Ring",
		back=gear.SCHCape_Nuke, waist="Lieutenant's Sash", legs="Assid. Pants +1", feet="Chironic Slippers"
	}

	sets.defense.MDT =
	{
		main="Akademos", sub="Irenic Strap +1", ammo="Staunch Tathlum +1",
		head="Chironic Hat", neck="Loricate Torque +1", lear="Eabani Earring", rear="Static Earring",
        body="Peda. Gown +3", hands="Peda. Bracers +3", lring="Defending Ring", rring="Vocane Ring",
		back=gear.SCHCape_Nuke, waist="Lieutenant's Sash", legs="Peda. Pants +3", feet="Amalric Nails +1"
	}

	sets.Kiting =
	{
		feet="Crier's Gaiters"
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
			ammo="Floestone",
			head="Jhakri Coronal +2", neck="Fotia Gorget", lear="Telos Earring", rear="Moonshade Earring",
			body="Jhakri Robe +2", hands="Jhakri Cuffs +2", lring="Chirich Ring +1", rring="Chirich Ring +1",
			waist="Fotia Belt", legs="Jhakri Slops +2", feet="Jhakri Pigaches +2"
		}

		sets.precast.WS['Shattersoul'] = set_combine(sets.precast.WS,
		{
			lear="Regal Earring",
			lring={name="Shiva Ring +1", bag="wardrobe2"}, rring={name="Shiva Ring +1", bag="wardrobe3"},
			back=gear.SCHCape_Nuke
		})
		
		sets.precast.WS['Omniscience'] = set_combine(sets.midcast.DarkHelix,
		{
			rear="Ishvara Earring",
			body="Peda. Gown +3", hands="Peda. Bracers +3",
			back=gear.SCHCape_ENF, waist="Orpheus's Sash"
		})
		
		sets.precast.WS['Myrkr'] = set_combine(sets.precast.JA['Tabula Rasa'],
		{
			rear="Moonshade Earring",
		})
		
	--------------------------------------
	-- Melee sets
	--------------------------------------

		sets.engaged = 
		{
			ammo="Floestone",
			head="Peda. M.Board +3", neck="Combatant's Torque", lear="Telos Earring", rear="Mache Earring +1",
			body="Jhakri Robe +2", hands="Peda. Bracers +3", lring="Chirich Ring +1", rring="Chirich Ring +1",
			back=gear.SCHCape_Nuke, waist="Windbuffet Belt +1", legs="Telchine Braconi", feet="Peda. Loafers +3"
		}

		sets.engaged.Refresh = sets.idle

	------------------------------------------------------------------------------------------------
	---------------------------------------- Special Sets ------------------------------------------
	------------------------------------------------------------------------------------------------

		sets.magic_burst =
		{
			main="Maxentius", sub="Ammurapi Shield", ammo="Pemphredo Tathlum",
			head="Peda. M.Board +3", neck="Mizu. Kubikazari", lear="Regal Earring", rear="Static Earring",
			body="Merlinic Jubbah", hands="Amalric Gages +1", lring="Locus Ring", rring="Mujin Band",
			back=gear.SCHCape_Nuke, waist="Refoccilation Stone", legs="Amalric Slops +1", feet="Amalric Nails +1"
		}
		
		sets.magic_burst.Resistant = set_combine(sets.magic_burst,
		{
			rear="Barkaro. Earring",
			hands="Regal Cuffs",
			waist="Eschan Stone", legs="Merlinic Shalwar", feet="Jhakri Pigaches +2"
		})

		sets.buff['Ebullience'] = {head="Arbatel Bonnet +1"}
		sets.buff['Rapture'] = {head="Arbatel Bonnet +1"}
		sets.buff['Perpetuance'] = {hands="Arbatel Bracers +1"}
		sets.buff['Immanence'] = {hands="Arbatel Bracers +1"}
		sets.buff['Celerity'] = {feet="Peda. Loafers +3"}
		sets.buff['Alacrity'] = {feet="Peda. Loafers +3"}

		sets.buff.Doom = 
		{
			neck="Nicander's Necklace",
			waist="Gishdubar Sash"
		}
		
		sets.buff['Klimaform'] =
		{
			main="Akademos", sub="Niobid Strap",
			waist="Hachirin-no-Obi", feet="Arbatel Loafers +1"
		}

		sets.buff.FullSublimation =
		{
			head="Acad. Mortar. +2", rear="Savant's Earring",
			body="Peda. Gown +3"
		}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_post_precast(spell, action, spellMap, eventArgs)
    if (spell.type == "WhiteMagic" and (buffactive["Light Arts"] or buffactive["Addendum: White"])) or
        (spell.type == "BlackMagic" and (buffactive["Dark Arts"] or buffactive["Addendum: Black"])) then
        equip(sets.precast.FC.Grimoire)
	end
end

-- Run after the general midcast() is done.
function job_post_midcast(spell, action, spellMap, eventArgs)
	if spell.action_type == 'Magic' then
		apply_grimoire_bonuses(spell, action, spellMap, eventArgs)
	end

	if spellMap == 'Cure' and spell.target.type == 'SELF' then
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

	if spell.skill == 'Elemental Magic' and state.MagicBurst.value and state.CastingMode.value ~= 'Resistant' then
		if spell.element ~= 'Dark' then
			equip(sets.magic_burst)
		elseif spell.element == 'Dark' and spell.english ~= 'Impact' then
			equip(set_combine(sets.magic_burst,
			{
				head="Pixie Hairpin +1",
				lring="Archon Ring"
			}))
		else
			equip(set_combine(sets.magic_burst,
			{
				head=empty,
				body="Twilight Cloak", lring="Archon Ring"
			}))
		end
	elseif spell.skill == 'Elemental Magic' and state.MagicBurst.value and state.CastingMode.value == 'Resistant' then
		if spell.element ~= 'Dark' then
			equip(sets.magic_burst.Resistant)
		elseif spell.element == 'Dark' and spell.english ~= 'Impact' then
			equip(set_combine(sets.magic_burst.Resistant,
			{
				head="Pixie Hairpin +1",
				lring="Archon Ring"
			}))
		else
			equip(set_combine(sets.magic_burst,
			{
				head=empty,
				body="Twilight Cloak", lring="Archon Ring"
			}))
		end
	end

	if spell.skill == 'Elemental Magic' and (spell.element ~= world.day_element and spell.element ~= world.weather_element) then
		if spell.target.distance < (15 - spell.target.model_size) then
			equip{waist="Orpheus's Sash"}
		end
	elseif spell.skill == 'Elemental Magic' and (spell.element == world.day_element and spell.element == world.weather_element)
			or (spell.element == world.weather_element and get_weather_intensity() == 2) then
		if spellMap ~= 'Helix' then
			equip
			{
				main="Akademos", sub="Niobid Strap",
				waist="Hachirin-no-Obi"
			}
		elseif spell.target.distance < (15 - spell.target.model_size) then
			equip{waist="Orpheus's Sash"}
		end
	elseif spell.skill == 'Elemental Magic' and (spell.element == world.day_element or (spell.element == world.weather_element and get_weather_intensity() == 1)) then
		if spell.target.distance < (7 - spell.target.model_size) then
			equip{waist="Orpheus's Sash"}
		elseif spellMap ~= 'Helix' then
			equip
			{
				main="Akademos", sub="Niobid Strap",
				waist="Hachirin-no-Obi"
			}
		end
	end
end

function job_aftercast(spell, action, spellMap, eventArgs)
	if not spell.interrupted then
		if spell.skill == 'Elemental Magic' then
			--state.MagicBurst:reset()
		end
	end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
	if buff == "Sublimation: Activated" then
		handle_equipping_gear(player.status)
	end
	
	if buff == "doom" then
        if gain then
            equip(sets.buff.Doom)
             disable('neck')
			 disable('waist')
        else
			enable('neck')
            enable('waist')
            handle_equipping_gear(player.status)
        end
    end
end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
	if stateField == 'Offense Mode' then
		if newValue == 'None' then
			enable('main','sub','range')
		else
			disable('main','sub','range')
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
            if (world.weather_element == 'Light' or world.day_element == 'Light') then
                return "CuresWeather"
            else
                return "Cures"
            end
        elseif default_spell_map == 'Curagas' then
            if (world.weather_element == 'Light' or world.day_element == 'Light') then
                return "CuragaWeather"
            else
                return "Curagas"
            end
		end
	end
end

function customize_idle_set(idleSet)
	if state.Buff['Sublimation: Activated'] then
		if state.IdleMode.value == 'Normal' then
			idleSet = set_combine(sets.idle, sets.buff.FullSublimation)
		elseif state.IdleMode.value == 'PDT' then
			idleSet = set_combine(sets.idle.PDT, sets.buff.FullSublimation)
		elseif state.IdleMode.value == 'MDT' then
			idleSet = set_combine(sets.idle.MDT, sets.buff.FullSublimation)
		end
	end

	return idleSet
end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
	update_active_strategems()
	update_sublimation()
end

-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
	display_current_caster_state()
	eventArgs.handled = true
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Reset the state vars tracking strategems.
function update_active_strategems()
	state.Buff['Ebullience'] = buffactive['Ebullience'] or false
	state.Buff['Rapture'] = buffactive['Rapture'] or false
	state.Buff['Perpetuance'] = buffactive['Perpetuance'] or false
	state.Buff['Immanence'] = buffactive['Immanence'] or false
	state.Buff['Penury'] = buffactive['Penury'] or false
	state.Buff['Parsimony'] = buffactive['Parsimony'] or false
	state.Buff['Celerity'] = buffactive['Celerity'] or false
	state.Buff['Alacrity'] = buffactive['Alacrity'] or false

	state.Buff['Klimaform'] = buffactive['Klimaform'] or false
end

function update_sublimation()
	state.Buff['Sublimation: Activated'] = buffactive['Sublimation: Activated'] or false
end

-- Equip sets appropriate to the active buffs, relative to the spell being cast.
function apply_grimoire_bonuses(spell, action, spellMap)
	if state.Buff.Perpetuance and spell.type =='WhiteMagic' and spell.skill == 'Enhancing Magic' then
		equip(sets.buff['Perpetuance'])
	end
	if state.Buff.Rapture and (spellMap == 'Cures' or spellMap == 'Curaga') then
		equip(sets.buff['Rapture'])
	end
	if spell.skill == 'Elemental Magic' and spellMap ~= 'ElementalEnfeeble' then
		if state.Buff.Ebullience and spell.english ~= 'Impact' then
			equip(sets.buff['Ebullience'])
		end
		if state.Buff.Immanence then
			equip(sets.buff['Immanence'])
		end
		if state.Buff.Klimaform and spell.element == world.weather_element then
			equip(sets.buff['Klimaform'])
		end
	end

	if state.Buff.Penury then equip(sets.buff['Penury']) end
	if state.Buff.Parsimony then equip(sets.buff['Parsimony']) end
	if state.Buff.Celerity then equip(sets.buff['Celerity']) end
	if state.Buff.Alacrity then equip(sets.buff['Alacrity']) end
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(1, 4)
end

function set_lockstyle()
    send_command('wait 3; input /lockstyleset ' .. lockstyleset)
end