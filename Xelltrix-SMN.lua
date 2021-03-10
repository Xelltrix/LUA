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
    state.Buff['Sublimation: Activated'] 	= 	buffactive['Sublimation: Activated'] or false
	
	state.Buff["Avatar's Favor"] = buffactive["Avatar's Favor"] or false
    state.Buff["Astral Conduit"] = buffactive["Astral Conduit"] or false
	
	--state.Avatar = M{['description']='Avatar','Carbuncle','Fenrir','Diabolos','Ifrit','Titan','Leviathan','Garuda','Shiva','Ramuh','Odin','Alexander','Cait Sith','Atomos','Siren'}
	
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Avatar','Normal')
    state.IdleMode:options('Normal', 'DT','MEVA','Favor')
	state.PhysicalDefenseMode:options('Master','Pet')
	
	
	if player.sub_job == 'WHM' then
		state.BarElement = M{['description']='BarElement', 'Barfira', 'Barblizzara', 'Baraera', 'Barstonra', 'Barthundra', 'Barwatera'}
		state.BarStatus = M{['description']='BarStatus', 'Baramnesra', 'Barvira', 'Barparalyzra', 'Barsilencera', 'Barpetra', 'Barpoisonra', 'Barblindra', 'Barsleepra'}
	elseif player.sub_job == 'RDM' then
		state.BarElement = M{['description']='BarElement', 'Barfire', 'Barblizzard', 'Baraero', 'Barstone', 'Barthunder', 'Barwater'}
		state.BarStatus = M{['description']='BarStatus', 'Baramnesia', 'Barvirus', 'Barparalyze', 'Barsilence', 'Barpetrify', 'Barpoison', 'Barblind', 'Barsleep'}
	end
	
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
		sets.precast.JA['Elemental Siphon'] =
		{
			main="Espiritus", sub="Vox Grip", ammo="Esper Stone +1",
			head="Baayami Hat +1", neck="Incanter's Torque", lear="Lodurr Earring", rear="C. Palug Earring",
			body="Baayami Robe +1", hands="Baayami Cuffs +1", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring="Evoker's Ring",
			back="Conveyance Cape", waist="Kobo Obi", legs="Baayami Slops +1",feet="Beck. Pigaches +1"
		}

		sets.precast.JA['Mana Cede'] = { hands="Beck. Bracers +1" }
		
		sets.precast.JA['Astral Conduit'] =
		{
			ammo="Ghastly Tathlum +1",
			main="Espiritus", sub="Niobid Strap",
			head="Amalric Coif +1", neck="Smn. Collar +2", lear="Evans Earring", rear="Etiolation Earring",
			body="Con. Doublet +3", hands="Beck. Bracers +1", lring="Mephitas's Ring +1", rring="Metamor. Ring +1",
			back="Conveyance Cape", waist="Shinjutsu-no-Obi +1", legs="Amalric Slops +1", feet="Amalric Nails +1"
		}
		
	
    -------------------
	--  Blood Pacts  --
	------------------- 
		sets.precast.BloodPactWard =
		{
			ammo="Sancus Sachet +1",
			head="Beckoner's Horn +1", neck="Incanter's Torque", lear="Lodurr Earring", rear="C. Palug Earring",
			body="Baayami Robe +1", hands="Baayami Cuffs +1", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring="Evoker's Ring",
			back="Conveyance Cape", waist="Kobo Obi", legs="Baayami Slops +1", feet="Baaya. Sabots +1"
		}

		sets.precast.BloodPactRage = sets.precast.BloodPactWard


    -------------------
	-- Precast Magic --
	------------------- 
		--Fast Cast: 82%
		sets.precast.FC =
		{
			main=gear.Grioavolr_Pet, sub="Khonsu", ammo="Sapience Orb",
			head="Amalric Coif +1", neck="Orunmila's Torque", lear="Loquac. Earring", rear="Malignance Earring",
			body="Inyanga Jubbah +2", hands=gear.FCHands, lring="Kishar Ring", rring="Weather. Ring +1",
			back="Fi Follet Cape +1", waist="Witful Belt", legs="Volte Brais", feet=gear.FCCrackows
		}
		
		--Fast Cast: 78%
		sets.precast.FC['Summoning Magic'] = sets.precast.FC

		--Fast Cast: 68%
		sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC)

		--Fast Cast: 83%
		sets.precast.FC.Stoneskin = set_combine(sets.precast.FC)

		sets.precast.FC.Cures = set_combine(sets.precast.FC,
		{
			rear="Mendi. Earring",
			feet="Vanya Clogs"
		})
		
		sets.precast.FC.Curagas = sets.precast.FC.Cures

		--Fast Cast: 49%
		sets.precast.FC.Impact = set_combine(sets.precast.FC,
		{
			head=empty,
			body="Twilight Cloak",
			waist="Embla Sash"
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
    -------------------
	--  Blood Pacts  --
	------------------- 
	
		sets.midcast.Pet.bp_Buffs =
		{
			main="Espiritus", sub="Vox Grip", ammo="Esper Stone +1",
			head="Baayami Hat +1", neck="Incanter's Torque", lear="Lodurr Earring", rear="C. Palug Earring",
			body="Baayami Robe +1", hands="Baayami Cuffs +1", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring="Evoker's Ring",
			back="Conveyance Cape", waist="Kobo Obi", legs="Baayami Slops +1", feet="Baaya. Sabots +1"
		}
		
		sets.midcast.Pet.bp_Boons = set_combine(sets.midcast.Pet.bp_Buffs,
		{
			head="Beckoner's Horn +1",
			hands="Beck. Bracers +1",
			feet="Beck. Pigaches +1"
		})

		sets.midcast.Pet.bp_Heals =
		{
			main="Nirvana", sub="Vox Grip", ammo="Sancus Sachet +1",
			head=gear.ACrown_Perp, neck="Unmoving Collar +1", lear="Tuisto Earring", rear="Odnowa Earring +1",
			body=gear.ADalmatica_Idle, hands="Apogee Mitts +1", lring="Eihwaz Ring", rring="Gelatinous Ring +1",
			back=gear.SMNCape_Mag, waist="Regal Belt", legs=gear.ASlacks_MAB, feet="Apogee Pumps +1"
		}

		sets.midcast.Pet.bp_Debuffs =
		{
			main="Nirvana", sub="Vox Grip", ammo="Sancus Sachet +1",
			head="Convoker's Horn +3", neck="Smn. Collar +2", lear="Enmerkar Earring", rear="Lugalbanda Earring",
			body="Con. Doublet +3", hands="Apogee Mitts +1", lring="C. Palug Ring", rring="Evoker's Ring",
			back=gear.SMNCape_Mag, waist="Regal Belt", legs="Tali'ah Sera. +2", feet="Convo. Pigaches +3"
		}

		sets.midcast.Pet.bp_Physical =
		{--		Blood Pact Damage: +140		Double Attack: +47%		Accuracy: +157	Attack: +94
			main="Nirvana", sub="Elan Strap +1", ammo="Sancus Sachet +1",
			head="Helios Band", neck="Smn. Collar +2", lear="Kyrene's Earring", rear="Lugalbanda Earring",
			body="Glyphic Doublet +3", hands=gear.PetAtkHands, lring="Varar Ring +1", rring="C. Palug Ring",
			back=gear.SMNCape_Phys, waist="Incarnation Sash", legs=gear.ASlacks_DA, feet="Helios Boots"
		}
	
		sets.midcast.Pet.bp_PhysicalTP = set_combine(sets.midcast.Pet.bp_Physical,
		{--		Blood Pact Damage: +163		Double Attack: +22%			Accuracy: +200	Attack: +114
			head=gear.ACrown_AD, lear="Gelos Earring",
			body="Con. Doublet +3", lring="Varar Ring +1", rring="Varar Ring +1",
			waist="Regal Belt", feet="Convo. Pigaches +3"
		})

		sets.midcast.Pet.bp_Magical =
		{--		Blood Pact Damage: +131		Magic Attack Bonus: +325	Magic Accuracy: +138
			main=gear.Grioavolr_Pet, sub="Elan Strap +1", ammo="Sancus Sachet +1",
			head="C. Palug Crown", neck="Smn. Collar +2", lear="Gelos Earring", rear="Lugalbanda Earring",
			body=gear.ADalmatica_MAB, hands=gear.PetNukeHands, lring="Varar Ring +1", rring="Varar Ring +1",
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
			body="Baayami Robe +1"
		})

		sets.midcast.ConserveMP = set_combine(sets.midcast.FC,
		{
			neck="Incanter's Torque", lear="Gwati Earring", rear="Mendi. Earring",
			body="Amalric Doublet +1", lring="Mephitas's Ring +1",
			back="Fi Follet Cape +1", waist="Shinjutsu-no-Obi +1", legs="Lengo Pants", feet=gear.FCCrackows
		})

	
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

		sets.midcast.Cursna =
		{
			main="Gada", sub="Chanter's Shield", ammo="Sapience Orb",
			head="Vanya Hood", neck="Debilis Medallion", lear="Meili Earring", rear="Beatific Earring",
			body="Vanya Robe", hands="Hieros Mittens", lring="Haoma's Ring", rring="Menelaus's Ring",
			back="Oretan. Cape +1", waist="Bishop's Sash", legs="Vanya Slops", feet="Vanya Clogs"
		}
		
		sets.midcast.Raise = sets.midcast.ConserveMP

		sets.midcast.Reraise = sets.midcast.ConserveMP

	
	--------------------------------------
	-- Buffing Midcast sets
	--------------------------------------
	
		sets.midcast.Duration =
		{
			main="Gada", sub="Ammurapi Shield",
			head=gear.ENH_Head, neck="Orunmila's Torque", lear="Loquac. Earring", rear="Malignance Earring",
			body=gear.ENH_Body, hands=gear.ENH_Gloves, lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back="Fi Follet Cape +1", waist="Embla Sash", legs=gear.ENH_Legs, feet="Telchine Pigaches"
		}

		sets.midcast.Stoneskin = set_combine(sets.midcast.Duration,
		{
			neck="Stone Gorget", rear="Earthcry Earring",
			waist="Siegel Sash", legs="Shedir Seraweels"
		})

		sets.midcast.Aquaveil = set_combine(sets.midcast.Duration,
		{
			main="Vadose Rod",
			head="Amalric Coif +1", 
			waist="Emphatikos Rope", legs="Shedir Seraweels"
		})

		sets.midcast['Enhancing Magic'] =
		{
			main="Gada", sub="Ammurapi Shield",
			head=gear.ENH_Head, neck="Incanter's Torque", lear="Andoaa Earring", rear="Mimir Earring",
			body=gear.ENH_Body, hands="Inyan. Dastanas +2", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back="Fi Follet Cape +1", waist="Olympus Sash", legs=gear.ENH_Legs, feet="Telchine Pigaches"
		}

		sets.midcast.BarElement = set_combine(sets.midcast['Enhancing Magic'],
		{
			waist="Embla Sash", legs="Shedir Seraweels"
		})

		sets.midcast.BarStatus = sets.midcast.BarElement

		sets.midcast.Regen =
		{
			main="Gada", sub="Ammurapi Shield",
			head="Inyanga Tiara +2", neck="Orunmila's Torque", lear="Gwati Earring", rear="Mendi. Earring",
			body=gear.ENH_Body, hands=gear.ENH_Gloves, lring="Lebeche Ring", rring="Weather. Ring +1",
			back="Fi Follet Cape +1", waist="Embla Sash", legs=gear.ENH_Legs, feet="Telchine Pigaches"
		}

		sets.midcast.Refresh =
		{
			main="Gada", sub="Ammurapi Shield",
			head="Amalric Coif +1", neck="Orunmila's Torque", lear="Gwati Earring", rear="Mendi. Earring",
			body=gear.ENH_Body, hands=gear.ENH_Gloves, lring="Lebeche Ring", rring="Weather. Ring +1",
			back="Fi Follet Cape +1", waist="Embla Sash", legs=gear.ENH_Legs, feet="Telchine Pigaches"
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
			main="Maxentius", sub="Ammurapi Shield", ammo="Pemphredo Tathlum",
			head=empty, neck="Erra Pendant", lear="Digni. Earring", rear="Malignance Earring",
			body="Cohort Cloak +1", hands="Inyan. Dastanas +2", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back="Aurist's Cape +1", waist="Acuity Belt +1", legs="Inyanga Shalwar +2", feet="Medium's Sabots"
		}
		
		sets.midcast['Enfeebling Magic'] = set_combine(sets.midcast.Macc,
		{
			main="Contemplator +1", sub="Enki Strap",
			lring="Kishar Ring"
		})
		
		
		sets.midcast.Dispelga = set_combine(sets.midcast.Macc,
		{
			main="Daybreak", sub="Ammurapi Shield"
		})

		sets.midcast['Dark Magic'] = set_combine(sets.midcast.Macc,
		{
			head="C. Palug Crown", lear="Mani Earring",
			body="Shango Robe"
		})

		sets.midcast.Sap = set_combine(sets.midcast['Dark Magic'],
		{
			main="Rubicundity", sub="Ammurapi Shield",
			head="Pixie Hairpin +1",
			rring="Archon Ring",
			waist="Fucho-no-Obi", feet=gear.SapCrackows
		})

		sets.midcast['Elemental Magic'] =
		{
			main="Daybreak", sub="Ammurapi Shield", ammo="Ghastly Tathlum +1",
			head=empty, neck="Sanctity Necklace", lear="Friomisi Earring", rear="Malignance Earring",
			body="Cohort Cloak +1", hands="Amalric Gages +1", lring="Freke Ring", rring="Shiva Ring +1",
			back="Aurist's Cape +1", waist="Orpheus's Sash", legs="Amalric Slops +1", feet="Amalric Nails +1"
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
			main="Contemplator +1", sub="Khonsu", ammo="Staunch Tathlum +1",
			head="Convoker's Horn +3", neck="Sanctity Necklace", lear="Dawn Earring", rear="C. Palug Earring",
			body="Shomonjijoe +1", hands="Asteria Mitts +1", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back="Moonlight Cape", waist="Regal Belt", legs="Volte Brais", feet="Baaya. Sabots +1"
		}

		sets.idle.DT =
		{
			main="Contemplator +1", sub="Khonsu", ammo="Staunch Tathlum +1",
			head="Convoker's Horn +3", neck="Smn. Collar +2", lear="Odnowa Earring +1", rear="C. Palug Earring",
			body="Udug Jacket", hands="Inyan. Dastanas +2", lring="Defending Ring", rring="C. Palug Ring",
			back="Moonlight Cape", waist="Regal Belt", legs="Volte Brais", feet="Baaya. Sabots +1"
		}
		
		sets.idle.MEVA = 
		{
			main="Contemplator +1", sub="Khonsu", ammo="Staunch Tathlum +1",
			head="Inyanga Tiara +2", neck="Warder's Charm +1",lear="Sanare Earring", rear="Lugalbanda Earring",
			body="Inyanga Jubbah +2", hands="Inyan. Dastanas +2", lring="Purity Ring", rring="Shadow Ring",
			back="Moonlight Cape", waist="Carrier's Sash", legs="Inyanga Shalwar +2", feet="Baaya. Sabots +1"
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
			main="Nirvana", sub="Khonsu", ammo="Sancus Sachet +1",
			head="Convoker's Horn +3", neck="Caller's Pendant", lear="Evans Earring", rear="C. Palug Earring",
			body=gear.ADalmatica_Idle, hands="Asteria Mitts +1", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back=gear.SMNCape_Phys, waist="Lucidity Sash", legs="Assid. Pants +1", feet="Baaya. Sabots +1"
		}
		
		sets.idle.DT.Avatar =
		{
			main="Nirvana", sub="Khonsu", ammo="Sancus Sachet +1",
			head=gear.ACrown_Perp, neck="Smn. Collar +2", lear="Odnowa Earring +1", rear="C. Palug Earring",
			body="Udug Jacket", hands="Baayami Cuffs +1", lring="Defending Ring", rring="C. Palug Ring",
			back="Moonlight Cape", waist="Regal Belt", legs="Artsieq Hose", feet="Baaya. Sabots +1"
		}
		
		sets.idle.MEVA.Avatar =
		{
			main="Nirvana", sub="Khonsu", ammo="Sancus Sachet +1",
			head=gear.ACrown_Perp, neck="Warder's Charm +1",lear="Sanare Earring", rear="Lugalbanda Earring",
			body="Udug Jacket", hands="Inyan. Dastanas +2", lring="Defending Ring", rring="C. Palug Ring",
			back="Moonlight Cape", waist="Carrier's Sash", legs="Inyanga Shalwar +2", feet="Baaya. Sabots +1"
		}
	
		sets.idle.Favor.Avatar =
		{
			main="Nirvana", sub="Vox Grip", ammo="Sancus Sachet +1",
			head="Beckoner's Horn +1", neck="Caller's Pendant", lear="Evans Earring", rear="C. Palug Earring",
			body=gear.ADalmatica_Idle, hands="Lamassu Mitts +1", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring="Evoker's Ring",
			back=gear.SMNCape_Phys, waist="Lucidity Sash", legs="Assid. Pants +1", feet="Baaya. Sabots +1"
		}
		
		sets.idle.Spirit =
		{
			main="Nirvana", sub="Vox Grip", ammo="Sancus Sachet +1",
			head="Convoker's Horn +3", neck="Smn. Collar +2", lear="Lodurr Earring", rear="C. Palug Earring",
			body=gear.ADalmatica_Idle, hands="Baayami Cuffs +1", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back=gear.SMNCape_Mag, waist="Regal Belt", legs="Baayami Slops +1", feet="Baaya. Sabots +1"
		}

	
	------------------------------------------------------------------------------------------------
	--------------------------------------- Defense Sets -------------------------------------------
	------------------------------------------------------------------------------------------------

	--------------------------------------
	-- Defensive Sets
	-------------------------------------

		sets.defense.Master =
		{
			main="Contemplator +1", sub="Khonsu", ammo="Staunch Tathlum +1",
			head="Inyanga Tiara +2", neck="Smn. Collar +2", lear="Odnowa Earring +1", rear="C. Palug Earring",
			body="Udug Jacket", hands="Inyan. Dastanas +2", lring="Defending Ring", rring="C. Palug Ring",
			back="Moonlight Cape", waist="Regal Belt", legs="Artsieq Hose", feet="Hippo. Socks +1"
		}
		
		sets.defense.Pet =
		{
			main="Nirvana", sub="Khonsu", ammo="Sancus Sachet +1",
			head=gear.ACrown_Perp, neck="Smn. Collar +2", lear="Enmerkar Earring", rear="Handler's Earring +1",
			body=gear.ADalmatica_Idle, hands="Baayami Cuffs +1", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back=gear.SMNCape_Phys, waist="Isa Belt", legs="Enticer's Pants", feet="Baaya. Sabots +1"
		}

		sets.defense.MDT =
		{
			main="Contemplator +1", sub="Khonsu", ammo="Staunch Tathlum +1",
			head="Inyanga Tiara +2", neck="Smn. Collar +2", lear="Odnowa Earring +1", rear="C. Palug Earring",
			body="Udug Jacket", hands="Inyan. Dastanas +2", lring="Defending Ring", rring="C. Palug Ring",
			back="Moonlight Cape", waist="Regal Belt", legs="Artsieq Hose", feet="Hippo. Socks +1"
		}
		
	
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
		
		sets.TreasureHunter =
		{
			ammo="Per. Lucky Egg",
			hands="Volte Bracers",
			waist="Chaac Belt", legs="Volte Hose"
		}
		
		sets.HPDown =
		{
			head=gear.ACrown_Perp, neck="Warder's Charm +1", lear="Evans Earring", rear="Loquac. Earring",
			body=gear.ADalmatica_Idle, hands="Apogee Mitts +1", lring="Mephitas's Ring +1", rring="Metamor. Ring +1",
			back=gear.SMNCape_Mag, waist="Shinjutsu-no-Obi +1", legs=gear.ASlacks_MAB, feet="Apogee Pumps +1"
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
			body="Glyphic Doublet +3", hands="Glyphic Bracers +3", lring="Shukuyu Ring", rring="Epaminondas's Ring",
			back="Aurist's Cape +1", waist="Fotia Belt", legs="Tali'ah Sera. +2", feet="Convo. Pigaches +3"
		}
		
		sets.precast.WS['Retribution'] = set_combine(sets.precast.WS,
		{
			body="Inyanga Jubbah +2", hands="Inyan. Dastanas +2",
			feet="Baaya. Sabots +1"
		})
		
		sets.precast.WS['Garland of Bliss'] =
		{
			ammo="Pemphredo Tathlum",
			head=empty, neck="Sanctity Necklace", lear="Friomisi Earring", rear="Malignance Earring",
			body="Cohort Cloak +1", hands="Amalric Gages +1", lring="Freke Ring", rring="Weather. Ring +1",
			back="Aurist's Cape +1", waist="Orpheus's Sash", legs="Amalric Slops +1", feet="Amalric Nails +1"
		}
	 
		sets.precast.WS['Shattersoul'] = set_combine(sets.precast.WS,
		{
			lear={name="Mache Earring +1", bag="wardrobe2"}, rear={name="Mache Earring +1", bag="wardrobe3"},
			lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"},
		})
		
		sets.precast.WS['Myrkr'] = 
		{
			ammo="Ghastly Tathlum +1",
			head="Amalric Coif +1", neck="Smn. Collar +2", lear="Etiolation Earring", rear="Moonshade Earring",
			body="Con. Doublet +3", hands="Beck. Bracers +1", lring="Mephitas's Ring +1", rring="Metamor. Ring +1",
			back="Conveyance Cape", waist="Shinjutsu-no-Obi +1", legs="Amalric Slops +1", feet="Amalric Nails +1"
		}
	
	--------------------------------------
	-- Melee sets
	--------------------------------------

		sets.engaged =
		{
			main="Nirvana", sub="Khonsu", ammo="Sancus Sachet +1",
			head="Convoker's Horn +3", neck="Shulmanu Collar", lear="Telos Earring", rear={name="Mache Earring +1", bag="wardrobe3"},
			body="Glyphic Doublet +3", hands="Glyphic Bracers +3", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"},
			back="Aurist's Cape +1", waist="Klouskap Sash +1", legs="Tali'ah Sera. +2", feet="Battlecast Gaiters"
		}
		
		sets.engaged.Avatar =
		{
			main="Nirvana", sub="Khonsu", ammo="Sancus Sachet +1",
			head="Convoker's Horn +3", neck="Shulmanu Collar", lear="Evans Earring", rear="C. Palug Earring",
			body=gear.ADalmatica_Idle, hands="Asteria Mitts +1", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back=gear.SMNCape_Phys, waist="Lucidity Sash", legs="Assid. Pants +1", feet="Baaya. Sabots +1"
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
	
	if spell.action_type == 'Ability' then
		eventArgs.handled = true
	end
end

-- Run after the general midcast() is done.
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
end


function job_post_pet_midcast(spell, action, spellMap, eventArgs)
	if (blood_pacts.bp_MagicalTP:contains(spell.english) or blood_pacts.bp_PhysicalTP:contains(spell.english) or blood_pacts.bp_Heals:contains(spell.english) and pet.tp < 2350) 
			or (blood_pacts.bp_Merit:contains(spell.english) and determine_petTP() < 2350) then
			
		equip({ legs="Enticer's Pants" })
	end
	
	if (blood_pacts.bp_Physical:contains(spell.english) and buffactive["Aftermath: Lv.3"] and player.equipment.main == "Nirvana") then
		equip(sets.midcast.Pet.bp_PhysicalTP)
	end

	if spell == "Healing Ruby" or spell == "Healing Ruby II" then
	
		equip({hands="Asteria Mitts +1"})
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
        --update_avatar()
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
	
	if state.Buff['Sublimation: Activated'] and state.DefenseMode.value == 'None' then
		idleSet = set_combine(idleSet, 
		{
			waist="Embla Sash"
		})
	end
	
	if player.mpp < 51 then
        if not pet.isvalid then
			idleSet = set_combine(idleSet,
			{
				waist="Fucho-no-Obi"
			})
		end
    end

    return idleSet
end

-- function update_avatar()
	-- if state.Avatar:contains(pet.name) then
		-- state.Avatar:set(pet.name)
	-- end
	
	-- add_to_chat(100, (pet.name))
-- end

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
-- User self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called for custom player commands.
------------------------------------------------------------------------------------
-- Commands:
-- AF
-- Protection
-- Buff
-- Enchant
-- Heal
-- Secondary
-- Nuke
-- Primary
-- Debuffs
-- CC
------------------------------------------------------------------------------------
function job_self_command(cmdParams, eventArgs)
	if pet.name == 'Carbuncle' then
		if cmdParams[1] == 'AF' then
			send_command('@input /pet "Searing Light" <t>')
		elseif cmdParams[1] == 'Protection' then
			send_command('@input /pet "Pacifying Ruby" <stpt>')
		elseif cmdParams[1] == 'Buff' then
			send_command('@input /pet "Shining Ruby" <me>')
		elseif cmdParams[1] == 'Enchant' then
			send_command('@input /pet "Soothing Ruby" <me>')
		elseif cmdParams[1] == 'Heal' then
			send_command('@input /pet "Healing Ruby II" <me>')
		elseif cmdParams[1] == 'Secondary' then
			send_command('@input /pet "Meteorite" <t>')
		elseif cmdParams[1] == 'Nuke' then
			send_command('@input /pet "Holy Mist" <t>')
		end
	elseif pet.name == 'Shiva' then
		if cmdParams[1] == 'AF' then
			send_command('@input /pet "Diamond Dust" <t>')
		elseif cmdParams[1] == 'Protection' then
			send_command('@input /pet "Frost Armor" <me>')
		elseif cmdParams[1] == 'Buff' then
			send_command('@input /pet "Crystal Blessing" <me>')
		elseif cmdParams[1] == 'Nuke' then
			send_command('@input /pet "Heavenly Strike" <t>')
		elseif cmdParams[1] == 'TierIV' then
			send_command('@input /pet "Blizzard IV" <t>')
		elseif cmdParams[1] == 'Primary' then
			send_command('@input /pet "Rush" <t>')
		elseif cmdParams[1] == 'Debuff' then
			send_command('@input /pet "Diamond Storm" <t>')
		elseif cmdParams[1] == 'CC' then
			send_command('@input /pet "Sleepga" <stnpc>')
		end
	elseif pet.name == 'Garuda' then
		if cmdParams[1] == 'AF' then
			send_command('@input /pet "Aerial Blast" <t>')
		elseif cmdParams[1] == 'Protection' then
			send_command('@input /pet "Aerial Armor" <me>')
		elseif cmdParams[1] == 'Buff' then
			send_command('@input /pet "Hastega II" <me>')
		elseif cmdParams[1] == 'Enchant' then
			send_command('@input /pet "Fleet Wind" <me>')
		elseif cmdParams[1] == 'Heal' then
			send_command('@input /pet "Whispering Wind" <me>')
		elseif cmdParams[1] == 'Nuke' then
			send_command('@input /pet "Wind Blade" <t>')
		elseif cmdParams[1] == 'TierIV' then
			send_command('@input /pet "Aero IV" <t>')
		elseif cmdParams[1] == 'Primary' then
			send_command('@input /pet "Predator Claws" <t>')
		end
	elseif pet.name == 'Titan' then
		if cmdParams[1] == 'AF' then
			send_command('@input /pet "Earthen Fury" <t>')
		elseif cmdParams[1] == 'Protection' then
			send_command('@input /pet "Earthen Armor" <me>')
		elseif cmdParams[1] == 'Enchant' then
			send_command('@input /pet "Earthen Ward" <me>')
		elseif cmdParams[1] == 'Secondary' then
			send_command('@input /pet "Crag Throw" <stnpc>')
		elseif cmdParams[1] == 'Nuke' then
			send_command('@input /pet "Geocrush" <t>')
		elseif cmdParams[1] == 'TierIV' then
			send_command('@input /pet "Stone IV" <t>')
		elseif cmdParams[1] == 'Primary' then
			send_command('@input /pet "Mountain Buster" <t>')
		end
	elseif pet.name == 'Ramuh' then
		if cmdParams[1] == 'AF' then
			send_command('@input /pet "Judgment Bolt" <t>')
		elseif cmdParams[1] == 'Protection' then
			send_command('@input /pet "Lightning Armor" <me>')
		elseif cmdParams[1] == 'Enchant' then
			send_command('@input /pet "Rolling Thunder" <me>')
		elseif cmdParams[1] == 'Secondary' then
			send_command('@input /pet "Chaotic Strike" <t>')
		elseif cmdParams[1] == 'Nuke' then
			send_command('@input /pet "Thunderstorm" <t>')
		elseif cmdParams[1] == 'TierIV' then
			send_command('@input /pet "Thunder IV" <t>')
		elseif cmdParams[1] == 'Primary' then
			send_command('@input /pet "Volt Strike" <t>')
		elseif cmdParams[1] == 'Debuff' then
			send_command('@input /pet "Thunderspark" <stnpc>')
		elseif cmdParams[1] == 'CC' then
			send_command('@input /pet "Shock Squall" <stnpc>')
		end
	elseif pet.name == 'Leviathan' then
		if cmdParams[1] == 'AF' then
			send_command('@input /pet "Tidal Wave" <t>')
		elseif cmdParams[1] == 'Enchant' then
			send_command('@input /pet "Soothing Current" <me>')
		elseif cmdParams[1] == 'Heal' then
			send_command('@input /pet "Spring Water" <me>')
		elseif cmdParams[1] == 'Nuke' then
			send_command('@input /pet "Grand Fall" <t>')
		elseif cmdParams[1] == 'TierIV' then
			send_command('@input /pet "Water IV" <t>')
		elseif cmdParams[1] == 'Primary' then
			send_command('@input /pet "Spinning Dive" <t>')
		elseif cmdParams[1] == 'Debuff' then
			send_command('@input /pet "Tidal Roar" <stnpc>')
		elseif cmdParams[1] == 'CC' then
			send_command('@input /pet "Slowga" <stnpc>')
		end
	elseif pet.name == 'Ifrit' then
		if cmdParams[1] == 'AF' then
			send_command('@input /pet "Inferno" <t>')
		elseif cmdParams[1] == 'Buff' then
			send_command('@input /pet "Crimson Howl" <me>')
		elseif cmdParams[1] == 'Enchant' then
			send_command('@input /pet "Inferno Howl" <me>')
		elseif cmdParams[1] == 'Secondary' then
			send_command('@input /pet "Conflag Strike" <t>')
		elseif cmdParams[1] == 'Nuke' then
			send_command('@input /pet "Meteor Strike" <t>')
		elseif cmdParams[1] == 'TierIV' then
			send_command('@input /pet "Fire IV" <t>')
		elseif cmdParams[1] == 'Primary' then
			send_command('@input /pet "Flaming Crush" <t>')
		end
	elseif pet.name == 'Fenrir' then
		if cmdParams[1] == 'AF' then
			send_command('@input /pet "Howling Moon" <t>')
		elseif cmdParams[1] == 'Protection' then
			send_command('@input /pet "Ecliptic Growl" <me>')
		elseif cmdParams[1] == 'Buff' then
			send_command('@input /pet "Ecliptic Howl" <me>')
		elseif cmdParams[1] == 'Enchant' then
			send_command('@input /pet "Heavenward Howl" <me>')
		elseif cmdParams[1] == 'Nuke' then
			send_command('@input /pet "Impact" <t>')
		elseif cmdParams[1] == 'Secondary' then
			send_command('@input /pet "Lunar Bay" <t>')
		elseif cmdParams[1] == 'Primary' then
			send_command('@input /pet "Eclipse Bite" <t>')
		elseif cmdParams[1] == 'Debuff' then
			send_command('@input /pet "Lunar Roar" <stnpc>')
		elseif cmdParams[1] == 'CC' then
			send_command('@input /pet "Lunar Cry" <t>')
		end
	elseif pet.name == 'Diabolos' then
		if cmdParams[1] == 'AF' then
			send_command('@input /pet "Ruminous Omen" <t>')
		elseif cmdParams[1] == 'Protection' then
			send_command('@input /pet "Noctoshield" <me>')
		elseif cmdParams[1] == 'Buff' then
			send_command('@input /pet "Dream Shroud" <me>')
		elseif cmdParams[1] == 'Secondary' then
			send_command('@input /pet "Nether Blast" <stnpc>')
		elseif cmdParams[1] == 'Nuke' then
			send_command('@input /pet "Night Terror" <t>')
		elseif cmdParams[1] == 'Primary' then
			send_command('@input /pet "Blindside" <t>')
		elseif cmdParams[1] == 'Debuff' then
			send_command('@input /pet "Pavor Nocturnus" <stnpc>')
		elseif cmdParams[1] == 'CC' then
			send_command('@input /pet "Nightmare" <stnpc>')
		end
	elseif pet.name == 'Cait Sith' then
		if cmdParams[1] == 'AF' then
			send_command('@input /pet "Altana\'s Favor" <t>')
		elseif cmdParams[1] == 'Enchant' then
			send_command('@input /pet "Reraise II" <stpt>')
		elseif cmdParams[1] == 'Heal' then
			send_command('@input /pet "Raise II" <stpt>')
		elseif cmdParams[1] == 'Nuke' then
			send_command('@input /pet "Level ? Holy" <t>')
		elseif cmdParams[1] == 'Primary' then
			send_command('@input /pet "Regal Gash" <t>')
		elseif cmdParams[1] == 'Debuff' then
			send_command('@input /pet "Eerie Eye" <stnpc>')
		elseif cmdParams[1] == 'CC' then
			send_command('@input /pet "Mewing Lullaby" <stnpc>')
		end
	elseif pet.name == 'Siren' then
		if cmdParams[1] == 'AF' then
			send_command('@input /pet "Clarsach Call" <t>')
		elseif cmdParams[1] == 'Protection' then
			send_command('@input /pet "Chinook" <me>')
		elseif cmdParams[1] == 'Buff' then
			send_command('@input /pet "Wind\'s Blessing" <me>')
		elseif cmdParams[1] == 'Enchant' then
			send_command('@input /pet "Katabatic Blades" <me>')
		elseif cmdParams[1] == 'Secondary' then
			send_command('@input /pet "Sonic Buffet" <t>')
		elseif cmdParams[1] == 'Nuke' then
			send_command('@input /pet "Tornado II" <t>')
		elseif cmdParams[1] == 'Primary' then
			send_command('@input /pet "Hysteric Assault" <t>')
		elseif cmdParams[1] == 'Debuff' then
			send_command('@input /pet "Bitter Elegy" <t>')
		elseif cmdParams[1] == 'CC' then
			send_command('@input /pet "Lunatic Voice" <stnpc>')
		end
	end
	
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
    set_macro_page(1, 15)
	
	send_command('lua l pettp')
	
	send_command('wait 3; input /lockstyleset 15')
end