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
    state.Buff["Avatar's Favor"] = buffactive["Avatar's Favor"] or false
    state.Buff["Astral Conduit"] = buffactive["Astral Conduit"] or false

end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Avatar','Normal')
    state.IdleMode:options('Normal', 'DT','MEVA','Favor')
	state.PhysicalDefenseMode:options('Master','Pet')
	
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
		sets.precast.JA['Elemental Siphon'] =
		{
			main="Espiritus", sub="Vox Grip", ammo="Esper Stone +1",
			head="Telchine Cap", neck="Incanter's Torque", lear="Andoaa Earring", rear="C. Palug Earring",
			body="Telchine Chas.", hands=gear.SiphonHands, lring={name="Stikini Ring +1", bag="wardrobe2"}, rring="Evoker's Ring",
			back="Conveyance Cape", waist="Kobo Obi", legs="Telchine Braconi",feet="Beck. Pigaches +1"
		}

		sets.precast.JA['Mana Cede'] = { hands="Beck. Bracers +1" }
		
		sets.precast.JA['Astral Conduit'] =
		{
			main="Espiritus", sub="Niobid Strap", ammo="Psilomene",
			head="Amalric Coif +1", neck="Smn. Collar +1", lear="Evans Earring", rear="Etiolation Earring",
			body="Con. Doublet +3", hands="Beck. Bracers +1", lring="Lebeche Ring", rring="Mephitas's Ring +1",
			back="Conveyance Cape", waist="Luminary Sash", legs="Amalric Slops +1", feet="Amalric Nails +1"
		}
		
	
    -------------------
	--  Blood Pacts  --
	------------------- 
		sets.precast.BloodPactWard =
		{
			main="Espiritus", sub="Vox Grip", ammo="Sancus Sachet +1",
			head="Beckoner's Horn +1", neck="Incanter's Torque", lear="Andoaa Earring", rear="C. Palug Earring",
			body="Baayami Robe", hands="Baayami Cuffs", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring="Evoker's Ring",
			back="Conveyance Cape", waist="Kobo Obi", legs="Baayami Slops", feet="Baayami Sabots"
		}

		sets.precast.BloodPactRage = sets.precast.BloodPactWard


    -------------------
	-- Precast Magic --
	------------------- 
		--Fast Cast: 78%
		sets.precast.FC =
		{
			main="Sucellus", sub="Chanter's Shield", ammo="Sapience Orb",
			head="Amalric Coif +1", neck="Orunmila's Torque", lear="Etiolation Earring", rear="Loquac. Earring",
			body="Inyanga Jubbah +2", hands=gear.ENH_Gloves, lring="Kishar Ring", rring="Rahab Ring",
			back=gear.SMNCape_Mag, waist="Witful Belt", legs="Lengo Pants", feet="Amalric Nails +1"
		}
		
		--Fast Cast: 78%
		sets.precast.FC['Summoning Magic'] = sets.precast.FC

		--Fast Cast: 68%
		sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC,
		{
			waist="Siegel Sash"
		})

		--Fast Cast: 83%
		sets.precast.FC.Stoneskin = set_combine(sets.precast.FC,
		{
			waist="Siegel Sash"
		})

		sets.precast.FC.Cures = set_combine(sets.precast.FC,
		{
			rear="Mendi. Earring",
			feet="Vanya Clogs"
		})

		--Fast Cast: 49%
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
    -------------------
	--  Blood Pacts  --
	------------------- 
	
		sets.midcast.Pet.bp_Buffs =
		{--		Summoning Magic Skill: 685
			main="Espiritus", sub="Vox Grip", ammo="Esper Stone +1",
			head="Baayami Hat", neck="Incanter's Torque", lear="Andoaa Earring", rear="C. Palug Earring",
			body="Baayami Robe", hands="Baayami Cuffs", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring="Evoker's Ring",
			back="Conveyance Cape", waist="Kobo Obi", legs="Baayami Slops", feet="Baayami Sabots"
		}

		sets.midcast.Pet.bp_Heals = set_combine(sets.midcast.bp_Buffs,
		{
			main="Nirvana", ammo="Sancus Sachet +1",
			head="Apogee Crown +1", neck="Smn. Collar +1", lear="Etiolation Earring", rear="Odnowa Earring +1",
			body="Apo. Dalmatica +1", hands="Asteria Mitts +1", lring="Eihwaz Ring", rring="C. Palug Ring",
			back=gear.SMNCape_Mag, waist="Regal Belt", legs="Enticer's Pants", feet="Apogee Pumps +1"
		})

		sets.midcast.Pet.bp_Debuffs = set_combine(sets.midcast.bp_Buffs,
		{
			main="Nirvana", ammo="Sancus Sachet +1",
			head="Tali'ah Turban +2", neck="Smn. Collar +1", lear="Enmerkar Earring", rear="Lugalbanda Earring",
			body="Con. Doublet +3", hands="Tali'ah Gages +2", lring="C. Palug Ring",
			back=gear.SMNCape_Mag, waist="Regal Belt", legs="Tali'ah Sera. +2",feet="Tali'ah Crackows +2"
		})

		sets.midcast.Pet.bp_Physical =
		{--		Blood Pact Damage: +138		Double Attack: +47%		Accuracy: +157	Attack: +94
			main="Nirvana", sub="Elan Strap +1", ammo="Sancus Sachet +1",
			head="Helios Band", neck="Smn. Collar +1", lear="Kyrene's Earring", rear="Lugalbanda Earring",
			body="Glyphic Doublet +3", hands=gear.PetAtkHands, lring="Varar Ring +1", rring="C. Palug Ring",
			back=gear.SMNCape_Phys, waist="Incarnation Sash", legs=gear.ASlacks_DA, feet="Helios Boots"
		}
	
		sets.midcast.Pet.bp_PhysicalTP = set_combine(sets.midcast.bp_Physical,
		{--		Blood Pact Damage: +163		Double Attack: +22%			Accuracy: +200	Attack: +114
			lear="Gelos Earring",
			body="Con. Doublet +3", lring="Varar Ring +1", rring="Varar Ring +1",
			waist="Regal Belt"
		})

		sets.midcast.Pet.bp_Magical =
		{--		Blood Pact Damage: +127		Magic Attack Bonus: +322	Magic Accuracy: +138
			main=gear.Grioavolr_Pet, sub="Elan Strap +1", ammo="Sancus Sachet +1",
			head="Apogee Crown +1", neck="Smn. Collar +1", lear="Gelos Earring", rear="Lugalbanda Earring",
			body="Apo. Dalmatica +1", hands=gear.PetNukeHands, lring="Varar Ring +1", rring="Varar Ring +1",
			back=gear.SMNCape_Mag, waist="Regal Belt", legs=gear.ASlacks_MAB, feet="Apogee Pumps +1"
		}

		sets.midcast.Pet.bp_MagicalTP = sets.midcast.Pet.bp_Magical
	
		sets.midcast.Pet.bp_Merit = sets.midcast.Pet.bp_MagicalTP

		sets.midcast.Pet.bp_Hybrid = set_combine(sets.midcast.Pet.bp_Magical,
		{--		Blood Pact Damage: +127		Magic Attack Bonus: +322	Magic Accuracy: +138	Accuracy: 190	Attack: +60
			main="Nirvana",
			body="Con. Doublet +3",
			back=gear.SMNCape_Phys,
		})


	--------------------------------------
	-- Base Midcast sets
	--------------------------------------

		sets.midcast.FC = sets.precast.FC
		
		sets.midcast['Summoning Magic'] = set_combine(sets.precast.FC,
		{
			body="Baayami Robe"
		})

		sets.midcast.ConserveMP = set_combine(sets.midcast.FC,
		{
			neck="Incanter's Torque", lear="Gwati Earring", rear="Mendi. Earring",
			body="Amalric Doublet +1",
			back="Fi Follet Cape +1", waist="Luminary Sash", legs="Lengo Pants", feet=gear.NukeCrackows
		})

	
	--------------------------------------
	-- Healing Midcast sets
	--------------------------------------	

		sets.midcast.Cures =
		{
			ammo="Esper Stone +1",
			head="Vanya Hood", neck="Lasaia Pendant", lear="Novia Earring", rear="Mendi. Earring",
			body="Vrikodara Jupon", hands=gear.ENH_Gloves, lring="Lebeche Ring", rring="Kuchekula Ring",
			back=gear.SMNCape_Mag,  waist="Bishop's Sash", legs="Assid. Pants +1", feet="Medium's Sabots"
		}
		sets.midcast.Curaga = sets.midcast.Cures

		sets.midcast.Cursna = set_combine(sets.precast.FC,
		{
			neck="Debilis Medallion", lear="Beatific Earring", rear="Healing Earring",
			hands="Hieros Mittens", lring="Haoma's Ring", rring="Menelaus's Ring",
			back="Oretan. Cape +1", waist="Bishop's Sash", feet="Vanya Clogs"
		})
		
		sets.midcast.Raise = sets.midcast.ConserveMP

		sets.midcast.Reraise = sets.midcast.ConserveMP

	
	--------------------------------------
	-- Buffing Midcast sets
	--------------------------------------
	
		sets.midcast.Duration =
		{
			main="Gada", sub="Ammurapi Shield",
			head="Telchine Cap", neck="Orunmila's Torque", lear="Etiolation Earring", rear="Loquac. Earring",
			body="Telchine Chas.", hands=gear.ENH_Gloves, lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back=gear.SMNCape_Mag, waist="Luminary Sash", legs="Telchine Braconi", feet="Telchine Pigaches"
		}

		sets.midcast.Stoneskin = set_combine(sets.midcast.Duration,
		{
			neck="Stone Gorget", rear="Earthcry Earring",
			waist="Siegel Sash", legs="Shedir Seraweels"
		})

		sets.midcast.Aquaveil = set_combine(sets.midcast.Duration,
		{
			main="Vadose Rod",
			head="Amalric Coif +1", waist="Emphatikos Rope", legs="Shedir Seraweels"
		})

		sets.midcast['Enhancing Magic'] =
		{
			main="Gada", sub="Ammurapi Shield",
			head="Befouled Crown", neck="Incanter's Torque", lear="Andoaa Earring", rear="Augment. Earring",
			body="Telchine Chas.", hands="Inyan. Dastanas +2", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back="Fi Follet Cape +1", waist="Olympus Sash", legs="Telchine Braconi", feet="Telchine Pigaches"
		}

		sets.midcast.BarElement = set_combine(sets.midcast['Enhancing Magic'],
		{
			legs="Shedir Seraweels"
		})

		sets.midcast.BarStatus = sets.midcast.BarElement

		sets.midcast.Regen =
		{
			main="Gada", sub="Ammurapi Shield",
			head="Inyanga Tiara +2", neck="Orunmila's Torque", lear="Gwati Earring", rear="Mendi. Earring",
			body="Telchine Chas.", hands=gear.ENH_Gloves, lring="Lebeche Ring", rring="Rahab Ring",
			back=gear.SMNCape_Mag, waist="Luminary Sash", legs="Telchine Braconi", feet="Telchine Pigaches"
		}

		sets.midcast.Refresh =
		{
			main="Gada", sub="Ammurapi Shield",
			head="Amalric Coif +1", neck="Orunmila's Torque", lear="Gwati Earring", rear="Mendi. Earring",
			body="Telchine Chas.", hands=gear.ENH_Gloves, lring="Lebeche Ring", rring="Rahab Ring",
			back="Grapevine Cape", waist="Gishdubar Sash", legs="Telchine Braconi", feet="Inspirited Boots"
		}

		sets.midcast.Statless = sets.midcast.Duration

		sets.midcast.Storm = sets.midcast.Duration

		sets.midcast.Protection = sets.midcast.Duration

	
	--------------------------------------
	-- Offensive Midcast sets
	--------------------------------------  
	
	---Enfeebling Magic
		sets.midcast.Macc =
		{
			main="Maxentius", sub="Ammurapi Shield",
			head=gear.NukeHood, neck="Erra Pendant", lear="Digni. Earring", rear="Gwati Earring",
			body="Amalric Doublet +1", hands="Inyan. Dastanas +2", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back="Grapevine Cape", waist="Luminary Sash", legs="Inyanga Shalwar +2", feet="Medium's Sabots"
		}

		sets.midcast['Dark Magic'] = set_combine(sets.midcast.Macc,
		{
			body="Shango Robe", 
		})

		sets.midcast.Sap = set_combine(sets.midcast['Dark Magic'],
		{
			head="Pixie Hairpin +1",
			rring="Archon Ring",
			waist="Fucho-no-Obi", feet=gear.NukeCrackows
		})

		sets.midcast['Elemental Magic'] =
		{
			main=gear.Grioavolr_Enf, sub="Niobid Strap", ammo="Pemphredo Tathlum",
			head=gear.NukeHood, neck="Sanctity Necklace", lear="Friomisi Earring", rear="Crematio Earring",
			body="Amalric Doublet +1", hands="Amalric Gages +1", lring="Freke Ring", rring={name="Shiva Ring +1", bag="wardrobe3"},
			back="Grapevine Cape", waist="Eschan Stone", legs="Amalric Slops +1", feet="Amalric Nails +1"
		}

		sets.midcast.Impact = set_combine(sets.midcast.Macc,
		{
			head=empty,
			body="Twilight Cloak", lring="Archon Ring", 
		})
		
	
	--------------------------------------
	-- Miscellaneous Midcast sets
	--------------------------------------  
	
		sets.midcast.Teleport = sets.midcast.ConserveMP
		
		sets.midcast.Utsusemi = sets.midcast.FastRecast

		
		
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
			main="Nirvana", sub="Kaja Grip", ammo="Staunch Tathlum +1",
			head="Beckoner's Horn +1", neck="Sanctity Necklace", lear="Dawn Earring", rear="C. Palug Earring",
			body="Apo. Dalmatica +1", hands="Asteria Mitts +1", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back="Moonlight Cape", waist="Regal Belt", legs="Assid. Pants +1", feet="Baayami Sabots"
		}

		sets.idle.DT = set_combine(sets.idle,
		{
			neck="Loricate Torque +1", lear="Genmei Earring", rear="Odnowa Earring +1",
			lring="Defending Ring", rring="C. Palug Ring"
		})
		
		sets.idle.MEVA = 
		{
			main="Nirvana", sub="Irenic Strap +1", ammo="Staunch Tathlum +1",
			head="Inyanga Tiara +2", neck="Warder's Charm +1",lear="Sanare Earring", rear="Lugalbanda Earring",
			body="Inyanga Jubbah +2", hands="Inyan. Dastanas +2", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back="Moonlight Cape", waist="Carrier's Sash", legs="Inyanga Shalwar +2", feet="Inyan. Crackows +2"
		}
		
		sets.idle.Favor = set_combine(sets.idle)

		sets.idle.Town = set_combine(sets.idle,
		{
			feet="Crier's Gaiters"
		})
		
		sets.idle.Adoulin = set_combine(sets.idle,
		{
			body="Councilor's Garb"
		})

		sets.idle.Weak = sets.idle.DT

	------------------------------------------------------------------------------------------------
	----------------------------------------- Avatar Sets ------------------------------------------
	------------------------------------------------------------------------------------------------
	
		sets.idle.Avatar =
		{
			main="Nirvana", sub="Kaja Grip", ammo="Sancus Sachet +1",
			head="Beckoner's Horn +1", neck="Caller's Pendant", lear="Evans Earring", rear="C. Palug Earring",
			body="Apo. Dalmatica +1", hands="Asteria Mitts +1", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back=gear.SMNCape_Phys, waist="Lucidity Sash", legs="Assid. Pants +1", feet="Baayami Sabots"
		}
		
		sets.idle.DT.Avatar = set_combine(sets.idle.DT,
		{
			ammo="Sancus Sachet +1",
			lear="Evans Earring", rear="C. Palug Earring",
			rring="C. Palug Ring"
		})
		
		sets.idle.MEVA.Avatar = set_combine(sets.idle.MEVA,
		{
			ammo="Sancus Sachet +1",
			lring="Inyanga Ring", rring="Evoker's Ring",
			waist="Lucidity Sash", legs="Assid. Pants +1"
		})
		
		sets.idle.Favor.Avatar =
		{
			main="Nirvana", sub="Vox Grip", ammo="Sancus Sachet +1",
			head="Beckoner's Horn +1", neck="Caller's Pendant", lear="Andoaa Earring", rear="C. Palug Earring",
			body="Apo. Dalmatica +1", hands="Lamassu Mitts +1", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring="Evoker's Ring",
			back=gear.SMNCape_Phys, waist="Lucidity Sash", legs="Assid. Pants +1", feet="Baayami Sabots"
		}
		
		sets.idle.Spirit =
		{
			main="Nirvana", sub="Vox Grip", ammo="Sancus Sachet +1",
			head="Beckoner's Horn +1", neck="Incanter's Torque", lear="Andoaa Earring", rear="C. Palug Earring",
			body="Apo. Dalmatica +1", hands="Asteria Mitts +1", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back=gear.SMNCape_Mag, waist="Regal Belt", legs="Assid. Pants +1", feet="Baayami Sabots"
		}

	
	------------------------------------------------------------------------------------------------
	--------------------------------------- Defense Sets -------------------------------------------
	------------------------------------------------------------------------------------------------

	--------------------------------------
	-- Defensive Sets
	-------------------------------------
		-- PDT: -44% 	MDT: -42%
		sets.defense.Master = set_combine(sets.idle.DT,
		{
			main="Nirvana", sub="Kaja Grip",
			head="Inyanga Tiara +2",
			body="Vrikodara Jupon", hands="Inyan. Dastanas +2",
			legs="Artsieq Hose"
		})
		
		sets.defense.Pet =
		{
			main="Nirvana", sub="Kaja Grip", ammo="Sancus Sachet +1",
			head="Apogee Crown", neck="Caller's Pendant", lear="Enmerkar Earring", rear="Handler's Earring +1",
			body="Apogee Dalmatica", hands="Asteria Mitts +1", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back=gear.SMNCape_Phys, waist="Isa Belt", legs="Enticer's Pants", feet="Baayami Sabots"
		}

		-- MDT:-57%		PDT: -29%
		sets.defense.MDT = set_combine(sets.defense.Master,
		{
			sub="Irenic Strap +1",
			neck="Warder's Charm +1",lear="Sanare Earring", rear="Lugalbanda Earring",
			body="Inyanga Jubbah +2", rring="Shukuyu Ring",
			waist="Carrier's Sash", legs="Inyanga Shalwar +2", feet="Inyan. Crackows +2"
		})
		
	
	--------------------------------------
	-- Special Sets
	--------------------------------------
    
		sets.Kiting = { feet="Crier's Gaiters" }

		sets.perp.Alexander = sets.midcast.Pet.Buffs

		sets.perp.Odin = sets.midcast.Pet.Debuffs

		sets.perp.Carbuncle = { hands="Asteria Mitts +1" }

		sets.perp['Cait Sith'] = { hands="Lamassu Mitts +1" }
		
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
			head="Tali'ah Turban +2", neck="Fotia Gorget", lear="Ishvara Earring", rear="Moonshade Earring",
			body="Tali'ah Manteel +2", hands="Tali'ah Gages +2", lring="Rufescent Ring", rring="Shukuyu Ring",
			back=gear.SMNCape_Phys, waist="Fotia Belt", legs="Tali'ah Sera. +2", feet="Tali'ah Crackows +2"
		}
		
		sets.precast.WS['Retribution'] = set_combine(sets.precast.WS,
		{
			body="Inyanga Jubbah +2", hands="Inyan. Dastanas +2", rring="Shukuyu Ring",
			back=gear.SMNCape_Phys, feet="Baayami Sabots"
		})
		
		sets.precast.WS['Garland of Bliss'] =
		{
			ammo="Pemphredo Tathlum",
			head=gear.NukeHood, neck="Sanctity Necklace", lear="Friomisi Earring", rear="Crematio Earring",
			body="Amalric Doublet +1", hands="Amalric Gages +1", lring="Freke Ring", rring={name="Shiva Ring +1", bag="wardrobe3"},
			back="Grapevine Cape", waist="Eschan Stone", legs="Amalric Slops +1", feet="Amalric Nails +1"
		}
	 
		sets.precast.WS['Shattersoul'] = set_combine(sets.precast.WS,
		{
			lear={name="Mache Earring +1", bag="wardrobe2"},
			lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"},
		})
		
		sets.precast.WS['Myrkr'] = 
		{
			ammo="Psilomene",
			head="Amalric Coif +1", neck="Smn. Collar +1", lear="Etiolation Earring", rear="Moonshade Earring",
			body="Con. Doublet +3", hands="Beck. Bracers +1", lring="Lebeche Ring", rring="Mephitas's Ring +1",
			back="Conveyance Cape", waist="Luminary Sash", legs="Amalric Slops +1", feet="Amalric Nails +1"
		}
	
	--------------------------------------
	-- Melee sets
	--------------------------------------

		sets.engaged =
		{
			main="Nirvana", sub="Kaja Grip", ammo="Sancus Sachet +1",
			head="Tali'ah Turban +2", neck="Combatant's Torque", lear="Telos Earring", rear="Dedition Earring",
			body="Tali'ah Manteel +2", hands="Tali'ah Gages +2", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"},
			back=gear.SMNCape_Phys, waist="Klouskap Sash", legs="Tali'ah Sera. +2", feet="Apogee Pumps +1"
		}
		
		sets.engaged.Avatar =
		{
			main="Nirvana", sub="Kaja Grip", ammo="Sancus Sachet +1",
			head="Beckoner's Horn +1", neck="Caller's Pendant", lear="Enmerkar Earring", rear="C. Palug Earring",
			body="Apo. Dalmatica +1", hands="Asteria Mitts +1", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back=gear.SMNCape_Phys, waist="Lucidity Sash", legs="Assid. Pants +1", feet="Baayami Sabots"
		}

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if state.Buff['Astral Conduit'] and pet_midaction() then
        eventArgs.handled = true
    end
end

function job_midcast(spell, action, spellMap, eventArgs)
    if state.Buff['Astral Conduit'] and pet_midaction() then
        eventArgs.handled = true
    end
end

function job_post_pet_midcast(spell, action, spellMap, eventArgs)
	if (blood_pacts.bp_MagicalTP:contains(spell.english) or blood_pacts.bp_PhysicalTP:contains(spell.english) and pet.tp < 2350) 
			or (blood_pacts.bp_Merit:contains(spell.english) and determine_petTP() < 2350) then
		equip(
		{
			legs="Enticer's Pants"
		})
	end
end


-- Run after the general midcast() is done.
function job_post_midcast(spell, action, spellMap, eventArgs)
	if spellMap == 'Cure' and spell.target.type == 'SELF' then
        equip(
		{
			waist="Gishdubar Sash"
		})
	end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if state.Buff[buff] ~= nil then
        handle_equipping_gear(player.status)
    elseif storms:contains(buff) then
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
	
	if buff == "sleep" then
		if gain then
			equip({neck="Sacrifice Torque"})
		else
			handle_equipping_gear(player.status)
		end
	end
end

-- Called when the player's pet's status changes.
-- This is also called after pet_change after a pet is released.  Check for pet validity.
function job_pet_status_change(newStatus, oldStatus, eventArgs)
    if pet.isvalid and not midaction() and not pet_midaction() and (newStatus == 'Engaged' or oldStatus == 'Engaged') then
        handle_equipping_gear(player.status, newStatus)
    end
end

--Determine Pet TP total for Blood Pacts.
function determine_petTP()
	local rank = 0
	local totalTP = 0
	
	if spell == "Meteor Strike" then
		rank = player.merits.meteor_strike -1
	elseif spell == "Thunderstorm" then
		rank = player.merits.thunderstorm -1
	elseif spell == "Geocrush" then
		rank = player.merits.geocrush -1
	elseif spell == "Wind Blade" then
		rank = players.merits.wind_blade -1
	elseif spell == "Heavenly Strike" then
		rank = players.merits.heavenly_strike -1
	elseif spell == "Grand Fall" then
		rank = players.merits.grand_fall -1
	end
	
	totalTP = pet.tp + (rank * 400)
	
	return totalTP
end

--Equips the appropriate gear for Blood Pacts
function job_get_spell_map(spell, default_spell_map)
    if (spell.type == 'BloodPactRage' or spell.type == 'BloodPactWard') then
        for category,spell_list in pairs(blood_pacts) do
            if spell_list:contains(spell.english) then
				return category
            end
        end
    end
end

-- Called when a player gains or loses a pet.
-- pet == pet structure
-- gain == true if the pet was gained, false if it was lost.
function job_pet_change(petparam, gain)
    classes.CustomIdleGroups:clear()
    if gain then
        if avatars:contains(pet.name)  then
            classes.CustomIdleGroups:append('Avatar')
        elseif spirits:contains(pet.name) then
            classes.CustomIdleGroups:append('Spirit')
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if pet.isvalid then
        if sets.perp[pet.name] then
            idleSet = set_combine(idleSet, sets.perp[pet.name])
        end
    end
	
	if player.mpp < 51 then
        if pet.isvalid then
			idleSet = set_combine(idleSet,
			{
				rring="Evoker's Ring",
				waist="Fucho-no-Obi"
			})
		else
			idleSet = set_combine(idleSet,
			{
				waist="Fucho-no-Obi"
			})
		end
    end

    return idleSet
end

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    classes.CustomIdleGroups:clear()
    if pet.isvalid then
        if avatars:contains(pet.name) then
            classes.CustomIdleGroups:append('Avatar')
        elseif spirits:contains(pet.name) then
            classes.CustomIdleGroups:append('Spirit')
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function apply_job_change()
    set_macro_page(1, 7)
	
	send_command('lua l pettp')
	
	send_command('wait 3; input /lockstyleset 7')
end