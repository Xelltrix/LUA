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

	customize_idle_set()
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	state.OffenseMode:options('Refresh','Normal')
	state.CastingMode:options('Normal','Resistant','Potency')
	state.IdleMode:options('Normal','DT','DeathMode')

	apply_job_change()
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
	-- Precast Magic --
	------------------- 
		sets.precast.FC =
		{--Fast Cast 74
			main="Sucellus", sub="Chanter's Shield", ammo="Sapience Orb",
			head="Amalric Coif +1", neck="Orunmila's Torque", lear="Etiolation Earring", rear="Loquac. Earring",
			body="Shango Robe", hands=gear.ENH_Gloves, lring="Kishar Ring", rring="Rahab Ring",
			back=gear.BLMCape_FC, waist="Witful Belt", legs="Psycloth Lappas", feet="Amalric Nails +1"
		}

		sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC,
		{--Fast Cast 71 / -8% Enhancing Magic Cast Time
			waist="Siegel Sash"
		})

		sets.precast.FC.Stoneskin = sets.precast.FC['Enhancing Magic']


		sets.precast.FC.Impact = set_combine(sets.precast.FC,
		{--Fast Cast 55
			head=empty,
			body="Twilight Cloak"
		})

		sets.precast.FC.Death = set_combine(sets.precast.FC,
		{--Fast Cast 72
			ammo="Sapience Orb",
			hands=gear.ENH_Gloves, rring="Mephitas's Ring +1",
		})

		sets.precast.FC.Cures = set_combine(sets.precast.FC,
		{--Fast Cast 72 / -5% Cure Cast Time
			lear="Mendi. Earring"
		})

		sets.precast.FC.Curaga = sets.precast.FC.Cures

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


		sets.midcast.Duration =
		{ --1.5 x 1.16 Duration Bonus
			main="Gada", sub="Ammurapi Shield", ammo="Pemphredo Tathlum",
			head="Telchine Cap", neck="Orunmila's Torque", lear="Etiolation Earring", rear="Loquac. Earring",
			body="Telchine Chas.", hands=gear.ENH_Gloves, lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back="Fi Follet Cape +1", waist="Witful Belt", legs="Telchine Braconi", feet="Telchine Pigaches"
		}

		sets.midcast['Enhancing Magic'] =
		{
			main="Gada", sub="Ammurapi Shield", ammo="Pemphredo Tathlum",
			head="Befouled Crown", neck="Incanter's Torque", lear="Andoaa Earring", rear="Augment. Earring",
			body="Telchine Chas.", hands=gear.ENH_Gloves, lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back="Fi Follet Cape +1", waist="Olympus Sash", legs="Telchine Braconi", feet="Telchine Pigaches"
		}
	
		sets.midcast.ConserveMP = 
		{
			main="Gada", sub="Ammurapi Shield", ammo="Pemphredo Tathlum",
			head="Vanya Hood", neck="Incanter's Torque", lear="Mendi. Earring", rear="Gwati Earring",
			body="Amalric Doublet +1", hands=gear.ENH_Gloves, lring="Kishar Ring", rring="Rahab Ring",
			back="Fi Follet Cape +1", waist="Luminary Sash", legs="Lengo Pants", feet=gear.NukeCrackows
		}

	--------------------------------------
	-- Healing Midcast sets
	--------------------------------------	
	
		--Cure Potency: 50%
		sets.midcast.Cures =
		{
			ammo="Esper Stone +1",
			head="Vanya Hood", neck="Incanter's Torque", lear="Novia Earring", rear="Mendi. Earring",
			body="Vrikodara Jupon", hands=gear.ENH_Gloves, lring="Lebeche Ring", rring="Kuchekula Ring",
			back=gear.BLMCape_FC, waist="Bishop's Sash", legs="Assid. Pants +1", feet="Medium's Sabots"
		}

		sets.midcast.Curaga = sets.midcast.Cures

		sets.midcast.StatusRemoval = sets.midcast.FC

		sets.midcast.Cursna = set_combine(sets.precast.FC,
		{
			main="Gada", sub="Ammurapi Shield",
			neck="Debilis Medallion", lear="Beatific Earring", rear="Healing Earring",
			hands="Hieros Mittens", lring="Haoma's Ring", rring="Menelaus's Ring",
			back="Oretan. Cape +1", waist="Bishop's Sash", feet="Vanya Clogs"
		})
		
		sets.midcast.Raise = sets.midcast.ConserveMP
	
	--------------------------------------
	-- Buffing Midcast sets
	--------------------------------------	
	
		sets.midcast.Stoneskin = set_combine(sets.midcast.Duration,
		{
			neck="Stone Gorget", rear="Earthcry Earring",
			waist="Siegel Sash", legs="Shedir Seraweels"
		})

		sets.midcast.Refresh = set_combine(sets.midcast.Duration,
		{
			head="Amalric Coif +1",
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

		sets.midcast.Storm = sets.midcast.Duration

		sets.midcast.Klimaform = sets.midcast.FC

		sets.midcast.Protection = sets.midcast.Duration
	
	--------------------------------------
	-- Offensive Midcast sets
	--------------------------------------   
	
	
	---Enfeebling
		sets.midcast.Macc =
		{
			main="Maxentius", sub="Ammurapi Shield", ammo="Pemphredo Tathlum",
			head="Amalric Coif +1", neck="Erra Pendant", lear="Digni. Earring", rear="Barkaro. Earring",
			body="Jhakri Robe +2", hands="Regal Cuffs", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back="Taranus's Cape", waist="Luminary Sash", legs="Jhakri Slops +2", feet="Jhakri Pigaches +2"
		}
	
		sets.midcast['Enfeebling Magic'] = set_combine(sets.midcast.Macc,
		{
			head="Befouled Crown", neck="Incanter's Torque",
			lring="Kishar Ring"
		})
	
		sets.midcast['Enfeebling Magic'].Resistant = sets.midcast.Macc

		sets.midcast.ElementalDebuffs = sets.midcast.Macc

	
	---Dark Magic
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
			back=gear.BLMCape_FC, waist="Witful Belt", legs="Psycloth Lappas"
		})
	
		sets.midcast.Stun.Resistant = sets.midcast.Macc

	-- Elemental Magic
		sets.midcast['Elemental Magic'] =
		{
			main="Lathi", sub="Niobid Strap", ammo="Pemphredo Tathlum",
			head=gear.NukeHood, neck="Sanctity Necklace", lear="Regal Earring", rear="Barkaro. Earring",
			body="Amalric Doublet +1", hands="Amalric Gages +1", lring="Freke Ring", rring={name="Shiva Ring +1", bag="wardrobe3"},
			back=gear.BLMCape_Nuke, waist="Sacro Cord", legs="Amalric Slops +1", feet="Amalric Nails +1"
		}

		sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'],
		{
			main="Maxentius", sub="Ammurapi Shield", 
			body="Jhakri Robe +2", 
			waist="Sacro Cord", legs="Jhakri Slops +2", feet="Jhakri Pigaches +2"
		})

		sets.midcast['Elemental Magic'].Potency = sets.midcast['Elemental Magic']

		sets.midcast.Comet = set_combine(sets.midcast['Elemental Magic'],
		{
			head="Pixie Hairpin +1",
			rring="Archon Ring",
		})

		sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'],
		{
			head=empty,
			body="Twilight Cloak",
			rring="Archon Ring",
		})

		sets.midcast.Death =
		{
			main="Lathi", sub="Niobid Strap", ammo="Psilomene",
			head="Pixie Hairpin +1", neck="Sanctity Necklace", lear="Friomisi Earring", rear="Barkaro. Earring",
			body="Amalric Doublet +1", hands="Amalric Gages +1", lring="Archon Ring", rring="Mephitas's Ring +1",
			back=gear.BLMCape_Nuke, waist="Sacro Cord", legs="Amalric Slops +1", feet="Amalric Nails +1"
		}

		sets.midcast.Death.Resistant = set_combine(sets.midcast.Death,
		{
			main=gear.Grioavolr_Enf, ammo="Pemphredo Tathlum",
			head=gear.NukeHood,
			body="Merlinic Jubbah",
			waist="Sacro Cord", legs="Jhakri Slops +2"
		})
	
		sets.magic_burst =
		{--MBD/II: 42/11
			main="Lathi", sub="Niobid Strap", ammo="Pemphredo Tathlum",
			head="Ea Hat", neck="Mizu. Kubikazari", lear="Regal Earring", rear="Static Earring",
			body="Amalric Doublet +1", hands="Amalric Gages +1", lring="Locus Ring", rring="Mujin Band",
			back=gear.BLMCape_Nuke, waist="Sacro Cord", legs="Merlinic Shalwar", feet="Amalric Nails +1"
		}

		sets.magic_burst.Resistant = set_combine(sets.magic_burst,
		{--MBD/II: 42/11
			main="Maxentius", sub="Ammurapi Shield",
			rear="Barkaro. Earring",
			hands="Regal Cuffs", 
			waist="Sacro Cord", feet="Jhakri Pigaches +2"
		})
	
	
	--------------------------------------
	-- Miscellaneous Midcast sets
	--------------------------------------  
	
		sets.midcast.Teleport = sets.midcast.ConserveMP
		
		sets.midcast.Utsusemi = sets.midcast.FC
	
	
	
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
		{--Regen+3 | Refresh+8~9 | PDT/MDT: (13/15)
			main="Lathi", sub="Khonsu", ammo="Staunch Tathlum +1",
			head="Befouled Crown", neck="Sanctity Necklace", lear="Dawn Earring", rear="Infused Earring",
			body="Amalric Doublet +1", hands="Amalric Gages +1", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back="Moonlight Cape", waist="Carrier's Sash", legs="Assid. Pants +1", feet="Amalric Nails +1"
		}

		sets.idle.DT = set_combine(sets.idle,
		{--Regen+0 | Refresh+6~7 | PDT/MDT: (38/40)
			neck="Loricate Torque +1",  lear="Genmei Earring", rear="Odnowa Earring +1",
			lring="Defending Ring", rring="Gelatinous Ring +1"
		})

		sets.idle.DeathMode =
		{--Regen+1 | Refresh+4~5 | PDT/MDT: (5/8)
			main="Lathi", sub="Khonsu", ammo="Psilomene",
			head="Befouled Crown", neck="Sanctity Necklace", lear="Etiolation Earring", rear="Loquac. Earring",
			body="Amalric Doublet +1", hands="Regal Cuffs", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back="Fi Follet Cape +1", waist="Fucho-no-Obi", legs="Assid. Pants +1", feet="Amalric Nails +1"
		}

		sets.idle.Weak = sets.idle.DT	
	
		sets.idle.Town = set_combine(sets.idle, 
		{
			feet="Crier's Gaiters"
		})

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
		{--PDT: 51 / MDT: 42
			sub="Khonsu", ammo="Staunch Tathlum +1",
			head="Vanya Hood", neck="Loricate Torque +1",  lear="Genmei Earring", rear="Odnowa Earring +1",
			body="Mallquis Saio +2", hands="Amalric Gages +1", lring="Defending Ring", rring="Gelatinous Ring +1",
			back="Moonlight Cape", waist="Carrier's Sash", legs="Artsieq Hose", feet="Wicce Sabots +1"
		}

		sets.defense.MDT = 
		{--MDT: 46 / PDT: 31
			main="Lathi", sub="Irenic Strap +1", ammo="Staunch Tathlum +1",
			head="Vanya Hood", neck="Loricate Torque +1", lear="Etiolation Earring", rear="Odnowa Earring +1",
			body="Mallquis Saio +2", hands="Amalric Gages +1", lring="Defending Ring", rring="Shukuyu Ring",
			back="Moonlight Cape", waist="Carrier's Sash", legs="Amalric Slops +1", feet="Amalric Nails +1"
		}

	--------------------------------------
	-- Special Sets
	--------------------------------------

		sets.Kiting = { feet="Crier's Gaiters" }

		sets.buff['Mana Wall'] =
		{
			back=gear.BLMCape_Nuke, feet="Wicce Sabots +1"
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
			ammo="Floestone",
			head="Jhakri Coronal +2", neck="Fotia Gorget", lear="Telos Earring", rear="Moonshade Earring",
			body="Jhakri Robe +2", hands="Jhakri Cuffs +2", lring="Karieyh Ring +1", rring="Epaminondas's Ring",
			back=gear.BLMCape_Nuke, legs="Jhakri Slops +2", feet="Jhakri Pigaches +2"
		}

		sets.precast.WS['Myrkr'] =
		{
			ammo="Psilomene",
			head="Amalric Coif +1", neck="Sanctity Necklace", lear="Etiolation Earring", rear="Moonshade Earring",
			body="Amalric Doublet +1", hands="Regal Cuffs", lring="Lebeche Ring", rring="Mephitas's Ring +1",
			back="Fi Follet Cape +1", waist="Luminary Sash", legs="Amalric Slops +1", feet="Amalric Nails +1"
		}
	
	--------------------------------------
	-- Melee sets
	--------------------------------------
	
		sets.engaged =
		{
			main="Lathi", sub="Khonsu", ammo="Floestone",
			head="Jhakri Coronal +2", neck="Combatant's Torque", lear={name="Mache Earring +1", bag="wardrobe2"}, rear={name="Mache Earring +1", bag="wardrobe3"},
			body="Jhakri Robe +2", hands="Volte Bracers", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"},
			back=gear.BLMCape_Nuke, waist="Windbuffet Belt +1", legs="Jhakri Slops +2", feet="Jhakri Pigaches +2"
		}
	
		sets.engaged.Refresh =
		{
			main="Lathi", sub="Khonsu", ammo="Staunch Tathlum +1",
			head="Befouled Crown", neck="Sanctity Necklace", lear="Dawn Earring", rear="Infused Earring",
			body="Jhakri Robe +2", hands="Amalric Gages +1", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back="Moonlight Cape", waist="Carrier's Sash", legs="Assid. Pants +1", feet="Amalric Nails +1"
		}

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------



-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_post_midcast(spell, action, spellMap, eventArgs)
	if spellMap == 'Cures' and spell.target.type == 'SELF' then
        	equip { waist="Gishdubar Sash" }
	end
	
	if spellMap == 'Refresh' and spell.target.type == 'SELF' then
		equip
		{
			back="Grapevine Cape", waist="Gishdubar Sash", feet="Inspirited Boots"
		}
	end

	if (spell.skill == 'Elemental Magic' or spell.english == 'Death') and state.MagicBurst.value and (state.CastingMode.value == 'Normal' or state.CastingMode.value == 'Potency') then
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
	elseif (spell.skill == 'Elemental Magic' or spell.english == 'Death') and state.MagicBurst.value and state.CastingMode.value == 'Resistant' then
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
	
	if spell.skill == 'Elemental Magic' and state.SaveMP.value and spell.english ~= 'Death' and spell.english ~= 'Impact' then
		equip{body="Spae. Coat +1"}
	end

	if spell.skill == 'Elemental Magic' and (spell.element ~= world.day_element and spell.element ~= world.weather_element) then
		if spell.target.distance < (15 - spell.target.model_size) then
			equip { waist="Orpheus's Sash" }
		end
	elseif spell.skill == 'Elemental Magic' and (spell.element == world.day_element and spell.element == world.weather_element)
			or (spell.element == world.weather_element and get_weather_intensity() == 2 and world.day_element ~= elements.strong_to[spell.element]) then
		if spellMap ~= 'Helix' then
			equip { waist="Hachirin-no-Obi" }
		elseif spell.target.distance < (15 - spell.target.model_size) then
			equip { waist="Orpheus's Sash" }
		end
	elseif spell.skill == 'Elemental Magic' and (spell.element == world.day_element or (spell.element == world.weather_element and get_weather_intensity() == 1)
		or (spell.element == world.weather_element and get_weather_intensity() == 2 and world.day_element == elements.strong_to[spell.element])) then
		if spell.target.distance < (7 - spell.target.model_size) then	
			equip { waist="Orpheus's Sash" }
		elseif spellMap ~= 'Helix' then
			equip { waist="Hachirin-no-Obi" }
		end
	end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------



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
		disable('neck','lring','rring','waist')
        else
		enable('neck','lring','rring','waist')
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
function apply_job_change()
	set_macro_page(1, 3)
	
	send_command('wait 3; input /lockstyleset 2')
end