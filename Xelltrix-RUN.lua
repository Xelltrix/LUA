-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

function job_setup()
	include('Mote-TreasureHunter')

	state.Buff['Embolden'] = buffactive['Embolden'] or false
	state.Buff['Battuta'] = buffactive['Battuta'] or false
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Low', 'Mid', 'High')
	state.WeaponskillMode:options('Normal','Turtle')
    state.HybridMode:options('Normal', 'DT')
	
	state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MEVA','MDT','Breath')
	
	state.CastingMode:options('Normal', 'HP', 'SIRD')
	
    state.IdleMode:options('Normal', 'DT', 'Refresh')
	
	state.WeaponSet = M{['description']='Weapon Set', 'Epeolatry', 'Lionheart','Lycurgos'}
	
	state.GripSet = M{['description']='Grip Set','Utu','Khonsu'}
	
	state.Resist = M{['description']='Resist Type','None','Death','Knockback'}
	
	send_command('bind ^= gs c cycle treasuremode')
	
	send_command('bind pageup gs c cycle WeaponSet')
	send_command('bind pagedown gs c cycleback WeaponSet')
	
	send_command('bind ^pageup gs c cycle GripSet')
	send_command('bind ^pagedown gs c cycleback GripSet')
	
	send_command('bind ^insert gs c cycle Resist')

	apply_job_change()
	
	
end

function user_unload()
		send_command('unbind ^=')
		send_command('unbind pageup')
		send_command('unbind pagedown')
		
		send_command('unbind ^pageup')
		send_command('unbind ^pagedown')
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

	--------------------------------------
	-- Special Sets
	--------------------------------------
	

		sets.Enmity =
		{--Enmity + 95	PDT: -29%
			ammo="Sapience Orb",
			head="Halitus Helm", neck="Moonlight Necklace", lear="Cryptic Earring", rear="Trux Earring",
			body="Emet Harness +1", hands="Kurys Gloves", lring="Eihwaz Ring", rring="Supershear Ring",
			back=gear.RUNCape_ENM, waist="Trance Belt", legs="Eri. Leg Guards +1", feet="Ahosi Leggings"
		}
		
		sets.Enmity.HP = set_combine(sets.Enmity,
		{--Enmity + 71	PDT: -44%
			neck="Unmoving Collar +1", lear="Odnowa Earring +1", rear="Tuisto Earring",
			lring="Defending Ring", rring="Moonlight Ring"
		})
		
		sets.buff.Doom = 
		{
			neck="Nicander's Necklace",
			lring={name="Eshmun's Ring", bag="wardrobe2"}, rring={name="Eshmun's Ring", bag="wardrobe3"},
			waist="Gishdubar Sash"
		}
		
		sets.buff['Battuta'] =
		{
			hands="Turms Mittens +1",
 			legs="Eri. Leg Guards +1", feet="Turms Leggings +1"
		}
		
		sets.buff['Embolden'] =
		{
			head="Erilaz Galea +1",
			hands="Regal Gauntlets",
			back="Evasionist's Cape", legs="Futhark Trousers +3"
		}
	
		sets.Kiting = { legs="Carmine Cuisses +1" }

		sets.Epeolatry = { main="Epeolatry" }
		
		sets.Lionheart = { main="Lionheart" }
		
		sets.Lycurgos = { main="Lycurgos" }
	
		sets.Utu = { sub="Utu Grip" }
	
		sets.Khonsu = { sub="Khonsu" }
	
		
		sets.Death =
		{
			body="Samnuha Coat", lring="Eihwaz Ring", rring="Shadow Ring",
		}
		
		sets.Knockback =
		{
			back="Repulse Mantle", legs="Dashing Subligar"
		}
		
		sets.TreasureHunter = 
		{ 
			head=gear.HHead_TH, 
			hands="Volte Bracers",
			waist="Chaac Belt"
		}
		
	-------------------
	-- Job Abilities --
	------------------- 

		sets.precast.JA['Swipe'] =
		{
			ammo="Pemphredo Tathlum",
			head=gear.HHead_MAB, neck="Sanctity Necklace", lear="Crematio Earring", rear="Static Earring",
			body="Samnuha Coat", hands="Carmine Fin. Ga. +1", lring="Locus Ring", rring="Mujin Band",
			back="Evasionist's Cape", waist="Orpheus's Sash", legs="Shneddick Tights +1", feet="Adhemar Gamashes +1"
		}

		sets.precast.JA['Lunge'] = sets.precast.JA['Swipe']
		
		sets.precast.JA['Rayke'] = { feet="Futhark Boots +3" }

		sets.precast.JA['Gambit'] = { hands="Runeist's Mitons +3" }

		sets.precast.JA['Swordplay'] = { hands="Futhark Mitons +3" }

		sets.precast.JA['Vallation'] = 
		{
			body="Runeist's Coat +3",
			back="Ogma's Cape"
		}

		sets.precast.JA['Valiance'] = sets.precast.JA['Vallation']
		
		sets.precast.JA['Pflug'] = { feet="Runeist's Boots +3" }

		sets.precast.JA['Battuta'] = { head="Fu. Bandeau +3" }

		sets.precast.JA['Liement'] = { body="Futhark Coat +3" }

		sets.precast.JA['Vivacious Pulse'] = 
		{
			ammo="Staunch Tathlum +1",	
			head="Erilaz Galea +1", neck="Incanter's Torque", lear="Beatific Earring", rear="Saxnot Earring",
			body="Futhark Coat +3", hands="Runeist's Mitons +3", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back="Moonlight Cape", waist="Bishop's Sash", legs="Rune. Trousers +2", feet="Ahosi Leggings"
		}

		sets.precast.JA['Elemental Sforzo'] = { body="Futhark Coat +3" }
		
		sets.precast.JA['One for All'] = set_combine(sets.Enmity.HP,
		{
			head="Erilaz Galea +1",
			body="Runeist's Coat +3", hands="Turms Mittens +1",
			feet="Turms Leggings +1"
		})
	
	-------------------
	-- Precast Magic --
	-------------------
	-- Spell Interruption Rate: -10%
	
		sets.precast.FC =
		{--Fast Cast + 75%
			ammo="Sapience Orb",
			head="Rune. Bandeau +3", neck="Orunmila's Torque", lear="Etiolation Earring", rear="Loquac. Earring",
			body=gear.TBody_Phalanx, hands="Leyline Gloves", lring="Kishar Ring", rring="Weather. Ring +1",
			back=gear.RUNCape_FC, waist="Carrier's Sash", legs="Aya. Cosciales +2", feet="Carmine Greaves +1"
		}
		
		sets.precast.FC.HP = set_combine(sets.precast.FC,
		{--Fast Cast + 63%
			neck="Unmoving Collar +1", lear="Odnowa Earring +1", rear="Tuisto Earring",
			lring="Gelatinous Ring +1",
		})
		
		sets.precast.FC['Enhancing Magic'] = 
		{
			waist="Siegel Sash",
			legs="Futhark Trousers +3"
		}
		


----------------------------------------------------------------------------
--------------------									--------------------
------------							 						------------
--------					Midcast Gear Sets						--------
------------							 						------------
--------------------									--------------------
----------------------------------------------------------------------------


		sets.midcast.FC = sets.precast.FC
		
		sets.midcast.FC.HP = sets.precast.FC.HP

		sets.midcast.FC.SIRD = 
		{--		Spell Interrupt: -101	PDT: -43%
			ammo="Staunch Tathlum +1",
			head=gear.THead_Phalanx, neck="Moonlight Necklace", lear="Genmei Earring", rear="Tuisto Earring",
			body="Futhark Coat +3", hands="Rawhide Gloves", lring="Defending Ring", rring="Moonlight Ring",
			back=gear.RUNCape_ENM, waist="Audumbla Sash", legs="Carmine Cuisses +1", feet=gear.TFeet_Phalanx
		}

	
	--------------------------------------
	-- Buffing Midcast sets
	--------------------------------------	
		
		sets.midcast.Duration = 
		{
			head="Erilaz Galea +1",
			hands="Regal Gauntlets",
			legs="Futhark Trousers +3"
		}
		
		sets.midcast.Regen =
		{
			head="Rune. Bandeau +3", neck="Sacro Gorget",
			body="Futhark Coat +3", hands="Regal Gauntlets",
			legs ="Futhark Trousers +3"
		}

		sets.midcast.Refresh =
		{
			head="Erilaz Galea +1",
			hands="Regal Gauntlets",
			waist="Gishdubar Sash", legs ="Futhark Trousers +3"
		}

		sets.midcast.Phalanx =
		{-- 28 + ((Enhancing Magic Skill - 300.5)/28.5) + 19 = 53
			ammo="Staunch Tathlum +1",
			head="Fu. Bandeau +3", neck="Incanter's Torque", lear="Mimir Earring", rear="Tuisto Earring",
			body=gear.TBody_Phalanx, hands=gear.THands_Phalanx, lring="Gelatinous Ring +1", rring={name="Stikini Ring +1", bag="wardrobe3"},
			back="Moonlight Cape", waist="Olympus Sash", legs=gear.TLegs_Phalanx, feet=gear.TFeet_Phalanx
		}

		sets.midcast.Temper = 
		{ 
			ammo="Staunch Tathlum +1",
			head="Carmine Mask +1", neck="Incanter's Torque", lear="Mimir Earring", rear="Andoaa Earring",
			body="Manasa Chasuble", hands="Runeist's Mitons +3", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back="Merciful Cape", waist="Olympus Sash", legs="Carmine Cuisses +1", feet="Turms Leggings +1"
		}

		sets.midcast.BarElement = 
		{
			ammo="Staunch Tathlum +1",
			head="Erilaz Galea +1", neck="Incanter's Torque", lear="Mimir Earring", rear="Tuisto Earring",
			body="Manasa Chasuble", hands="Runeist's Mitons +3", lring="Gelatinous Ring +1", rring={name="Stikini Ring +1", bag="wardrobe3"},
			back="Moonlight Cape", waist="Olympus Sash", legs ="Futhark Trousers +3", feet="Turms Leggings +1"
		}

		sets.midcast.BarStatus = sets.midcast.Duration

		sets.midcast.Stoneskin = set_combine(sets.midcast.FC, sets.midcast.FC.SIRD,
		{
			neck="Stone Gorget", lear="Earthcry Earring",
			waist="Siegel Sash"
		})

		sets.midcast.Aquaveil = set_combine(sets.midcast.Duration, sets.midcast.FC.SIRD)

		sets.midcast.Statless = sets.midcast.Duration

		sets.midcast['Enhancing Magic'] = sets.midcast.Duration
		
		sets.midcast.Utsusemi = sets.midcast.FC

		sets.midcast.Protection = sets.midcast.Duration
		
		sets.midcast.Cocoon = sets.midcast.FC.SIRD


    --------------------------------------
	-- Enmity Midcast sets
	--------------------------------------		
	
		sets.midcast.Flash = sets.Enmity
		
		sets.midcast.Stun = sets.Enmity
		
		sets.midcast.Foil = sets.Enmity
		
		sets.midcast.Debuffs = sets.Enmity
	
	
	--------------------------------------
	-- Misc. Job Midcast sets
	--------------------------------------	
	
		sets.midcast.Macc =
		{
			ammo="Pemphredo Tathlum",
			head="Carmine Mask +1", neck="Erra Pendant", lear="Digni. Earring", rear="Gwati Earring",
			body="Futhark Coat +3", hands="Aya. Manopolas +2", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back=gear.RUNCape_FC, waist="Luminary Sash", legs="Aya. Cosciales +2", feet="Futhark Boots +3"
		}
	
		sets.midcast.Cures = set_combine(sets.midcast.FC.SIRD,
		{--		Cure Potency: +36%
			head="Erilaz Galea +1", neck="Sacro Gorget", lear="Mendi. Earring", rear="Roundel Earring",
			body="Vrikodara Jupon", hands="Runeist's Mitons +3", lring="Lebeche Ring", rring="Menelaus's Ring",
			back="Moonlight Cape", waist="Gishdubar Sash", legs="Carmine Cuisses +1"
		})
		
		sets.midcast['Elemental Magic'] = sets.precast.JA['Swipe']

		sets.midcast.StatusRemoval = sets.midcast.FastRecast

		sets.midcast.Cursna = set_combine(sets.midcast.FastRecast,
		{
			neck="Debilis Medallion", lear="Meili Earring", rear="Beatific Earring",
			lring="Haoma's Ring", rring="Menelaus's Ring",
			waist="Bishop's Sash"
		})
		
		sets.midcast.Teleport = sets.midcast.FC

		sets.midcast.Raise = sets.midcast.FC

		sets.midcast.Reraise = sets.midcast.FC
		
		sets.midcast.Protectra = sets.midcast.Protect

		sets.midcast.Shellra = sets.midcast.Shell

		

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
		{-- DT: 6%		PDT: 35%		MDT: 6%		Refresh: 6		Regen: 22
			ammo="Homiliary",
			head="Turms Cap +1", neck="Sanctity Necklace", lear="Dawn Earring", rear="Infused Earring",
			body="Runeist's Coat +3", hands="Regal Gauntlets", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back="Moonlight Cape", waist="Flume Belt +1", legs="Carmine Cuisses +1", feet="Turms Leggings +1"
		}

		sets.idle.DT = 
		{-- DT: 38%		PDT: 31%		MDT: 40%	Regen: 23
			ammo="Staunch Tathlum +1",
			head="Turms Cap +1", neck="Futhark Torque +2", lear="Genmei Earring", rear="Tuisto Earring",
			body="Futhark Coat +3", hands="Turms Mittens +1", lring="Defending Ring", rring="Moonlight Ring",
			back="Moonlight Cape", waist="Flume Belt +1", legs="Eri. Leg Guards +1", feet="Turms Leggings +1"
		}
		
		sets.idle.Refresh =
		{-- DT: 6%		PDT: 39%		MDT: 6%		Refresh: 10		Regen: 4
			ammo="Homiliary",
			head="Rawhide Mask", neck="Sanctity Necklace", lear="Dawn Earring", rear="Infused Earring",
			body="Runeist's Coat +3", hands="Regal Gauntlets", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back="Moonlight Cape", waist="Flume Belt +1", legs="Rawhide Trousers", feet=gear.HBoots_Refresh
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
		sets.defense.PDT =
		{--DT: -24%		PDT: -45%		MDT: -27%
			ammo="Staunch Tathlum +1",
			head="Turms Cap +1", neck="Futhark Torque +2", lear="Odnowa Earring +1", rear="Tuisto Earring",
			body="Runeist's Coat +3", hands="Turms Mittens +1", lring="Defending Ring", rring="Moonlight Ring",
			back=gear.RUNCape_ENM, waist="Flume Belt +1", legs="Eri. Leg Guards +1", feet="Turms Leggings +1"
		}
		
		sets.defense.MEVA = 
		{--DT: -16%		PDT: -33%		MDT: -22%
			ammo="Yamarang",
			head="Turms Cap +1", neck="Futhark Torque +2", lear="Sanare Earring", rear="Eabani Earring",
			body="Runeist's Coat +3",hands="Volte Bracers", lring="Defending Ring", rring="Purity Ring",
			back=gear.RUNCape_ENM, waist="Engraved Belt", legs="Turms Subligar +1", feet="Turms Leggings +1"
		}
		
		sets.defense.Breath =
		{--DT: -44%		PDT: -44%		MDT: -44%
			ammo="Staunch Tathlum +1",
			head="Turms Cap +1", neck="Futhark Torque +2", lear="Sanare Earring", rear="Eabani Earring",
			body="Futhark Coat +3", hands="Raetic Bangles +1", lring="Defending Ring", rring="Moonlight Ring",
			back="Moonlight Cape", waist="Engraved Belt", legs="Aya. Cosciales +2", feet="Turms Leggings +1"
		}
		
		sets.defense.MDT = 
		{--DT: -36%		PDT: -36%		MDT: -45%
			ammo="Yamarang",
			head="Turms Cap +1", neck="Futhark Torque +2", lear="Etiolation Earring", rear="Odnowa Earring +1",
			body="Futhark Coat +3",hands="Raetic Bangles +1", lring="Defending Ring", rring="Purity Ring",
			back="Moonlight Cape", waist="Engraved Belt", legs="Aya. Cosciales +2", feet="Turms Leggings +1"
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
			ammo="Knobkierrie",
			head="Lustratio Cap +1", neck="Fotia Gorget", lear="Ishvara Earring", rear="Moonshade Earring",
			body="Adhemar Jacket +1", hands="Meg. Gloves +2", lring="Regal Ring", rring="Niqmaddu Ring",
			back=gear.RUNCape_RES, waist="Fotia Belt", legs="Meg. Chausses +2", feet=gear.HBoots_WSD
		}

    ---Dimidation
		sets.precast.WS['Dimidiation'] = set_combine(sets.precast.WS,
		{
			lear={name="Mache Earring +1", bag="wardrobe2"},  rear={name="Mache Earring +1", bag="wardrobe3"},
			body="Herculean Vest", rring="Epaminondas's Ring",
			back=gear.RUNCape_DIM, legs="Lustr. Subligar +1", feet="Lustra. Leggings +1"
		})
		
		sets.precast.WS['Dimidiation'].Low = set_combine(sets.precast.WS['Dimidiation'],
		{
			body="Futhark Coat +3", 
			feet="Futhark Boots +3"
		})

		sets.precast.WS['Dimidiation'].Mid = set_combine(sets.precast.WS['Dimidiation'].Low,
		{
			ammo="Voluspa Tathlum"
		})
		
		sets.precast.WS['Dimidiation'].High= set_combine(sets.precast.WS['Dimidiation'].Mid,
		{
			head="Fu. Bandeau +3"
		})
		
		sets.precast.WS['Dimidiation'].Turtle = set_combine(sets.precast.WS['Dimidiation'],
		{
			head="Fu. Bandeau +3", neck="Futhark Torque +2",
			body="Futhark Coat +3", lring="Defending Ring",
			legs="Meg. Chausses +2", feet=gear.HBoots_WSD
		})
		
	
	---Ground Strike
		sets.precast.WS['Ground Strike'] = set_combine(sets.precast.WS,
		{
			neck="Futhark Torque +2", lear="Sherida Earring", rear="Ishvara Earring",
			body="Lustr. Harness +1", rring="Epaminondas's Ring",
			waist="Sailfi Belt +1", legs="Meg. Chausses +2", feet="Lustra. Leggings +1"
		})
		
		sets.precast.WS['Ground Strike'].Low = set_combine(sets.precast.WS['Ground Strike'],
		{
			body="Futhark Coat +3", 
			feet="Futhark Boots +3"
		})
		
		sets.precast.WS['Ground Strike'].Mid = set_combine(sets.precast.WS['Ground Strike'].Low,
		{
			rear={name="Mache Earring +1", bag="wardrobe3"},
			waist="Fotia Belt"
		})
		
		sets.precast.WS['Ground Strike'].High = set_combine(sets.precast.WS['Ground Strike'].Mid,
		{
			ammo="Voluspa Tathlum",
			lear={name="Mache Earring +1", bag="wardrobe2"}
		})
		
		sets.precast.WS['Ground Strike'].Turtle = set_combine(sets.precast.WS['Ground Strike'],
		{
			head="Fu. Bandeau +3",
			body="Futhark Coat +3", lring="Defending Ring",
			feet=gear.HBoots_WSD
		})

	---Spinning Slash
		sets.precast.WS['Spinning Slash'] = sets.precast.WS['Ground Strike']
		
		sets.precast.WS['Spinning Slash'].Low = sets.precast.WS['Spinning Slash']
		
		sets.precast.WS['Spinning Slash'].Mid = sets.precast.WS['Ground Strike'].Mid
		
		sets.precast.WS['Spinning Slash'].High = sets.precast.WS['Ground Strike'].High
		
		sets.precast.WS['Spinning Slash'].Turtle = sets.precast.WS['Ground Strike'].Turtle
		
	---Resolution
		sets.precast.WS['Resolution'] = set_combine(sets.precast.WS,
		{
			ammo="Voluspa Tathlum",
			lear="Sherida Earring",
			body="Lustr. Harness +1", hands="Adhemar Wrist. +1", lring="Regal Ring", rring="Niqmaddu Ring",
			waist="Sailfi Belt +1", legs="Meg. Chausses +2", feet="Lustra. Leggings +1"
		})
		
		sets.precast.WS['Resolution'].Low = set_combine(sets.precast.WS['Resolution'],
		{
			head="Fu. Bandeau +3", 
			body="Adhemar Jacket +1",
			feet="Futhark Boots +3"
		})
		
		sets.precast.WS['Resolution'].Mid = set_combine(sets.precast.WS['Resolution'].Low,
		{
			lear={name="Mache Earring +1", bag="wardrobe2"}, rear={name="Mache Earring +1", bag="wardrobe3"},
			hands="Meg. Gloves +2"
		})
		
		sets.precast.WS['Resolution'].High = set_combine(sets.precast.WS['Resolution'].Mid,
		{
			head="Carmine Mask +1",
			body="Futhark Coat +3",
			waist="Fotia Belt", legs="Carmine Cuisses +1", feet="Turms Leggings +1"
		})
		
		sets.precast.WS['Resolution'].Turtle = set_combine(sets.precast.WS['Resolution'],
		{
			head="Fu. Bandeau +3", neck="Futhark Torque +2",
			body="Futhark Coat +3", lring="Defending Ring",
			feet=gear.HBoots_TP
		})
		
	--Shockwave	
		sets.precast.WS['Shockwave'] = sets.precast.WS['Ground Strike']
		
		sets.precast.WS['Shockwave'].Turtle = sets.midcast.Macc
		
	--Frostbite
		sets.precast.WS['Frostbite'] = set_combine(sets.precast.JA['Swipe'],
		{
			lear="Crematio Earring", rear="Moonshade Earring",
			body="Samnuha Coat", lring="Shiva Ring +1", rring="Epaminondas's Ring"
		})
		
	--Freezebite
		sets.precast.WS['Freezebite'] =  sets.precast.WS['Frostbite']
		
	
	--- *** GREAT AXE ***
	
	--Upheavel
		sets.precast.WS['Upheavel'] = sets.precast.WS['Resolution']
	
		sets.precast.WS['Upheavel'].Low = sets.precast.WS['Resolution'].Low
		
		sets.precast.WS['Upheavel'].Mid = sets.precast.WS['Resolution'].Mid
	
		sets.precast.WS['Upheavel'].High = sets.precast.WS['Resolution'].High
		
		sets.precast.WS['Upheavel'].Turtle = sets.precast.WS['Resolution'].Turtle
		
	---Steel Cyclone
		sets.precast.WS['Steel Cyclone'] = set_combine(sets.precast.WS,
		{
			neck="Futhark Torque +2",
			body="Lustr. Harness +1", rring="Epaminondas's Ring",
			waist="Sailfi Belt +1"
		})
		
		sets.precast.WS['Steel Cyclone'].Turtle = set_combine(sets.precast.WS['Steel Cyclone'],
		{
			head="Fu. Bandeau +3",
			body="Futhark Coat +3", lring="Defending Ring",
			feet=gear.HBoots_WSD
		})
	
	---Fell Cleave
		sets.precast.WS['Fell Cleave'] = set_combine(sets.precast.WS['Steel Cyclone'],
		{
			lear="Sherida Earring", rear="Ishvara Earring",
		})
		
		sets.precast.WS['Fell Cleave'].Turtle = set_combine(sets.precast.WS['Steel Cyclone'].Turtle,
		{
			lear="Sherida Earring", rear="Ishvara Earring",
		})


	--------------------------------------
	-- Melee sets
	--------------------------------------

		sets.engaged =
		{
			ammo="Yamarang",
			head=gear.AHead_TP, neck="Anu Torque", lear="Sherida Earring", rear="Brutal Earring",
			body="Adhemar Jacket +1", hands="Adhemar Wrist. +1", lring="Epona's Ring", rring="Niqmaddu Ring",
			back=gear.RUNCape_STP, waist="Windbuffet Belt +1", legs="Samnuha Tights", feet=gear.HBoots_TP
		}
	
		sets.engaged.AM3 = set_combine(sets.engaged,
		{
			head="Dampening Tam", rear="Telos Earring"
		})

		sets.engaged.Low = set_combine(sets.engaged,
		{
			head="Dampening Tam", neck="Combatant's Torque", lear={name="Mache Earring +1", bag="wardrobe2"}
		})

		sets.engaged.Mid = set_combine(sets.engaged.Low,
		{
			rear={name="Mache Earring +1", bag="wardrobe3"},
			body="Ashera Harness", 
			waist="Kentarch Belt +1", legs="Aya. Cosciales +2"
		})

		sets.engaged.High = set_combine(sets.engaged.Mid,
		{
			ammo="Voluspa Tathlum",
			head="Carmine Mask +1",
			hands="Meg. Gloves +2", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"},
			legs="Carmine Cuisses +1", feet="Turms Leggings +1"
		})
		
		
	------------------------------------------------------------------------------------------------
	---------------------------------------  Hybrid Sets -------------------------------------------
	------------------------------------------------------------------------------------------------	
	
	---Base Hybrid Set
		sets.engaged.Hybrid =
		{-- 		DT: 27%		PDT: 74%	MDT: 27%
			head=gear.AHead_PDT, neck="Futhark Torque +2",
			body="Ashera Harness", lring="Defending Ring", rring="Moonlight Ring",
			waist="Sailfi Belt +1", legs="Meg. Chausses +2"
		}
		
	---Hybrid Combat
		sets.engaged.DT 			= set_combine(sets.engaged, 		sets.engaged.Hybrid)
		sets.engaged.DT.AM3			= set_combine(sets.engaged.AM3,		sets.engaged.Hybrid,
		{
			rear="Telos Earring"
		})
		sets.engaged.Low.DT 		= set_combine(sets.engaged.Low, 	sets.engaged.Hybrid)
		sets.engaged.Mid.DT			= set_combine(sets.engaged.Mid, 	sets.engaged.Hybrid)
		sets.engaged.High.DT		= set_combine(sets.engaged.High, 	sets.engaged.Hybrid)

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
function job_precast(spell, action, spellMap, eventArgs)
	currentSpell = spell.english
	
	if spell.type ~= 'WeaponSkill' and (state.CastingMode.value ~= 'Normal' or (spell.action_type == 'Magic' and buffactive['Fast Cast'])) then
		eventArgs.handled = true
		
		if spell.action_type == 'Magic' then
			equip(sets.precast.FC.HP)
			equip(sets.precast.FC['currentSpell'])
		elseif spell.action_type == 'Ability' and spellMap ~= 'Rune' then
			equip(sets.Enmity.HP)
			equip(sets.precast.JA[currentSpell])
		end
	else
		if spell.action_type == 'Magic' then
			equip(sets.precast.FC)
			equip(sets.precast.FC['currentSpell'])
		elseif spell.action_type == 'Ability' and spellMap ~= 'Rune' then
			equip(sets.Enmity)
			equip(sets.precast.JA[currentSpell])
		end
	end
end

function job_midcast(spell, action, spellMap, eventArgs)
	currentSpell = spell.english
	
	if spell.action_type == 'Magic' then
		if state.CastingMode.value == 'HP' then
			if spell.English == 'Flash' or spell.English == 'Foil' or spell.English == 'Stun' or spell.English == 'Poisonga' or spell.English == 'Banishga' or spell.skill == 'Blue Magic' then
				equip(sets.Enmity.HP)
			else
				equip(sets.midcast.FC.HP)
				equip(sets.midcast['currentSpell'])
			end
		elseif state.CastingMode.value == 'SIRD' then
			if spell.English == 'Poisonga' or spell.English == 'Banishga' then
				equip(sets.midcast.FC.SIRD)
			else
				equip(sets.midcast.FC.SIRD)
				equip(sets.midcast['currentSpell'])
			end
		else
			equip(sets.midcast.FC)
			equip(sets.midcast['currentSpell'])
		end
	end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
	if state.CastingMode.value == 'SIRD' then
		if spell.skill == 'Blue Magic' then
			equip(sets.midcast.FC.SIRD)
		end
	end
	
	if spell.action_type == 'Magic' then
		if buffactive['Embolden'] and spell.skill == 'Enhancing Magic' then
			if spell.english == 'Phalanx' then
				equip(set_combine(sets.midcast.Phalanx, 
				{
					hands="Regal Guauntlets",
					back="Evasionist's Cape", legs="Futhark Trousers +3"
				}))
			else
				equip(sets.buff['Embolden'])
			end
		end
	end
	
	if state.TreasureMode.value ~= 'None' and spell.action_type == 'Magic' and spell.target.type == 'MONSTER' then
		equip(sets.TreasureHunter)
	end
end

function job_aftercast(spell,action, spellMap, eventArgs)
	equip(sets[state.WeaponSet.current])
	equip(sets[state.GripSet.current])
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

--[[ Called when a player gains or loses a buff.
		buff == buff gained or lost
		gain == true if the buff was gained, false if it was lost. ]]
function job_buff_change(buff,gain)
	if state.Buff[buff] ~= nil then
			if not midaction() then
        		handle_equipping_gear(player.status)
        	end
	end
	
	---Gearswap for Doom Status
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
			equip({head="Frenzy Sallet"})
		else
			handle_equipping_gear(player.status)
		end
	end
	
	if buff == "Aftermath: Lv.3" and player.equipment.main == "Epeolatry" then
		if gain then
			classes.CustomMeleeGroups:append('AM3')
			handle_equipping_gear(player.status)
		else
			classes.CustomMeleeGroups:clear()
		end
	end
end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
	equip(sets[state.WeaponSet.current])
	equip(sets[state.GripSet.current])
end


function customize_idle_set(idleSet)
    if player.mpp < 51 and state.IdleMode.value ~= 'DT' and state.DefenseMode.value == 'None' then
        idleSet = set_combine(idleSet,
		{
			waist="Fucho-no-Obi",
		})
    end
	
	if buffactive['Embolden'] then
		idleSet = set_combine(idleSet, sets.buff['Embolden'])
	end
	
	return idleSet
end

function customize_defense_set(defenseSet)
    if buffactive['Battuta'] and player.status == 'Engaged' then
        defenseSet = set_combine(defenseSet, sets.buff['Battuta'])
    end
	
	if state.Resist.value == 'Death' then
		defenseSet = set_combine(defenseSet, sets.Death)
	elseif state.Resist.value == 'Knockback' then
		defenseSet = set_combine(defenseSet, sets.Knockback)
	end
	
    return defenseSet
end

function customize_melee_set(meleeSet)
	if buffactive['Battuta'] and state.HybridMode.value ~= 'Normal' then
		meleeSet = set_combine(meleeSet, sets.buff['Battuta'])
	end
	
	return meleeSet
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------
-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
	classes.CustomMeleeGroups:clear()
	
	equip(sets[state.WeaponSet.current])
	equip(sets[state.GripSet.current])
end

-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
	local msg = '| ' .. state.WeaponSet.value .. ' | '

	msg = msg .. '[IDLE: ' .. state.IdleMode.value .. ']'

	msg = msg .. '  --' .. state.OffenseMode.value .. '--'
	
	if state.HybridMode.value ~= 'Normal' then
		msg = msg .. ' [' .. state.HybridMode.value .. '] '
	end
	
	msg = msg .. ' [WS: ' .. state.WeaponskillMode.value .. '] '

	if state.DefenseMode.value ~= 'None' then
		msg = msg .. ', ' .. 'Defense: ' .. state.DefenseMode.value .. ' (' .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ')'
	end

	if state.Resist.value ~= 'None' then
			msg = msg .. ' (' .. state.Resist.value .. ')'
	end
	
	if state.Kiting.value == true then
		msg = msg .. '  ~KITING~  '
	end
	
	if state.CastingMode.value ~= 'Normal' then
		msg = msg .. ' || ' .. 'Casting Mode:' .. state.CastingMode.value .. ' || '
	end
	
	if state.TreasureMode.has_value then
		msg = msg .. ', TH: ' .. state.TreasureMode.value
	end

	add_to_chat(122, msg)

	eventArgs.handled = true
end
-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function apply_job_change()
	if player.sub_job == 'DRK' then
		set_macro_page(2, 2)
		send_command('wait 3; input /lockstyleset 22')
	elseif player.sub_job == 'WAR' or player.sub_job == 'SAM' then
		set_macro_page(5, 2)
		send_command('wait 3; input /lockstyleset 22')
	else
		set_macro_page(8,2)
		send_command('wait 3; input /lockstyleset 22')
	end
end