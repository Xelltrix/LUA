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

	include('Mote-TreasureHunter')

	customize_idle_set()
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	state.OffenseMode:options('Normal','Luopan','Refresh')
	state.CastingMode:options('Normal','Resistant')
	state.IdleMode:options('Normal','DT')
	state.PhysicalDefenseMode:options('PDMaster','PDPet')
	state.MagicalDefenseMode:options('MEVA','MDT')
	
	if player.sub_job == 'WHM' then
		state.BarElement = M{['description']='BarElement', 'Barfira', 'Barblizzara', 'Baraera', 'Barstonra', 'Barthundra', 'Barwatera'}
		state.BarStatus = M{['description']='BarStatus', 'Baramnesra', 'Barvira', 'Barparalyzra', 'Barsilencera', 'Barpetra', 'Barpoisonra', 'Barblindra', 'Barsleepra'}
	elseif player.sub_job == 'RDM' then
		state.BarElement = M{['description']='BarElement', 'Barfire', 'Barblizzard', 'Baraero', 'Barstone', 'Barthunder', 'Barwater'}
		state.BarStatus = M{['description']='BarStatus', 'Baramnesia', 'Barvirus', 'Barparalyze', 'Barsilence', 'Barpetrify', 'Barpoison', 'Barblind', 'Barsleep'}
	end
	
	send_command('bind ^= gs c cycle treasuremode')

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

		sets.precast.JA['Bolster'] = { body="Bagua Tunic +3" }

		sets.precast.JA['Full Circle'] =
		{
			head="Azimuth Hood +1",
			hands="Bagua Mitaines +3"
		}
		
		sets.precast.JA['Life Cycle'] = 
		{ 
			head="Bagua Galero +3",
			body="Geomancy Tunic +3",
			back=gear.GEOCape_Luopan
		}
		
		sets.precast.JA['Radial Arcana'] = 
		{ 
			head="Bagua Galero +3",
			body="Bagua Tunic +3",
			feet="Bagua Sandals +3" 
		}
		
	
	-------------------
	-- Precast Magic --
	------------------- 
		sets.precast.FC =
		{--Fast Cast 90
			main="Solstice", sub="Chanter's Shield", ammo="Sapience Orb",
			head="Amalric Coif +1", neck="Orunmila's Torque", lear="Loquac. Earring", rear="Malignance Earring",
			body=gear.FCJubbah, hands=gear.FCHands, lring="Lebeche Ring", rring="Weather. Ring +1",
			back="Fi Follet Cape +1", waist="Witful Belt", legs="Geomancy Pants +3", feet="Volte Gaiters"
		}

		sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC)
		
		sets.precast.FC.Geomancy =
		{--Fast Cast 91
			main="Solstice", sub="Chanter's Shield", range="Dunna", ammo=empty,
			head="Amalric Coif +1", neck="Orunmila's Torque", lear="Loquac. Earring", rear="Malignance Earring",
			body=gear.FCJubbah, hands=gear.FCHands, lring="Lebeche Ring", rring="Weather. Ring +1",
			back="Fi Follet Cape +1", waist="Witful Belt", legs="Geomancy Pants +3", feet="Volte Gaiters"
		}

		sets.precast.FC.Stoneskin = sets.precast.FC['Enhancing Magic']
		
		sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC,
		{
			hands="Bagua Mitaines +3"
		})

		sets.precast.FC.Impact = set_combine(sets.precast.FC['Elemental Magic'],
		{--Fast Cast 64
			range="Dunna", ammo=empty,
			head=empty,
			body="Twilight Cloak",
			feet=gear.FCCrackows
		})

		sets.precast.FC.Cures = sets.precast.FC

		sets.precast.FC.Curagas = sets.precast.FC.Cures
		
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
		{
			ammo="Hasty Pinion +1",
			lring="Kishar Ring"
		})

		sets.midcast.Duration =
		{ --1.5 x 1.16 Duration Bonus
			main="Gada", sub="Ammurapi Shield", ammo="Sapience Orb",
			head=gear.ENH_Head, neck="Orunmila's Torque", lear="Loquac. Earring", rear="Malignance Earring",
			body=gear.ENH_Body, hands=gear.ENH_Gloves, lring="Kishar Ring", rring="Weather. Ring +1",
			back="Fi Follet Cape +1", waist="Embla Sash", legs=gear.ENH_Legs, feet="Telchine Pigaches"
		}

		sets.midcast['Enhancing Magic'] =
		{
			main="Gada", sub="Ammurapi Shield", ammo="Pemphredo Tathlum",
			head=gear.ENH_Head, neck="Incanter's Torque", lear="Andoaa Earring", rear="Mimir Earring",
			body=gear.ENH_Body, hands=gear.ENH_Gloves, lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back="Fi Follet Cape +1", waist="Olympus Sash", legs=gear.ENH_Legs, feet="Telchine Pigaches"
		}
	
		sets.midcast.ConserveMP = 
		{
			main="Solstice", sub="Ammurapi Shield", ammo="Pemphredo Tathlum",
			head="Vanya Hood", neck="Incanter's Torque", lear="Gwati Earring", rear="Mendi. Earring",
			body="Amalric Doublet +1", hands=gear.FCHands, lring="Mephitas's Ring +1", rring="Weather. Ring +1",
			back="Fi Follet Cape +1", waist="Shinjutsu-no-Obi +1", legs="Lengo Pants", feet="Medium's Sabots"
		}

	--------------------------------------
	-- Healing Midcast sets
	--------------------------------------	
	
		sets.midcast.Cures =
		{-- Cure Potency/II: 50%/10%			Enmity: -29		Healing Magic Skill: +24(500)	MND+197
			main="Raetic Rod +1", sub="Sors Shield", ammo="Esper Stone +1",
			head="Vanya Hood", neck="Incanter's Torque", lear="Meili Earring", rear="Novia Earring",
			body="Vanya Robe", hands="Vanya Cuffs", lring="Lebeche Ring", rring="Kuchekula Ring",
			back="Oretan. Cape +1", waist="Bishop's Sash", legs="Vanya Slops", feet="Vanya Clogs"
		}
		
		sets.midcast.CuresLocked =
		{--Cure Potency: 49%
			ammo="Esper Stone +1",
			head="Vanya Hood", neck="Incanter's Torque", lear="Meili Earring", rear="Mendi. Earring",
			body="Vanya Robe", hands=gear.ENH_Gloves, lring="Lebeche Ring", rring="Menelaus's Ring",
			back="Oretan. Cape +1", waist="Bishop's Sash", legs="Vanya Slops", feet="Medium's Sabots"
		}
		
		sets.midcast.CuresWeather =
		{
			rear="Mendi. Earring",
			rring="Menelaus's Ring",
			back="Twilight Cape", waist="Hachirin-no-Obi"
		}

		sets.midcast.Curagas = sets.midcast.Cures

		sets.midcast.StatusRemoval = sets.midcast.FC

		sets.midcast.Cursna = 
		{--	(10 + 605/30)*(1 + 116/100) =		65.16% Success Rate
			main="Gada", sub="Chanter's Shield", ammo="Sapience Orb",
			head="Vanya Hood", neck="Debilis Medallion", lear="Meili Earring", rear="Beatific Earring",
			body="Vanya Robe", hands="Hieros Mittens", lring="Haoma's Ring", rring="Menelaus's Ring",
			back="Oretan. Cape +1", waist="Bishop's Sash", legs="Vanya Slops", feet="Vanya Clogs"
		}
		
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
			main="Gada"
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
		
		sets.midcast.Geomancy = 
		{--		Geomancy+Handbell: 904	Conserve MP: 57%
			main="Idris", sub="Chanter's Shield", range="Dunna", ammo=empty,
			head="Azimuth Hood +1", neck="Bagua Charm +1", lear="Loquac. Earring", rear="Mendi. Earring",
			body="Amalric Doublet +1", hands="Shrieker's Cuffs", lring="Mephitas's Ring +1", rring={name="Stikini Ring +1", bag="wardrobe3"},
			back="Fi Follet Cape +1", waist="Shinjutsu-no-Obi +1", legs="Azimuth Tights +1", feet="Medium's Sabots"
		}
		
		sets.midcast.Indicolure =
		{--		Geomancy+Handbell: 902	Conserve MP: 53%
			main="Idris", sub="Chanter's Shield", range="Dunna", ammo=empty,
			head="Vanya Hood", neck="Incanter's Torque", lear="Gwati Earring", rear="Mendi. Earring",
			body="Amalric Doublet +1", hands="Shrieker's Cuffs", lring="Mephitas's Ring +1", rring="Weather. Ring +1",
			back="Lifestream Cape", waist="Shinjutsu-no-Obi +1", legs="Bagua Pants +3", feet="Azimuth Gaiters +1"
		}
	
	--------------------------------------
	-- Offensive Midcast sets
	--------------------------------------   
	
	
	---Enfeebling
		sets.midcast.Macc =
		{
			main="Daybreak", sub="Ammurapi Shield", ammo="Pemphredo Tathlum",
			head=empty, neck="Bagua Charm +1", lear="Regal Earring", rear="Malignance Earring",
			body="Cohort Cloak +1", hands="Geo. Mitaines +3", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring="Metamor. Ring +1",
			back="Aurist's Cape +1", waist="Acuity Belt +1", legs="Geomancy Pants +3", feet="Geo. Sandals +3"
		}
	
		sets.midcast['Enfeebling Magic'] = set_combine(sets.midcast.Macc,
		{
			main="Contemplator +1", sub="Enki Strap",
			neck="Incanter's Torque",
			lring="Kishar Ring", hands="Regal Cuffs",
			feet="Bagua Sandals +3"
		})
	
		sets.midcast['Enfeebling Magic'].Resistant = sets.midcast.Macc
		
		sets.midcast.Dispelga = set_combine(sets.midcast['Enfeebling Magic'].Resistant,
		{
			main="Daybreak", sub="Ammurapi Shield"
		})

		sets.midcast.ElementalDebuffs = set_combine(sets.midcast.Macc,
		{
			neck="Incanter's Torque",
			hands="Amalric Gages +1", rring={name="Stikini Ring +1", bag="wardrobe3"},
		})

	
	---Dark Magic
		sets.midcast['Dark Magic'] = set_combine(sets.midcast.Macc,
		{
			head="C. Palug Crown", neck="Erra Pendant", lear="Mani Earring",
			body="Geomancy Tunic +3",
			waist="Fucho-no-Obi", legs="Azimuth Tights +1",
		})

		sets.midcast.Sap = set_combine(sets.midcast['Dark Magic'],
		{
			main="Rubicundity", sub="Ammurapi Shield",
			head="Pixie Hairpin +1", rear="Hirudinea Earring",
			lring="Archon Ring", rring="Evanescence Ring", 
			feet=gear.SapCrackows
		})
		
		sets.midcast.Sap.Resistant = set_combine(sets.midcast.Sap,
		{
			head="Bagua Galero +3"
		})
		
		sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'],
		{
			neck="Orunmila's Torque",
			body="Shango Robe",
			back="Lifestream Cape", waist="Witful Belt", feet="Volte Gaiters"
		})
	
		sets.midcast.Stun.Resistant = sets.midcast.Macc

	-- Elemental Magic
		sets.midcast['Elemental Magic'] =
		{
			main="Marin Staff +1", sub="Niobid Strap", ammo="Ghastly Tathlum +1",
			head="Bagua Galero +3", neck="Saevus Pendant +1", lear="Regal Earring", rear="Malignance Earring",
			body="Amalric Doublet +1", hands="Amalric Gages +1", lring="Freke Ring", rring="Metamor. Ring +1",
			back=gear.GEOCape_Nuke, waist="Sacro Cord", legs="Amalric Slops +1", feet="Amalric Nails +1"
		}

		sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'],
		{
			ammo="Pemphredo Tathlum",
			head=empty, neck="Sanctity Necklace",
			body="Cohort Cloak +1",
			waist="Sacro Cord", legs="Merlinic Shalwar", feet="Bagua Sandals +3"
		})
		
		sets.midcast.MDMG = set_combine(sets.midcast['Elemental Magic'],
		{
			ammo="Ghastly Tathlum +1",
			head="Mall. Chapeau +2",
			rring="Shiva Ring +1",
		})
		
		sets.midcast.MDMG.Resistant = sets.midcast['Elemental Magic'].Resistant

		sets.midcast.Impact = set_combine(sets.midcast.Macc,
		{
			head=empty,
			body="Twilight Cloak",
			rring="Archon Ring",
		})
		
		sets.magic_burst =
		{--MB/II: 39/35
			main="Marin Staff +1", sub="Niobid Strap", ammo="Ghastly Tathlum +1",
			head="Ea Hat +1", neck="Mizu. Kubikazari", lear="Regal Earring", rear="Malignance Earring",
			body="Ea Houppe. +1", hands="Amalric Gages +1", lring="Locus Ring", rring="Mujin Band",
			back=gear.GEOCape_Nuke, waist="Sacro Cord", legs="Ea Slops +1", feet="Amalric Nails +1"
		}

		sets.magic_burst.Resistant = set_combine(sets.magic_burst,
		{--MBD/II: 42/34
			ammo="Pemphredo Tathlum",
			hands="Ea Cuffs +1", lring="Metamor. Ring +1",
			feet="Ea Pigaches +1"
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
		{--Regen+3 | Refresh+9 | PDT/MDT: (21/9)
			main="Daybreak", sub="Genmei Shield", ammo="Staunch Tathlum +1",
			head="Volte Beret", neck="Sanctity Necklace", lear="Dawn Earring", rear="Infused Earring",
			body="Shamash Robe", hands="Bagua Mitaines +3", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back="Moonlight Cape", waist="Carrier's Sash", legs="Volte Brais", feet="Geo. Sandals +3"
		}

		sets.idle.DT =
		{--Refresh+6 | PDT/MDT: (51/14)
			main="Daybreak", sub="Genmei Shield", ammo="Staunch Tathlum +1",
			head="Hike Khat +1", neck="Warder's Charm +1", lear="Odnowa Earring +1", rear="Genmei Earring",
			body="Shamash Robe", hands="Bagua Mitaines +3", lring="Defending Ring", rring="Shadow Ring",
			back="Moonlight Cape", waist="Carrier's Sash", legs="Volte Brais", feet="Geo. Sandals +3"
		}
		
		sets.idle.Luopan =
		{--Refresh+6 | PDT/MDT: (15/3)	[Luopan: Regen+24 | DT: -40% | Abs. Dmg. Tkn. +8%]
			main="Idris", sub="Genmei Shield", ammo="Staunch Tathlum +1",
			head=gear.Pet_Head, neck="Bagua Charm +1", lear="Sanare Earring", rear="Lugalbanda Earring",
			body="Shamash Robe", hands=gear.Pet_Hands, lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back=gear.GEOCape_Luopan, waist="Isa Belt", legs=gear.Pet_Legs, feet="Bagua Sandals +3"
		}	

		sets.idle.DT.Luopan =
		{--Refresh+5 | PDT/MDT: (13/3)	[Luopan: Regen+30 | DT: -39% | Abs. Dmg. Tkn. +8%]
			main="Idris", sub="Genmei Shield", ammo="Staunch Tathlum +1",
			head=gear.Pet_Head, neck="Bagua Charm +1", lear="Genmei Earring", rear="Lugalbanda Earring",
			body="Shamash Robe", hands=gear.Pet_Hands, lring="Defending Ring", rring="Gelatinous Ring +1",
			back=gear.GEOCape_Luopan, waist="Isa Belt", legs=gear.Pet_Legs, feet="Bagua Sandals +3"
		}
	
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
	
		sets.defense.PDMaster =
		{--PDT: 54 / MDT: 22
			main="Daybreak", sub="Genmei Shield", ammo="Staunch Tathlum +1",
			head="Hike Khat +1", neck="Warder's Charm +1", lear="Odnowa Earring +1", rear="Lugalbanda Earring",
			body="Shamash Robe", hands="Volte Bracers", lring="Defending Ring", rring="Purity Ring",
			back="Shadow Mantle", waist="Carrier's Sash", legs="Artsieq Hose", feet="Hippo. Socks +1"
		}
		
		sets.defense.PDPet =
		{--PDT: 51 / MDT: 22		Pet DT: 41 / Regen: 27
			main="Idris", sub="Genmei Shield", ammo="Staunch Tathlum +1",
			head="Hike Khat +1", neck="Bagua Charm +1",  lear="Odnowa Earring +1", rear="Genmei Earring",
			body="Shamash Robe", hands=gear.Pet_Hands, lring="Defending Ring", rring="Purity Ring",
			back=gear.GEOCape_Luopan, waist="Isa Belt", legs=gear.Pet_Legs, feet="Bagua Sandals +3"
		}
		
		sets.defense.MEVA = 
		{--PDT: 42 / MDT: 24
			main="Daybreak", sub="Genmei Shield", ammo="Staunch Tathlum +1",
			head="Volte Beret", neck="Warder's Charm +1", lear="Odnowa Earring +1", rear="Lugalbanda Earring",
			body="Shamash Robe", hands="Raetic Bangles +1", lring="Defending Ring", rring="Shadow Ring",
			back="Moonlight Cape", waist="Carrier's Sash", legs="Volte Brais", feet="Volte Gaiters"
		}
		
		sets.defense.MDT = 
		{--PDT: 39 / MDT: 52
			main="Daybreak", sub="Genmei Shield", ammo="Staunch Tathlum +1",
			head="Vanya Hood", neck="Loricate Torque +1", lear="Odnowa Earring +1", rear="Etiolation Earring",
			body="Vanya Robe", hands="Raetic Bangles +1", lring="Defending Ring", rring="Purity Ring",
			back="Moonlight Cape", waist="Carrier's Sash", legs="Vanya Slops", feet="Vanya Clogs"
		}

	--------------------------------------
	-- Special Sets
	--------------------------------------

		sets.Kiting = { ffeet="Geo. Sandals +3" }

		sets.buff.Doom = 
		{
			neck="Nicander's Necklace",
			lring={name="Eshmun's Ring", bag="wardrobe2"}, rring={name="Eshmun's Ring", bag="wardrobe3"},
			waist="Gishdubar Sash"
		}
		
		sets.TreasureHunter =
		{
			head="Per. Lucky Egg",
			hands="Volte Bracers",
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
			ammo="Hasty Pinion +1",
			head="Blistering Sallet +1", neck="Fotia Gorget", lear="Ishvara Earring", rear="Moonshade Earring",
			body="Jhakri Robe +2", hands="Jhakri Cuffs +2", lring="Shukuyu Ring", rring="Epaminondas's Ring",
			back="Aurist's Cape +1", waist="Fotia Belt", legs="Jhakri Slops +2", feet="Jhakri Pigaches +2"
		}
		
		--Physical Club
		sets.precast.WS['Exudation'] = set_combine(sets.precast.WS,
		{
			rear="Regal Earring",
			lring="Metamor. Ring +1",
			waist="Sacro Cord"
		})
		
		sets.precast.WS['Realmralzer'] = set_combine(sets.precast.WS,
		{
			lear="Regal Earring", rear="Malignance Earring",
			lring={name="Stikini Ring +1", bag="wardrobe2"}
		})
		
		sets.precast.WS['Hexa Strike'] = set_combine(sets.precast.WS,
		{
			lear="Telos Earring", rear={name="Mache Earring +1", bag="wardrobe3"},
		})
		
		sets.precast.WS['True Strike'] = sets.precast.WS
		
		sets.precast.WS['Brainshaker'] = sets.precast.WS['True Strike']
		
		sets.precast.WS['Skullbreaker'] = sets.precast.WS['True Strike']
		
		sets.precast.WS['Judgment'] = set_combine(sets.precast.WS,
		{
			lear="Regal Earring"
		})
		
		sets.precast.WS['Black Halo'] = set_combine(sets.precast.WS,
		{
			lear="Regal Earring"
		})
		
		
		--Magical Club
		sets.precast.WS['Flash Nova'] = 
		{
			ammo="Pemphredo Tathlum",
			head="Bagua Galero +3", neck="Sanctity Necklace", lear="Regal Earring", rear="Malignance Earring",
			body="Amalric Doublet +1", hands="Jhakri Cuffs +2", lring="Epaminondas's Ring", rring="Weather. Ring +1",
			back=gear.GEOCape_Nuke, waist="Orpheus's Sash", legs="Amalric Slops +1", feet="Amalric Nails +1"
		}
		
		sets.precast.WS['Shining Strike'] = sets.precast.WS['Flash Nova']
		
		sets.precast.WS['Seraph Strike'] = sets.precast.WS['Flash Nova']
		
		sets.precast.WS['Moonlight'] = { neck="Incanter's Torque" }

	
	--------------------------------------
	-- Melee sets
	--------------------------------------
	
		sets.engaged =
		{
			sub="Genmei Shield", ammo="Hasty Pinion +1",
			head="Blistering Sallet +1", neck="Combatant's Torque", lear={name="Mache Earring +1", bag="wardrobe2"},  rear={name="Mache Earring +1", bag="wardrobe3"},
			body="Bagua Tunic +3", hands="Gazu Bracelet +1", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"},
			back="Aurist's Cape +1", waist="Windbuffet Belt +1", legs="Jhakri Slops +2", feet="Battlecast Gaiters"
		}
		
		sets.engaged.Luopan =
		{
			main="Idris", sub="Genmei Shield", range="Dunna", ammo=empty,
			head="Blistering Sallet +1", neck="Bagua Charm +1", lear={name="Mache Earring +1", bag="wardrobe2"},  rear={name="Mache Earring +1", bag="wardrobe3"},
			body=gear.Pet_Body, hands="Gazu Bracelet +1", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"},
			back=gear.GEOCape_Luopan, waist="Isa Belt", legs="Jhakri Slops +2", feet="Bagua Sandals +3"
		}
		
		sets.engaged.Refresh =
		{
			main="Idris", sub="Genmei Shield", ammo="Staunch Tathlum +1",
			head=gear.Pet_Head, neck="Bagua Charm +1", lear="Sanare Earring", rear="Lugalbanda Earring",
			body="Shamash Robe", hands=gear.Pet_Hands, lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back=gear.GEOCape_Luopan, waist="Isa Belt", legs=gear.Pet_Legs, feet="Bagua Sandals +3"
		}

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------



-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_post_midcast(spell, action, spellMap, eventArgs)
	if spellMap == 'Cures' or spellMap == 'Curagas' then
		if state.WeaponLock.value == true then
			equip(sets.midcast.CuresLocked)
		else
			if spell.element == world.day_element or spell.element == world.weather_element then
				equip(sets.midcast.CuresWeather)
			end
		end
	
		if spell.target.type =='SELF' then 
			equip 
			{ 
				hands=gear.ENH_Gloves,
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
	
	if spell.english:startswith('Indi') then
		if spell.target.type == 'SELF' then
			equip(sets.midcast.Indicolure)
		elseif spell.target.type == 'PLAYER' or spell.target.type == 'NPC' then
			equip(set_combine(sets.midcast.Indicolure,
			{
				main="Solstice",
				rear="Malignance Earring"
			}))
		end
	end

	if (spell.skill == 'Elemental Magic') and state.MagicBurst.value and (state.CastingMode.value ~= 'Resistant') then
		if spell.element ~= 'Dark' then
			equip(sets.magic_burst)
		elseif spell.english =='Impact' then
			equip(set_combine(sets.magic_burst,
			{
				head=empty,
				body="Twilight Cloak", lring="Archon Ring"
			}))
		end
	elseif (spell.skill == 'Elemental Magic') and state.MagicBurst.value and state.CastingMode.value == 'Resistant' then
		if spell.element ~= 'Dark' then
			equip(sets.magic_burst.Resistant)
		elseif spell.english =='Impact' then
			equip(set_combine(sets.magic_burst.Resistant,
			{
				head=empty,
				body="Twilight Cloak", lring="Archon Ring"
			}))
		end
	end
	
	if spell.skill == 'Elemental Magic' and state.SaveMP.value and spell.english ~= 'Impact' then
		equip{body="Seidr Cotehardie"}
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
	
	if state.TreasureMode.value ~= 'None' and (spell.english == 'Poisonga' or spell.english == 'Diaga' or spell.english == 'Poison' or spell.english == 'Dia' or spell.english == 'Dispelga') 
			and spell.target.type == 'MONSTER' then
		equip(sets.TreasureHunter)
	end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

function job_buff_change(buff, gain)
    if state.Buff[buff] ~= nil then
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


function job_pet_status_change(newStatus, oldStatus, eventArgs)
    if pet.isvalid and not midaction() and not pet_midaction() and (newStatus == 'Engaged' or oldStatus == 'Engaged') then
        handle_equipping_gear(player.status, newStatus)
    end
end


function job_pet_change(petparam, gain)
    classes.CustomIdleGroups:clear()
    if gain then
		if pet.name == 'Luopan' then
			classes.CustomIdleGroups:append('Luopan')
		end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
	
	if player.mpp < 51 and state.IdleMode.value ~= 'DT' and state.DefenseMode.value == 'None' then
        idleSet = set_combine(idleSet,
		{
			body="Jhakri Robe +2",
			waist="Fucho-no-Obi",
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
	end
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function apply_job_change()
	set_macro_page(1, 1)
	
	send_command('wait 3; input /lockstyleset 21')
end