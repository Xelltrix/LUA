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
	state.Buff['Sublimation: Activated'] 	= buffactive['Sublimation: Activated'] or false
	
	state.Buff['Afflatus Solace'] 			= buffactive['Afflatus Solace'] or false
	state.Buff['Afflatus Misery'] 			= buffactive['Afflatus Misery'] or false
	state.Buff['Light Arts'] 				= buffactive['Light Arts'] or false
	
	state.SaveMP        					= M(true)
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	state.OffenseMode:options('Normal')
	state.CastingMode:options('Normal','Resistant')
	state.IdleMode:options('Normal','DT','MEVA')
	state.MagicalDefenseMode:options('MEVA','MDT')
	
	state.BarElement = M{['description']='BarElement','Barfira','Barblizzara','Baraera','Barstonra','Barthundra','Barwatera'}
    state.BarStatus = M{['description']='BarStatus','Baramnesra','Barvira','Barparalyzra','Barsilencera','Barpetra','Barpoisonra','Barblindra','Barsleepra'}
	
	state.Boost = M{['description']='Boost','Boost-STR','Boost-DEX','Boost-INT','Boost-AGI','Boost-MND'}
	
	send_command('bind ^home gs c cycle BarElement')
	send_command('bind ^end gs c cycleback BarElement')
	
	send_command('bind !home gs c cycle BarStatus')
	send_command('bind !end gs c cycleback BarStatus')

	apply_job_change()
end


function user_unload()
	send_command('unbind ^home')
	send_command('unbind !home')
	send_command('unbind ^end')
	send_command('unbind !end')
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
			main="Asclepius", sub="Ammurapi Shield", ammo="Ghastly Tathlum +1",
			head="Kaykaus Mitra +1", neck="Clr. Torque +2", lear="Loquac. Earring", rear="Etiolation Earring",
			body="Piety Briault +3", hands="Kaykaus Cuffs +1", lring="Lebeche Ring", rring="Kuchekula Ring",
			back="Fi Follet Cape +1", waist="Shinjutsu-no-Obi +1", legs="Piety Pantaln. +3", feet="Kaykaus Boots +1"
		}

	-------------------
	-- Precast Magic --
	------------------- 
	-- Healing Cast Time: 	-8%
	-- Divine Benison: 	50% Fast Cast
	
		sets.precast.FC =
		{--		Fast Cast: 96%
			main="Sucellus", sub="Chanter's Shield", ammo="Sapience Orb",
			head="Bunzi's Hat", neck="Clr. Torque +2", lear="Loquac. Earring", rear="Malignance Earring",
			body="Pinga Tunic +1", hands="Fanatic Gloves", lring="Lebeche Ring", rring="Weather. Ring +1",
			back="Fi Follet Cape +1", waist="Witful Belt", legs="Pinga Pants +1", feet="Volte Gaiters"
		}

		sets.precast.FC['Healing Magic'] = 
		{--		Fast Cast: 91%		Healing Casting Time: -25%(+8%)
			main="Asclepius", sub="Chanter's Shield", ammo="Sapience Orb",
			head="Bunzi's Hat", neck="Clr. Torque +2", lear="Loquac. Earring", rear="Malignance Earring",
			body="Pinga Tunic +1", hands="Fanatic Gloves", lring="Lebeche Ring", rring="Weather. Ring +1",
			back="Fi Follet Cape +1", waist="Witful Belt", legs="Pinga Pants +1", feet="Volte Gaiters"		
		}

		sets.precast.FC.StatusRemoval =
		{--		Fast Cast: 91%		Divine Benison FC: 20%(+50%)
			main="Yagrush", sub="Chanter's Shield", ammo="Sapience Orb",
			head="Bunzi's Hat", neck="Clr. Torque +2", lear="Loquac. Earring", rear="Malignance Earring",
			body="Pinga Tunic +1", hands="Fanatic Gloves", lring="Lebeche Ring", rring="Weather. Ring +1",
			back="Fi Follet Cape +1", waist="Witful Belt", legs="Pinga Pants +1", feet="Volte Gaiters"
		}

		sets.precast.FC.Cures =
		{--		Fast Cast: 81%		Healing Castime: 40%
			main="Asclepius", sub="Chanter's Shield", ammo="Sapience Orb",
			head="Bunzi's Hat", neck="Clr. Torque +2", lear="Loquac. Earring", rear="Mendi. Earring",
			body="Pinga Tunic +1", hands="Fanatic Gloves", lring="Lebeche Ring", rring="Weather. Ring +1",
			back="Fi Follet Cape +1", waist="Witful Belt", legs="Pinga Pants +1", feet="Vanya Clogs"
		}

		sets.precast.FC.Curagas = sets.precast.FC.Cures

		sets.precast.FC.Impact =
		{--		Fast Cast: 67%
			main="Sucellus", sub="Chanter's Shield", ammo="Sapience Orb",
			head=empty, neck="Clr. Torque +2", lear="Loquac. Earring", rear="Malignance Earring",
			body="Twilight Cloak", hands="Fanatic Gloves", lring="Lebeche Ring", rring="Weather. Ring +1",
			back="Fi Follet Cape +1", waist="Witful Belt", legs="Pinga Pants +1", feet="Volte Gaiters"
		}
		
		sets.precast.FC.Dispelga =
		{--		Fast Cast: 81%
			main="Daybreak", sub="Chanter's Shield", ammo="Sapience Orb",
			head="Bunzi's Hat", neck="Clr. Torque +2", lear="Loquac. Earring", rear="Malignance Earring",
			body="Pinga Tunic +1", hands="Fanatic Gloves", lring="Lebeche Ring", rring="Weather. Ring +1",
			back="Fi Follet Cape +1", waist="Witful Belt", legs="Pinga Pants +1", feet="Volte Gaiters"
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

		sets.midcast.FC = 
		{--		Fast Cast: 89%		Haste: 26%
			main="Sucellus", sub="Chanter's Shield", ammo="Hasty Pinion +1",
			head="Bunzi's Hat", neck="Clr. Torque +2", lear="Loquac. Earring", rear="Malignance Earring",
			body="Pinga Tunic +1", hands="Fanatic Gloves", lring="Defending Ring", rring="Weather. Ring +1",
			back="Fi Follet Cape +1", waist="Witful Belt", legs="Volte Brais", feet="Volte Gaiters"
		}

		sets.midcast.ConserveMP = 
		{--		Fast Cast: 38%		Haste: 20%	Conserve MP: 
			main="Asclepius", sub="Chanter's Shield", ammo="Pemphredo Tathlum",
			head="Vanya Hood", neck="Incanter's Torque", lear="Gwati Earring", rear="Mendi. Earring",
			body="Kaykaus Bliaut +1", hands="Fanatic Gloves", lring="Mephitas's Ring +1", rring="Weather. Ring +1",
			back="Fi Follet Cape +1", waist="Shinjutsu-no-Obi +1", legs="Lengo Pants", feet="Kaykaus Boots +1"
		}

		sets.midcast.Duration = 
		{--		Fast Cast: 33%		Haste: 23%	Duration: (1.46) * (1.2)
			main="Gada", sub="Ammurapi Shield", ammo="Hasty Pinion +1",
			head=gear.ENH_Head, neck="Clr. Torque +2", lear="Loquac. Earring", rear="Malignance Earring",
			body=gear.ENH_Body, hands=gear.ENH_Gloves, lring="Kishar Ring", rring="Weather. Ring +1",
			back="Fi Follet Cape +1", waist="Embla Sash", legs=gear.ENH_Legs, feet="Theo. Duckbills +3"
		}
		
		
    --------------------------------------
	-- Healing Midcast sets					Base Healing: 476		Base Mind: 112
	--------------------------------------	

		sets.midcast.Cures =
		{-- Cure Potency/II: 55%/26%			Enmity: -61		Healing Magic Skill: +63(539)	MND+209
			main="Raetic Rod +1", sub="Ammurapi Shield", ammo="Pemphredo Tathlum",
			head="Kaykaus Mitra +1", neck="Clr. Torque +2", lear="Glorious Earring", rear="Meili Earring",
			body="Theo. Briault +3", hands="Theophany Mitts +3", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back="Fi Follet Cape +1", waist="Shinjutsu-no-Obi +1", legs="Ebers Pant. +1", feet="Kaykaus Boots +1"
		}
		
		sets.midcast.Curagas =
		{-- Cure Potency/II: 60%/26%			Enmity: -61		Healing Magic Skill: +26(521)	MND+201
			main="Raetic Rod +1", sub="Ammurapi Shield", ammo="Pemphredo Tathlum",
			head="Kaykaus Mitra +1", neck="Clr. Torque +2", lear="Glorious Earring", rear="Mendi. Earring",
			body="Theo. Briault +3", hands="Theophany Mitts +3", lring="Mephitas's Ring +1", rring={name="Stikini Ring +1", bag="wardrobe3"},
			back="Fi Follet Cape +1", waist="Shinjutsu-no-Obi +1", legs="Ebers Pant. +1", feet="Kaykaus Boots +1"
		}
		
		sets.midcast.Curas =
		{-- Cure Potency/II: 50%/16%			Enmity: -74		Healing Magic Skill: +37(513)	MND+171
			main="Asclepius", sub="Chanter's Shield", ammo="Hasty Pinion +1",
			head="Kaykaus Mitra +1", neck="Clr. Torque +2", lear="Glorious Earring", rear="Mendi. Earring",
			body="Theo. Briault +3", hands="Theophany Mitts +3", lring="Lebeche Ring", rring="Weather. Ring +1",
			back="Alaunus's Cape", waist="Witful Belt", legs="Sifahir Slacks", feet="Kaykaus Boots +1"
		}

--[[		CURSNA FORMULA
		R = (10 + s/30)*(1 + c/100)*(1 + r/100)

		s - Healing magic skill
		c - Cursna success rate+
		r - Cursna received success rate+
]]
		
		sets.midcast.Cursna =
		{--	(10 + 612/30)*(1 + 116/100) =		65.664% Success Rate
			main="Yagrush", sub="Chanter's Shield", ammo="Hasty Pinion +1",
			head="Vanya Hood", neck="Debilis Medallion", lear="Beatific Earring", rear="Meili Earring",
			body="Ebers Bliaud +1", hands="Fanatic Gloves", lring="Haoma's Ring", rring="Menelaus's Ring",
			back="Fi Follet Cape +1", waist="Bishop's Sash", legs="Th. Pant. +3", feet="Vanya Clogs"
		}

		sets.midcast.StatusRemoval =
		{
			main="Yagrush", sub="Chanter's Shield", ammo="Hasty Pinion +1",
			head="Bunzi's Hat", neck="Clr. Torque +2", lear="Loquac. Earring", rear="Malignance Earring",
			body="Pinga Tunic +1", hands="Fanatic Gloves", lring="Lebeche Ring", rring="Weather. Ring +1",
			back="Fi Follet Cape +1", waist="Witful Belt", legs="Ebers Pant. +1", feet="Volte Gaiters"
		}
		
		sets.midcast.Esuna = set_combine(sets.midcast.FC,
		{--		Fast Cast: 72%		Haste: 24%
			main="Asclepius"
		})

		sets.midcast['Healing Magic'] =
		{
			main="Asclepius", sub="Chanter's Shield", ammo="Hasty Pinion +1",
			head="Bunzi's Hat", neck="Clr. Torque +2", lear="Loquac. Earring", rear="Malignance Earring",
			body="Pinga Tunic +1", hands="Fanatic Gloves", lring="Kishar Ring", rring="Weather. Ring +1",
			back="Fi Follet Cape +1", waist="Witful Belt", legs="Volte Brais", feet="Volte Gaiters"
		}

	--------------------------------------
	-- Buffing Midcast sets
	--------------------------------------	
		
		sets.midcast.Stoneskin = set_combine(sets.midcast.Duration,
		{
			neck="Stone Gorget", lear="Earthcry Earring",
			back="Alaunus's Cape", waist="Siegel Sash", legs="Shedir Seraweels"
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
			head="Ebers Cap +1", neck="Incanter's Torque", lear="Andoaa Earring", rear="Mimir Earring",
			body="Ebers Bliaud +1", hands="Ebers Mitts +1", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back="Fi Follet Cape +1", waist="Embla Sash", legs="Piety Pantaln. +3", feet="Ebers Duckbills +1"
		}

		sets.midcast.BarStatus = set_combine(sets.midcast.Duration,
		{
			neck="Incanter's Torque", lear="Andoaa Earring", rear="Mimir Earring",
			hands="Dynasty Mitts",  lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			waist="Embla Sash"
		})

		sets.midcast.BoostStat =
		{
			main="Gada", sub="Ammurapi Shield", ammo="Pemphredo Tathlum",
			head=gear.ENH_Head, neck="Incanter's Torque", lear="Andoaa Earring", rear="Mimir Earring",
			body=gear.ENH_Body, hands="Dynasty Mitts", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back="Fi Follet Cape +1", waist="Embla Sash", legs=gear.ENH_Legs, feet="Theo. Duckbills +3"
		}

		sets.midcast.Enhancement = 
		{
			main="Gada", sub="Ammurapi Shield", ammo="Pemphredo Tathlum",
			head=gear.ENH_Head, neck="Incanter's Torque", lear="Andoaa Earring", rear="Mimir Earring",
			body=gear.ENH_Body, hands="Dynasty Mitts", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back="Fi Follet Cape +1", waist="Embla Sash", legs=gear.ENH_Legs, feet="Theo. Duckbills +3"
		}

		sets.midcast.Regen =
		{--(Regen IV	40/tick		120s		1600 HP)	Potency: +76%	Duration: +46	/ +10%(+10%)		
		 --			70/tick		200s	=	4620 HP
			main="Gada", sub="Ammurapi Shield", ammo="Pemphredo Tathlum",
			head="Inyanga Tiara +2", neck="Incanter's Torque", lear="Gwati Earring", rear="Mendi. Earring",
			body="Piety Briault +3", hands="Ebers Mitts +1", lring="Kishar Ring", rring="Weather. Ring +1",
			back="Fi Follet Cape +1", waist="Embla Sash", legs="Th. Pant. +3", feet="Theo. Duckbills +3"
		}

		sets.midcast.Refresh = sets.midcast.Duration

		sets.midcast.Statless = sets.midcast.Duration

		sets.midcast.Storm = sets.midcast.Duration

		sets.midcast.Protection = set_combine(sets.midcast.Duration,
		{
			ammo="Pemphredo Tathlum",
			neck="Incanter's Torque", lear="Gwati Earring", rear="Mendi. Earring",
			lring="Mephitas's Ring +1",
			back="Fi Follet Cape +1",
		})
		sets.midcast.Teleport = sets.midcast.ConserveMP
		
		sets.midcast.Utsusemi = sets.midcast.FC


	--------------------------------------
	-- Offensive Midcast sets
	--------------------------------------    
	
	---Enfeebling Magic	
		sets.midcast.Macc =
		{
			main="Asclepius", sub="Ammurapi Shield", ammo="Pemphredo Tathlum",
			head="Theophany Cap +3", neck="Incanter's Torque", lear="Regal Earring", rear="Malignance Earring", 
			body="Theo. Briault +3", hands="Kaykaus Cuffs +1", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring="Metamor. Ring +1",
			back="Aurist's Cape +1", waist="Sacro Cord", legs="Th. Pant. +3", feet="Theo. Duckbills +3"
		}
		
		sets.midcast['Enfeebling Magic'] = set_combine(sets.midcast.Macc,
		{
			main="Contemplator +1", sub="Enki Strap",
			head=empty,
			body="Cohort Cloak +1", lring="Kishar Ring", rring={name="Stikini Ring +1", bag="wardrobe3"},
			legs="Chironic Hose"
		})

		sets.midcast.Static = set_combine(sets.midcast['Enfeebling Magic'],
		{
			hands="Regal Cuffs", lring="Kishar Ring"
		})
		
		sets.midcast.Dispelga = set_combine(sets.midcast['Enfeebling Magic'],
		{
			main="Daybreak"
		})
		
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
			lear="Mani Earring",
			rring={name="Stikini Ring +1", bag="wardrobe3"},
			body="Shango Robe"
		})

		sets.midcast.Sap = set_combine(sets.midcast['Dark Magic'],
		{
			main="Rubicundity",
			head="Pixie Hairpin +1",
			body="Shango Robe", hands="Inyan. Dastanas +2", lring="Archon Ring", rring="Evanescence Ring",
			waist="Fucho-no-Obi"
		})
		
		
	-- Elemental Magic	
		sets.midcast.Brightness =
		{
			main="Daybreak", sub="Ammurapi Shield", ammo="Pemphredo Tathlum",
			head=empty, neck="Sanctity Necklace", lear="Regal Earring", rear="Malignance Earring",
			body="Cohort Cloak +1", hands="Fanatic Gloves", lring="Metamor. Ring +1", rring="Weather. Ring +1",
			back="Aurist's Cape +1", waist="Sacro Cord", legs="Kaykaus Tights +1", feet="Bunzi's Sabots"
		}

		sets.midcast['Elemental Magic'] = set_combine(sets.midcast.Brightness,
		{
			main="Marin Staff +1", sub="Niobid Strap",
			lring="Freke Ring", rring={name="Shiva Ring +1", bag="wardrobe3"}
		})
		
		sets.midcast.Impact = set_combine(sets.midcast.Macc,
		{
			head=empty,
			body="Twilight Cloak", lring="Archon Ring"
		})
		
		sets.magic_burst =
		{
			main="Daybreak", sub="Ammurapi Shield", ammo="Pemphredo Tathlum",
			head=empty, neck="Mizu. Kubikazari", lear="Static Earring", rear="Malignance Earring",
			body="Cohort Cloak +1", hands="Bunzi's Gloves", lring="Mujin Band", rring="Metamor. Ring +1",
			back="Aurist's Cape +1", waist="Sacro Cord", legs="Bunzi's Pants", feet="Bunzi's Sabots"
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
		{-- 	DT: -6%		|	PDT: -28%	| 	MDT: -6%	|	Refresh: 13 	| 	Regen: 3
			main="Daybreak", sub="Genmei Shield", ammo="Homiliary",
			head="Volte Beret", neck="Sanctity Necklace", lear="Dawn Earring", rear="Infused Earring",
			body="Shamash Robe", hands="Chironic Gloves", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back="Moonlight Cape", waist="Carrier's Sash", legs="Volte Brais", feet="Chironic Slippers"
		}
		
		sets.idle.DT =
		{-- 	DT: -46%	|	PDT: -66% 	| 	MDT:-57%	|	Refresh: 4		| 	Regen: 0
			main="Asclepius", sub="Genmei Shield", ammo="Staunch Tathlum +1",
			head="Inyanga Tiara +2", neck="Warder's Charm +1", lear="Odnowa Earring +1", rear="Tuisto Earring", 
			body="Shamash Robe", hands="Inyan. Dastanas +2", lring="Defending Ring", rring="Shadow Ring",
			back="Shadow Mantle", waist="Carrier's Sash", legs="Bunzi's Pants", feet="Bunzi's Sabots"
		}
		
		sets.idle.MEVA =
		{-- 	DT: -36%	|	PDT: -66% 	| 	MDT:-52%	|	Refresh: 4		| 	Regen: 0
			main="Asclepius", sub="Genmei Shield", ammo="Staunch Tathlum +1",
			head="Inyanga Tiara +2", neck="Warder's Charm +1", lear="Odnowa Earring +1", rear="Sanare Earring", 
			body="Shamash Robe", hands="Inyan. Dastanas +2", lring="Purity Ring", rring="Shadow Ring",
			back="Alaunus's Cape", waist="Carrier's Sash", legs="Bunzi's Pants", feet="Bunzi's Sabots"
		}

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
		{-- 	DT: -40%	|	PDT: -60% 	| 	MDT:-51%
			main="Asclepius", sub="Genmei Shield", ammo="Staunch Tathlum +1",
			head="Bunzi's Hat", neck="Warder's Charm +1", lear="Odnowa Earring +1", rear="Tuisto Earring",
			body="Bunzi's Robe", hands="Bunzi's Gloves", lring="Defending Ring", rring="Shadow Ring",
			back="Shadow Mantle", waist="Carrier's Sash", legs="Bunzi's Pants", feet="Hippo. Socks +1"
		}
		
		sets.defense.MEVA = 
		{-- 	DT: -33%	|	PDT: -63% 	| 	MDT:-48%
			main="Asclepius", sub="Genmei Shield", ammo="Staunch Tathlum +1",
			head="Bunzi's Hat", neck="Warder's Charm +1", lear="Eabani Earring", rear="Sanare Earring",
			body="Bunzi's Robe", hands="Raetic Bangles +1", lring="Purity Ring", rring="Shadow Ring",
			back="Alaunus's Cape", waist="Carrier's Sash", legs="Bunzi's Pants", feet="Bunzi's Sabots"
		}

		sets.defense.MDT = 
		{-- 	DT: -52%	|	PDT: -72% 	| 	MDT:-59%
			main="Asclepius", sub="Genmei Shield", ammo="Staunch Tathlum +1",
			head="Bunzi's Hat", neck="Warder's Charm +1", lear="Odnowa Earring +1", rear="Sanare Earring",
			body="Bunzi's Robe", hands="Raetic Bangles +1", lring="Defending Ring", rring="Shadow Ring",
			back="Moonlight Cape", waist="Carrier's Sash", legs="Bunzi's Pants", feet="Bunzi's Sabots"
		}
	
	
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
		
		sets.TreasureHunter =
		{
			ammo="Per. Lucky Egg",
			head="Chironic Hat",
			waist="Chaac Belt",
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
			ammo="Hasty Pinion +1",
			head="Blistering Sallet +1", neck="Fotia Gorget", lear="Brutal Earring", rear="Ishvara Earring",
			body="Bunzi's Robe", hands="Gazu Bracelet +1", lring="Shukuyu Ring", rring="Epaminondas's Ring",
			back="Aurist's Cape +1", waist="Fotia Belt", legs="Bunzi's Pants", feet="Bunzi's Sabots"
		}
		
		sets.precast.WS['Dagan'] =
		{
			head="Kaykaus Mitra +1", neck="Sanctity Necklace", lear="Loquac. Earring", rear="Moonshade Earring",
			body="Kaykaus Bliaut +1", hands="Kaykaus Cuffs +1", lring="Lebeche Ring", rring="Metamor. Ring +1",
			back="Fi Follet Cape +1", waist="Shinjutsu-no-Obi +1", legs="Piety Pantaln. +3", feet="Kaykaus Boots +1"
		}
		
		sets.precast.WS['Starlight'] = set_combine(sets.precast.WS['Dagan'],
		{
			neck="Combatant's Torque"
		})
		
		sets.precast.WS['Moonlight'] = sets.precast.WS['Starlight']
		
		sets.precast.WS['Mystic Boon'] = set_combine(sets.precast.WS,
		{
			lear="Regal Earring", rear="Moonshade Earring",
			body="Piety Briault +3", hands="Theophany Mitts +3", lring="Metamor. Ring +1",
			legs="Piety Pantaln. +3"
		})
		
		sets.precast.WS['Flash Nova'] = 
		{
			ammo="Pemphredo Tathlum",
			head=empty, neck="Sanctity Necklace", lear="Regal Earring", rear="Malignance Earring",
			body="Cohort Cloak +1", hands="Fanatic Gloves", rring="Epaminondas's Ring", rring="Weather. Ring +1",
			back="Aurist's Cape +1", waist="Orpheus's Sash", legs="Kaykaus Tights +1", feet="Bunzi's Sabots"
		}
		
	
	--------------------------------------
	-- Melee sets
	--------------------------------------
		
		sets.engaged =
		{
			ammo="Hasty Pinion +1",
			head="Blistering Sallet +1", neck="Combatant's Torque", lear="Telos Earring", rear={name="Mache Earring +1", bag="wardrobe3"},
			body="Bunzi's Robe", hands="Gazu Bracelet +1", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"},
			back="Aurist's Cape +1",  waist="Windbuffet Belt +1", legs="Bunzi's Pants", feet="Bunzi's Sabots"
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
	
	if (spellMap == 'Cures' or spellMap == 'Curagas' or spellMap ==  'Curas') then
        if (state.WeaponLock.value and player.equipment.sub ~= "Raetic Rod +1") and (spellMap == 'Curagas' or spellMap == 'Cures') then
			equip 
			{ 
				hands="Kaykaus Cuffs +1",
				legs="Sifahir Slacks"
			}
		end
		
		if (spellMap == 'Cures' and buffactive['Afflatus Solace']) then
			equip
				{
					back="Alaunus's Cape", body="Ebers Bliaud +1"
				}
		end
		
		if (spell.element == world.day_element or (spell.element == world.weather_element and get_weather_intensity() == 1)
				or (spell.element == world.weather_element and get_weather_intensity() == 2 and world.day_element == elements.strong_to[spell.element])) then
			if (spellMap == 'Cures' and buffactive['Afflatus Solace']) then
				equip
				{
					waist="Hachirin-no-Obi"
				}
			else
				equip
				{
					back="Twilight Cape", waist="Hachirin-no-Obi"
				}
			end
		end
		
		if spell.target.type =='SELF' and spellMap == 'Cures' then 
			equip 
			{ 
				waist="Gishdubar Sash"
			}
		end
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
	
	if (spellMap ==  'BoostStat' or spellMap == 'BarStatus') and buffactive['Light Arts'] then
		equip{ hands=gear.ENH_Gloves }
	end
	
	if (spell.skill == 'Elemental Magic' or spellMap ==  'Brightness') and state.MagicBurst.value then
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
				lring="Locus Ring", rring="Archon Ring",
				legs="Bunzi's Pants"
			})
		elseif spell.element == 'Light' then
			equip(
			{
				main="Daybreak", sub="Ammurapi Shield",
				neck="Mizu. Kubikazari", lear="Static Earring",
				lring="Locus Ring", rring="Weather. Ring +1",
				legs="Bunzi's Pants"
			})
		else
			equip(
			{
				main="Maxentius", sub="Ammurapi Shield",
				neck="Mizu. Kubikazari", lear="Static Earring",
				lring="Locus Ring", rring="Archon Ring",
				legs="Bunzi's Pants"
			})
		end
	end
	
	if (spell.skill == 'Elemental Magic' or spellMap == 'Brightness') and (spell.element ~= world.day_element and spell.element ~= world.weather_element) then
		if spell.target.distance < (15 - spell.target.model_size) then
			equip { waist="Orpheus's Sash" }
		end
	elseif (spell.skill == 'Elemental Magic' or spellMap == 'Brightness') and (spell.element == world.day_element and spell.element == world.weather_element)
			or (spell.element == world.weather_element and get_weather_intensity() == 2 and world.day_element ~= elements.strong_to[spell.element]) then
		if spellMap ~= 'Helix' then
			equip { waist="Hachirin-no-Obi" }
		elseif spell.target.distance < (15 - spell.target.model_size) then
			equip { waist="Orpheus's Sash" }
		end
	elseif (spell.skill == 'Elemental Magic' or spellMap == 'Brightness') and (spell.element == world.day_element or (spell.element == world.weather_element and get_weather_intensity() == 1)
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
	if buff == "Sublimation: Activated" and state.DefenseMode.value == 'None' then
		handle_equipping_gear(player.status)
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
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function customize_idle_set(idleSet)
	if state.Buff['Sublimation: Activated'] and state.IdleMode.value == 'None' and state.DefenseMode.value == 'None' then
		idleSet = set_combine(idleSet, 
		{
			waist="Embla Sash"
		})
	end
	
	if player.mpp < 51 and state.IdleMode.value ~= 'DT' and state.DefenseMode.value == 'None' then
		idleSet = set_combine(idleSet, 
			{
				waist="Fucho-no-Obi"
			})
	end

	return idleSet
end


-- Function to display the current relevant user state when doing an update.
function display_current_job_state(eventArgs)
	display_current_caster_state()
	eventArgs.handled = true
end


-------------------------------------------------------------------------------------------------------------------
-- User self-commands.
-------------------------------------------------------------------------------------------------------------------


function job_self_command(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'barele' then
        send_command('@input /ma '..state.BarElement.current..' <me>')
    elseif cmdParams[1]:lower() == 'barstat' then
		 send_command('@input /ma "'..state.BarStatus.current..'" <me>')
    elseif cmdParams[1]:lower() == 'boost' then
		 send_command('@input /ma "'..state.Boost.current..'" <me>')
	end
end



-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function apply_job_change()
	set_macro_page(1, 3)
	
	send_command('wait 3; input /lockstyleset 3')
end