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
	state.Buff['Sublimation: Activated'] = buffactive['Sublimation: Activated'] or false
	
	state.Buff['Rapture'] 		= buffactive['Rapture'] 		or false
	state.Buff['Perpetuance'] 	= buffactive['Perpetuance'] 	or false
	state.Buff['Celerity'] 		= buffactive['Celerity'] 		or false
	state.Buff['Alacrity'] 		= buffactive['Alacrity'] 		or false
	state.Buff['Immanence']		= buffactive['Immanence']		or false
	state.Buff['Focalizatoin'] 	= buffactive['Focalization'] 	or false

	state.Buff['Klimaform'] 	= buffactive['Klimaform'] 		or false
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	state.OffenseMode:options('Refresh','Normal')
	state.CastingMode:options('Normal','Resistant','Occult')
	state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('EVA','MDT')
	state.IdleMode:options('Normal','DT','MEVA','Vagary')

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

		sets.precast.JA['Tabula Rasa'] =
		{
			main="Musa", sub="Niobid Strap", ammo="Ghastly Tathlum +1",
			head="Amalric Coif +1", neck="Sanctity Necklace", lear="Etiolation Earring", rear="Mendi. Earring",
			body="Acad. Gown +3", hands="Kaykaus Cuffs +1", lring="Mephitas's Ring +1", rring="Metamor. Ring +1",
			back="Fi Follet Cape +1", waist="Shinjutsu-no-Obi +1", legs="Peda. Pants +3", feet="Amalric Nails +1"
		}

		sets.precast.JA['Enlightenment'] = { body="Peda. Gown +3" }

	
	-------------------
	-- Precast Magic --
	------------------- 
	--/RDM Fast Cast: 15%
	
		sets.precast.FC =
		{--		Fast Cast: 98%
			main="Musa", sub="Khonsu", ammo="Sapience Orb",
			head="Amalric Coif +1", neck="Orunmila's Torque", lear="Loquac. Earring", rear="Malignance Earring",
			body="Pinga Tunic +1", hands="Acad. Bracers +3", lring="Lebeche Ring", rring="Weather. Ring +1",
			back=gear.SCHCape_ENF, waist="Witful Belt", legs="Pinga Pants +1", feet="Peda. Loafers +3"
		}

		sets.precast.FC.Grimoire =
		{--		Fast Cast: 79%
			head="Peda. M.Board +3",
			feet="Acad. Loafers +3"
		}
	
		sets.precast.FC.Impact = set_combine(sets.precast.FC,
		{--		Fast Cast: 72%
			head=empty,
			body="Twilight Cloak", lring="Kishar Ring",
		})
		
		sets.precast.FC.Dispelga = set_combine(sets.precast.FC,
		{
			main="Daybreak", sub="Ammurapi Shield"
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
		{--		Fast Cast: 92%
			ammo="Hasty Pinion +1",
			head="Amalric Coif +1",
			lring="Kishar Ring",
			legs="Lengo Pants"
		})

		sets.midcast.ConserveMP = set_combine(sets.precast.FC,
		{
			ammo="Pemphredo Tathlum",
			head="Vanya Hood", neck="Incanter's Torque", lear="Gwati Earring", rear="Mendi. Earring",
			body="Amalric Doublet +1", lring="Kishar Ring",
			back="Fi Follet Cape +1", waist="Shinjutsu-no-Obi +1", legs="Lengo Pants", feet="Kaykaus Boots +1"
		})

		sets.midcast.Duration = 
		{
			main="Musa", sub="Khonsu", ammo="Sapience Orb",
			head=gear.ENH_Head, neck="Incanter's Torque", lear="Andoaa Earring", rear="Mimir Earring",
			body="Peda. Gown +3", hands=gear.ENH_Gloves, lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back=gear.SCHCape_ENF, waist="Embla Sash", legs=gear.ENH_Legs, feet="Telchine Pigaches"
		}

	
	--------------------------------------
	-- Healing Midcast sets
	--------------------------------------	

		
		sets.midcast.Cures =
		{-- 	Cure Potency/II: 50%/11%		Enmity: -50		Healing Magic Skill: +69
			main="Raetic Rod +1", sub="Ammurapi Shield", ammo="Esper Stone +1",
			head="Kaykaus Mitra +1", neck="Incanter's Torque", lear="Novia Earring", rear="Meili Earring",
			body="Kaykaus Bliaut +1", hands="Peda. Bracers +3", lring="Kuchekula Ring", rring="Menelaus's Ring",
			back=gear.SCHCape_ENF, waist="Bishop's Sash", legs="Kaykaus Tights +1",  feet="Kaykaus Boots +1"
		}

		
		sets.midcast.CuresLocked =
		{-- 	
			ammo="Staunch Tathlum +1",
			head="Kaykaus Mitra +1", neck="Loricate Torque +1", lear="Genmei Earring", rear="Sanare Earring",
			body="Kaykaus Bliaut +1", hands="Kaykaus Cuffs +1", lring="Defending Ring", rring="Gelatinous Ring +1",
			back=gear.SCHCape_ENF, waist="Carrier's Sash", legs="Kaykaus Tights +1",  feet="Kaykaus Boots +1"
		}
	
		sets.midcast.CuresWeather =
		{
			back="Twilight Cape", waist="Hachirin-no-Obi"
		}

		sets.midcast.Curagas = sets.midcast.Cures

		sets.midcast.StatusRemoval = sets.midcast.FC

		sets.midcast.Cursna =
		{
			main="Gada", sub="Genmei Shield", ammo="Sapience Orb",
			head="Vanya Hood", neck="Debilis Medallion", lear="Beatific Earring", rear="Meili Earring",
			body="Peda. Gown +3", hands="Hieros Mittens", lring="Haoma's Ring", rring="Menelaus's Ring",
			back="Oretan. Cape +1", waist="Bishop's Sash", legs="Acad. Pants +3", feet="Vanya Clogs"
		}

		sets.midcast.Raises = sets.midcast.ConserveMP
		
	
	--------------------------------------
	-- Buffing Midcast sets
	--------------------------------------	
	
		sets.midcast['Enhancing Magic'] =
		{
			main="Gada", sub="Ammurapi Shield", ammo="Sapience Orb",
			head=gear.ENH_Head, neck="Incanter's Torque", lear="Andoaa Earring", rear="Mimir Earring",
			body="Peda. Gown +3", hands=gear.ENH_Gloves, lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back="Fi Follet Cape +1", waist="Olympus Sash", legs=gear.ENH_Legs, feet="Kaykaus Boots +1"
		}

		sets.midcast.Regen = set_combine(sets.midcast.Duration,
		{
			head="Arbatel Bonnet +1",
			body=gear.ENH_Body
		})

		sets.midcast.Refresh = set_combine(sets.midcast.Duration,
		{
			head="Amalric Coif +1"
		})

		sets.midcast.BarElement = set_combine(sets.midcast['Enhancing Magic'],
		{
			head=gear.ENH_Head,
			waist="Embla Sash", legs="Shedir Seraweels", feet="Kaykaus Boots +1"
		})

		sets.midcast.BarElementLA = set_combine(sets.midcast.BarElement,
		{
			main="Musa", sub="Khonsu",
			 feet="Telchine Pigaches"
		})

		sets.midcast.BarStatus = sets.midcast.Duration
		
		sets.midcast.Enhancement = set_combine(sets.midcast['Enhancing Magic'],
		{
			main="Musa", sub="Khonsu",
			waist="Embla Sash"
		})

		sets.midcast.Stoneskin = set_combine(sets.midcast.Duration,
		{
			ammo="Staunch Tathlum +1",
			neck="Stone Gorget", rear="Earthcry Earring",
			lring="Lebeche Ring", rring="Weather. Ring +1",
			waist="Siegel Sash", legs="Shedir Seraweels"
		})

		sets.midcast.Aquaveil = set_combine(sets.midcast.Duration,
		{-- Aquaveil +7
			main="Vadose Rod", sub="Ammurapi Shield", ammo="Staunch Tathlum +1",
			head="Amalric Coif +1", 
			hands="Regal Cuffs",
			waist="Emphatikos Rope", legs="Shedir Seraweels"
		})

		sets.midcast.Statless = sets.midcast.Duration
		
		sets.midcast.Storm = sets.midcast.Duration

		sets.midcast.Klimaform = sets.midcast.FC

		sets.midcast.Protection = sets.midcast.Duration
	
	
	--------------------------------------
	-- Offensive Midcast sets
	-------------------------------------- 
	
	---Enfeebling Magic
		sets.midcast.Macc =
		{
			main="Musa", sub="Khonsu", ammo="Pemphredo Tathlum",
			head="Acad. Mortar. +3", neck="Argute Stole +2", lear="Gwati Earring", rear="Malignance Earring",
			body="Acad. Gown +3", hands="Acad. Bracers +3", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring="Metamor. Ring +1",
			back=gear.SCHCape_ENF, waist="Acuity Belt +1", legs="Acad. Pants +3", feet="Acad. Loafers +3"
		}

		sets.midcast['Enfeebling Magic'] = set_combine(sets.midcast.Macc,
		{
			head=empty, lear="Regal Earring",
			body="Cohort Cloak +1", hands="Regal Cuffs", lring="Kishar Ring", rring={name="Stikini Ring +1", bag="wardrobe3"},
			legs="Chironic Hose", feet="Medium's Sabots"
		})

		sets.midcast['Enfeebling Magic'].Resistant = set_combine(sets.midcast.Macc,
		{
			head=empty,
			body="Cohort Cloak +1",
		})

		sets.midcast.Dispelga = set_combine(sets.midcast['Enfeebling Magic'].Resistant,
		{
			main="Daybreak", sub="Ammurapi Shield"
		})

		sets.midcast.ElementalDebuffs = sets.midcast.Macc

	---Dark Magic
		sets.midcast['Dark Magic'] = set_combine(sets.midcast.Macc,
		{
			neck="Erra Pendant", lear="Mani Earring",
			legs="Peda. Pants +3"
		})

		sets.midcast.Sap = set_combine(sets.midcast['Dark Magic'],
		{
			main="Rubicundity", sub="Ammurapi Shield",
			head="Pixie Hairpin +1", rear="Hirudinea Earring",
			lring="Archon Ring", rring="Evanescence Ring",
			waist="Fucho-no-Obi", feet=gear.SapCrackows
		})
		
		sets.midcast.Sap.Resistant = set_combine(sets.midcast.Sap,
		{
			head="Acad. Mortar. +3", neck="Argute Stole +2", rear="Malignance Earring",
			feet="Acad. Loafers +3"
		})

		sets.midcast.Stun =
		{
			main="Musa", sub="Khonsu", ammo="Pemphredo Tathlum",
			head="Amalric Coif +1", neck="Orunmila's Torque", lear="Mani Earring", rear="Malignance Earring",
			body="Shango Robe", hands="Acad. Bracers +3", lring="Kishar Ring", rring="Weather. Ring +1",
			back=gear.SCHCape_ENF, waist="Witful Belt", legs="Peda. Pants +3", feet="Peda. Loafers +3"
		}

		sets.midcast.Stun.Resistant = set_combine(sets.midcast.Stun,
		{
			head="Acad. Mortar. +3", neck="Erra Pendant",
			body="Acad. Gown +3", hands="Acad. Bracers +3", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			waist="Luminary Sash", feet="Acad. Loafers +3"
		})

	---Elemental Magic
		sets.midcast['Elemental Magic'] =
		{
			main="Akademos", sub="Enki Strap", ammo="Pemphredo Tathlum",
			head="Peda. M.Board +3", neck="Argute Stole +2", lear="Regal Earring", rear="Malignance Earring",
			body="Amalric Doublet +1", hands="Amalric Gages +1", lring="Freke Ring", rring="Metamor. Ring +1",
			back=gear.SCHCape_Nuke, waist="Sacro Cord", legs="Amalric Slops +1", feet="Amalric Nails +1"
		}

		sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'],
		{
			main="Raetic Staff +1", sub="Khonsu",
			head=empty,
			body="Cohort Cloak +1",
			legs="Peda. Pants +3", feet="Acad. Loafers +3"
		})
		
		sets.midcast['Elemental Magic'].Occult = set_combine(sets.midcast['Elemental Magic'],
		{
			ammo="Seraphic Ampulla",
			head="Mall. Chapeau +2",
			lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"},
			waist="Oneiros Rope", legs="Perdition Slops"
		})
		
		sets.midcast.MDMG = set_combine(sets.midcast['Elemental Magic'],
		{
			main="Raetic Staff +1", sub="Niobid Strap",
			head="Mall. Chapeau +2", neck="Argute Stole +2",
			rring="Shiva Ring +1"
		})
		
		sets.midcast.MDMG.Resistant = sets.midcast['Elemental Magic'].Resistant
		
		sets.midcast.MDMG.Occult = sets.midcast['Elemental Magic'].Occult

		---Darkness
		sets.midcast.Darkness = set_combine(sets.midcast['Elemental Magic'],
		{
			head="Pixie Hairpin +1", neck="Argute Stole +2",
			rring="Archon Ring"
		})
		
		sets.midcast.Darkness.Resistant = set_combine(sets.midcast['Elemental Magic'].Resistant,
		{
			neck="Argute Stole +2",
			rring="Archon Ring"
		})
		
		sets.midcast.Impact = set_combine(sets.midcast.Macc,
		{
			head=empty, 
			body="Twilight Cloak"
		})
		
		sets.midcast.Impact.Occult = set_combine(sets.midcast.Impact,
		{
			ammo="Seraphic Ampulla",
			lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"},
			waist="Oneiros Rope", legs="Perdition Slops"
		})
		
		---Brightness
		sets.midcast.Brightness = set_combine(sets.midcast['Elemental Magic'],
		{
			neck="Argute Stole +2",
			rring="Weather. Ring +1"
		})
		
		sets.midcast.Brightness.Resistant = set_combine(sets.midcast['Elemental Magic'].Resistant,
		{
			neck="Argute Stole +2",
			rring="Weather. Ring +1"
		})
		
		---Magic Burst
		sets.magic_burst = 
		{--		Magic Burst: +40%	Magic Burst II: +10%
			main="Akademos", sub="Enki Strap", ammo="Pemphredo Tathlum",
			head="Peda. M.Board +3", neck="Argute Stole +2", lear="Static Earring", rear="Malignance Earring",
			body="Amalric Doublet +1", hands="Amalric Gages +1", lring="Locus Ring", rring="Mujin Band",
			back=gear.SCHCape_Nuke, waist="Sacro Cord", legs="Merlinic Shalwar", feet="Amalric Nails +1"
		}
		
				sets.magic_burst.Resistant = set_combine(sets.magic_burst,
		{--		Magic Burst: 40%	Magic Burst II: +4%
			main="Raetic Staff +1", sub="Khonsu", ammo="Pemphredo Tathlum",
			head="Peda. M.Board +3", neck="Argute Stole +2", lear="Static Earring", rear="Malignance Earring",
			body="Acad. Gown +3", hands="Regal Cuffs", lring="Locus Ring", rring="Mujin Band",
			back=gear.SCHCape_Nuke, waist="Sacro Cord", legs="Merlinic Shalwar", feet="Acad. Loafers +3"
		})

	
	--------------------------------------
	-- Miscellaneous Midcast sets
	--------------------------------------  

		sets.midcast.Utsusemi = sets.midcast.FC

	
	------------------------------------------------------------------------------------------------
	------------------------------------------ Idle Sets -------------------------------------------
	------------------------------------------------------------------------------------------------

		sets.idle =
		{--	DT: -11%	PDT: -11%	MDT:-11%	Refresh: 14~15
			main="Akademos", sub="Khonsu", ammo="Homiliary",
			head="Befouled Crown", neck="Sanctity Necklace", lear="Dawn Earring", rear="Infused Earring",
			body="Acad. Gown +3", hands="Chironic Gloves", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back="Moonlight Cape", waist="Carrier's Sash", legs="Volte Brais", feet="Chironic Slippers"
		}

		sets.idle.DT = set_combine(sets.idle,
		{--	DT: -30%	PDT: -41%	MDT:-29%	Refresh: 11~12
			ammo="Staunch Tathlum +1",
			neck="Loricate Torque +1", lear="Genmei Earring", rear="Lugalbanda Earring",
			lring="Defending Ring", rring="Gelatinous Ring +1"
		})
		
		sets.idle.MEVA = set_combine(sets.idle,
		{
			ammo="Staunch Tathlum +1",
			head="Peda. M.Board +3", neck="Warder's Charm +1", lear="Genmei Earring", rear="Lugalbanda Earring",
			hands="Raetic Bangles +1", lring="Shadow Ring", rring="Purity Ring",
			waist="Carrier's Sash", legs="Volte Brais", feet="Volte Gaiters"
		})
		
		sets.idle.Vagary = set_combine(sets.magic_burst, 
		{
			main="Akademos", sub="Niobid Strap",
			waist="Hachirin-no-Obi", feet="Arbatel Loafers +1"
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
	---------------------------------------- Defense Sets ------------------------------------------
	------------------------------------------------------------------------------------------------

		sets.defense.PDT =
		{--	DT: -38%	PDT: -52%	MDT:-42%
			main="Akademos", sub="Khonsu", ammo="Staunch Tathlum +1",
			head="Peda. M.Board +3", neck="Warder's Charm +1",  lear="Genmei Earring", rear="Lugalbanda Earring",
			body="Mallquis Saio +2", hands="Volte Bracers", lring="Defending Ring", rring="Gelatinous Ring +1",
			back=gear.SCHCape_Nuke, waist="Carrier's Sash", legs="Artsieq Hose", feet="Hippo. Socks +1"
		}

		sets.defense.EVA =
		{--	DT: -27%	PDT: -44%	MDT:-22%
			main="Akademos", sub="Khonsu", ammo="Staunch Tathlum +1",
			head="Peda. M.Board +3", neck="Warder's Charm +1", lear="Sanare Earring", rear="Lugalbanda Earring",
			body="Pinga Tunic +1", hands="Raetic Bangles +1", lring="Shadow Ring", rring="Purity Ring",
			back="Moonlight Cape", waist="Carrier's Sash", legs="Pinga Pants +1", feet="Volte Gaiters"
		}
		
		sets.defense.MDT =
		{--	DT: -27%	PDT: -44%	MDT:-22%
			main="Akademos", sub="Khonsu", ammo="Staunch Tathlum +1",
			head="Chironic Hat", neck="Loricate Torque +1", lear="Etiolation Earring", rear="Odnowa Earring +1",
			body="Mallquis Saio +2", hands="Raetic Bangles +1", lring="Defending Ring", rring="Shadow Ring",
			back="Moonlight Cape", waist="Carrier's Sash", legs="Pinga Pants +1", feet="Volte Gaiters"
		}

		sets.Kiting = { feet="Crier's Gaiters" }
	
	
	------------------------------------------------------------------------------------------------
	---------------------------------------- Special Sets ------------------------------------------
	------------------------------------------------------------------------------------------------

		sets.buff.Doom = 
		{
			neck="Nicander's Necklace",
			lring={name="Eshmun's Ring", bag="wardrobe2"}, rring={name="Eshmun's Ring", bag="wardrobe3"},
			waist="Gishdubar Sash"
		}
		
		sets.buff['Klimaform'] =
		{
			feet="Arbatel Loafers +1"
		}

		sets.buff['Sublimation: Activated'] =
		{
			head="Acad. Mortar. +3", rear="Savant's Earring",
			body="Peda. Gown +3",
			waist="Embla Sash"
		}
		
		sets.TreasureHunter =
		{
			head="Chironic Hat",
			hands="Volte Bracers",
			waist="Chaac Belt", legs="Volte Hose"
		}
	
	---Stratagem Buffs
		sets.buff['Rapture'] 		= { head="Arbatel Bonnet +1" }
	
		sets.buff['Perpetuance'] 	= { hands="Arbatel Bracers +1" }
	
		sets.buff['Celerity'] 		= { feet="Peda. Loafers +3" }
	
		sets.buff['Alacrity'] 		= { feet="Peda. Loafers +3" }
		
		sets.buff['Immanence']		= 
		{
			main="Musa", sub="Khonsu", ammo="Pemphredo Tathlum",
			head="Acad. Mortar. +3", neck="Orunmila's Torque", lear="Regal Earring", rear="Malignance Earring",
			body="Amalric Doublet +1", hands="Acad. Bracers +3", lring="Freke Ring", rring="Weather. Ring +1",
			back=gear.SCHCape_ENF, waist="Embla Sash", legs="Kaykaus Tights +1", feet="Amalric Nails +1"
		}
		
		sets.buff['Focalization'] 	= { head="Peda. M.Board +3" }


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
			head="Jhakri Coronal +2", neck="Fotia Gorget", lear="Telos Earring", rear="Moonshade Earring",
			body="Jhakri Robe +2", hands="Jhakri Cuffs +2", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"},
			back=gear.SCHCape_Nuke, waist="Fotia Belt", legs="Jhakri Slops +2", feet="Jhakri Pigaches +2"
		}

		sets.precast.WS['Shattersoul'] = set_combine(sets.precast.WS,
		{
			lear={name="Mache Earring +1", bag="wardrobe2"}, rear={name="Mache Earring +1", bag="wardrobe3"},
			back=gear.SCHCape_Nuke
		})
		
		sets.precast.WS['Omniscience'] = 
		{
			ammo="Pemphredo Tathlum",
			head="Peda. M.Board +3", neck="Sanctity Necklace", lear="Regal Earring", rear="Malignance Earring",
			body="Peda. Gown +3", hands="Peda. Bracers +3", lring="Freke Ring", rring="Epaminondas's Ring",
			back=gear.SCHCape_Nuke, waist="Orpheus's Sash", legs="Amalric Slops +1", feet="Amalric Nails +1"
		}
	
		sets.precast.WS['Starburst'] = 
		{
			ammo="Pemphredo Tathlum",
			head="Peda. M.Board +3", neck="Sanctity Necklace", lear="Regal Earring", rear="Malignance Earring",
			body="Amalric Doublet +1", hands="Amalric Gages +1", lring="Epaminondas's Ring", rring="Weather. Ring +1",
			back=gear.SCHCape_Nuke, waist="Orpheus's Sash", legs="Amalric Slops +1", feet="Amalric Nails +1"
		}
		
		sets.precast.WS['Myrkr'] =
		{
			ammo="Ghastly Tathlum +1",
			head="Amalric Coif +1", neck="Sanctity Necklace", lear="Etiolation Earring", rear="Moonshade Earring",
			body="Acad. Gown +3", hands="Kaykaus Cuffs +1", lring="Mephitas's Ring +1", rring="Metamor. Ring +1",
			back="Fi Follet Cape +1", waist="Luminary Sash", legs="Amalric Slops +1", feet="Amalric Nails +1"
		}
		
	--------------------------------------
	-- Melee sets
	--------------------------------------

		sets.engaged = 
		{
			head="Peda. M.Board +3", neck="Combatant's Torque", lear={name="Mache Earring +1", bag="wardrobe2"}, rear={name="Mache Earring +1", bag="wardrobe3"},
			body="Jhakri Robe +2", hands="Raetic Bangles +1", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"},
			back=gear.SCHCape_Nuke, waist="Windbuffet Belt +1", legs="Volte Hose", feet="Peda. Loafers +3"
		}

		sets.engaged.Refresh = sets.idle

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_post_precast(spell, action, spellMap, eventArgs)
	-- Equips Grimoire Spellcasting Gear for precast if a spell of the appropriate Art is being cast.
    if (spell.type == "WhiteMagic" and (buffactive["Light Arts"] or buffactive["Addendum: White"])) or
        (spell.type == "BlackMagic" and (buffactive["Dark Arts"] or buffactive["Addendum: Black"])) then
        equip(sets.precast.FC.Grimoire)
	end
end

-- Run after the general midcast() is done.
function job_post_midcast(spell, action, spellMap, eventArgs)
	
	-- Modifies Curing gear based off weather, locked weapon, and target.
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
				waist="Gishdubar Sash"
			}
		end
	end

	-- Equips Storm enhancement boots if the spell is being cast under Light Arts.
	if spellMap == 'Storm' and (buffactive["Light Arts"] or buffactive["Addendum: White"]) then
		equip { feet="Peda. Loafers +3" }
	end
	
	-- Equips self-target Refresh gear if casting upon self.
	if spellMap == 'Refresh' and spell.target.type == 'SELF' then
		equip
		{
			back="Grapevine Cape", waist="Gishdubar Sash", feet="Inspirited Boots"
		}
	end

	-- Equips appropriate Magic Burst gear depending on spell, element of spell, and casting mode.
	if (spell.skill == 'Elemental Magic' or spell.english == 'Kaustra') and state.MagicBurst.value and state.CastingMode.value ~= 'Resistant' then
		-- Equipping gear for basic magic burst set with modifications for spell and spell element.
		if spell.element ~= 'Dark' and spell.element ~= 'Light' then
			equip(sets.magic_burst)
		elseif spell.element == 'Dark' and spell.english ~= 'Impact' then
			equip(set_combine(sets.magic_burst,
			{
				head="Pixie Hairpin +1",
				lring="Archon Ring"
			}))
		elseif spell.element == 'Light' then
			if state.WeaponLock.value == true then
				equip(set_combine(sets.magic_burst,
				{
					lring="Mujin Band", rring="Weather. Ring +1"
				}))
			else
				equip(set_combine(sets.magic_burst,
				{
					main="Daybreak", sub="Ammurapi Shield",
					lring="Mujin Band", rring="Weather. Ring +1",
				}))
			end
		else
			equip(set_combine(sets.magic_burst,
			{
				head=empty,
				body="Twilight Cloak", lring="Archon Ring"
			}))
		end
	elseif (spell.skill == 'Elemental Magic' or spell.english == 'Kaustra') and state.MagicBurst.value and state.CastingMode.value == 'Resistant' then
		--Equipping gear for resistant magic burst set with modifications for spell and spell element.
		if spell.element ~= 'Dark' and spell.element ~= 'Light' then
			equip(sets.magic_burst.Resistant)
		elseif spell.element == 'Dark' and spell.english ~= 'Impact' then
			equip(set_combine(sets.magic_burst.Resistant,
			{
				lring="Archon Ring"
			}))
		elseif spell.element == 'Light' then
			equip(set_combine(sets.magic_burst.Resistant,
			{
				main="Daybreak", sub="Ammurapi Shield",
				lring="Mujin Band", rring="Weather. Ring +1"
			}))
		else
			equip(set_combine(sets.magic_burst.Resistant,
			{
				main="Akademos", sub="Khonsu",
				head=empty,
				body="Twilight Cloak", lring="Archon Ring"
			}))
		end
	end
	
	if spell.skill == 'Elemental Magic' and state.SaveMP.value and spell.english ~= 'Impact' then
		equip{body="Seidr Cotehardie"}
	end

	-- Handles equipment modifications based of distance and spell weather/day alignment.
	if (spell.skill == 'Elemental Magic' or spell.english == 'Kaustra') and (spell.element ~= world.day_element and spell.element ~= world.weather_element) then
		-- If the spell element does not match either the weather or the day and there is less than 15 yalms between the caster and the target
		if spell.target.distance < (15 - spell.target.model_size) then
			equip { waist="Orpheus's Sash" }
		end
	elseif (spell.skill == 'Elemental Magic' or spell.english == 'Kaustra') and ((spell.element == world.day_element and spell.element == world.weather_element)
			or (spell.element == world.weather_element and get_weather_intensity() == 2 and world.day_element ~= elements.strong_to[spell.element])) then
		-- If the element of a non-helix spell matches both the day and weather with a net intensity of at least 2
		if spellMap ~= 'Helix' then
			equip
			{
				waist="Hachirin-no-Obi"
			}
		elseif spell.target.distance < (15 - spell.target.model_size) then
			equip
			{
				waist="Orpheus's Sash"
			}
		end
	elseif (spell.skill == 'Elemental Magic' or spell.english == 'Kaustra') and (spell.element == world.day_element or (spell.element == world.weather_element and get_weather_intensity() == 1)
		or (spell.element == world.weather_element and get_weather_intensity() == 2 and world.day_element == elements.strong_to[spell.element])) then
		-- If the element of a non-helix spell matches either day or weather with a net intensity of 1.
		if (spell.target.distance < (15 - spell.target.model_size)) then
			equip
			{
				waist="Orpheus's Sash"
			}
		elseif spellMap ~= 'Helix' then
			equip
			{
				waist="Hachirin-no-Obi"
			}
		end
	end
	
	if spell.action_type == 'Magic' then
		apply_grimoire_bonuses(spell, action, spellMap, eventArgs)
	end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
	if buff == "Sublimation: Activated" and state.DefenseMode.value == 'None' then
		handle_equipping_gear(player.status)
	end
	
	if buff == "doom" then
		if gain then
			equip(sets.buff.Doom)
			disable('neck','lring','rring','waist')
		else
			disable('neck','lring','rring','waist')
			handle_equipping_gear(player.status)
		end
	end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function customize_idle_set(idleSet)
	if state.Buff['Sublimation: Activated'] and state.DefenseMode.value == 'None' then
		idleSet = set_combine(idleSet, sets.buff['Sublimation: Activated'])
	end
	
	if player.mpp < 51 and state.IdleMode.value ~= 'DT' and state.DefenseMode.value == 'None' then
		idleSet = set_combine(idleSet, 
			{
				body="Jhakri Robe +2",
				waist="Fucho-no-Obi"
			})
	end

	return idleSet
end

function customize_melee_set(meleeSet)
	if buffactive['Sublimation: Activated'] and state.OffenseMode.value ~= 'Normal' and state.DefenseMode.value == 'None' then
		meleeSet = set_combine(meleeSet, sets.buff['Sublimation: Activated'])
	end
	
	return meleeSet
end

function job_get_spell_map(spell, default_spell_map)
	if spell.action_type == 'Magic' then
		if default_spell_map == 'BarElement'then
			if buffactive['Light Arts'] then
				return "BarElementLA"
			end
		elseif default_spell_map == 'BarStatus' then
			if buffactive['Light Arts'] then
				return "BarStatusLA"
			end
		end
	end
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

-- Equip sets appropriate to the active buffs, relative to the spell being cast.
function apply_grimoire_bonuses(spell, action, spellMap)
	if state.Buff.Perpetuance and spell.type == 'WhiteMagic' and spell.skill == 'Enhancing Magic' then
		equip(sets.buff['Perpetuance'])
	end
	
	if state.Buff.Rapture and (spellMap == 'Cures' or spellMap == 'Curaga') then
		equip(sets.buff['Rapture'])
	end
	
	if state.Buff.Celerity and spell.type == 'WhiteMagic' and spell.skill ~= 'Enhancing Magic' then 
		equip(sets.buff['Celerity']) 
	end
	
	if state.Buff.Alacrity and spell.skill == 'BlackMagic' and (spell.skill ~= 'Elemental Magic' and spell.english ~= 'Kaustra' and spell.english ~= 'Impact') then 
		equip(sets.buff['Alacrity']) 
	end
	
	if state.Buff.Immanence and spell.skill == 'Elemental Magic' and spellMap ~= 'ElementalEnfeeble' then 
		equip(sets.buff['Immanence']) 
	end
	
	if state.Buff.Focalization and spell.type == 'BlackMagic' then
		equip(sets.buff['Focalization'])
	end
	
	if (spell.skill == 'Elemental Magic' or spell.english == 'Kaustra' or spell.english == 'Impact') and spellMap ~= 'ElementalEnfeeble' and spellMap ~= 'Helix' and spellMap ~= 'Darkness' then
		if state.Buff.Klimaform and spell.element == world.weather_element and state.CastingMode.value ~= 'Resistant' then
			if state.Buff.Immanence then
				equip(sets.buff['Immanence'])
			else
				equip(sets.buff['Klimaform'])
			end
		end
	end
end


-- Select default macro book on initial load or subjob change.
function apply_job_change()
	set_macro_page(1, 20)
	
	send_command('wait 3; input /lockstyleset 20')
end