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
	
	state.SaveMP        			= M(true)
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	state.OffenseMode:options('Normal')
	state.CastingMode:options('Normal', 'Resistant')
	state.IdleMode:options('Normal', 'DT', 'MEVA')

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
	-- Job Abilities --
	------------------- 
	
		sets.precast.JA['Benediction'] =
		{
			main="Piety Wand", sub="Ammurapi Shield", ammo="Esper Stone +1",
			head="Kaykaus Mitra +1", neck="Sanctity Necklace", lear="Loquac. Earring", rear="Etiolation Earring",
			body="Piety Briault +3", hands="Kaykaus Cuffs +1", lring="Lebeche Ring", rring="Mephitas's Ring +1",
			back="Fi Follet Cape +1", waist="Luminary Sash", legs="Piety Pantaln. +3", feet="Kaykaus Boots +1"
		}

	-------------------
	-- Precast Magic --
	------------------- 
	-- Healing Cast Time: 	-8%
	-- Divine Benison: 	50% Fast Cast
	
		sets.precast.FC =
		{--		Fast Cast: 84%
			main="Sucellus", sub="Chanter's Shield", ammo="Sapience Orb",
			head="C. Palug Crown", neck="Cleric's Torque", lear="Loquac. Earring", rear="Malignance Earring",
			body="Pinga Tunic", hands="Fanatic Gloves", lring="Lebeche Ring", rring="Weather. Ring +1",
			back="Alaunus's Cape", waist="Witful Belt", legs="Pinga Pants", feet="Telchine Pigaches"
		}

		sets.precast.FC['Healing Magic'] = set_combine(sets.precast.FC,
		{--		Fast Cast: 71%		Healing Casting Time: -21%
			legs="Ebers Pant. +1"
		})

		sets.precast.FC.StatusRemoval = set_combine(sets.precast.FC['Healing Magic'],
		{--		Fast Cast: 66%		Healing Cast Time: 21%
			main="Yagrush"
		})

		sets.precast.FC.Cures = set_combine(sets.precast.FC['Healing Magic'],
		{--		Fast Cast: 66%		Healing Castime: 40%
			rear="Mendi. Earring",
			feet="Vanya Clogs"
		})

		sets.precast.FC.Curagas = sets.precast.FC.Cures

		sets.precast.FC.Impact = set_combine(sets.precast.FC,
		{--		Fast Cast: 67%
			head=empty,
			body="Twilight Cloak"
		})
		
		sets.precast.FC.Dispelga = set_combine(sets.precast.FC,
		{
			main="Daybreak"
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
		{--		Fast Cast: 81%		Haste: 24%
			lring="Kishar Ring",
			legs="Aya. Cosciales +2"
		})

		sets.midcast.ConserveMP = set_combine(sets.midcast.FC,
		{--		Fast Cast: 38%		Haste: 20%	Conserve MP: 
			ammo="Pemphredo Tathlum",
			head="Vanya Hood", neck="Incanter's Torque", lear="Gwati Earring", rear="Mendi. Earring",
			body="Kaykaus Bliaut +1",
			back="Fi Follet Cape +1", waist="Luminary Sash", legs="Lengo Pants", feet="Kaykaus Boots +1"
		})

		sets.midcast.Duration = set_combine(sets.midcast.FC,
		{--		Fast Cast: 33%		Haste: 23%	Duration: (1.46) * (1.2)
			main="Gada", sub="Ammurapi Shield",
			head="Telchine Cap",
			body=gear.ENH_Body, hands=gear.ENH_Gloves,
			legs=gear.ENH_Legs, feet="Theo. Duckbills +3"
		})
		
		
    --------------------------------------
	-- Healing Midcast sets
	--------------------------------------	

		sets.midcast.Cures =
		{-- Cure Potency/II: 50%/16%			Enmity: -51		Healing Magic Skill: +87(563)	MND+215
			main="Gada", sub="Ammurapi Shield", ammo="Pemphredo Tathlum",
			head="Kaykaus Mitra +1", neck="Cleric's Torque", lear="Glorious Earring", rear="Beatific Earring",
			body="Theo. Briault +3", hands="Theophany Mitts +3", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring="Menelaus's Ring",
			back="Alaunus's Cape", waist="Bishop's Sash", legs="Ebers Pant. +1", feet="Kaykaus Boots +1"
		}
			
		sets.midcast.CureSolace = set_combine(sets.midcast.Cures,
		{-- Cure Potency/II: 50%/10%			Enmity: -50		Healing Magic Skill: +110(587)	MND+209
			ammo="Esper Stone +1",
			body="Ebers Bliaud +1"
		})
		
		sets.midcast.Curagas = set_combine(sets.midcast.Cures,
		{-- Cure Potency/II: 57%/16%			Enmity: -51		Healing Magic Skill: +34(529)	MND+267
			main="Daybreak",
			rear="Regal Earring",
			rring={name="Stikini Ring +1", bag="wardrobe3"},
			waist="Luminary Sash"
		})
		
		sets.midcast.Curas =
		{-- Cure Potency/II: 52%/14%			Enmity: -50		Healing Magic Skill: +24(500)	MND+197
			main="Piety Wand", sub="Chanter's Shield", ammo="Sapience Orb",
			head="Kaykaus Mitra +1", neck="Cleric's Torque", lear="Glorious Earring", rear="Mendi. Earring",
			body="Kaykaus Bliaut +1", hands="Kaykaus Cuffs +1", lring="Lebeche Ring", rring={name="Stikini Ring +1", bag="wardrobe3"},
			back="Alaunus's Cape", waist="Sacro Cord", legs="Ebers Pant. +1", feet="Kaykaus Boots +1"
		}
		
		sets.midcast.CuresWeather =
		{-- Cure Potency/II: 50%/16%			Enmity: -56		Healing Magic Skill: +52(528)	MND+183
			main="Chatoyant Staff", sub="Enki Strap", ammo="Pemphredo Tathlum",
			head="Kaykaus Mitra +1", neck="Cleric's Torque", lear="Glorious Earring", rear="Mendi. Earring",
			body="Theo. Briault +3", hands="Theophany Mitts +3", lring="Lebeche Ring", rring="Menelaus's Ring",
			back="Twilight Cape", waist="Hachirin-no-Obi", legs="Ebers Pant. +1", feet="Kaykaus Boots +1"
		}
			
		sets.midcast.CureSolaceWeather = set_combine(sets.midcast.CuresWeather,
		{-- Cure Potency/II: 50%/10%			Enmity: -50		Healing Magic Skill: +76(552)	MND+177
			body="Ebers Bliaud +1",
			back="Alaunus's Cape"
		})
		sets.midcast.CuragaWeather = set_combine(sets.midcast.CuresWeather,
		{-- Cure Potency/II: 51%/16%			Enmity: -50		Healing Magic Skill: +45(521)	MND+185
			body="Kaykaus Bliaut +1", rring={name="Stikini Ring +1", bag="wardrobe3"},
		})
		
		sets.midcast.CurasWeather = set_combine(sets.midcast.Curas,
		{-- Cure Potency/II: 52%/14%			Enmity: -54		Healing Magic Skill: +24(500)	MND+169
			ammo="Esper Stone +1",
			back="Twilight Cape", waist="Hachirin-no-Obi"
		})

--[[		CURSNA FORMULA
		R = (10 + s/30)*(1 + c/100)*(1 + r/100)

		s - Healing magic skill
		c - Cursna success rate+
		r - Cursna received success rate+
]]
		
		sets.midcast.Cursna = set_combine(sets.precast.FC['Healing Magic'],
		{--	(10 + 605/30)*(1 + 116/100) =		65.16% Success Rate
			main="Yagrush",
			head="Vanya Hood", neck="Debilis Medallion", lear="Healing Earring", rear="Beatific Earring",
			body="Ebers Bliaud +1", lring="Haoma's Ring", rring="Menelaus's Ring",
			waist="Bishop's Sash", legs="Th. Pant. +3", feet="Vanya Clogs"
		})

		sets.midcast.StatusRemoval = sets.precast.FC.StatusRemoval
		
		sets.midcast.Esuna = set_combine(sets.midcast.FC,
		{--		Fast Cast: 72%		Haste: 24%
			main="Piety Wand"
		})

		sets.midcast['Healing Magic'] = set_combine(sets.midcast.FC,
		{
			main="Piety Wand"
		})

	--------------------------------------
	-- Buffing Midcast sets
	--------------------------------------	
		
		sets.midcast.Stoneskin = set_combine(sets.midcast.Duration,
		{
			neck="Stone Gorget", lear="Earthcry Earring",
			waist="Siegel Sash", legs="Shedir Seraweels"
		})

		sets.midcast.Aquaveil = set_combine(sets.midcast.Duration,
		{
			main="Vadose Rod", ammo="Staunch Tathlum +1",
			head="Chironic Hat", 
			hands="Chironic Gloves",
			waist="Emphatikos Rope", legs="Shedir Seraweels"
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
			back="Alaunus's Cape", waist="Olympus Sash", legs="Piety Pantaln. +3", feet="Ebers Duckbills +1"
		}
		
		sets.midcast.BarElementLA = set_combine(sets.midcast.BarElement,
		{
			hands="Ebers Mitts +1"
		})

		sets.midcast.BarStatus = set_combine(sets.midcast.Duration,
		{
			neck="Incanter's Torque", lear="Andoaa Earring", rear="Augment. Earring",
			hands="Dynasty Mitts",  lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back="Fi Follet Cape +1", waist="Olympus Sash"
		})

		sets.midcast.BarStatusLA = set_combine(sets.midcast.BarStatus,
		{
			hands=gear.ENH_Gloves
		})
	
		sets.midcast.BoostStat =
		{
			main="Gada", sub="Ammurapi Shield", ammo="Pemphredo Tathlum",
			head="Telchine Cap", neck="Incanter's Torque", lear="Andoaa Earring", rear="Augment. Earring",
			body=gear.ENH_Body, hands="Dynasty Mitts", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back="Fi Follet Cape +1", waist="Olympus Sash", legs=gear.ENH_Legs, feet="Theo. Duckbills +3"
		}

		sets.midcast.BoostStatLA = set_combine(sets.midcast.BoostStat,
		{
			hands=gear.ENH_Gloves
		})
		
		sets.midcast.Enhancement = 
		{
			main="Gada", sub="Ammurapi Shield", ammo="Pemphredo Tathlum",
			head="Telchine Cap", neck="Incanter's Torque", lear="Andoaa Earring", rear="Augment. Earring",
			body=gear.ENH_Body, hands="Dynasty Mitts", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back="Fi Follet Cape +1", waist="Olympus Sash", legs=gear.ENH_Legs, feet="Theo. Duckbills +3"
		}

		sets.midcast.Regen =
		{--(Regen IV	40/tick		120s		1600 HP)	Potency: +76%	Duration: +46	/ +10%(+10%)		
		 --			70/tick		200s	=	4620 HP
			main="Bolelabunga", sub="Ammurapi Shield", ammo="Pemphredo Tathlum",
			head="Inyanga Tiara +2", neck="Incanter's Torque", lear="Gwati Earring", rear="Mendi. Earring",
			body="Piety Briault +3", hands="Ebers Mitts +1", lring="Kishar Ring", rring="Weather. Ring +1",
			back="Fi Follet Cape +1", waist="Luminary Sash", legs="Th. Pant. +3", feet="Theo. Duckbills +3"
		}

		sets.midcast.Refresh = sets.midcast.Duration

		sets.midcast.Statless = sets.midcast.Duration

		sets.midcast.Storm = sets.midcast.Duration

		sets.midcast.Protection = set_combine(sets.midcast.Duration,
		{
			ammo="Pemphredo Tathlum",
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
			main="Daybreak", sub="Ammurapi Shield", ammo="Pemphredo Tathlum",
			head="Theophany Cap +2", neck="Incanter's Torque", lear="Regal Earring", rear="Malignance Earring", 
			body="Theo. Briault +3", hands="Theophany Mitts +3", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back="Alaunus's Cape", waist="Luminary Sash", legs="Th. Pant. +3", feet="Theo. Duckbills +3"
		}
		
		sets.midcast['Enfeebling Magic'] = set_combine(sets.midcast.Macc,
		{
			hands="Kaykaus Cuffs +1",
			legs="Chironic Hose" 
		})

		sets.midcast.Static = set_combine(sets.midcast['Enfeebling Magic'],
		{
			hands="Regal Cuffs", lring="Kishar Ring"
		})
		
		sets.midcast.Dispelga = sets.midcast['Enfeebling Magic']
		
		sets.midcast.Repose = sets.midcast.Macc

		sets.midcast['Dia'] = sets.midcast.FastRecast
		
		sets.midcast['Dia II'] = set_combine(sets.midcast.FastRecast,
		{
			hands="Regal Cuffs", lring="Kishar Ring"
		})

		sets.midcast['Divine Magic'] = sets.midcast.Macc
	
	---Dark Magic	
		sets.midcast['Dark Magic'] = set_combine(sets.midcast.Macc,
		{
			body="Shango Robe"
		})

		sets.midcast.Sap = set_combine(sets.midcast['Dark Magic'],
		{
			head="Pixie Hairpin +1",
			body="Chironic Doublet", hands="Inyan. Dastanas +2", lring="Archon Ring", rring="Evanescence Ring",
			waist="Fucho-no-Obi"
		})
		
		
	-- Elemental Magic	
		sets.midcast.DivineNuke =
		{
			main="Daybreak", sub="Ammurapi Shield", ammo="Pemphredo Tathlum",
			head="C. Palug Crown", neck="Sanctity Necklace", lear="Regal Earring", rear="Malignance Earring",
			body="Chironic Doublet", hands="Fanatic Gloves", lring="Freke Ring", rring="Weather. Ring +1",
			back="Alaunus's Cape", waist="Sacro Cord", legs="Kaykaus Tights +1", feet="Chironic Slippers"
		}

		sets.midcast['Elemental Magic'] = set_combine(sets.midcast.DivineNuke,
		{
			rring={name="Shiva Ring +1", bag="wardrobe3"}
		})
		
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
			main="Daybreak", sub="Genmei Shield", ammo="Homiliary",
			head="Befouled Crown", neck="Sanctity Necklace", lear="Dawn Earring", rear="Infused Earring",
			body="Piety Briault +3", hands="Chironic Gloves", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back="Moonlight Cape", waist="Carrier's Sash", legs="Volte Brais", feet="Chironic Slippers"
		}
		
		sets.idle.DT = set_combine(sets.idle,
		{
			main="Piety Wand",
			head="Inyanga Tiara +2", neck="Loricate Torque +1", lear="Genmei Earring", rear="Odnowa Earring +1",
			lring="Defending Ring", rring="Gelatinous Ring +1",
			legs="Inyanga Shalwar +2",
		})
		
		sets.idle.MEVA = set_combine(sets.idle,
		{
			ammo="Staunch Tathlum +1",
			head="Inyanga Tiara +2", neck="Warder's Charm +1", lear="Eabani Earring", rear="Sanare Earring",
			body="Inyanga Jubbah +2", hands="Inyan. Dastanas +2",
			legs="Inyanga Shalwar +2", feet="Inyan. Crackows +2"
		})

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
		{
			main="Piety Wand", sub="Genmei Shield", ammo="Staunch Tathlum +1",
			head="Inyanga Tiara +2", neck="Loricate Torque +1", lear="Eabani Earring", rear="Sanare Earring",
			body="Inyanga Jubbah +2", hands="Inyan. Dastanas +2", lring="Defending Ring", rring="Gelatinous Ring +1",
			back="Moonlight Cape", waist="Carrier's Sash", legs="Inyanga Shalwar +2", feet="Inyan. Crackows +2"
		}

		sets.defense.MDT = set_combine(sets.defense.PDT,
		{
			main="Piety Wand",
			neck="Warder's Charm +1", lear="Genmei Earring",
			rring="Inyanga Ring",
			back="Alaunus's Cape"
		})
	
	
	--------------------------------------
	-- Special Sets
	--------------------------------------
		
		sets.Kiting = { feet="Crier's Gaiters" }

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
		
		sets.TreasureHunter =
		{
			head="Chironic Hat", hands="Volte Bracers",
			waist="Chaac Belt", legs="Volte Hose"
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
			head="Chironic Hat", neck="Fotia Gorget", lear="Brutal Earring", rear="Ishvara Earring",
			body="Ayanmo Corazza +2", hands="Aya. Manopolas +2", lring="Shukuyu Ring", rring="Epaminondas's Ring",
			back="Alaunus's Cape", waist="Fotia Belt", legs=gear.ENH_Legs, feet="Chironic Slippers"
		}
		
		sets.precast.WS['Moonlight'] =
		{
			head="Kaykaus Mitra +1", neck="Combatant's Torque", lear="Loquac. Earring", rear="Moonshade Earring",
			body="Piety Briault +3", hands="Kaykaus Cuffs +1", lring="Lebeche Ring", rring="Mephitas's Ring +1",
			back="Fi Follet Cape +1", waist="Luminary Sash", legs="Piety Pantaln. +3", feet="Kaykaus Boots +1"
		}
		
		sets.precast.WS['Mystic Boon'] = set_combine(sets.precast.WS,
		{
			lear="Regal Earring", rear="Moonshade Earring",
			body="Piety Briault +3", hands="Theophany Mitts +3", lring={name="Stikini Ring +1", bag="wardrobe2"},
			legs="Piety Pantaln. +3"
		})	
		
	
	--------------------------------------
	-- Melee sets
	--------------------------------------
		
		sets.engaged =
		{
			main="Maxentius", sub="Genmei Shield", ammo="Floestone",
			head="Chironic Hat", neck="Combatant's Torque", lear={name="Mache Earring +1", bag="wardrobe2"}, rear={name="Mache Earring +1", bag="wardrobe3"},
			body="Ayanmo Corazza +2", hands="Aya. Manopolas +2", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"},
			back="Alaunus's Cape", waist="Windbuffet Belt +1", legs="Aya. Cosciales +2", feet="Chironic Slippers"
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
	
	if (spellMap == 'Raises' and state.SaveMP.value) then
		equip(sets.midcast.ConserveMP)
	end
	
	
	if (spell.skill == 'Elemental Magic' or spellMap ==  'DivineNuke') and state.MagicBurst.value then
		if spell.element ~= 'Dark' and spell.element ~= 'Light' then
			equip(
			{
				main="Maxentius", sub="Ammurapi Shield",
				neck="Mizu. Kubikazari", lear="Static Earring",
				lring="Locus Ring"
			})
		elseif spell.element == 'Dark' and spell.english ~= 'Impact' then
			equip(
			{
				main="Maxentius", sub="Ammurapi Shield",
				head="Pixie Hairpin +1", neck="Mizu. Kubikazari", lear="Static Earring",
				lring="Locus Ring", rring="Archon Ring"
			})
		elseif spell.element == 'Light' then
			equip(
			{
				main="Daybreak", sub="Ammurapi Shield",
				neck="Mizu. Kubikazari", lear="Static Earring",
				lring="Locus Ring", rring="Weather. Ring +1"
			})
		else
			equip(
			{
				main="Maxentius", sub="Ammurapi Shield",
				neck="Mizu. Kubikazari", lear="Static Earring",
				lring="Locus Ring", rring="Archon Ring"
			})
		end
	end
	
	
	if (spell.skill == 'Elemental Magic' or spellMap == 'DivineNuke') and (spell.element ~= world.day_element and spell.element ~= world.weather_element) then
		if spell.target.distance < (15 - spell.target.model_size) then
			equip { waist="Orpheus's Sash" }
		end
	elseif (spell.skill == 'Elemental Magic' or spellMap == 'DivineNuke') and (spell.element == world.day_element and spell.element == world.weather_element)
			or (spell.element == world.weather_element and get_weather_intensity() == 2 and world.day_element ~= elements.strong_to[spell.element]) then
		if spellMap ~= 'Helix' then
			equip { waist="Hachirin-no-Obi" }
		elseif spell.target.distance < (15 - spell.target.model_size) then
			equip { waist="Orpheus's Sash" }
		end
	elseif (spell.skill == 'Elemental Magic' or spellMap == 'DivineNuke') and (spell.element == world.day_element or (spell.element == world.weather_element and get_weather_intensity() == 1)
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
		elseif default_spell_map == 'Curas' then
			if buffactive['Afflatus Misery'] then
				if (world.weather_element == 'Light' or world.day_element == 'Light') then
					return "CurasWeather"
				else
					return "Curas"
				end
			else
				if (world.weather_element == 'Light' or world.day_element == 'Light') then
					return "CuragasWeather"
				else
					return "Curagas"
				end
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
function apply_job_change()
	set_macro_page(1, 2)
	
	send_command('wait 3; input /lockstyleset 3')
end