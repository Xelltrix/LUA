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
    state.OffenseMode:options('Normal', 'Low', 'Mid', 'High')
	state.WeaponskillMode:options('Normal', 'Low', 'Mid', 'High')
    state.HybridMode:options('Normal', 'DT')
    state.CastingMode:options('Normal', 'Resistant', 'Potency')
    state.IdleMode:options('Normal', 'DT', 'Refresh')
	
	state.WeaponSet = M{['description']='Weapon Set',
		'SequenceK',
		'SequenceA',
		'KajaT',
		'Almace',
	}

	send_command('bind pageup gs c cycle WeaponSet')
	send_command('bind pagedown gs c cycleback WeaponSet')

	apply_job_change()
end

function user_unload()
	send_command('unbind pageup')
	send_command('unbind pagedown')
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

		sets.precast.JA['Chainspell'] = 
		{
			body="Viti. Tabard +3"
		}

	
	-------------------
	-- Precast Magic --
	------------------- 
	
		sets.precast.FC =
		{
			ammo="Staunch Tathlum +1",
			head="Atrophy Chapeau +3", neck="Orunmila's Torque", lear="Etiolation Earring", rear="Loquacious Earring",
			body="Viti. Tabard +3", hands="Chironic Gloves", lring="Kishar Ring", rring="Evanescence Ring", 
			back=gear.RDMCape_DW, waist="Witful Belt", legs="Carmine Cuisses +1",feet="Amalric Nails +1"
		}

		sets.precast.FC.Impact = 
		{
			ammo="Sapience Orb",
			head=empty, neck="Orunmila's Torque", neck="Orunmila's Torque", lear="Etiolation Earring", rear="Loquacious Earring",
			body="Twilight Cloak", hands="Leyline Gloves", lring="Kishar Ring", rring="Rahab Ring", 
			back=gear.RDMCape_DW, waist="Witful Belt", legs="Lengo Pants", feet="Carmine Greaves +1"
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
		{
			ammo="Staunch Tathlum +1",
			head="Atrophy Chapeau +3", neck="Orunmila's Torque", lear="Etiolation Earring", rear="Loquacious Earring",
			body="Viti. Tabard +3", hands="Chironic Gloves", lring="Kishar Ring", rring="Evanescence Ring", 
			back=gear.RDMCape_DW, waist="Witful Belt", legs="Carmine Cuisses +1",feet="Amalric Nails +1"
		}

		sets.midcast.ConserveMP = 
		{
			ammo="Pemphredo Tathlum",
			head="Vanya Hood", neck="Incanter's Torque", lear="Gwati Earring", rear="Mendi. Earring",
			body="Chironic Doublet", hands="Leyline Gloves", lring="Kishar Ring", rring="Rahab Ring",
			back="Fi Follet Cape +1", waist="Luminary Sash", legs="Lengo Pants", feet="Carmine Greaves +1"
		}
		
		sets.midcast.Duration =
		{
			main="Colada", sub="Ammurapi Shield", ammo="Sapience Orb",
			head="Telchine Cap", neck="Dls. Torque +1", lear="Etiolation Earring", rear="Loquac. Earring",
			body="Viti. Tabard +3", hands="Atrophy Gloves +3", lring="Kishar Ring", rring="Rahab Ring",
			back="Ghostfyre Cape", waist="Witful Belt", legs="Telchine Braconi", feet="Leth. Houseaux +1"
		}

    --------------------------------------
	-- Healing Midcast sets
	--------------------------------------	
	
		-- Cure Potency: 50%		Enmity: -55		Healing Magic Skill: +53
		sets.midcast.Cures =
		{
			ammo="Esper Stone +1",
			head="Kaykaus Mitra", neck="Lasaia Pendant", lear="Novia Earring", rear="Mendi. Earring",
			body="Kaykaus Bliaut", hands="Kaykaus Cuffs +1", lring="Lebeche Ring", rring="Kuchekula Ring",
			back="Ghostfyre Cape", waist="Bishop's Sash", legs="Atrophy Tights +3", feet="Vanya Clogs"
		}

		sets.midcast.Curagas = sets.midcast.Cures

		sets.midcast.StatusRemoval = sets.midcast.FC

		sets.midcast.Cursna = set_combine(sets.midcast.FC,
		{
			head="Kaykaus Mitra", neck="Debilis Medallion", lear="Beatific Earring", rear="Healing Earring",
			hands="Hieros Mittens", lring="Haoma's Ring", rring="Menelaus's Ring",
			back="Oretan. Cape +1", waist="Bishop's Sash", feet="Vanya Clogs"
		})
		
		sets.midcast.Raise = sets.midcast.ConserveMP

		sets.midcast.Reraise = sets.midcast.ConserveMP

    --------------------------------------
	-- Buffing Midcast sets
	--------------------------------------	
	
		sets.midcast.Regen =
		{
			main="Bolelabunga", sub="Ammurapi Shield", ammo="Pemphredo Tathlum",
			head="Telchine Cap", neck="Dls. Torque +1", lear="Gwati Earring", rear="Mendi. Earring",
			body="Telchine Chas.", hands="Atrophy Gloves +3", lring="Kishar Ring", rring="Evanescence Ring",
			back="Ghostfyre Cape", waist="Luminary Sash", legs="Telchine Braconi", feet="Leth. Houseaux +1"
		}

		sets.midcast.Refresh =
		{
			main="Colada", sub="Ammurapi Shield", ammo="Sapience Orb",
			head="Amalric Coif +1", neck="Dls. Torque +1", lear="Etiolation Earring", rear="Loquac. Earring",
			body="Atrophy Tabard +3", hands="Atrophy Gloves +3", lring="Kishar Ring", rring="Rahab Ring",
			back="Ghostfyre Cape", waist="Witful Belt", legs="Leth. Fuseau +1", feet="Leth. Houseaux +1"
		}

		sets.midcast.Enspells =
		{
			main="Colada", sub="Ammurapi Shield", ammo="Pemphredo Tathlum",
			head="Befouled Crown", neck="Incanter's Torque", lear="Andoaa Earring", rear="Augment. Earring",
			body="Viti. Tabard +3", hands="Viti. Gloves +3", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back="Fi Follet Cape +1", waist="Olympus Sash", legs="Atrophy Tights +3", feet="Leth. Houseaux +1"
		}
		
		sets.midcast.EnspellsDW = set_combine(sets.midcast.Enspells,
		{
			main="Pukulatmuj +1", sub="Pukulatmuj",
		})

		sets.midcast.Phalanxs = set_combine(sets.midcast.Enspells,
		{
			ammo="Staunch Tathlum +1",
			head=gear.THead_Phalanx, neck="Dls. Torque +1",
			body=gear.TBody_Phalanx, hands=gear.THands_Phalanx,
			legs=gear.TLegs_Phalanx, feet=gear.TFeet_Phalanx
		})
		
		sets.midcast.PhalanxDW = set_combine(sets.midcast.Phalanx,
		{
			main="Pukulatmuj +1", sub="Pukulatmuj"
		})

		sets.midcast.Klimaform = sets.midcast.FastRecast

		sets.midcast.GainStat =
		{
			main="Colada", sub="Ammurapi Shield", ammo="Pemphredo Tathlum",
			head="Telchine Cap", neck="Dls. Torque +1", lear="Andoaa Earring", rear="Mendi. Earring",
			body="Viti. Tabard +3", hands="Viti. Gloves +3", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back="Ghostfyre Cape", waist="Luminary Sash", legs="Telchine Braconi", feet="Leth. Houseaux +1"
		}

		sets.midcast.BarElement = set_combine(sets.midcast.GainStat,
		{
			legs="Shedir Seraweels"
		})

		sets.midcast.BarStatus = sets.midcast.Duration

		sets.midcast.Stoneskin = set_combine(sets.midcast.Duration,
		{
			ammo="Staunch Tathlum +1",
			neck="Stone Gorget", rear="Earthcry Earring",
			hands="Stone Mufflers",
			waist="Siegel Sash", legs="Shedir Seraweels"
		})

		sets.midcast.Aquaveil = set_combine(sets.midcast.Duration,
		{
			ammo="Staunch Tathlum +1",
			head="Amalric Coif +1", hands="Regal Cuffs",
			waist="Emphatikos Rope", legs="Shedir Seraweels"
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
			main="Maxentius", sub="Ammurapi Shield", range="Kaja Bow",
			head="Atrophy Chapeau +3", neck="Dls. Torque +1", lear="Regal Earring", rear="Digni. Earring", 
			body="Atrophy Tabard +3", hands="Kaykaus Cuffs +1", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back=gear.RDMCape_ENF, waist="Luminary Sash", legs="Chironic Hose", feet="Vitiation Boots +3"
		}

		sets.midcast['Enfeebling Magic'] = 
		{
			main="Maxentius", sub="Ammurapi Shield", ammo="Regal Gem",
			head="Viti. Chapeau +3", neck="Dls. Torque +1", lear="Regal Earring", rear="Digni. Earring", 
			body="Atrophy Tabard +3", hands="Regal Cuffs", lring="Kishar Ring", rring={name="Stikini Ring +1", bag="wardrobe3"},
			back=gear.RDMCape_ENF, waist="Luminary Sash", legs="Chironic Hose", feet="Vitiation Boots +3"
		}

		sets.midcast['Enfeebling Magic'].Resistant = sets.midcast.Macc

		sets.midcast['Enfeebling Magic'].Potency = set_combine(sets.midcast['Enfeebling Magic'],
		{
			body="Lethargy Sayon +1", hands="Kaykaus Cuffs +1", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
		})
		
		sets.midcast.Static = set_combine(sets.midcast['Enfeebling Magic'].Resistant,
		{
			hands="Regal Cuffs", lring="Kishar Ring"
		})
		
		sets.midcast.ESkill = set_combine(sets.midcast['Enfeebling Magic'].Potency,
		{
			main=gear.Grioavolr_Enf, sub="Enki Strap",
			neck="Incanter's Torque", rear="Enfeebling Earring",
			body="Atrophy Tabard +3", hands="Leth. Gantherots +1",
			waist="Casso Sash"
		})
		
		sets.midcast.Dispel = sets.midcast['Enfeebling Magic'].Resistant
		
		sets.midcast.Frazzle = sets.midcast['Enfeebling Magic'].Resistant
		
		sets.midcast.ElementalDebuffs = sets.midcast.Macc

		sets.midcast['Dia'] = sets.midcast.FastRecast
		
		sets.midcast['Dia II'] = sets.midcast.FastRecast
		
		sets.midcast['Dia III'] = set_combine(sets.midcast.ConserveMP,
		{
			head="Viti. Chapeau +3", neck="Dls. Torque +1",
			hands="Regal Cuffs", lring="Kishar Ring"
		})

		
	---Dark Magic
		sets.midcast['Dark Magic'] = set_combine(sets.midcast.Macc,
		{
			main="Maxentius", sub="Ammurapi Shield",
			neck="Erra Pendant", 
			body="Shango Robe",
			feet="Vitiation Boots +3"
		})

		sets.midcast.Sap = set_combine(sets.midcast['Dark Magic'],
		{
			head="Pixie Hairpin +1", lear="Gwati Earring",
			body="Chironic Doublet", hands="Leyline Gloves", lring="Archon Ring", rring="Evanescence Ring", 
			waist="Fucho-no-Obi", feet=gear.NukeCrackows
		})

		sets.midcast.Stun = set_combine(sets.midcast.Macc,
		{
			main="Maxentius", sub="Chanter's Shield", 
			neck="Erra Pendant",
			body="Shango Robe", hands="Leyline Gloves", lring="Kishar Ring",
			back=gear.RDMCape_Nuke, legs="Aya. Cosciales +2", feet=gear.NukeCrackows
		})
		
		sets.midcast.Stun.Resistant = set_combine(sets.midcast.Macc,
		{
			legs="Aya. Cosciales +2"
		})

	-- Elemental Magic
		sets.midcast['Elemental Magic'] =
		{
			main="Maxentius", sub="Ammurapi Shield", ammo="Pemphredo Tathlum",
			head=gear.NukeHood, neck="Sanctity Necklace", lear="Regal Earring", rear="Friomisi Earring", 
			body="Amalric Doublet +1", hands="Amalric Gages +1", lring={name="Shiva Ring +1", bag="wardrobe2"}, rring={name="Shiva Ring +1", bag="wardrobe3"},
			back=gear.RDMCape_Nuke, waist="Refoccilation Stone", legs="Amalric Slops +1", feet="Amalric Nails +1"
		}

		sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'],
		{
			waist="Eschan Stone", legs="Jhakri Slops +2", feet="Vitiation Boots +3"
		})

		sets.midcast['Elemental Magic'].Potency = sets.midcast['Elemental Magic']

		sets.midcast.Impact = set_combine(sets.midcast.Macc,
		{
			head=empty, lear="Digni. Earring",
			body="Twilight Cloak",lring="Archon Ring",
		})
		
		sets.magic_burst =
		{
			main="Maxentius", sub="Ammurapi Shield", ammo="Pemphredo Tathlum",
			head=gear.NukeHood, neck="Mizu. Kubikazari", lear="Regal Earring", rear="Static Earring",
			body="Merlinic Jubbah", hands="Amalric Gages +1", lring={name="Shiva Ring +1", bag="wardrobe2"}, rring="Mujin Band",
			back=gear.RDMCape_Nuke, waist="Refoccilation Stone", legs="Amalric Slops +1", feet=gear.NukeCrackows
		}
		
		sets.magic_burst.Resistant = set_combine(sets.magic_burst,
		{
			head="Atrophy Chapeau +3",
			hands="Regal Cuffs",
			waist="Eschan Stone", legs="Jhakri Slops +2", feet="Vitiation Boots +3"
		})
	

	
	
	--------------------------------------
	-- Miscellaneous Midcast sets
	--------------------------------------  
	
		sets.midcast.Teleport = sets.midcast.ConserveMP
		
		sets.midcast.Utsusemi = sets.midcast.FC
		
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


		sets.SequenceK = { main="Sequence", sub="Kaja Knife" }

		sets.SequenceA = { main="Sequence", sub="Almace" }
			
		sets.KajaT = { main="Kaja Sword", sub="Thibron" }
			
		sets.Almace = { main="Almace", sub="Kaja Knife" }
		
	
	------------------------------------------------------------------------------------------------
	------------------------------------------ Idle Sets -------------------------------------------
	------------------------------------------------------------------------------------------------

		sets.idle =
		{
			main="Bolelabunga", sub="Genmei Shield", ammo="Homiliary",
			head="Viti. Chapeau +3", neck="Sanctity Necklace", lear="Dawn Earring", rear="Infused Earring",
			body="Atrophy Tabard +3", hands="Chironic Gloves", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back=gear.RDMCape_DW, waist="Flume Belt +1", legs="Carmine Cuisses +1", feet="Chironic Slippers"
		}

		sets.idle.DT = set_combine(sets.idle,
		{
			main="Mafic Cudgel", sub="Genmei Shield", ammo="Staunch Tathlum +1",
			neck="Loricate Torque +1", lear="Etiolation Earring", rear="Sanare Earring",
			lring="Defending Ring", rring="Gelatinous Ring +1"
		})
		
		sets.idle.Refresh = set_combine(sets.idle,
		{
			body="Jhakri Robe +2",
			legs="Lengo Pants"
		})

		sets.idle.Town = set_combine(sets.idle,
		{
			legs="Carmine Cuisses +1"
		})
		
		sets.idle.Adoulin = set_combine(sets.idle,
		{
			body="Councilor's Garb"
		})

		sets.idle.Weak = sets.idle.DT

	
	------------------------------------------------------------------------------------------------
	--------------------------------------- Defense Sets -------------------------------------------
	------------------------------------------------------------------------------------------------
	
	
	--------------------------------------
	-- Defensive Sets
	--------------------------------------
		sets.defense.PDT =
		{
			main="Mafic Cudgel", sub="Genmei Shield", ammo="Staunch Tathlum +1",
			head="Viti. Chapeau +3", neck="Loricate Torque +1", lear="Etiolation Earring", rear="Odnowa Earring +1",
			body="Atrophy Tabard +3", hands="Chironic Gloves", lring="Defending Ring", rring="Gelatinous Ring +1",
			back=gear.RDMCape_DW, waist="Flume Belt +1", legs="Lengo Pants", feet="Chironic Slippers"
		}
		
		sets.defense.MDT = 
		{
			main="Mafic Cudgel", sub="Genmei Shield", ammo="Staunch Tathlum +1",
			head="Viti. Chapeau +3", neck="Loricate Torque +1", lear="Static Earring", rear="Sanare Earring",
			body="Viti. Tabard +3", hands="Aya. Manopolas +2", lring="Defending Ring", rring="Shukuyu Ring",
			back="Reiki Cloak", waist="Carrier's Sash", legs="Viti. Tights +3", feet="Vitiation Boots +3"
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

		sets.buff['Saboteur'] =
		{
			hands="Leth. Gantherots +1"
		}

		sets.buff['Composure'] =
		{
			head="Leth. Chappel +1",
			body="Lethargy Sayon +1", 
			legs="Leth. Fuseau +1", feet="Leth. Houseaux +1"
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
			head="Viti. Chapeau +3", neck="Fotia Gorget", lear="Sherida Earring", rear="Moonshade Earring",
			body="Viti. Tabard +3", hands="Atrophy Gloves +3", lring="Rufescent Ring", rring="Karieyh Ring +1",
			back=gear.RDMCape_WSD, waist="Fotia Belt", legs=gear.TLegs_TP, feet="Carmine Greaves +1"
		}

		sets.precast.WS.Mid = sets.precast.WS.Low

		sets.precast.WS.High = sets.precast.WS.Mid
	
    --	***Swords***
	
	---Chant du Cygne
		sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS,
		{
			ammo="Yetshila",
			head=gear.THead_TP, rear={name="Mache Earring +1", bag="wardrobe3"},
			body="Ayanmo Corazza +2", hands="Aya. Manopolas +2", lring="Begrudging Ring", rring="Ilabrat Ring",
			back=gear.RDMCape_Crit, legs="Viti. Tights +3", feet="Thereoid Greaves"
		})
	
		sets.precast.WS['Chant du Cygne'].Low = set_combine(sets.precast.WS['Chant du Cygne'],
		{
			legs="Aya. Cosciales +2"
		})
		
		sets.precast.WS['Chant du Cygne'].Mid = set_combine(sets.precast.WS['Chant du Cygne'].Low,
		{
			feet="Aya. Gambieras +2"
		})
		
		sets.precast.WS['Chant du Cygne'].High = set_combine(sets.precast.WS['Chant du Cygne'].Mid,
		{
			head="Aya. Zucchetto +2", lear={name="Mache Earring +1", bag="wardrobe2"},
			hands="Aya. Manopolas +2",
		})

	---Vorpal Blade
		sets.precast.WS['Vorpal Blade'] = set_combine(sets.precast.WS['Chant du Cygne'],
		{
			rear="Moonshade Earring",
			rring="Shukuyu Ring",
			back=gear.RDMCape_WSD
		})

		sets.precast.WS['Vorpal Blade'].Low = set_combine(sets.precast.WS['Chant du Cygne'].Low,
		{
			rear="Moonshade Earring",
			rring="Rufescent Ring",
			back=gear.RDMCape_WSD
		})
		
		sets.precast.WS['Vorpal Blade'].Mid = sets.precast.WS['Chant du Cygne'].Mid
		
		sets.precast.WS['Vorpal Blade'].High = sets.precast.WS['Chant du Cygne'].High	
	
	---Requiescat
		sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS,
		{
			ammo="Regal Gem",
			head="Viti. Chapeau +3", lear="Regal Earring",
			rring={name="Stikini Ring +1", bag="wardrobe3"},
			back=gear.RDMCape_ENF, legs="Jhakri Slops +2", feet="Jhakri Pigaches +2"
		})

		sets.precast.WS['Requiescat'].Low = set_combine(sets.precast.WS['Requiescat'],
		{
			head="Carmine Mask +1"
		})
		
		sets.precast.WS['Requiescat'].Mid = set_combine(sets.precast.WS['Requiescat'].Low,
		{
			legs="Carmine Cuisses +1"
		})
		
		sets.precast.WS['Requiescat'].High = set_combine(sets.precast.WS['Requiescat'].Mid,
		{
			lear={name="Mache Earring +1", bag="wardrobe2"}, rear={name="Mache Earring +1", bag="wardrobe3"},
		})
	
	---Savage Blade
		sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS,
		{
			ammo="Regal Gem",
			head="Viti. Chapeau +3", neck="Dls. Torque +1", lear="Regal Earring",
			lring="Shukuyu Ring",
			waist="Prosilio Belt +1", legs="Jhakri Slops +2", feet="Carmine Greaves +1"
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
			head="Pixie Hairpin +1", neck="Sanctity Necklace", lear="Regal Earring", rear="Friomisi Earring",
			body="Amalric Doublet +1", hands="Jhakri Cuffs +2", lring="Archon Ring", rring="Karieyh Ring +1",
			back=gear.RDMCape_ENF, waist="Orpheus's Sash", legs="Amalric Slops +1", feet="Vitiation Boots +3"
		}
	
	
	--	***Daggers***
	
	---Evisceration
		sets.precast.WS['Evisceration'] = sets.precast.WS['Chant du Cygne']
	
		sets.precast.WS['Evisceration'].Low = sets.precast.WS['Chant du Cygne'].Low
		
		sets.precast.WS['Evisceration'].Mid = sets.precast.WS['Chant du Cygne'].Mid
		
		sets.precast.WS['Evisceration'].High = sets.precast.WS['Chant du Cygne'].High

	---Exenterator
		sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS['Requiescat'],
		{
			head=gear.THead_TP,
			body="Ayanmo Corazza +2", hands=gear.THands_TP, lring="Shukuyu Ring", rring="Ilabrat Ring",
			legs=gear.TLegs_TP, feet=gear.TFeet_TP
		})

		sets.precast.WS['Requiescat'].Low = set_combine(sets.precast.WS['Requiescat'],
		{
			rring={name="Chirich Ring +1", bag="wardrobe3"}
		})
		
		sets.precast.WS['Requiescat'].Mid = set_combine(sets.precast.WS['Requiescat'].Low,
		{
			legs="Carmine Cuisses +1"
		})
		
		sets.precast.WS['Requiescat'].High = set_combine(sets.precast.WS['Requiescat'].Mid,
		{
			lear={name="Mache Earring +1", bag="wardrobe2"}, rear={name="Mache Earring +1", bag="wardrobe3"},
		})

	---Aeolian Edge
		sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS['Sanguine Blade'] ,
		{
			head=gear.NukeHood, 
			lring={name="Shiva Ring +1", bag="wardrobe2"},
			back=gear.RDMCape_Nuke
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
			sub="Genmei Shield", ammo="Ginsen",
			head=gear.THead_TP, neck="Anu Torque", lear="Sherida Earring", rear="Brutal Earring",
			body="Ayanmo Corazza +2", hands="Carmine Fin. Ga. +1", lring="Hetairoi Ring", rring="Ilabrat Ring",
			back=gear.RDMCape_STP, waist="Windbuffet Belt +1", legs=gear.TLegs_TP, feet="Carmine Greaves +1"
		}

		-----------------------------------------------------------------------------------
		---	TP/h:104	(STP:39		QA:2%	TA:8%	DA:24%)
		---	Primary Accuracy: 1093~		/ Primary Attack: 971~
		--- DT: 9%	PDT: 19%	MDT: 9%		Defense: 1074~
		-----------------------------------------------------------
		sets.engaged.Low = set_combine(sets.engaged,
		{
			rear="Telos Earring",
			hands="Aya. Manopolas +2", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"},
		})

		-----------------------------------------------------------------------------------
		---	TP/h:104	(STP:39		QA:2%	TA:2%	DA:24%)
		---	Primary Accuracy: 1124~		/ Primary Attack: 1004~
		--- DT: 11%	PDT: 21%	MDT: 11%		Defense: 1115~
		-----------------------------------------------------------
		sets.engaged.Mid = set_combine(sets.engaged.Low,
		{
			head="Carmine Mask +1", neck="Combatant's Torque", rear={name="Mache Earring +1", bag="wardrobe3"},
		})

		-----------------------------------------------------------------------------------
		---	TP/h:101~	(STP:31~35	QA:0%	TA:0%	DA:14%)
		---	Primary Accuracy: 1170~		/ Primary Attack: 1001~
		--- DT: 11%	PDT: 21%	MDT: 11%		Defense: 1120~
		-----------------------------------------------------------
		sets.engaged.High = set_combine(sets.engaged.Mid,
		{
			lear={name="Mache Earring +1", bag="wardrobe2"}, 
			waist="Kentarch Belt +1", legs="Viti. Tights +3", feet="Aya. Gambieras +2"
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
			ammo="Ginsen",
			head=gear.THead_TP, neck="Anu Torque", lear="Eabani Earring", rear="Suppanomimi",
			body="Ayanmo Corazza +2", hands=gear.THands_TP, lring="Hetairoi Ring", rring="Ilabrat Ring",
			back=gear.RDMCape_DW, waist="Reiki Yotai", legs="Carmine Cuisses +1", feet=gear.TFeet_TP
		}

		-----------------------------------------------------------------------------------
		---	TP/h:63		(DW:36	STP:29		QA:0%	TA:4%	DA:7%)
		---	Primary Accuracy: 1130 		/ Primary Attack: 1017
		--- Auxiliary Accuracy: 1106 	/ Auxiliary Attack: 937
		-----------------------------------------------------------		
		sets.engaged.DW2.Low = set_combine(sets.engaged.DW2,
		{
			hands="Aya. Manopolas +2", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"},
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
			waist="Kentarch Belt +1",
			feet="Aya. Gambieras +2"
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
			ammo="Ginsen",
			head=gear.THead_TP, neck="Anu Torque", lear="Eabani Earring", rear="Suppanomimi",
			body="Ayanmo Corazza +2", hands=gear.THands_TP, lring="Hetairoi Ring", rring="Ilabrat Ring",
			back=gear.RDMCape_DW, waist="Reiki Yotai", legs="Carmine Cuisses +1", feet=gear.TFeet_TP
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
			waist="Kentarch Belt +1",
			feet="Aya. Gambieras +2"
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
			ammo="Ginsen",
			head=gear.THead_TP, neck="Anu Torque", lear="Sherida Earring", rear="Suppanomimi",
			body="Ayanmo Corazza +2", hands=gear.THands_TP, lring="Hetairoi Ring", rring="Ilabrat Ring",
			back=gear.RDMCape_DW, waist="Reiki Yotai", legs="Carmine Cuisses +1", feet=gear.TFeet_TP
		}
		
		-----------------------------------------------------------------------------------
		---	TP/h:65		(DW:32	STP:39		QA:0%	TA:2%	DA:13%)
		---	Primary Accuracy: 1160 		/ Primary Attack: 1018
		--- Auxiliary Accuracy: 1136 	/ Auxiliary Attack: 932
		-----------------------------------------------------------		
		sets.engaged.DW3.Low.Med = set_combine(sets.engaged.DW3.Med,
		{
			hands="Aya. Manopolas +2", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"}
		})
		
		-----------------------------------------------------------------------------------
		---	TP/h:62		(DW:32	STP:34		QA:0%	TA:2%	DA:12%)
		---	Primary Accuracy: 1169 		/ Primary Attack: 1016
		--- Auxiliary Accuracy: 1145	/ Auxiliary Attack: 930
		-----------------------------------------------------------	
		sets.engaged.DW3.Mid.Med = set_combine(sets.engaged.DW3.Low.Med,
		{
			head="Carmine Mask +1", neck="Combatant's Torque"
		})
		-----------------------------------------------------------------------------------
		---	TP/h:70		(DW:21	STP:35		QA:0%	TA:0%	DA:11%)
		---	Primary Accuracy: 1198 		/ Primary Attack: 1002
		--- Auxiliary Accuracy: 1174 	/ Auxiliary Attack: 918
		-----------------------------------------------------------	
		sets.engaged.DW3.High.Med = set_combine(sets.engaged.DW3.Mid.Med,
		{
			lear={name="Mache Earring +1", bag="wardrobe2"}, rear={name="Mache Earring +1", bag="wardrobe3"},
			waist="Kentarch Belt +1",
			feet="Aya. Gambieras +2"
		})

	
	
	----------------------------------------------------------
	--					(DW2 + Max Haste)
	----------------------------------------------------------

	--25 DW = 21 DW needed		(DNC Sub)
	
	----------------------------------------------------------	
		
		-----------------------------------------------------------------------------------
		---	TP/h:65		(DW:36	STP:33		QA:0%	TA:4%	DA:10%)
		---	Primary Accuracy: 1140 		/ Primary Attack: 1018
		--- Auxiliary Accuracy: 1115 	/ Auxiliary Attack: 936
		-----------------------------------------------------------	
		sets.engaged.DW2.Max =
		{
			ammo="Ginsen",
			head=gear.THead_TP, neck="Anu Torque", lear="Sherida Earring", rear="Suppanomimi",
			body="Ayanmo Corazza +2", hands=gear.THands_TP, lring="Hetairoi Ring", rring="Ilabrat Ring",
			back=gear.RDMCape_DW, waist="Windbuffet Belt +1", legs="Carmine Cuisses +1", feet="Carmine Greaves +1"
		}
		
		-----------------------------------------------------------------------------------
		---	TP/h:65		(DW:36	STP:33		QA:0%	TA:4%	DA:10%)
		---	Primary Accuracy: 1140 		/ Primary Attack: 1018
		--- Auxiliary Accuracy: 1115 	/ Auxiliary Attack: 936
		-----------------------------------------------------------	
		sets.engaged.DW2.Low.Max = set_combine(sets.engaged.DW2.Max,
		{
			head="Carmine Mask +1", neck="Combatant's Torque",
			hands="Aya. Manopolas +2"
		})
		
		-----------------------------------------------------------------------------------
		---	TP/h:65		(DW:36	STP:33		QA:0%	TA:4%	DA:10%)
		---	Primary Accuracy: 1140 		/ Primary Attack: 1018
		--- Auxiliary Accuracy: 1115 	/ Auxiliary Attack: 936
		-----------------------------------------------------------	
		sets.engaged.DW2.Mid.Max = set_combine(sets.engaged.DW2.Low.Max,
		{
			lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"},
			feet="Carmine Greaves +1"
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
			ammo="Ginsen",
			head=gear.THead_TP, neck="Anu Torque", lear="Sherida Earring", rear="Dedition Earring",
			body="Ayanmo Corazza +2", hands="Carmine Fin. Ga. +1", lring="Hetairoi Ring", rring="Ilabrat Ring",
			back=gear.RDMCape_DW, waist="Windbuffet Belt +1", legs=gear.TLegs_TP, feet="Carmine Greaves +1"
		}
		
		-----------------------------------------------------------------------------------
		---	TP/h:78		(DW:10	STP:40		QA:2%	TA:8%	DA:18%)
		---	Primary Accuracy: 1121 		/ Primary Attack: 945
		--- Auxiliary Accuracy: 1096 	/ Auxiliary Attack: 859
		-----------------------------------------------------------	
		sets.engaged.DW3.Low.Max = set_combine(sets.engaged.DW3.Max,
		{
			rear="Telos Earring",
			hands="Aya. Manopolas +2", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"},
		})
		
		-----------------------------------------------------------------------------------
		---	TP/h:78		(DW:10	STP:40		QA:2%	TA:6%	DA:14%)
		---	Primary Accuracy: 1138 		/ Primary Attack: 951
		--- Auxiliary Accuracy: 1113 	/ Auxiliary Attack: 867
		-----------------------------------------------------------	
		sets.engaged.DW3.Mid.Max = set_combine(sets.engaged.DW3.Low.Max,
		{
			head="Carmine Mask +1", neck="Combatant's Torque"
		})
		-----------------------------------------------------------------------------------
		---	TP/h:78~	(DW:10	STP:34~38	QA:0%	TA:4%	DA:14%)
		---	Primary Accuracy: 1181 		/ Primary Attack: 953
		--- Auxiliary Accuracy: 1156 	/ Auxiliary Attack: 868
		-----------------------------------------------------------	
		sets.engaged.DW3.High.Max = set_combine(sets.engaged.DW3.Mid.Max,
		{
			lear={name="Mache Earring +1", bag="wardrobe2"}, rear={name="Mache Earring +1", bag="wardrobe3"},
			waist="Kentarch Belt +1", legs="Viti. Tights +3", feet="Aya. Gambieras +2"
		})





	--------------------------------------
	-- Hybrid Sets
	--------------------------------------
		sets.engaged.Hybrid = 
		{
			ammo="Staunch Tathlum +1",
			neck="Loricate Torque +1",
			lring="Defending Ring", rring="Gelatinous Ring +1"
		}
		
		
		----------------------------------------------------------
		-- Sword & Board
		----------------------------------------------------------	
	    sets.engaged.DT 				= set_combine(sets.engaged, 				sets.engaged.Hybrid)
		sets.engaged.Low.DT 			= set_combine(sets.engaged.Low, 			sets.engaged.Hybrid)
		sets.engaged.Mid.DT 			= set_combine(sets.engaged.Mid, 			sets.engaged.Hybrid)
		sets.engaged.High.DT			= set_combine(sets.engaged.High, 			sets.engaged.Hybrid)

		
		----------------------------------------------------------
		-- No Haste
		----------------------------------------------------------
		sets.engaged.DW2.DT 			= set_combine(sets.engaged.DW2, 			sets.engaged.Hybrid)
		sets.engaged.DW2.Low.DT 		= set_combine(sets.engaged.DW2.Low, 		sets.engaged.Hybrid)
		sets.engaged.DW2.Mid.DT 		= set_combine(sets.engaged.DW2.Mid, 		sets.engaged.Hybrid)
		sets.engaged.DW2.High.DT 		= set_combine(sets.engaged.DW2.High, 		sets.engaged.Hybrid)

		sets.engaged.DW3.DT 			= set_combine(sets.engaged.DW3, 			sets.engaged.Hybrid)
		sets.engaged.DW3.Low.DT 		= set_combine(sets.engaged.DW3.Low, 		sets.engaged.Hybrid)
		sets.engaged.DW3.Mid.DT 		= set_combine(sets.engaged.DW3.Mid, 		sets.engaged.Hybrid)
		sets.engaged.DW3.High.DT 		= set_combine(sets.engaged.DW3.High, 		sets.engaged.Hybrid)
		
		
		----------------------------------------------------------
		-- Minimum Haste
		----------------------------------------------------------
		sets.engaged.DW2.DT.Min 	 	= set_combine(sets.engaged.DW2.Min, 		sets.engaged.Hybrid)
		sets.engaged.DW2.Low.DT.Min  	= set_combine(sets.engaged.DW2.Low.Min, 	sets.engaged.Hybrid)
		sets.engaged.DW2.Mid.DT.Min  	= set_combine(sets.engaged.DW2.Mid.Min, 	sets.engaged.Hybrid)
		sets.engaged.DW2.High.DT.Min 	= set_combine(sets.engaged.DW2.High.Min, 	sets.engaged.Hybrid)
		
		sets.engaged.DW3.DT.Min 	 	= set_combine(sets.engaged.DW3.Min, 		sets.engaged.Hybrid)
		sets.engaged.DW3.Low.DT.Min  	= set_combine(sets.engaged.DW3.Low.Min, 	sets.engaged.Hybrid)
		sets.engaged.DW3.Mid.DT.Min  	= set_combine(sets.engaged.DW3.Mid.Min, 	sets.engaged.Hybrid)
		sets.engaged.DW3.High.DT.Min 	= set_combine(sets.engaged.DW3.High.Min, 	sets.engaged.Hybrid)
		
		
		----------------------------------------------------------
		-- Medium Haste
		----------------------------------------------------------
		sets.engaged.DW2.DT.Med 	 	= set_combine(sets.engaged.DW2.Med, 		sets.engaged.Hybrid)
		sets.engaged.DW2.Low.DT.Med  	= set_combine(sets.engaged.DW2.Low.Med, 	sets.engaged.Hybrid)
		sets.engaged.DW2.Mid.DT.Med  	= set_combine(sets.engaged.DW2.Mid.Med, 	sets.engaged.Hybrid)
		sets.engaged.DW2.High.DT.Med 	= set_combine(sets.engaged.DW2.High.Med, 	sets.engaged.Hybrid)

		sets.engaged.DW3.DT.Med 	 	= set_combine(sets.engaged.DW3.Med, 		sets.engaged.Hybrid)
		sets.engaged.DW3.Low.DT.Med  	= set_combine(sets.engaged.DW3.Low.Med, 	sets.engaged.Hybrid)
		sets.engaged.DW3.Mid.DT.Med  	= set_combine(sets.engaged.DW3.Mid.Med, 	sets.engaged.Hybrid)
		sets.engaged.DW3.High.DT.Min 	= set_combine(sets.engaged.DW3.High.Min, 	sets.engaged.Hybrid)
		
		----------------------------------------------------------
		-- Maximum Haste
		----------------------------------------------------------		
		sets.engaged.DW2.DT.Max 	 	= set_combine(sets.engaged.DW2.Max, 		sets.engaged.Hybrid)
		sets.engaged.DW2.Low.DT.Max  	= set_combine(sets.engaged.DW2.Low.Max, 	sets.engaged.Hybrid)
		sets.engaged.DW2.Mid.DT.Max  	= set_combine(sets.engaged.DW2.Mid.Max, 	sets.engaged.Hybrid)
		sets.engaged.DW2.High.DT.Max 	= set_combine(sets.engaged.DW2.High.Max, 	sets.engaged.Hybrid)
		
		sets.engaged.DW3.DT.Max 	 	= set_combine(sets.engaged.DW3.Max, 		sets.engaged.Hybrid)
		sets.engaged.DW3.Low.DT.Max  	= set_combine(sets.engaged.DW3.Low.Max, 	sets.engaged.Hybrid)
		sets.engaged.DW3.Mid.DT.Max  	= set_combine(sets.engaged.DW3.Mid.Max, 	sets.engaged.Hybrid)
		sets.engaged.DW3.High.DT.Max 	= set_combine(sets.engaged.DW3.High.Max, 	sets.engaged.Hybrid)
		
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


-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.action_type == 'Magic' then
		apply_abilities(spell, action, spellMap, eventArgs)
	end
	
	if spellMap == 'Cures' or spellMap == 'Curagas' and (spell.element == world.day_element and spell.element == world.weather_element) then
		equip
		{
			main="Chatoyant Staff", sub="Enki Strap",
			back="Twilight Cape", waist="Hachirin-no-Obi",
		}
	end
	
	if spell.target.type == 'SELF' and (spellMap == 'Cures' or spellMap == 'Refresh') then
        equip
		{
			waist="Gishdubar Sash"
		}
	end


	if spell.skill == 'Elemental Magic' and state.MagicBurst.value and state.CastingMode.value ~= 'Resistant' then
		if spell.english ~= 'Impact' then
			equip(sets.magic_burst)
		else
			equip(set_combine(sets.magic_burst,
			{
				head=empty,
				body="Twilight Cloak", lring="Archon Ring"
			}))
		end
	elseif spell.skill == 'Elemental Magic' and state.MagicBurst.value and state.CastingMode.value == 'Resistant' then
		if spell.english ~= 'Impact' then
			equip(sets.magic_burst.Resistant)
		else
			equip(set_combine(sets.magic_burst.Resistant,
			{
				head=empty,
				body="Twilight Cloak", lring="Archon Ring",
			}))
		end
	end

	if spell.skill == 'Elemental Magic' and spell.element == 'Dark' and spell.english ~= 'Impact' then
		if state.CastingMode.value ~= 'Resistant' then
			equip
			{
				head="Pixie Hairpin +1",
				lring="Archon Ring"
			}
		else
			equip
			{
				lring="Archon Ring"
			}
		end
	end

	if spell.skill == 'Elemental Magic' and (spell.element ~= world.day_element and spell.element ~= world.weather_element) then
		if spell.target.distance < (15 - spell.target.model_size) then
			equip
			{
				waist="Orpheus's Sash"
			}
		end
	elseif spell.skill == 'Elemental Magic' and (spell.element == world.day_element and spell.element == world.weather_element)
			or (spell.element == world.weather_element and get_weather_intensity() == 2) then
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
	elseif spell.skill == 'Elemental Magic' and (spell.element == world.day_element or (spell.element == world.weather_element and get_weather_intensity() == 1)) then
		if spell.target.distance < (7 - spell.target.model_size) then
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
end


function job_aftercast(spell,action, spellMap, eventArgs)
	equip(sets[state.WeaponSet.current])
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------
function job_buff_change(buff,gain)
	-- If we gain or lose any haste buffs, adjust which gear set we target.
	if S{'haste','march','embrava','haste samba', 'mighty guard'}:contains(buff:lower()) then
		determine_haste_group()
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

function job_status_change(new_status, old_status)
	if new_status == 'Engaged' then
		equip(sets[state.WeaponSet.current])
		determine_haste_group()
		update_combat_form()
	end
end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
	equip(sets[state.WeaponSet.current])
end

function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet,
		{
			waist="Fucho-no-Obi"
		})
    end
	
	return idleSet
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
	if spell.action_type == 'Magic' then
		if determine_DW() > 0 then
			if default_spell_map == 'Tempers' then
				return "TempersDW"
			elseif default_spell_map == 'Enspells' then 
				return "EnspellsDW"
			elseif spell.english == 'Phalanx' then
				return "PhalanxDW"
			end
		end
	end
end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
	equip(sets[state.WeaponSet.current])
	determine_haste_group()
	update_combat_form()
	update_active_abilities()
end

-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
	local msg = state.WeaponSet.value .. ' '

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
    set_macro_page(1, 1)
end