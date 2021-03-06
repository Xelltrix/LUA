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
    determine_haste_group()
	update_combat_form()
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None','Normal', 'Low', 'Mid', 'High')
	state.WeaponskillMode:options('Normal', 'Low', 'Mid', 'High')
    state.HybridMode:options('Normal', 'DT')
    state.CastingMode:options('Normal', 'Resistant', 'Potency')
    state.IdleMode:options('Normal', 'DT', 'MEVA', 'Refresh')
	state.MagicalDefenseMode:options('MEVA','MDT')
	
	state.MainWeaponSet = M{['description']='Main Weapon Set',
		'Crocea',
		'Naegling',
		'Tauret',
		'Maxentius',
		'Almace',
		'Norgish'
	}
	
	state.SubWeaponSet = M{['description']='Sub Weapon Set',
		'subTauret',
		'Daybreak',
		'subAlmace',
		'subNaegling',
		'Thibron',
		'Ternion',
		'Qutrub'
	}
	
	if player.sub_job == 'WHM' then
		state.BarElement = M{['description']='BarElement','Barfira','Barblizzara','Baraera','Barstonra','Barthundra','Barwatera'}
		state.BarStatus = M{['description']='BarStatus','Baramnesra','Barvira','Barparalyzra','Barsilencera','Barpetra','Barpoisonra','Barblindra','Barsleepra'}
	else
		state.BarElement = M{['description']='BarElement','Barfire','Barblizzard','Baraero','Barstone','Barthunder','Barwater'}
		state.BarStatus = M{['description']='BarStatus','Baramnesia','Barvirus','Barparalyze','Barsilence','Barpetrify','Barpoison','Barblind','Barsleep'}
	end
	
	state.Gain = M{['description']='Gain','Gain-STR','Gain-INT','Gain-DEX','Gain-MND'}
	
	state.Enspells = M{['description']='Enspell','Enfire','Enblizzard','Enaero','Enstone','Enthunder','Enwater'}


	send_command('bind pageup gs c cycle MainWeaponSet')
	send_command('bind pagedown gs c cycleback MainWeaponSet')
	
	send_command('bind ^pageup gs c cycle SubWeaponSet')
	send_command('bind ^pagedown gs c cycleback SubWeaponSet')
	
	send_command('bind ^home gs c cycle BarElement')
	send_command('bind ^end gs c cycleback BarElement')
	
	send_command('bind !home gs c cycle BarStatus')
	send_command('bind !end gs c cycleback BarStatus')

	apply_job_change()
end


function user_unload()	
	send_command('unbind pageup')
	send_command('unbind pagedown')
	send_command('unbind ^pageup')
	send_command('unbind ^pagedown')
	
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

		sets.precast.JA['Chainspell'] = { body="Viti. Tabard +3" }

	
	-------------------
	-- Precast Magic --
	------------------- 
	--Fast Cast: 38%
	
		sets.precast.FC =
		{--		67%(+38%)
			ammo="Staunch Tathlum +1",
			head="Atrophy Chapeau +3", neck="Orunmila's Torque", lear="Loquac. Earring", rear="Malignance Earring",
			body="Viti. Tabard +3", hands="Chironic Gloves", lring="Lebeche Ring", rring="Weather. Ring +1", 
			back="Fi Follet Cape +1", waist="Witful Belt", legs="Bunzi's Pants",feet="Amalric Nails +1"
		}

		sets.precast.FC.Impact = 
		{--		52%(+38%)
			ammo="Sapience Orb",
			head=empty, neck="Orunmila's Torque", lear="Loquac. Earring", rear="Malignance Earring",
			body="Twilight Cloak", hands="Leyline Gloves", lring="Lebeche Ring", rring="Weather. Ring +1", 
			back="Fi Follet Cape +1", waist="Witful Belt", legs="Volte Brais", feet="Carmine Greaves +1"
		}
		
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

		sets.midcast.FC =
		{--		Fast Cast: 42%(+38%)	SIRD: 92%(+10%)		DT: 22%
			ammo="Staunch Tathlum +1",
			head=gear.THead_Phalanx, neck="Orunmila's Torque", lear="Loquac. Earring", rear="Malignance Earring",
			body="Viti. Tabard +3", hands="Chironic Gloves", lring="Defending Ring", rring="Freke Ring",
			back="Fi Follet Cape +1", waist="Sailfi Belt +1", legs="Bunzi's Pants",feet="Amalric Nails +1"
		}

		sets.midcast.ConserveMP = 
		{--		Fast Cast: 42%(+38%)	Conserve MP: 68
			ammo="Pemphredo Tathlum",
			head="Vanya Hood", neck="Incanter's Torque", lear="Gwati Earring", rear="Mendi. Earring",
			body="Amalric Doublet +1", hands="Leyline Gloves", lring="Mephitas's Ring +1", rring="Weather. Ring +1",
			back="Fi Follet Cape +1", waist="Shinjutsu-no-Obi +1", legs="Lengo Pants", feet="Carmine Greaves +1"
		}
		
		sets.midcast.Duration =
		{--		Fast Cast: 45%(+38%)	Duration: (1.85 * 1.68)
			main="Colada", sub="Ammurapi Shield", ammo="Hasty Pinion +1",
			head=gear.ENH_Head, neck="Dls. Torque +2", lear="Loquac. Earring", rear="Malignance Earring",
			body="Viti. Tabard +3", hands="Atrophy Gloves +3", lring="Kishar Ring", rring="Weather. Ring +1",
			back="Ghostfyre Cape", waist="Embla Sash", legs=gear.ENH_Legs, feet="Leth. Houseaux +1"
		}

    --------------------------------------
	-- Healing Midcast sets
	--------------------------------------	
	
		sets.midcast.Cures =
		{-- 		Cure Potency: 55%		Enmity: -49		Healing Magic Skill: +50
			ammo="Esper Stone +1",
			head="Kaykaus Mitra +1", neck="Incanter's Torque", lear="Meili Earring", rear="Novia Earring",
			body="Kaykaus Bliaut +1", hands="Kaykaus Cuffs +1", lring="Kuchekula Ring", rring="Menelaus's Ring",
			back="Fi Follet Cape +1", waist="Bishop's Sash", legs="Kaykaus Tights +1", feet="Kaykaus Boots +1"
		}

		sets.midcast.Curagas = sets.midcast.Cures

		sets.midcast.StatusRemoval = sets.midcast.FC

--[[		CURSNA FORMULA
		R = (10 + s/30)*(1 + c/100)*(1 + r/100)

		s - Healing magic skill
		c - Cursna success rate+
		r - Cursna received success rate+
]]
		sets.midcast.Cursna = set_combine(sets.midcast.FC,
		{--		Healing: 515(551)	Cursna: +70		Curnsa Rate: 46%(48%)
			head="Vanya Hood", neck="Debilis Medallion", lear="Meili Earring", rear="Beatific Earring",
			hands="Hieros Mittens", lring="Haoma's Ring", rring="Menelaus's Ring",
			back="Oretan. Cape +1", waist="Bishop's Sash", feet="Vanya Clogs"
		})
		
		sets.midcast.Raise = sets.midcast.ConserveMP

		sets.midcast.Reraise = sets.midcast.ConserveMP

    --------------------------------------
	-- Buffing Midcast sets
	--------------------------------------	
	
		sets.midcast.Regen =
		{--		Fast Cast: 37%(+38%)	Duration: (1.70 * 1.78)		Regen Duration: +12
			main="Colada", sub="Ammurapi Shield", ammo="Pemphredo Tathlum",
			head=gear.ENH_Head, neck="Dls. Torque +2", lear="Gwati Earring", rear="Mendi. Earring",
			body=gear.ENH_Body, hands="Atrophy Gloves +3", lring="Kishar Ring", rring="Weather. Ring +1",
			back="Ghostfyre Cape", waist="Embla Sash", legs=gear.ENH_Legs, feet="Leth. Houseaux +1"
		}

		sets.midcast.Refresh =
		{--		Fast Cast: 38%(+38%)	Duration: (1.70 * 1.48)		Refresh: +6
			main="Colada", sub="Ammurapi Shield", ammo="Sapience Orb",
			head="Amalric Coif +1", neck="Dls. Torque +2", lear="Loquac. Earring", rear="Malignance Earring",
			body="Atrophy Tabard +3", hands="Atrophy Gloves +3", lring="Kishar Ring", rring="Weather. Ring +1",
			back="Ghostfyre Cape", waist="Embla Sash", legs="Leth. Fuseau +1", feet="Leth. Houseaux +1"
		}

		--Enspell Formula: Floor[(400/3098)(Skill+3.65)]
		--Temper II Formula: floor[( Enhancing Magic Skill - 300 ) ÷ 10]
		sets.midcast.Enhancement =
		{--		Enhancing Skill: 632	Duration: (1.55 * 1.19)		Enspell Damage: 82		Temper II: 32%
			main="Pukulatmuj +1", sub="Ammurapi Shield", ammo="Pemphredo Tathlum",
			head="Befouled Crown", neck="Incanter's Torque", lear="Andoaa Earring", rear="Mimir Earring",
			body="Viti. Tabard +3", hands="Viti. Gloves +3", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back="Ghostfyre Cape", waist="Olympus Sash", legs="Atrophy Tights +3", feet="Leth. Houseaux +1"
		}


		--Phalanx Formula: 28 + Floor( (Enhancing Magic Skill - 300.5) / 28.5)
		sets.midcast.Enhancement.Self = 
		{--		Phalanx:+15		Enhancing Skill: 508	Duration: (1.2 * 1.44)	Phalanx Total: 50
			head=gear.THead_Phalanx, neck="Dls. Torque +2",
			body=gear.TBody_Phalanx, hands=gear.THands_Phalanx,
			back="Ghostfyre Cape", waist="Embla Sash", legs=gear.TLegs_Phalanx, feet=gear.TFeet_Phalanx
		}

		sets.midcast.Klimaform = sets.midcast.FastRecast

		sets.midcast.GainStat =
		{
			main="Colada", sub="Ammurapi Shield", ammo="Pemphredo Tathlum",
			head=gear.ENH_Head, neck="Dls. Torque +2", lear="Andoaa Earring", rear="Mendi. Earring",
			body="Viti. Tabard +3", hands="Viti. Gloves +3", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back="Ghostfyre Cape", waist="Embla Sash", legs=gear.ENH_Legs, feet="Leth. Houseaux +1"
		}

		sets.midcast.BarElement = set_combine(sets.midcast.GainStat,
		{
			hands="Atrophy Gloves +3",
			legs="Shedir Seraweels"
		})

		sets.midcast.BarStatus = sets.midcast.Duration

		sets.midcast.Stoneskin =
		{--		Fast Cast: 43% (+38%)	--Stoneskin +125
			main="Crocea Mors", sub="Ammurapi Shield", ammo="Staunch Tathlum +1",
			head="Malignance Chapeau", neck="Stone Gorget", lear="Earthcry Earring", rear="Malignance Earring",
			body="Malignance Tabard", hands="Stone Mufflers", lring="Defending Ring", rring="Gelatinous Ring +1",
			back="Fi Follet Cape +1", waist="Siegel Sash", legs="Shedir Seraweels", feet="Bunzi's Sabots"
		}

		sets.midcast.Aquaveil = set_combine(sets.midcast.Duration,
		{--		Aquaveil +6
			ammo="Staunch Tathlum +1",
			head="Amalric Coif +1", 
			hands="Regal Cuffs", rring="Freke Ring",
			back="Fi Follet Cape +1", waist="Emphatikos Rope", legs="Shedir Seraweels", feet="Amalric Nails +1"
		})
		
		sets.midcast.Protection = sets.midcast.Duration

		sets.midcast.Statless = sets.midcast.Duration

		sets.midcast.Storm = sets.midcast.Duration

		sets.midcast['Enhancing Magic'] = sets.midcast.Duration

    --------------------------------------
	-- Offensive Midcast sets
	--------------------------------------    
	
	---Enfeebling Magic
		sets.midcast.Macc =
		{
			main="Crocea Mors", sub="Ammurapi Shield", range="Ullr", ammo=empty,
			head="Atrophy Chapeau +3", neck="Dls. Torque +2", lear="Regal Earring", rear="Snotra Earring", 
			body="Atrophy Tabard +3", hands="Kaykaus Cuffs +1", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring="Metamor. Ring +1",
			back=gear.RDMCape_ENF, waist="Acuity Belt +1", legs="Chironic Hose", feet="Vitiation Boots +3"
		}

		sets.midcast['Enfeebling Magic'] = 
		{
			main="Contemplator +1", sub="Enki Strap", range=empty, ammo="Regal Gem",
			head="Viti. Chapeau +3", neck="Dls. Torque +2", lear="Regal Earring", rear="Snotra Earring",
			body="Lethargy Sayon +1", hands="Regal Cuffs", lring="Kishar Ring", rring={name="Stikini Ring +1", bag="wardrobe3"},
			back=gear.RDMCape_ENF, waist="Sacro Cord", legs="Chironic Hose", feet="Vitiation Boots +3"
		}

		sets.midcast['Enfeebling Magic'].Resistant = sets.midcast.Macc

		sets.midcast['Enfeebling Magic'].Potency = set_combine(sets.midcast['Enfeebling Magic'],
		{
			hands="Kaykaus Cuffs +1", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
		})
		
		sets.midcast.Static = set_combine(sets.midcast['Enfeebling Magic'].Resistant,
		{
			rear="Snotra Earring",
			hands="Regal Cuffs", lring="Kishar Ring"
		})
		
		sets.midcast['Distract III'] = set_combine(sets.midcast['Enfeebling Magic'],
		{
			lear="Vor Earring",
			waist="Rumination Sash"
		})
		
		sets.midcast['Distract III'].Potency =
		{-- 	Potency = [Floor(6/21)(Enfeebling Skill - 190)] + Floor(dMND/5); where dMND/5 caps at 0 and 10.		610 Max
			main="Contemplator +1", sub="Enki Strap", ammo="Regal Gem",
			head="Viti. Chapeau +3", neck="Dls. Torque +2", lear="Vor Earring", rear="Snotra Earring",
			body="Lethargy Sayon +1", hands="Leth. Gantherots +1", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back=gear.RDMCape_ENF, waist="Rumination Sash", legs="Psycloth Lappas", feet="Vitiation Boots +3"
		}
		
		sets.midcast['Distract III'].Resistant = sets.midcast['Enfeebling Magic'].Resistant
		
		sets.midcast['Frazzle III'] = sets.midcast['Distract III']
		
		sets.midcast['Frazzle III'].Potency = sets.midcast['Distract III'].Potency
		
		sets.midcast['Frazzle III'].Resistant = sets.midcast['Enfeebling Magic'].Resistant
		
		sets.midcast['Poison II'] = set_combine(sets.midcast['Enfeebling Magic'].Potency,
		{-- 	Potency = 82 + Floor[(180/783)(Skill-500)] 
			lear="Vor Earring",
			hands="Leth. Gantherots +1",
			waist="Rumination Sash", legs="Psycloth Lappas"
		})
		
		sets.midcast['Poison II'].Resistant = sets.midcast['Enfeebling Magic'].Resistant
		
		sets.midcast.Dispel = sets.midcast['Enfeebling Magic'].Resistant
		
		sets.midcast.Dispelga = set_combine(sets.midcast.Dispel,
		{
			main="Daybreak", sub="Ammurapi Shield"
		})
		
		sets.midcast.Frazzle = sets.midcast['Enfeebling Magic'].Resistant
		
		sets.midcast.ElementalDebuffs = sets.midcast.Macc

		sets.midcast['Dia'] = sets.midcast.FC
		
		sets.midcast['Dia II'] = sets.midcast.FC
		
		sets.midcast['Dia III'] = set_combine(sets.midcast.ConserveMP,
		{
			head="Viti. Chapeau +3", neck="Dls. Torque +2", rear="Snotra Earring", 
			hands="Regal Cuffs", lring="Kishar Ring"
		})

		
	---Dark Magic
		sets.midcast['Dark Magic'] = set_combine(sets.midcast.Macc,
		{
			main="Rubicundity", sub="Ammurapi Shield",
			neck="Erra Pendant", lear="Mani Earring", rear="Malignance Earring",
			body="Shango Robe", rring="Evanescence Ring", 
			feet="Vitiation Boots +3"
		})

		sets.midcast.Sap = set_combine(sets.midcast['Dark Magic'],
		{
			head="Pixie Hairpin +1",
			body="Shango Robe", hands="Leyline Gloves", lring="Archon Ring", rring="Evanescence Ring", 
			waist="Fucho-no-Obi", feet=gear.SapCrackows
		})

		sets.midcast.Stun = set_combine(sets.midcast.Macc,
		{
			neck="Erra Pendant", lear="Mani Earring", rear="Malignance Earring",
			body="Viti. Tabard +3", rring={name="Stikini Ring +1", bag="wardrobe3"},
			waist="Witful Belt", legs="Volte Brais"
		})
		
		sets.midcast.Stun.Resistant = set_combine(sets.midcast.Macc,
		{
			neck="Erra Pendant",
			legs="Volte Brais"
		})

	-- Elemental Magic
		sets.midcast['Elemental Magic'] =
		{
			main="Marin Staff +1", sub="Enki Strap", ammo="Ghastly Tathlum +1",
			head="C. Palug Crown", neck="Sanctity Necklace", lear="Regal Earring", rear="Malignance Earring", 
			body="Amalric Doublet +1", hands="Amalric Gages +1", lring="Metamor. Ring +1", rring="Freke Ring",
			back=gear.RDMCape_Nuke, waist="Sacro Cord", legs="Amalric Slops +1", feet="Amalric Nails +1"
		}

		sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'],
		{
			sub="Niobid Strap", ammo="Pemphredo Tathlum",
			head=empty,
			body="Cohort Cloak +1", hands="Ea Cuffs +1",
			waist="Acuity Belt +1", legs="Ea Slops +1", feet="Vitiation Boots +3"
		})

		sets.midcast['Elemental Magic'].Potency = sets.midcast['Elemental Magic']

		sets.midcast.Impact = set_combine(sets.midcast.Macc,
		{
			head=empty, lear="Gwati Earring",
			body="Twilight Cloak", lring="Archon Ring",
			back=gear.RDMCape_Nuke, waist="Sacro Cord"
		})
		
		sets.magic_burst =
		{--MBD/II: 39/35
			main="Marin Staff +1", sub="Enki Strap", ammo="Ghastly Tathlum +1",
			head="Ea Hat +1", neck="Mizu. Kubikazari", lear="Regal Earring", rear="Malignance Earring",
			body="Ea Houppe. +1", hands="Amalric Gages +1", lring="Mujin Band", rring="Locus Ring",
			back=gear.RDMCape_Nuke, waist="Sacro Cord", legs="Ea Slops +1", feet="Amalric Nails +1"
		}
		
		sets.magic_burst.Resistant =
		{--MBD/II: 38/28
			main="Marin Staff +1", sub="Enki Strap", ammo="Pemphredo Tathlum",
			head="Atrophy Chapeau +3", neck="Dls. Torque +2", lear="Regal Earring", rear="Malignance Earring",
			body="Ea Houppe. +1", hands="Ea Cuffs +1", lring="Metamor. Ring +1", rring="Freke Ring",
			back=gear.RDMCape_Nuke, waist="Acuity Belt +1", legs="Ea Slops +1", feet="Ea Pigaches +1"
		}
		
	
	
	--------------------------------------
	-- Miscellaneous Midcast sets
	--------------------------------------  
	
		sets.midcast.Teleport = sets.midcast.ConserveMP
		
		sets.midcast.Utsusemi = 
		{--		Fast Cast: 42%(+38%)		DT: 52%		PDT: 52%	MDT: 55%
			ammo="Hasty Pinion +1",
			head="Bunzi's Hat", neck="Loricate Torque +1", lear="Etiolation Earring", rear="Malignance Earring",
			body="Bunzi's Robe", hands="Bunzi's Gloves", lring="Defending Ring", rring="Gelatinous Ring +1",
			back=gear.RDMCape_ENF, waist="Shinjutsu-no-Obi +1", legs="Bunzi's Pants", feet="Bunzi's Sabots"
		}

		
		sets.midcast['Blue Magic'] = sets.midcast.Macc


----------------------------------------------------------------------------
--------------------									--------------------
------------							 						------------
--------					  Other Gear Sets						--------
------------							 						------------
--------------------									--------------------
----------------------------------------------------------------------------	

	------------------------------------------------------------------------------------------------
	----------------------------------------- Weapon Sets ------------------------------------------
	------------------------------------------------------------------------------------------------

	
	-- Mainhand Weapons
		sets.Crocea 		= { main="Crocea Mors" }
		
		sets.Naegling 		= { main="Naegling" }
			
		sets.Tauret 		= { main="Tauret" }
			
		sets.Almace 		= { main="Almace" }
		
		sets.Maxentius 		= { main="Maxentius" }
		
		sets.Norgish 		= { main="Norgish Dagger" }
	
	
	-- Offhand Weapons
		sets.subNaegling 	= { sub="Naegling" }
			
		sets.subTauret 		= { sub="Tauret" }
		
		sets.Daybreak 		= { sub="Daybreak"}
			
		sets.subAlmace 		= { sub="Almace" }
		
		sets.Thibron 		= { sub="Thibron" }
		
		sets.Qutrub 		= { sub="Qutrub Knife" }
		
		sets.Ternion		= { sub="Ternion Dagger +1" }
		
	
	------------------------------------------------------------------------------------------------
	------------------------------------------ Idle Sets -------------------------------------------
	------------------------------------------------------------------------------------------------

		sets.idle =
		{-- 	PDT: -32% | MDT:-11%	|	Refresh: 14 | Regen: 4
			main="Daybreak", sub="Genmei Shield", ammo="Homiliary",
			head="Viti. Chapeau +3", neck="Sanctity Necklace", lear="Dawn Earring", rear="Infused Earring",
			body="Shamash Robe", hands="Chironic Gloves", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back="Moonlight Cape", waist="Flume Belt +1", legs="Carmine Cuisses +1", feet="Chironic Slippers"
		}

		sets.idle.DT =
		{-- 	PDT: -56% | MDT:-24%	|	Refresh: 11 | Regen: 0
			main="Daybreak", sub="Genmei Shield", ammo="Staunch Tathlum +1",
			head="Viti. Chapeau +3", neck="Warder's Charm +1", lear="Odnowa Earring +1", rear="Genmei Earring",
			body="Shamash Robe", hands="Chironic Gloves", lring="Defending Ring", rring="Gelatinous Ring +1",
			back="Moonlight Cape", waist="Flume Belt +1", legs="Carmine Cuisses +1", feet="Chironic Slippers"
		}
		
		sets.idle.MEVA =
		{-- 	PDT: -34% | MDT:-14%	|	Refresh: 10 | Regen: 0
			main="Daybreak", sub="Genmei Shield", ammo="Homiliary",
			head="Volte Beret", neck="Warder's Charm +1", lear="Eabani Earring", rear="Sanare Earring",
			body="Shamash Robe", hands="Bunzi's Gloves", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back="Moonlight Cape", waist="Carrier's Sash", legs="Volte Brais", feet="Volte Gaiters"
		}
		
		sets.idle.Refresh = set_combine(sets.idle,
		{-- 	PDT: -22% | MDT:-11%	|	Refresh: 16 | Regen: 4
			body="Jhakri Robe +2",
			legs="Volte Brais"
		})

		sets.idle.Town = set_combine(sets.idle,
		{
			legs="Carmine Cuisses +1"
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
		{--	DT: -42%	PDT: -55%	MDT:-43%
			ammo="Staunch Tathlum +1",
			head="Bunzi's Hat", neck="Loricate Torque +1", lear="Odnowa Earring +1", rear="Genmei Earring",
			body="Bunzi's Robe", hands="Bunzi's Gloves", lring="Defending Ring", rring="Shadow Ring",
			back="Shadow Mantle", waist="Flume Belt +1", legs="Carmine Cuisses +1", feet="Hippo. Socks +1"
		}
		
		sets.defense.MEVA = 
		{--	DT: -41%	PDT: -41%	MDT:-45%
			ammo="Staunch Tathlum +1",
			head="Bunzi's Hat", neck="Warder's Charm +1", lear="Eabani Earring", rear="Sanare Earring",
			body="Bunzi's Robe", hands="Raetic Bangles +1", lring="Purity Ring", rring="Shadow Ring",
			back="Moonlight Cape", waist="Carrier's Sash", legs="Bunzi's Pants", feet="Bunzi's Sabots"
		}
		
		sets.defense.MDT = 
		{--	DT: -54%	PDT: -54%	MDT:-60%
			ammo="Staunch Tathlum +1",
			head="Bunzi's Hat", neck="Loricate Torque +1", lear="Odnowa Earring +1", rear="Sanare Earring",
			body="Bunzi's Robe", hands="Raetic Bangles +1", lring="Defending Ring", rring="Shadow Ring",
			back="Moonlight Cape", waist="Carrier's Sash", legs="Bunzi's Pants", feet="Bunzi's Sabots"
		}
	
	--------------------------------------
	-- Special Sets
	--------------------------------------

		sets.Kiting = { legs="Carmine Cuisses +1" }
		
	
	---Buffs
		sets.buff.Doom = 
		{
			neck="Nicander's Necklace",
			lring={name="Eshmun's Ring", bag="wardrobe2"}, rring={name="Eshmun's Ring", bag="wardrobe3"},
			waist="Gishdubar Sash"
		}

		sets.buff['Saboteur'] = { hands="Leth. Gantherots +1" }

		sets.buff['Composure'] =
		{
			head="Leth. Chappel +1",
			body="Lethargy Sayon +1", 
			legs="Leth. Fuseau +1", feet="Leth. Houseaux +1"
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
			ammo="Voluspa Tathlum",
			head="Viti. Chapeau +3", neck="Fotia Gorget", lear="Sherida Earring", rear="Moonshade Earring",
			body="Viti. Tabard +3", hands="Atrophy Gloves +3", lring="Shukuyu Ring", rring="Epaminondas's Ring",
			back=gear.RDMCape_WSD, waist="Fotia Belt", legs="Malignance Tights", feet="Malignance Boots"
		}

		sets.precast.WS.Mid = sets.precast.WS.Low

		sets.precast.WS.High = sets.precast.WS.Mid
	
    --	***Swords***
	
	---Chant du Cygne
		sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS,
		{
			ammo="Yetshila +1",
			head="Blistering Sallet +1", rear={name="Mache Earring +1", bag="wardrobe3"},
			body="Ayanmo Corazza +2", hands="Malignance Gloves", lring="Hetairoi Ring", rring="Ilabrat Ring",
			back=gear.RDMCape_Crit, legs="Zoar Subligar +1", feet="Thereoid Greaves"
		})
	
		sets.precast.WS['Chant du Cygne'].Low = sets.precast.WS['Chant du Cygne']
		
		sets.precast.WS['Chant du Cygne'].Mid = sets.precast.WS['Chant du Cygne'].Low
		
		sets.precast.WS['Chant du Cygne'].High = set_combine(sets.precast.WS['Chant du Cygne'].Mid,
		{
			lear={name="Mache Earring +1", bag="wardrobe2"},
			legs="Malignance Tights", feet="Malignance Boots"
		})

	---Vorpal Blade
		sets.precast.WS['Vorpal Blade'] = set_combine(sets.precast.WS['Chant du Cygne'],
		{
			rear="Moonshade Earring",
			back=gear.RDMCape_WSD
		})

		sets.precast.WS['Vorpal Blade'].Low = set_combine(sets.precast.WS['Chant du Cygne'].Low,
		{
			rear="Moonshade Earring",
			back=gear.RDMCape_WSD
		})
		
		sets.precast.WS['Vorpal Blade'].Mid = sets.precast.WS['Chant du Cygne'].Mid
		
		sets.precast.WS['Vorpal Blade'].High = sets.precast.WS['Chant du Cygne'].High	
	
	---Requiescat
		sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS,
		{
			ammo="Regal Gem",
			head="Viti. Chapeau +3", lear="Regal Earring",
			hands="Viti. Gloves +3", lring="Metamor. Ring +1", rring={name="Stikini Ring +1", bag="wardrobe3"},
			back=gear.RDMCape_ENF, legs="Jhakri Slops +2", feet="Jhakri Pigaches +2"
		})

		sets.precast.WS['Requiescat'].Low = set_combine(sets.precast.WS['Requiescat'],
		{
			head="Malignance Chapeau"
		})
		
		sets.precast.WS['Requiescat'].Mid = set_combine(sets.precast.WS['Requiescat'].Low,
		{
			legs="Malignance Tights"
		})
		
		sets.precast.WS['Requiescat'].High = set_combine(sets.precast.WS['Requiescat'].Mid,
		{
			lear={name="Mache Earring +1", bag="wardrobe2"}, rear={name="Mache Earring +1", bag="wardrobe3"},
		})
	
	---Savage Blade
		sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS,
		{
			ammo="Aurgelmir Orb +1",
			head="Viti. Chapeau +3", neck="Dls. Torque +2", lear="Ishvara Earring", rear="Regal Earring",
			lring="Metamor. Ring +1",
			waist="Sailfi Belt +1", legs="Jhakri Slops +2", feet="Carmine Greaves +1"
		})
		
		sets.precast.WS['Savage Blade'].Low = set_combine(sets.precast.WS['Savage Blade'])

		sets.precast.WS['Savage Blade'].Mid = set_combine(sets.precast.WS['Savage Blade'].Low)
		
		sets.precast.WS['Savage Blade'].High = set_combine(sets.precast.WS['Savage Blade'].Mid,
		{
			lear={name="Mache Earring +1", bag="wardrobe2"}, rear={name="Mache Earring +1", bag="wardrobe3"},
			legs="Carmine Cuisses +1"
		})
	
	
	---Death Blossom
		sets.precast.WS['Death Blossom'] = sets.precast.WS['Savage Blade']
		
		sets.precast.WS['Death Blossom'].Low = sets.precast.WS['Savage Blade'].Low

		sets.precast.WS['Death Blossom'].Mid = sets.precast.WS['Savage Blade'].Mid
		
		sets.precast.WS['Death Blossom'].High = sets.precast.WS['Savage Blade'].High
	
	
	---Sanguine Blade
		sets.precast.WS['Sanguine Blade'] =
		{
			ammo="Pemphredo Tathlum",
			head="Pixie Hairpin +1", neck="Sanctity Necklace", lear="Regal Earring", rear="Malignance Earring",
			body="Amalric Doublet +1", hands="Jhakri Cuffs +2", lring="Archon Ring", rring="Epaminondas's Ring",
			back=gear.RDMCape_ENF, waist="Sacro Cord", legs="Amalric Slops +1", feet="Vitiation Boots +3"
		}
	
	---Seraph Blade
		sets.precast.WS['Seraph Blade'] = set_combine(sets.precast.WS['Sanguine Blade'],
		{
			head=empty,
			body="Cohort Cloak +1", lring="Weather. Ring +1",
			feet="Amalric Nails +1"
		})
		
		sets.precast.WS['Shining Blade'] = sets.precast.WS['Seraph Blade']
		
	---Red Lotus Blade	
		sets.precast.WS['Red Lotus Blade'] = set_combine(sets.precast.WS['Seraph Blade'],
		{
			lring="Freke Ring"
		})
		
		sets.precast.WS['Burning Blade'] = sets.precast.WS['Red Lotus Blade']
		
	
	--	***Daggers***
	
	---Evisceration
		sets.precast.WS['Evisceration'] = sets.precast.WS['Chant du Cygne']
	
		sets.precast.WS['Evisceration'].Low = sets.precast.WS['Chant du Cygne'].Low
		
		sets.precast.WS['Evisceration'].Mid = sets.precast.WS['Chant du Cygne'].Mid
		
		sets.precast.WS['Evisceration'].High = sets.precast.WS['Chant du Cygne'].High

	---Exenterator
		sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS['Requiescat'],
		{
			ammo="Voluspa Tathlum",
			head="Malignance Chapeau",
			body="Malignance Tabard", hands="Malignance Gloves", lring="Shukuyu Ring", rring="Ilabrat Ring",
			legs="Malignance Tights", feet="Malignance Boots"
		})

		sets.precast.WS['Requiescat'].Low = set_combine(sets.precast.WS['Requiescat'],
		{
			rring={name="Chirich Ring +1", bag="wardrobe3"}
		})
		
		sets.precast.WS['Requiescat'].Mid = sets.precast.WS['Requiescat'].Low
		
		sets.precast.WS['Requiescat'].High = set_combine(sets.precast.WS['Requiescat'].Mid,
		{
			lear={name="Mache Earring +1", bag="wardrobe2"}, rear={name="Mache Earring +1", bag="wardrobe3"},
		})

	---Aeolian Edge
		sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS['Sanguine Blade'],
		{
			head="C. Palug Crown",
			lring="Freke Ring",
			back=gear.RDMCape_Nuke
		})
		
	
	--	***Clubs***
		sets.precast.WS['Shining Strike'] = sets.precast.WS['Seraph Blade']
		
		sets.precast.WS['Seraph Strike'] = sets.precast.WS['Seraph Blade']
		
		sets.precast.WS['Judgment'] = sets.precast.WS['Savage Blade']
		
		sets.precast.WS['Black Halo'] = sets.precast.WS['Savage Blade']


	--	***Bow**
		sets.precast.WS['Empyreal Arrow'] = set_combine(sets.precast.WS,
		{
			head="Malignance Chapeau", lear="Ishvara Earring",
			body="Malignance Tabard", hands="Malignance Gloves", lring="Ilabrat Ring"
		})


	--------------------------------------
	-- Melee sets
	--------------------------------------
	------------------------------------------------
	----------------------------------------------------------
	--	*************************************************** --
	----------------------------------------------------------
	-- Sword & Board
	----------------------------------------------------------	
	
		-----------------------------------------------------------------------------------
		---	TP/h:107	(STP:43		QA:2%	TA:8%	DA:27%)
		---	Primary Accuracy: 1070~		/ Primary Attack: 966~
		--- DT: 9%	PDT: 19%	MDT: 9%		Defense: 1079~
		-----------------------------------------------------------
		sets.engaged =
		{
			sub="Genmei Shield", ammo="Aurgelmir Orb +1",
			head="Malignance Chapeau", neck="Anu Torque", lear="Sherida Earring", rear="Brutal Earring",
			body="Malignance Tabard", hands="Malignance Gloves", lring="Hetairoi Ring", rring="Ilabrat Ring",
			back=gear.RDMCape_STP, waist="Windbuffet Belt +1", legs="Malignance Tights", feet="Malignance Boots"
		}
		
		sets.engaged.ENSPELLS =
		{
			sub="Genmei Shield", ammo="Aurgelmir Orb +1",
			head="Malignance Chapeau", neck="Anu Torque", lear="Sherida Earring", rear="Brutal Earring",
			body="Malignance Tabard", hands="Aya. Manopolas +2", lring="Hetairoi Ring", rring="Ilabrat Ring",
			back=gear.RDMCape_STP, waist="Orpheus's Sash", legs="Malignance Tights", feet="Malignance Boots"
		}
		
		sets.engaged.NOTP =
		{
			sub="Genmei Shield", ammo="Aurgelmir Orb +1",
			head="Malignance Chapeau", neck="Dls. Torque +2", lear="Digni. Earring", rear={name="Mache Earring +1", bag="wardrobe3"},
			body="Malignance Tabard",  hands="Gazu Bracelet +1", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"},
			back=gear.RDMCape_STP, waist="Orpheus's Sash", legs="Malignance Tights", feet="Malignance Boots"
		}

		-----------------------------------------------------------------------------------
		---	TP/h:104	(STP:39		QA:2%	TA:8%	DA:24%)
		---	Primary Accuracy: 1093~		/ Primary Attack: 971~
		--- DT: 9%	PDT: 19%	MDT: 9%		Defense: 1074~
		-----------------------------------------------------------
		sets.engaged.Low = set_combine(sets.engaged,
		{
			ammo="Voluspa Tathlum",
			neck="Combatant's Torque", rear="Telos Earring",
			hands="Gazu Bracelet +1"
		})

		-----------------------------------------------------------------------------------
		---	TP/h:104	(STP:39		QA:2%	TA:2%	DA:24%)
		---	Primary Accuracy: 1124~		/ Primary Attack: 1004~
		--- DT: 11%	PDT: 21%	MDT: 11%		Defense: 1115~
		-----------------------------------------------------------
		sets.engaged.Mid = set_combine(sets.engaged.Low,
		{
			neck="Combatant's Torque", rear={name="Mache Earring +1", bag="wardrobe3"},
		})

		-----------------------------------------------------------------------------------
		---	TP/h:101~	(STP:31~35	QA:0%	TA:0%	DA:14%)
		---	Primary Accuracy: 1170~		/ Primary Attack: 1001~
		--- DT: 11%	PDT: 21%	MDT: 11%		Defense: 1120~
		-----------------------------------------------------------
		sets.engaged.High = set_combine(sets.engaged.Mid,
		{
			lear={name="Mache Earring +1", bag="wardrobe2"}, 
			waist="Kentarch Belt +1", feet="Malignance Boots"
		})

		
	
	----------------------------------------------------------
	--					(DW2 + No Haste)
	----------------------------------------------------------

	--15 DW = 59 DW needed		(DNC Sub)
	
	----------------------------------------------------------	
	
		-----------------------------------------------------------------------------------
		---	TP/h:65		(DW:36	STP:33		QA:0%	TA:4%	DA:10%)
		---	Primary Accuracy: 1140 		/ Primary Attack: 1018
		--- Auxiliary Accuracy: 1115 	/ Auxiliary Attack: 936
		-----------------------------------------------------------
		sets.engaged.DW2 =
		{
			ammo="Aurgelmir Orb +1",
			head="Carmine Mask +1", neck="Anu Torque", lear="Eabani Earring", rear="Suppanomimi",
			body="Malignance Tabard", hands="Malignance Gloves", lring="Hetairoi Ring", rring="Ilabrat Ring",
			back=gear.RDMCape_DW, waist="Reiki Yotai", legs="Carmine Cuisses +1", feet=gear.TFeet_TP
		}
		
		sets.engaged.DW2.ENSPELLS =
		{
			ammo="Aurgelmir Orb +1",
			head="Carmine Mask +1", neck="Anu Torque", lear="Eabani Earring", rear="Suppanomimi",
			body="Malignance Tabard", hands="Aya. Manopolas +2", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"},
			back=gear.RDMCape_DW, waist="Reiki Yotai", legs="Carmine Cuisses +1", feet=gear.TFeet_TP
		}
		
		sets.engaged.DW2.NOTP =
		{
			ammo="Aurgelmir Orb +1",
			head="Malignance Chapeau", neck="Dls. Torque +2", lear="Eabani Earring", rear="Suppanomimi",
			body="Malignance Tabard", hands="Gazu Bracelet +1", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"},
			back=gear.RDMCape_DW, waist="Reiki Yotai", legs="Malignance Tights", feet="Malignance Boots"
		}

		-----------------------------------------------------------------------------------
		---	TP/h:63		(DW:36	STP:29		QA:0%	TA:4%	DA:7%)
		---	Primary Accuracy: 1130 		/ Primary Attack: 1017
		--- Auxiliary Accuracy: 1106 	/ Auxiliary Attack: 937
		-----------------------------------------------------------		
		sets.engaged.DW2.Low = set_combine(sets.engaged.DW2,
		{
			 hands="Gazu Bracelet +1", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"},
		})

		-----------------------------------------------------------------------------------
		---	TP/h:63		(DW:36	STP:29		QA:0%	TA:2%	DA:7%)
		---	Primary Accuracy: 1175 		/ Primary Attack: 1011
		--- Auxiliary Accuracy: 1151 	/ Auxiliary Attack: 927
		-----------------------------------------------------------		
		sets.engaged.DW2.Mid = set_combine(sets.engaged.DW2.Low,
		{
			head="Carmine Mask +1", neck="Combatant's Torque",
			head="Atrophy Gloves +3"
		})

		-----------------------------------------------------------------------------------
		---	TP/h:80~	(DW:16	STP:34~8	QA:0%	TA:0%	DA:14%)
		---	Primary Accuracy: 1209		/ Primary Attack: 996
		--- Auxiliary Accuracy: 1184 	/ Auxiliary Attack: 912
		-----------------------------------------------------------		
		sets.engaged.DW2.High = set_combine(sets.engaged.DW2.Mid,
		{
			lear={name="Mache Earring +1", bag="wardrobe2"}, rear={name="Mache Earring +1", bag="wardrobe3"},
			waist="Kentarch Belt +1"
		})
	
	
	----------------------------------------------------------
	--					(DW3 + No Haste)
	----------------------------------------------------------

	--25 DW = 49 DW needed		(NIN Sub)
	
	----------------------------------------------------------	
	
		-----------------------------------------------------------------------------------
		---	TP/h:59		(DW:36	STP:33		QA:0%	TA:4%	DA:10%)
		---	Primary Accuracy: 1131 		/ Primary Attack: 1020
		--- Auxiliary Accuracy: 1106 	/ Auxiliary Attack: 9377
		-----------------------------------------------------------	
		sets.engaged.DW3 = 
		{
			ammo="Hasty Pinion +1",
			head="Malignance Chapeau", neck="Anu Torque", lear="Eabani Earring", rear="Suppanomimi",
			body="Malignance Tabard", hands="Malignance Gloves", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"},
			back=gear.RDMCape_DW, waist="Reiki Yotai", legs="Carmine Cuisses +1", feet=gear.TFeet_TP
		}
		
		sets.engaged.DW3.ENSPELLS = 
		{
			ammo="Aurgelmir Orb +1",
			head="Carmine Mask +1", neck="Anu Torque", lear="Eabani Earring", rear="Suppanomimi",
			body="Malignance Tabard", hands="Aya. Manopolas +2", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"},
			back=gear.RDMCape_DW, waist="Reiki Yotai", legs="Carmine Cuisses +1", feet=gear.TFeet_TP
		}
		
		sets.engaged.DW3.NOTP =
		{
			ammo="Aurgelmir Orb +1",
			head="Malignance Chapeau", neck="Dls. Torque +2", lear="Eabani Earring", rear="Suppanomimi",
			body="Malignance Tabard", hands="Aya. Manopolas +2", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"},
			back=gear.RDMCape_DW, waist="Reiki Yotai", legs="Malignance Tights", feet="Malignance Boots"
		}

		-----------------------------------------------------------------------------------
		---	TP/h:58		(DW:36	STP:29		QA:0%	TA:4%	DA:7%)
		---	Primary Accuracy: 1153		/ Primary Attack: 1024
		--- Auxiliary Accuracy: 1129 	/ Auxiliary Attack: 942
		-----------------------------------------------------------	
		sets.engaged.DW3.Low = set_combine(sets.engaged.DW3,
		{
			hands="Aya. Manopolas +2", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"}
		})

		-----------------------------------------------------------------------------------
		---	TP/h:58		(DW:36	STP:29		QA:0%	TA:2%	DA:7%)
		---	Primary Accuracy: 1165 		/ Primary Attack: 1012
		--- Auxiliary Accuracy: 1141 	/ Auxiliary Attack: 928
		-----------------------------------------------------------	
		sets.engaged.DW3.Mid = set_combine(sets.engaged.DW3.Low,
		{
			head="Carmine Mask +1", neck="Combatant's Torque"
		})

		-----------------------------------------------------------------------------------
		---	TP/h:74~	(DW:16	STP:34~8	QA:0%	TA:0%	DA:14%)
		---	Primary Accuracy: 1200		/ Primary Attack: 997
		--- Auxiliary Accuracy: 1175 	/ Auxiliary Attack: 913
		-----------------------------------------------------------	
		sets.engaged.DW3.High = set_combine(sets.engaged.DW3.Mid,
		{
			lear={name="Mache Earring +1", bag="wardrobe2"}, rear={name="Mache Earring +1", bag="wardrobe3"},
			hands="Gazu Bracelet +1",
			waist="Kentarch Belt +1"
		})
	
	
	
	----------------------------------------------------------
	--					(DW2 + 15% Haste)
	----------------------------------------------------------

	--15 DW = 52 DW needed		(DNC Sub)
	
	----------------------------------------------------------		


		-----------------------------------------------------------------------------------
		---	TP/h:65		(DW:36	STP:33		QA:0%	TA:4%	DA:10%)
		---	Primary Accuracy: 1140 		/ Primary Attack: 1018
		--- Auxiliary Accuracy: 1115 	/ Auxiliary Attack: 936
		-----------------------------------------------------------
		sets.engaged.DW2.Min = sets.engaged.DW2
		
		sets.engaged.DW2.Min.ENSPELLS = sets.engaged.DW2.ENSPELLS
		
		sets.engaged.DW2.Min.NOTP =
		{
			ammo="Aurgelmir Orb +1",
			head="Malignance Chapeau", neck="Dls. Torque +2", lear="Eabani Earring", rear="Suppanomimi",
			body="Malignance Tabard",  hands="Gazu Bracelet +1", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"},
			back=gear.RDMCape_DW, waist="Reiki Yotai", legs="Malignance Tights", feet="Malignance Boots"
		}

		-----------------------------------------------------------------------------------
		---	TP/h:63		(DW:36	STP:29		QA:0%	TA:4%	DA:7%)
		---	Primary Accuracy: 1130 		/ Primary Attack: 1017
		--- Auxiliary Accuracy: 1106 	/ Auxiliary Attack: 937
		-----------------------------------------------------------		
		sets.engaged.DW2.Low.Min = sets.engaged.DW2.Low

		-----------------------------------------------------------------------------------
		---	TP/h:63		(DW:36	STP:29		QA:0%	TA:2%	DA:7%)
		---	Primary Accuracy: 1175 		/ Primary Attack: 1011
		--- Auxiliary Accuracy: 1151 	/ Auxiliary Attack: 927
		-----------------------------------------------------------		
		sets.engaged.DW2.Mid.Min = sets.engaged.DW2.Mid

		-----------------------------------------------------------------------------------
		---	TP/h:80~	(DW:16	STP:34~8	QA:0%	TA:0%	DA:14%)
		---	Primary Accuracy: 1209		/ Primary Attack: 996
		--- Auxiliary Accuracy: 1184 	/ Auxiliary Attack: 912
		-----------------------------------------------------------		
		sets.engaged.DW2.High.Min = sets.engaged.DW2.High
	
	----------------------------------------------------------
	--					(DW3 + 15% Haste)
	----------------------------------------------------------

	--25 DW = 42 DW needed		(NIN Sub)
	
	----------------------------------------------------------	
	
		-----------------------------------------------------------------------------------
		---	TP/h:59		(DW:36	STP:33		QA:0%	TA:4%	DA:10%)
		---	Primary Accuracy: 1131 		/ Primary Attack: 1020
		--- Auxiliary Accuracy: 1106 	/ Auxiliary Attack: 937
		-----------------------------------------------------------	
		sets.engaged.DW3.Min = sets.engaged.DW3
		
		sets.engaged.DW3.Min.ENSPELLS = sets.engaged.DW3.ENSPELLS
		
		sets.engaged.DW3.Min.NOTP =
		{
			ammo="Aurgelmir Orb +1",
			head="Malignance Chapeau", neck="Dls. Torque +2", lear="Eabani Earring", rear="Suppanomimi",
			body="Malignance Tabard",  hands="Gazu Bracelet +1", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"},
			back=gear.RDMCape_DW, waist="Reiki Yotai", legs="Malignance Tights", feet="Malignance Boots"
		}

		-----------------------------------------------------------------------------------
		---	TP/h:58		(DW:36	STP:29		QA:0%	TA:4%	DA:7%)
		---	Primary Accuracy: 1153		/ Primary Attack: 1024
		--- Auxiliary Accuracy: 1129 	/ Auxiliary Attack: 942
		-----------------------------------------------------------	
		sets.engaged.DW3.Low.Min = sets.engaged.DW3.Low

		-----------------------------------------------------------------------------------
		---	TP/h:58		(DW:36	STP:29		QA:0%	TA:2%	DA:7%)
		---	Primary Accuracy: 1165 		/ Primary Attack: 1012
		--- Auxiliary Accuracy: 1141 	/ Auxiliary Attack: 928
		-----------------------------------------------------------	
		sets.engaged.DW3.Mid.Min = sets.engaged.DW3.Mid

		-----------------------------------------------------------------------------------
		---	TP/h:74~	(DW:16	STP:34~8	QA:0%	TA:0%	DA:14%)
		---	Primary Accuracy: 1200		/ Primary Attack: 997
		--- Auxiliary Accuracy: 1175 	/ Auxiliary Attack: 913
		-----------------------------------------------------------	
		sets.engaged.DW3.High.Min = sets.engaged.DW3.High

	


	----------------------------------------------------------
	--					(DW2 + 30% Haste)
	----------------------------------------------------------

	--25 DW = 41 DW needed		(DNC Sub)
	
	----------------------------------------------------------
		
		-----------------------------------------------------------------------------------
		---	TP/h:65		(DW:36	STP:33		QA:0%	TA:4%	DA:10%)
		---	Primary Accuracy: 1140 		/ Primary Attack: 1018
		--- Auxiliary Accuracy: 1115 	/ Auxiliary Attack: 936
		-----------------------------------------------------------
		sets.engaged.DW2.Med = sets.engaged.DW2.Min
		
		sets.engaged.DW2.Med.ENSPELLS = sets.engaged.DW2.Min.ENSPELLS
		
		sets.engaged.DW2.Med.NOTP =
		{
			ammo="Hasty Pinion +1",
			head="Malignance Chapeau", neck="Dls. Torque +2", lear="Eabani Earring", rear="Suppanomimi",
			body="Malignance Tabard", hands="Gazu Bracelet +1", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"},
			back=gear.RDMCape_DW, waist="Reiki Yotai", legs="Malignance Tights", feet="Malignance Boots"
		}

		-----------------------------------------------------------------------------------
		---	TP/h:63		(DW:36	STP:29		QA:0%	TA:4%	DA:7%)
		---	Primary Accuracy: 1130 		/ Primary Attack: 1017
		--- Auxiliary Accuracy: 1106 	/ Auxiliary Attack: 937
		-----------------------------------------------------------			
		sets.engaged.DW2.Low.Med = sets.engaged.DW2.Low.Min
		
		-----------------------------------------------------------------------------------
		---	TP/h:63		(DW:36	STP:29		QA:0%	TA:2%	DA:7%)
		---	Primary Accuracy: 1175 		/ Primary Attack: 1011
		--- Auxiliary Accuracy: 1151 	/ Auxiliary Attack: 927
		-----------------------------------------------------------	
		sets.engaged.DW2.Mid.Med = sets.engaged.DW2.Mid.Min
		
		-----------------------------------------------------------------------------------
		---	TP/h:80~	(DW:16	STP:34~8	QA:0%	TA:0%	DA:14%)
		---	Primary Accuracy: 1209		/ Primary Attack: 996
		--- Auxiliary Accuracy: 1184 	/ Auxiliary Attack: 912
		-----------------------------------------------------------	
		sets.engaged.DW2.High.Med = sets.engaged.DW2.High.Min

	----------------------------------------------------------
	--					(DW3 + 30% Haste)
	----------------------------------------------------------

	--25 DW = 31 DW needed		(NIN Sub)
	
	----------------------------------------------------------
		
		-----------------------------------------------------------------------------------
		---	TP/h:64		(DW:32	STP:38		QA:0%	TA:4%	DA:15%)
		---	Primary Accuracy: 1135 		/ Primary Attack: 1023
		--- Auxiliary Accuracy: 1110 	/ Auxiliary Attack: 939
		-----------------------------------------------------------		
		sets.engaged.DW3.Med =
		{
			ammo="Hasty Pinion +1",
			head="Malignance Chapeau", neck="Anu Torque", lear="Eabani Earring", rear="Suppanomimi",
			body="Malignance Tabard", hands="Malignance Gloves", lring="Hetairoi Ring", rring="Ilabrat Ring",
			back=gear.RDMCape_DW, waist="Reiki Yotai", legs="Carmine Cuisses +1", feet="Carmine Greaves +1"
		}
		
		sets.engaged.DW3.Med.ENSPELLS =
		{
			ammo="Aurgelmir Orb +1",
			head="Malignance Chapeau", neck="Anu Torque", lear="Eabani Earring", rear="Suppanomimi",
			body="Malignance Tabard", hands="Gazu Bracelet +1", lring="Hetairoi Ring", rring={name="Chirich Ring +1", bag="wardrobe3"},
			back=gear.RDMCape_DW, waist="Orpheus's Sash", legs="Carmine Cuisses +1", feet=gear.TFeet_TP
		}
		
		sets.engaged.DW3.Med.NOTP =
		{
			ammo="Hasty Pinion +1",
			head="Malignance Chapeau", neck="Dls. Torque +2", lear="Eabani Earring", rear="Suppanomimi",
			body="Malignance Tabard", hands="Aya. Manopolas +2", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"},
			back=gear.RDMCape_DW, waist="Reiki Yotai", legs="Malignance Tights", feet=gear.TFeet_TP
		}
		
		-----------------------------------------------------------------------------------
		---	TP/h:65		(DW:32	STP:39		QA:0%	TA:2%	DA:13%)
		---	Primary Accuracy: 1160 		/ Primary Attack: 1018
		--- Auxiliary Accuracy: 1136 	/ Auxiliary Attack: 932
		-----------------------------------------------------------		
		sets.engaged.DW3.Low.Med = set_combine(sets.engaged.DW3.Med,
		{
			 lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"}
		})
		
		-----------------------------------------------------------------------------------
		---	TP/h:62		(DW:32	STP:34		QA:0%	TA:2%	DA:12%)
		---	Primary Accuracy: 1169 		/ Primary Attack: 1016
		--- Auxiliary Accuracy: 1145	/ Auxiliary Attack: 930
		-----------------------------------------------------------	
		sets.engaged.DW3.Mid.Med = set_combine(sets.engaged.DW3.Low.Med,
		{
			head="Carmine Mask +1", neck="Combatant's Torque",
			hands="Gazu Bracelet +1"
		})
		-----------------------------------------------------------------------------------
		---	TP/h:70		(DW:21	STP:35		QA:0%	TA:0%	DA:11%)
		---	Primary Accuracy: 1198 		/ Primary Attack: 1002
		--- Auxiliary Accuracy: 1174 	/ Auxiliary Attack: 918
		-----------------------------------------------------------	
		sets.engaged.DW3.High.Med = set_combine(sets.engaged.DW3.Mid.Med,
		{
			lear={name="Mache Earring +1", bag="wardrobe2"}, rear={name="Mache Earring +1", bag="wardrobe3"},
			waist="Kentarch Belt +1"
		})
		
	
	
	----------------------------------------------------------
	--					(DW2 + Max Haste)
	----------------------------------------------------------

	--15 DW = 21 DW needed		(DNC Sub)
	
	----------------------------------------------------------	
		
		-----------------------------------------------------------------------------------
		---	TP/h:65		(DW:36	STP:33		QA:0%	TA:4%	DA:10%)
		---	Primary Accuracy: 1140 		/ Primary Attack: 1018
		--- Auxiliary Accuracy: 1115 	/ Auxiliary Attack: 936
		-----------------------------------------------------------	
		sets.engaged.DW2.Max =
		{
			ammo="Aurgelmir Orb +1",
			head="Malignance Chapeau", neck="Anu Torque", lear="Sherida Earring", rear="Suppanomimi",
			body="Malignance Tabard", hands="Malignance Gloves", lring="Hetairoi Ring", rring="Ilabrat Ring",
			back=gear.RDMCape_DW, waist="Reiki Yotai", legs="Malignance Tights", feet="Malignance Boots"
		}
		
		sets.engaged.DW2.Max.ENSPELLS =
		{
			ammo="Aurgelmir Orb +1",
			head="Carmine Mask +1", neck="Anu Torque", lear="Sherida Earring", rear="Suppanomimi",
			body="Malignance Tabard", hands="Aya. Manopolas +2", lring="Hetairoi Ring", rring={name="Chirich Ring +1", bag="wardrobe3"},
			back=gear.RDMCape_DW, waist="Orpheus's Sash", legs="Carmine Cuisses +1", feet="Malignance Boots"
		}
		
		sets.engaged.DW2.Max.NOTP =
		{
			ammo="Hasty Pinion +1",
			head="Malignance Chapeau", neck="Dls. Torque +2", lear="Eabani Earring", rear="Suppanomimi",
			body="Malignance Tabard", hands="Gazu Bracelet +1", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"},
			back=gear.RDMCape_DW, waist="Orpheus's Sash", legs="Malignance Tights", feet="Malignance Boots"
		}
		
		-----------------------------------------------------------------------------------
		---	TP/h:65		(DW:36	STP:33		QA:0%	TA:4%	DA:10%)
		---	Primary Accuracy: 1140 		/ Primary Attack: 1018
		--- Auxiliary Accuracy: 1115 	/ Auxiliary Attack: 936
		-----------------------------------------------------------	
		sets.engaged.DW2.Low.Max = set_combine(sets.engaged.DW2.Max,
		{
			neck="Combatant's Torque",
			hands="Aya. Manopolas +2"
		})
		
		-----------------------------------------------------------------------------------
		---	TP/h:65		(DW:36	STP:33		QA:0%	TA:4%	DA:10%)
		---	Primary Accuracy: 1140 		/ Primary Attack: 1018
		--- Auxiliary Accuracy: 1115 	/ Auxiliary Attack: 936
		-----------------------------------------------------------	
		sets.engaged.DW2.Mid.Max = set_combine(sets.engaged.DW2.Low.Max,
		{
			hands="Gazu Bracelet +1", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"}
		})
		
		-----------------------------------------------------------------------------------
		---	TP/h:65		(DW:36	STP:33		QA:0%	TA:4%	DA:10%)
		---	Primary Accuracy: 1140 		/ Primary Attack: 1018
		--- Auxiliary Accuracy: 1115 	/ Auxiliary Attack: 936
		-----------------------------------------------------------	
		sets.engaged.DW2.High.Max = set_combine(sets.engaged.DW2.Mid.Max,
		{
			lear={name="Mache Earring +1", bag="wardrobe2"},
			waist="Kentarch Belt +1",
		})
	
	----------------------------------------------------------
	--					(DW3 + Max Haste)
	----------------------------------------------------------

	--25 DW = 11 DW needed		(NIN Sub)
	
	----------------------------------------------------------
	
		-----------------------------------------------------------------------------------
		---	TP/h:77		(DW:10	STP:39		QA:2%	TA:10%	DA:20%)
		---	Primary Accuracy: 1094 		/ Primary Attack: 950
		--- Auxiliary Accuracy: 1070 	/ Auxiliary Attack: 867
		-----------------------------------------------------------	
		sets.engaged.DW3.Max =
		{
			ammo="Aurgelmir Orb +1",
			head="Malignance Chapeau", neck="Anu Torque", lear="Sherida Earring", rear="Dedition Earring",
			body="Malignance Tabard", hands="Malignance Gloves", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"},
			back=gear.RDMCape_DW, waist="Windbuffet Belt +1", legs="Malignance Tights", feet="Malignance Boots"
		}
		
		sets.engaged.DW3.Max.ENSPELLS =
		{
			ammo="Voluspa Tathlum",
			head="Malignance Chapeau", neck="Anu Torque", lear="Sherida Earring", rear="Brutal Earring",
			body="Malignance Tabard", hands="Aya. Manopolas +2", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"},
			back=gear.RDMCape_DW, waist="Orpheus's Sash", legs="Malignance Tights", feet="Malignance Boots"
		}
		
		sets.engaged.DW3.Max.NOTP =
		{
			ammo="Voluspa Tathlum",
			head="Malignance Chapeau", neck="Dls. Torque +2", lear="Digni. Earring", rear={name="Mache Earring +1", bag="wardrobe3"},
			body="Malignance Tabard", hands="Gazu Bracelet +1", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"},
			back=gear.RDMCape_DW, waist="Orpheus's Sash", legs="Malignance Tights", feet="Malignance Boots"
		}
		
		-----------------------------------------------------------------------------------
		---	TP/h:78		(DW:10	STP:40		QA:2%	TA:8%	DA:18%)
		---	Primary Accuracy: 1121 		/ Primary Attack: 945
		--- Auxiliary Accuracy: 1096 	/ Auxiliary Attack: 859
		-----------------------------------------------------------	
		sets.engaged.DW3.Low.Max = set_combine(sets.engaged.DW3.Max,
		{
			ammo="Voluspa Tathlum",
			neck="Combatant's Torque", rear="Telos Earring",
		})
		
		-----------------------------------------------------------------------------------
		---	TP/h:78		(DW:10	STP:40		QA:2%	TA:6%	DA:14%)
		---	Primary Accuracy: 1138 		/ Primary Attack: 951
		--- Auxiliary Accuracy: 1113 	/ Auxiliary Attack: 867
		-----------------------------------------------------------	
		sets.engaged.DW3.Mid.Max = set_combine(sets.engaged.DW3.Max,
		{
			ammo="Hasty Pinion +1",
			head="Carmine Mask +1", neck="Combatant's Torque", rear="Telos Earring",
			hands="Gazu Bracelet +1",
			back=gear.RDMCape_STP, waist="Reiki Yotai", legs="Carmine Cuisses +1"
		})
		-----------------------------------------------------------------------------------
		---	TP/h:78~	(DW:10	STP:34~38	QA:0%	TA:4%	DA:14%)
		---	Primary Accuracy: 1181 		/ Primary Attack: 953
		--- Auxiliary Accuracy: 1156 	/ Auxiliary Attack: 868
		-----------------------------------------------------------	
		sets.engaged.DW3.High.Max = set_combine(sets.engaged.DW3.Mid.Max,
		{
			lear={name="Mache Earring +1", bag="wardrobe2"}, rear={name="Mache Earring +1", bag="wardrobe3"},
			back=gear.RDMCape_DW, waist="Kentarch Belt +1"
		})




	--------------------------------------
	-- Hybrid Sets
	--------------------------------------
		sets.engaged.Hybrid = 
		{
			ammo="Staunch Tathlum +1",
			head="Malignance Chapeau",
			body="Malignance Tabard", hands="Malignance Gloves", lring="Defending Ring",
			legs="Malignance Tights", feet="Malignance Boots"
		}
		
		
		----------------------------------------------------------
		-- Sword & Board
		----------------------------------------------------------	
	    sets.engaged.DT 					= set_combine(sets.engaged, 					sets.engaged.Hybrid)
		sets.engaged.DT.ENSPELLS			= set_combine(sets.engaged.ENSPELLS,			sets.engaged.Hybrid,
		{
			hands="Aya. Manopolas +2"
		})
		sets.engaged.Low.DT 				= set_combine(sets.engaged.Low, 				sets.engaged.Hybrid)
		sets.engaged.Mid.DT 				= set_combine(sets.engaged.Mid, 				sets.engaged.Hybrid)
		sets.engaged.High.DT				= set_combine(sets.engaged.High, 				sets.engaged.Hybrid)

		
		----------------------------------------------------------
		-- No Haste
		----------------------------------------------------------
		sets.engaged.DW2.DT 				= set_combine(sets.engaged.DW2, 				sets.engaged.Hybrid)
		sets.engaged.DW2.DT.ENSPELLS		= set_combine(sets.engaged.DW2.ENSPELLS,		sets.engaged.Hybrid,
		{
			hands="Aya. Manopolas +2"
		})
		sets.engaged.DW2.Low.DT 			= set_combine(sets.engaged.DW2.Low, 			sets.engaged.Hybrid)
		sets.engaged.DW2.Mid.DT 			= set_combine(sets.engaged.DW2.Mid, 			sets.engaged.Hybrid)
		sets.engaged.DW2.High.DT 			= set_combine(sets.engaged.DW2.High, 			sets.engaged.Hybrid)

		sets.engaged.DW3.DT 				= set_combine(sets.engaged.DW3, 				sets.engaged.Hybrid)
		sets.engaged.DW3.DT.ENSPELLS		= set_combine(sets.engaged.DW3.ENSPELLS,		sets.engaged.Hybrid,
		{
			hands="Aya. Manopolas +2"
		})
		sets.engaged.DW3.Low.DT 			= set_combine(sets.engaged.DW3.Low, 			sets.engaged.Hybrid)
		sets.engaged.DW3.Mid.DT 			= set_combine(sets.engaged.DW3.Mid, 			sets.engaged.Hybrid)
		sets.engaged.DW3.High.DT 			= set_combine(sets.engaged.DW3.High, 			sets.engaged.Hybrid)
		
		
		----------------------------------------------------------
		-- Minimum Haste
		----------------------------------------------------------
		sets.engaged.DW2.DT.Min 	 		= set_combine(sets.engaged.DW2.Min, 			sets.engaged.Hybrid)
		sets.engaged.DW2.DT.Min.ENSPELLS	= set_combine(sets.engaged.DW2.Min.ENSPELLS,	sets.engaged.Hybrid,
		{
			hands="Aya. Manopolas +2"
		})
		sets.engaged.DW2.Low.DT.Min  		= set_combine(sets.engaged.DW2.Low.Min, 		sets.engaged.Hybrid)
		sets.engaged.DW2.Mid.DT.Min  		= set_combine(sets.engaged.DW2.Mid.Min, 		sets.engaged.Hybrid)
		sets.engaged.DW2.High.DT.Min 		= set_combine(sets.engaged.DW2.High.Min, 		sets.engaged.Hybrid)
		
		sets.engaged.DW3.DT.Min 	 		= set_combine(sets.engaged.DW3.Min, 			sets.engaged.Hybrid)
		sets.engaged.DW3.DT.Min.ENSPELLS	= set_combine(sets.engaged.DW3.Min.ENSPELLS,	sets.engaged.Hybrid,
		{
			hands="Aya. Manopolas +2"
		})
		sets.engaged.DW3.Low.DT.Min  		= set_combine(sets.engaged.DW3.Low.Min, 		sets.engaged.Hybrid)
		sets.engaged.DW3.Mid.DT.Min  		= set_combine(sets.engaged.DW3.Mid.Min, 		sets.engaged.Hybrid)
		sets.engaged.DW3.High.DT.Min 		= set_combine(sets.engaged.DW3.High.Min, 		sets.engaged.Hybrid)
		
		
		----------------------------------------------------------
		-- Medium Haste
		----------------------------------------------------------
		sets.engaged.DW2.DT.Med 	 		= set_combine(sets.engaged.DW2.Med, 			sets.engaged.Hybrid)
		sets.engaged.DW2.DT.Med.ENSPELLS	= set_combine(sets.engaged.DW2.Med.ENSPELLS,	sets.engaged.Hybrid,
		{
			hands="Aya. Manopolas +2"
		})
		sets.engaged.DW2.Low.DT.Med  		= set_combine(sets.engaged.DW2.Low.Med, 		sets.engaged.Hybrid)
		sets.engaged.DW2.Mid.DT.Med  		= set_combine(sets.engaged.DW2.Mid.Med, 		sets.engaged.Hybrid)
		sets.engaged.DW2.High.DT.Med 		= set_combine(sets.engaged.DW2.High.Med, 		sets.engaged.Hybrid)

		sets.engaged.DW3.DT.Med 	 		= set_combine(sets.engaged.DW3.Med, 			sets.engaged.Hybrid)
		sets.engaged.DW3.DT.Med.ENSPELLS	= set_combine(sets.engaged.DW3.Med.ENSPELLS,	sets.engaged.Hybrid,
		{
			hands="Aya. Manopolas +2"
		})
		sets.engaged.DW3.Low.DT.Med  		= set_combine(sets.engaged.DW3.Low.Med, 		sets.engaged.Hybrid)
		sets.engaged.DW3.Mid.DT.Med  		= set_combine(sets.engaged.DW3.Mid.Med, 		sets.engaged.Hybrid)
		sets.engaged.DW3.High.DT.Min 		= set_combine(sets.engaged.DW3.High.Min, 		sets.engaged.Hybrid)
		
		----------------------------------------------------------
		-- Maximum Haste
		----------------------------------------------------------		
		sets.engaged.DW2.DT.Max 	 		= set_combine(sets.engaged.DW2.Max, 			sets.engaged.Hybrid)
		sets.engaged.DW2.DT.Max.ENSPELLS	= set_combine(sets.engaged.DW2.Max.ENSPELLS,	sets.engaged.Hybrid,
		{
			hands="Aya. Manopolas +2"
		})
		sets.engaged.DW2.Low.DT.Max  		= set_combine(sets.engaged.DW2.Low.Max, 		sets.engaged.Hybrid)
		sets.engaged.DW2.Mid.DT.Max  		= set_combine(sets.engaged.DW2.Mid.Max, 		sets.engaged.Hybrid)
		sets.engaged.DW2.High.DT.Max 		= set_combine(sets.engaged.DW2.High.Max, 		sets.engaged.Hybrid)
		
		sets.engaged.DW3.DT.Max 	 		= set_combine(sets.engaged.DW3.Max, 			sets.engaged.Hybrid)
		sets.engaged.DW3.DT.Max.ENSPELLS	= set_combine(sets.engaged.DW3.Max.ENSPELLS,	sets.engaged.Hybrid,
		{
			hands="Aya. Manopolas +2"
		})
		sets.engaged.DW3.Low.DT.Max  		= set_combine(sets.engaged.DW3.Low.Max, 		sets.engaged.Hybrid)
		sets.engaged.DW3.Mid.DT.Max  		= set_combine(sets.engaged.DW3.Mid.Max, 		sets.engaged.Hybrid)
		sets.engaged.DW3.High.DT.Max 		= set_combine(sets.engaged.DW3.High.Max, 		sets.engaged.Hybrid)
		
end


function determine_DW()

	local sub_job_dw = 0
	local player_has_sj = false
	
	if player.sub_job then
		if 		player.sub_job == 'DNC' then 
			sub_job_dw = 15
		elseif 	player.sub_job == 'NIN' then 
			sub_job_dw = 25
		end
	end

	return sub_job_dw
end

	
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
function job_post_precast(spell, action, spellMap, eventArgs)
	
	
	if spell.type == 'WeaponSkill' and magical_ws:contains(spell.name) then
		if spell.element ~= world.day_element and spell.element ~= world.weather_element then
			if spell.target.distance < (15 - spell.target.model_size) then
				equip { waist="Orpheus's Sash" }
			end
		elseif (spell.element == world.day_element and spell.element == world.weather_element)
				or (spell.element == world.weather_element and get_weather_intensity() == 2 and world.day_element ~= elements.strong_to[spell.element]) then
			equip { waist="Hachirin-no-Obi" }
		elseif (spell.element == world.day_element or (spell.element == world.weather_element and get_weather_intensity() == 1)
				or (spell.element == world.weather_element and get_weather_intensity() == 2 and world.day_element == elements.strong_to[spell.element])) then
			equip { waist="Hachirin-no-Obi" }
		end	
	end
	
	
end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.action_type == 'Magic' then
		apply_abilities(spell, action, spellMap, eventArgs)
	end
	
	-- if spellMap == 'Cures' or spellMap == 'Curagas' and (spell.element == world.day_element and spell.element == world.weather_element) then
		-- equip
		-- {
			-- back="Twilight Cape", waist="Hachirin-no-Obi",
		-- }
	-- end
	
	if spell.target.type == 'SELF' then
		if (spellMap == 'Cures' or spellMap == 'Refresh') then
        	equip
			{ 
				hands=gear.ENH_Gloves,
				waist="Gishdubar Sash" 
			}
		end
		
		if spell.english == 'Phalanx' or spell.english == 'Phalanx II' then
			equip(sets.midcast.Enhancement.Self)
		end
	end


	if spell.skill == 'Elemental Magic' and state.MagicBurst.value and state.CastingMode.value ~= 'Resistant' then
		if spell.english ~= 'Impact' then
			equip(sets.magic_burst)
		else
			equip(set_combine(sets.magic_burst,
			{
				head=empty, lear="Static Earring",
				body="Twilight Cloak",
				feet="Ea Pigaches +1"
			}))
		end
	elseif spell.skill == 'Elemental Magic' and state.MagicBurst.value and state.CastingMode.value == 'Resistant' then
		if spell.english ~= 'Impact' then
			equip(sets.magic_burst.Resistant)
		else
			equip(set_combine(sets.magic_burst.Resistant,
			{
				head=empty, lear="Static Earring",
				body="Twilight Cloak", rring="Locus Ring",
			}))
		end
	end

	if spell.skill == 'Elemental Magic' and spell.element == 'Dark' and spell.english ~= 'Impact' then
		if state.CastingMode.value ~= 'Resistant' then
			equip
			{
				head="Pixie Hairpin +1",
				rring="Archon Ring"
			}
		else
			equip { rring="Archon Ring" }
		end
	end
	
	if spell.skill == 'Elemental Magic' and state.SaveMP.value and spell.english ~= 'Impact' then
		equip{body="Seidr Cotehardie"}
		
		if state.MagicBurst.value then
			equip
			{
				neck="Mizu. Kubikazari",
				hands="Ea Cuffs +1",
				feet="Ea Pigaches +1"
			}
		end
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
	
	
	if spell.skill == 'Elemental Magic' and determine_DW() > 0 then
		equip{ main="Maxentius", sub="Daybreak" }
	end
	
	
	if state.TreasureMode.value ~= 'None' and (spell.english == 'Poisonga' or spell.english == 'Diaga' or spell.english == 'Poison' or spell.english == 'Dia' or spell.english == 'Sleepga') 
			and spell.target.type == 'MONSTER' then
		equip(sets.TreasureHunter)
	end
end


function job_aftercast(spell,action, spellMap, eventArgs)
	equip(sets[state.MainWeaponSet.current])
	
	if determine_DW() > 0 then
		equip(sets[state.SubWeaponSet.current])
	end
	
	if (buffactive[94] or buffactive[95] or buffactive[96] or buffactive[97] or buffactive[98] or buffactive[99]) then
		if player.equipment.main == "Crocea Mors" then
			classes.CustomMeleeGroups:append('ENSPELLS')
		elseif player.equipment.main == "Norgish Dagger" then
			classes.CustomMeleeGroups:append('NOTP')
		end
		
		handle_equipping_gear(player.status)
	end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------
function job_buff_change(buff,gain)
	-- If we gain or lose any haste buffs, adjust which gear set we target.
	if S{'haste','march','embrava','haste samba', 'mighty guard', 'geo-haste','indi-haste','slow','indi-slow','elegy'}:contains(buff:lower()) then
		determine_haste_group()
		handle_equipping_gear(player.status)
	elseif state.Buff[buff] ~= nil then
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
	
	if (buffactive[94] or buffactive[95] or buffactive[96] or buffactive[97] or buffactive[98] or buffactive[99]) then
		if player.equipment.main == "Crocea Mors" then
			classes.CustomMeleeGroups:append('ENSPELLS')
		elseif player.equipment.main == "Norgish Dagger" then
			classes.CustomMeleeGroups:append('NOTP')
		end
		
		handle_equipping_gear(player.status)
	end
end

function job_status_change(new_status, old_status)
	if new_status == 'Engaged' then
		equip(sets[state.MainWeaponSet.current])
		
		if determine_DW() > 0 then
			equip(sets[state.SubWeaponSet.current])
		end
		
		determine_haste_group()
		update_combat_form()
	end
	
	if (buffactive[94] or buffactive[95] or buffactive[96] or buffactive[97] or buffactive[98] or buffactive[99]) then
		if player.equipment.main == "Crocea Mors" then
			classes.CustomMeleeGroups:append('ENSPELLS')
		elseif player.equipment.main == "Norgish Dagger" then
			classes.CustomMeleeGroups:append('NOTP')
		end
		
		handle_equipping_gear(player.status)
	end
end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
	equip(sets[state.MainWeaponSet.current])
	
	if determine_DW() > 0 then
		equip(sets[state.SubWeaponSet.current])
	end
	
	if (buffactive[94] or buffactive[95] or buffactive[96] or buffactive[97] or buffactive[98] or buffactive[99]) then
		if player.equipment.main == "Crocea Mors" then
			classes.CustomMeleeGroups:append('ENSPELLS')
		elseif player.equipment.main == "Norgish Dagger" then
			classes.CustomMeleeGroups:append('NOTP')
		end
		
		handle_equipping_gear(player.status)
	end
end

function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet,
		{
			body="Jhakri Robe +2",
			waist="Fucho-no-Obi"
		})
    end
	
	if determine_DW() > 0 then
		idleSet = set_combine(idleSet, sets[state.MainWeaponSet.current], sets[state.SubWeaponSet.current])
	end
	
	return idleSet
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
	equip(sets[state.MainWeaponSet.current])
	
	if determine_DW() > 0 then
		equip(sets[state.SubWeaponSet.current])
	end
	
	if (buffactive[94] or buffactive[95] or buffactive[96] or buffactive[97] or buffactive[98] or buffactive[99]) then
		if player.equipment.main == "Crocea Mors" then
			classes.CustomMeleeGroups:append('ENSPELLS')
		elseif player.equipment.main == "Norgish Dagger" then
			classes.CustomMeleeGroups:append('NOTP')
		end
		
		handle_equipping_gear(player.status)
	end
	
	determine_haste_group()
	update_combat_form()
	update_active_abilities()
end

-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
	local msg = '[' .. state.MainWeaponSet.value

	if player.sub_job == 'NIN' then
		msg = msg  .. '/' .. state.SubWeaponSet.value .. ']'
	end
	
	if state.CombatForm.has_value then
		msg = msg .. ' (' .. state.CombatForm.value .. ')'
	end

	msg = msg .. ': '

	msg = msg .. state.OffenseMode.value
	if state.HybridMode.value ~= 'Normal' then
		msg = msg .. '/' .. state.HybridMode.value
	end
	msg = msg .. ', WS: ' .. state.WeaponskillMode.value

	if state.DefenseMode.value ~= 'None' then
		msg = msg .. ', ' .. 'Defense: ' .. state.DefenseMode.value .. ' (' .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ')'
	end
	
	msg = msg .. ' ' .. 'Casting Mode: ' .. state.CastingMode.value
	
	if state.TreasureMode.has_value then
		msg = msg .. ', TH: ' .. state.TreasureMode.value
	end
	
	if state.MagicBurst.value == true then
		msg= msg .. ' (Magic Burst On)'
	end

	if state.Kiting.value == true then
		msg = msg .. ', [KITING]'
	end

	add_to_chat(122, msg)

	eventArgs.handled = true
end
-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function determine_haste_group()
--[[
				buffactive[1]	= Weakness
				buffactive[13]	= Slow
				buffactive[33]	= Haste
				buffactive[194]	= Elegy
				buffactive[214]	= March
				buffactive[228]	= Embrava
				buffactive[370]	= Haste Samba
				buffactive[580]	= Geo-Haste
				buffactive[604]	= Mighty Guard							]]
	
	classes.CustomMeleeGroups:clear()

	if buffactive[1] or buffactive[13] or buffactive[194] then
		classes.CustomMeleeGroups:append('')						-- Slow Status Effect
		--add_to_chat(8, '*********Slowed Status Effect Set***********')
	else
		if (((buffactive[33] or buffactive[580] or buffactive.embrava) and (buffactive[214] or buffactive[604])) or
			(buffactive[33] and (buffactive[580] or buffactive.embrava)) or (buffactive.march == 2 and buffactive[604])) then
			classes.CustomMeleeGroups:append('Max')								-- 43.75% Magical Haste
			--add_to_chat(8, '*********Maximum Haste Set***********')
		elseif buffactive[33] or buffactive.march == 2 or buffactive[580] or buffactive[228] then
			classes.CustomMeleeGroups:append('Med')								-- 30% Magical Haste
			--add_to_chat(8, '*********Medium Haste Set***********')
		elseif buffactive[214] or buffactive[604] then
			classes.CustomMeleeGroups:append('Min')								-- 15% Magical Haste
			--add_to_chat(8, '*********Minimum Haste Set***********')
		else
			classes.CustomMeleeGroups:append('')								-- No Magical Haste
			--add_to_chat(8, '********* No Haste Set ***********')
		end
	end
end

-- Determines Dual Wield level for Combat Form
function update_combat_form()
    if determine_DW() == 25  then
		state.CombatForm:set('DW3')	
		--add_to_chat(8, '-------------Dual Wield Level 3 Detected--------------')
	elseif determine_DW() == 15  then
		state.CombatForm:set('DW2')
		--add_to_chat(8, '-------------Dual Wield Level 2 Detected--------------')
	else
        state.CombatForm:reset()
		--add_to_chat(8, '------------- No Dual Wield Detected   --------------')
    end
end

function update_active_abilities()
	state.Buff['Saboteur'] = buffactive['Saboteur'] or false
	state.Buff['Composure'] = buffactive['Composure'] or false
end

function apply_abilities(spell, action, spellMap)
	if buffactive.Composure and spell.skill == 'Enhancing Magic' then
		if (spell.target.type == 'PLAYER' or spell.target.type == 'NPC') and spellMap ~= 'Regen' and spellMap ~='Refresh' then
			equip(sets.buff['Composure'])
		elseif (spell.target.type == 'PLAYER' or spell.target.type == 'NPC') and spellMap == 'Regen' then
			equip(
			{
				head="Leth. Chappel +1",
				legs="Leth. Fuseau +1"
			})
		end
	end

	if buffactive.Saboteur and spell.skill == 'Enfeebling Magic' and spellMap ~='Static' then
		equip(sets.buff['Saboteur'])
	end
end

-- Select default macro book on initial load or subjob change.
function apply_job_change()
    set_macro_page(1, 5)
	
	send_command('wait 3; input /lockstyleset 5')
end