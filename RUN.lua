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
	lockstyleset = 9
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None','Normal', 'Low', 'Mid', 'High')
	state.WeaponskillMode:options('None', 'Normal', 'Low', 'Mid', 'High')
    state.HybridMode:options('Normal', 'DT', 'DTMAX')
	
	state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	
	state.CastingMode:options('Normal', 'HP', 'SIRD')
	
    state.IdleMode:options('Normal', 'DT', 'Refresh')
	
	state.WeaponSet = M{['description']='Weapon Set', 'Epeolatry', 'Montante', 'Aettir', 'Hepatizon'}
	
	state.GripSet = M{['description']='Grip Set','Utu','Kaja','Irenic',}
	
	send_command('bind pageup gs c cycle WeaponSet')
	send_command('bind pagedown gs c cycleback WeaponSet')
	
	send_command('bind ^pageup gs c cycle GripSet')
	send_command('bind ^pagedown gs cycleback GripSet')

	select_default_macro_book()
	
	set_lockstyle()
	
	function user_unload()
		send_command('unbind pageup')
		send_command('unbind pagedown')
		
		send_command('unbind ^pageup')
		send_command('unbind ^pagedown')
	end
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

		sets.Enmity =
		{--Enmity + 74
			ammo="Sapience Orb",
			head="Rabid Visor", neck="Moonbeam Necklace", lear="Cryptic Earring", rear="Friomisi Earring",
			body="Emet Harness +1", hands="Nilas Gloves", lring="Eihwaz Ring", rring="Petrov Ring",
			back="Reiki Cloak", waist="Trance Belt", legs="Eri. Leg Guards +1", feet="Erilaz Greaves +1"
		}
		
		sets.Enmity.HP = set_combine(sets.Enmity,
		{--Enmity + 61
			rear="Odnowa Earring +1",
			rring="Moonbeam Ring",
			back="Moonlight Cape"
		})
		
	-------------------
	-- Job Abilities --
	------------------- 

		sets.precast.JA['Swipe'] =
		{
			ammo="Seeth. Bomblet +1",
			head=gear.HHead_MAB, neck="Sanctity Necklace", lear="Novio Earring", rear="Friomisi Earring",
			body="Samnuha Coat", hands="Carmine Fin. Ga. +1", lring={name="Shiva Ring +1", bag="wardrobe2"}, rring={name="Shiva Ring +1", bag="wardrobe3"},
			back="Evasionist's Cape", waist="Orpheus's Sash", legs="Shneddick Tights +1", feet=gear.HBoots_TP
		}

		sets.precast.JA['Lunge'] = sets.precast.JA['Swipe']

		sets.precast.JA['Gambit'] =
		{
			hands="Runeist Mitons +1"
		}

		sets.precast.JA['Rayke'] = 
		{
			feet="Futhark Boots +1"
		}

		sets.precast.JA['Swordplay'] = 
		{
			hands="Futhark Mitons +1"
		}

		sets.precast.JA['Vallation'] = 
		{
			body="Runeist's Coat +2",
			back="Ogma's Cape"
		}

		sets.precast.JA['Valiance'] =
		{
			body="Runeist's Coat +2",
			back="Ogma's Cape"
		}

		sets.precast.JA['Pflug'] = 
		{
			feet="Runeist Bottes +1"
		}

		sets.precast.JA['Battuta'] =
		{
			head="Fu. Bandeau +1"
		}

		sets.precast.JA['Liement'] = 
		{
			body="Futhark Coat +1"
		}

		sets.precast.JA['Vivacious Pulse'] = 
		{
			ammo="Staunch Tathlum +1",	
			head="Erilaz Galea +1", neck="Incanter's Torque", lear="Beatific Earring", rear="Odnowa Earring +1",
			body="Runeist's Coat +2", hands="Turms Mittens +1", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back="Moonlight Cape", waist="Bishop's Sash", legs="Rune. Trousers +1", feet="Erilaz Greaves +1"
		}

		sets.precast.JA['Elemental Sforzo'] =
		{
			body="Futhark Coat +1"
		}
		
		sets.precast.JA['One for All'] = set_combine(sets.Enmity.HP,
		{
			head="Erilaz Galea +1", lear="Etiolation Earring",
			body="Runeist's Coat +2", hands="Turms Mittens +1",
			feet="Turms Leggings"
		})
	
	-------------------
	-- Precast Magic --
	------------------- 
	
		sets.precast.FC =
		{--Fast Cast + 71%
			ammo="Sapience Orb",
			head="Carmine Mask +1", neck="Orunmila's Torque", lear="Etiolation Earring", rear="Loquac. Earring",
			body=gear.TBody_Phalanx, hands="Leyline Gloves", lring="Kishar Ring", rring="Rahab Ring",
			back=gear.RUNCape_FC, waist="Trance Belt", legs="Aya. Cosciales +2", feet="Carmine Greaves +1"
		}
		
		sets.precast.FC.HP = set_combine(sets.precast.FC,
		{--Fast Cast + 53%
			rear="Odnowa Earring +1",
			lring="Eihwaz Ring", rring="Moonbeam Ring",
			back="Moonlight Cape",
		})

		sets.precast.FC['Utsusemi'] = 
		{--Fast Cast + 71%
			neck="Magoraga Beads",
			body="Passion Jacket"
		}

		sets.precast.FC['Enhancing Magic'] = 
		{
			waist="Siegel Sash",
			legs="Futhark Trousers +1"
		}
		


----------------------------------------------------------------------------
--------------------									--------------------
------------							 						------------
--------					Midcast Gear Sets						--------
------------							 						------------
--------------------									--------------------
----------------------------------------------------------------------------


		sets.midcast.FC = sets.precast.FC
		
		sets.midcast.FC.HP = set_combine(sets.precast.FC.HP,
		{
			ammo="Staunch Tathlum +1"
		})
		
		sets.midcast.FC.SIRD = set_combine(sets.midcast.FC.HP,
		{
			head=gear.THead_Phalanx, neck="Moonbeam Necklace",
			hands="Rawhide Gloves", lring="Defending Ring", rring="Moonbeam Ring",
			waist="Flume Belt +1", legs="Carmine Cuisses +1", feet=gear.TFeet_Phalanx
		})

	
	--------------------------------------
	-- Buffing Midcast sets
	--------------------------------------	
		
		sets.midcast.Duration = 
		{
			head="Erilaz Galea +1",
			legs="Futhark Trousers +1"
		}
		
		sets.midcast.Regen =
		{
			head="Rune. Bandeau +1",
			body="Futhark Coat +1", legs ="Futhark Trousers +1"
		}

		sets.midcast.Refresh =
		{
			head="Erilaz Galea +1",
			waist="Gishdubar Sash", legs ="Futhark Trousers +1"
		}

		sets.midcast.Phalanx =
		{-- 28 + ((Enhancing Magic Skill - 300.5)/28.5) + 17 = 50
			ammo="Staunch Tathlum +1",
			head="Fu. Bandeau +1", neck="Incanter's Torque", lear="Andoaa Earring", rear="Odnowa Earring +1",
			body=gear.TBody_Phalanx, hands=gear.THands_Phalanx, lring={name="Stikini Ring +1", bag="wardrobe2"}, rring="Moonbeam Ring",
			back="Moonlight Cape", waist="Olympus Sash", legs=gear.TLegs_Phalanx, feet=gear.TFeet_Phalanx
		}

		sets.midcast.Temper = 
		{ 
			ammo="Staunch Tathlum +1",
			head="Carmine Mask +1", neck="Incanter's Torque", lear="Andoaa Earring", rear="Odnowa Earring +1",
			body="Futhark Coat +1", hands="Runeist Mitons +1", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back="Merciful Cape", waist="Olympus Sash", legs="Carmine Cuisses +1", feet="Turms Leggings"
		}

		sets.midcast.BarElement = 
		{
			ammo="Staunch Tathlum +1",
			head="Carmine Mask +1", neck="Incanter's Torque", lear="Andoaa Earring", rear="Augment. Earring",
			body="Futhark Coat +1", hands="Runeist Mitons +1", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back="Moonlight Cape", waist="Olympus Sash", legs="Carmine Cuisses +1", feet="Runeist Bottes +1"
		}

		sets.midcast.BarStatus = sets.midcast.Duration

		sets.midcast.Stoneskin = sets.midcast.FC.SIRD

		sets.midcast.Aquaveil = sets.midcast.Duration

		sets.midcast.Statless = sets.midcast.Duration

		sets.midcast['Enhancing Magic'] = sets.midcast.Duration
		
		sets.midcast.Utsusemi = sets.midcast.FC

		sets.midcast.Protection = sets.midcast.Duration
		
		sets.midcast.Buffs = sets.midcast.FC.HP


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
			head="Aya. Zucchetto +2", neck="Erra Pendant", lear="Digni. Earring", rear="Gwati Earring",
			body="Ayanmo Corazza +2", hands="Aya. Manopolas +2", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back=gear.RUNCape_FC, waist="Luminary Sash", legs="Aya. Cosciales +2", feet="Aya. Gambieras +2"
		}
	
		sets.midcast.Cures = set_combine(sets.midcast.FC.SIRD,
		{
			head="Erilaz Galea +1", lear="Mendi. Earring", rear="Odnowa Earring +1",
			hands="Runeist Mitons +1", lring="Eihwaz Ring", rring="Moonbeam Ring",
			back="Moonlight Cape", waist="Gishdubar Sash", legs="Futhark Trousers +1", feet="Erilaz Greaves +1"
		})
		
		sets.midcast['Elemental Magic'] = sets.precast.JA['Swipe']

		sets.midcast.StatusRemoval = sets.midcast.FastRecast

		sets.midcast.Cursna = set_combine(sets.midcast.FastRecast,
		{
			neck="Debilis Medallion", lear="Healing Earring", rear="Beatific Earring",
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
		{-- DT: 6%	PDT: 4%		MDT: 6%		Refresh: 3	Regen: 
			ammo="Homiliary",
			head="Erilaz Galea +1", neck="Sanctity Necklace", lear="Dawn Earring", rear="Infused Earring",
			body="Runeist's Coat +2", hands="Turms Mittens +1", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back="Moonlight Cape", waist="Flume Belt +1", legs="Carmine Cuisses +1", feet="Turms Leggings"
		}

		sets.idle.DT = 
		{-- DT: 29%	PDT: 49%	MDT: 34%
			ammo="Staunch Tathlum +1",
			head="Fu. Bandeau +1", neck="Loricate Torque +1", lear="Etiolation Earring", rear="Odnowa Earring +1",
			body="Runeist's Coat +2", hands="Turms Mittens +1", lring="Defending Ring", rring="Moonbeam Ring",
			back="Moonlight Cape", waist="Flume Belt +1", legs="Eri. Leg Guards +1", feet="Erilaz Greaves +1"
		}
		
		sets.idle.Refresh =
		{-- DT: 6%	PDT: 12%	MDT: 6%		Refresh: 7	Regen: 
			ammo="Homiliary",
			head="Rawhide Mask", neck="Sanctity Necklace", lear="Dawn Earring", rear="Infused Earring",
			body="Runeist's Coat +2", hands="Turms Mittens +1", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back="Moonlight Cape", waist="Flume Belt +1", legs="Rawhide Trousers", feet=gear.HBoots_Refresh
		}

		sets.idle.Town = set_combine(sets.idle.Refresh,
		{
			legs="Carmine Cuisses +1"
		})
		
		sets.idle.Adoulin = set_combine(sets.idle.Refresh,
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
		{--DT: -29%	PDT: -49%	MDT: -34%
			ammo="Staunch Tathlum +1",
			head="Fu. Bandeau +1", neck="Loricate Torque +1", lear="Etiolation Earring", rear="Odnowa Earring +1",
			body="Runeist's Coat +2", hands="Turms Mittens +1", lring="Defending Ring", rring="Moonbeam Ring",
			back="Moonlight Cape", waist="Flume Belt +1", legs="Eri. Leg Guards +1", feet="Erilaz Greaves +1"
		}
		
		sets.defense.MDT = 
		{--DT: -29%	PDT: -41%	MDT: -34%
			ammo="Staunch Tathlum +1",
			head="Erilaz Galea +1", neck="Futhark Torque +1", lear="Etiolation Earring", rear="Odnowa Earring +1",
			body="Runeist's Coat +2",hands="Turms Mittens +1", lring="Defending Ring", rring="Moonbeam Ring",
			back="Moonlight Cape", waist="Carrier's Sash", legs="Eri. Leg Guards +1", feet="Turms Leggings"
		}

	
	--------------------------------------
	-- Special Sets
	--------------------------------------
		
		sets.buff.Doom = 
		{
			neck="Nicander's Necklace",
			lring={name="Eshmun's Ring", bag="wardrobe2"}, rring={name="Eshmun's Ring", bag="wardrobe3"},
			waist="Gishdubar Sash"
		}
		
		sets.buff['Embolden'] =
		{
			head="Erilaz Galea +1",
			back="Evasionist's Cape", legs="Futhark Trousers +1"
		}
		
		sets.buff['Battuta'] =
 		{
 			hands="Turms Mittens +1",
 			back=gear.RUNCape_STP, legs="Eri. Leg Guards +1", feet="Turms Leggings"
 		}

	
		sets.Kiting =
		{
			legs="Carmine Cuisses +1"
		}

		sets.Epeolatry = { main="Epeolatry" }
		
		sets.Aettir = { main="Aettir" }
		
		sets.Montante = { main="Montante" }
		
		sets.Hepatizon = { main="Hepatizon Axe +1" }
	
		sets.Utu = { sub="Utu Grip" }
	
		sets.Kaja = { sub="Kaja Grip" }
	
		sets.Irenic = { sub="Irenic Strap +1" }


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
			head=gear.HHead_WSD, neck="Fotia Gorget", lear="Ishvara Earring", rear="Moonshade Earring",
			body="Adhemar Jacket +1", hands="Meg. Gloves +2", lring="Regal Ring", rring="Karieyh Ring +1",
			back=gear.RUNCape_STP, waist="Fotia Belt", legs="Herculean Trousers", feet=gear.HBoots_WSD
		}

    ---Dimidation
		sets.precast.WS['Dimidiation'] = set_combine(sets.precast.WS,
		{
			lear={name="Mache Earring +1", bag="wardrobe2"},
			body="Herculean Vest",
			legs="Samnuha Tights"
		})
		
		sets.precast.WS['Dimidiation'].Low = sets.precast.WS['Dimidiation']

		sets.precast.WS['Dimidiation'].Mid = set_combine(sets.precast.WS['Dimidiation'].Low,
		{
			ammo="Falcon Eye",
			rear={name="Mache Earring +1", bag="wardrobe3"},
			legs="Adhemar Kecks +1"
		})
		
		sets.precast.WS['Dimidiation'].High= set_combine(sets.precast.WS['Dimidiation'].Mid,
		{
			head="Carmine Mask +1",
			legs="Carmine Cuisses +1", feet="Aya. Gambieras +2"
		})
	
	---Ground Strike
		sets.precast.WS['Ground Strike'] = set_combine(sets.precast.WS,
		{
			lear="Sherida Earring", rear="Ishvara Earring",
			waist="Prosilio Belt +1"
		})
		
		sets.precast.WS['Ground Strike'].Low = sets.precast.WS['Ground Strike']
		
		sets.precast.WS['Ground Strike'].Mid = set_combine(sets.precast.WS['Ground Strike'].Low,
		{
			rear={name="Mache Earring +1", bag="wardrobe3"},
			waist="Fotia Belt", legs="Adhemar Kecks +1"
		})
		
		sets.precast.WS['Ground Strike'].High = set_combine(sets.precast.WS['Ground Strike'].Mid,
		{
			ammo="Seeth. Bomblet +1",
			head="Carmine Mask +1", lear={name="Mache Earring +1", bag="wardrobe2"}, 
			legs="Carmine Cuisses +1", feet="Aya. Gambieras +2"
		})

	---Spinning Slash
		sets.precast.WS['Spinning Slash'] = set_combine(sets.precast.WS,
		{
			lear="Sherida Earring", rear="Ishvara Earring"
		})
		
		sets.precast.WS['Spinning Slash'].Low = sets.precast.WS['Spinning Slash']
		
		sets.precast.WS['Spinning Slash'].Mid = set_combine(sets.precast.WS['Spinning Slash'].Low,
		{
			rear={name="Mache Earring +1", bag="wardrobe3"},
			legs="Adhemar Kecks +1"
		})
		
		sets.precast.WS['Spinning Slash'].High = set_combine(sets.precast.WS['Spinning Slash'].Mid,
		{
			ammo="Seeth. Bomblet +1",
			head="Carmine Mask +1", lear={name="Mache Earring +1", bag="wardrobe2"}, 
			legs="Carmine Cuisses +1", feet="Aya. Gambieras +2"
		})
		
	---Resolution
		sets.precast.WS['Resolution'] = set_combine(sets.precast.WS,
		{
			ammo="Seeth. Bomblet +1",
			head="Adhemar Bonnet +1", lear="Sherida Earring",
			body="Adhemar Jacket +1", hands="Adhemar Wrist. +1", lring="Niqmaddu Ring", rring="Epona's Ring",
			legs="Samnuha Tights", feet=gear.HBoots_TP
		})
		
		sets.precast.WS['Resolution'].Low = set_combine(sets.precast.WS['Resolution'],
		{
			head=gear.HHead_WSD, rear={name="Mache Earring +1", bag="wardrobe3"},
			body="Herculean Vest", rring="Regal Ring"
		})
		
		sets.precast.WS['Resolution'].Mid = set_combine(sets.precast.WS['Resolution'].Low,
		{
			lear={name="Mache Earring +1", bag="wardrobe2"},
			hands="Meg. Gloves +2",
			legs="Adhemar Kecks +1"
		})
		
		sets.precast.WS['Resolution'].High = set_combine(sets.precast.WS['Resolution'].Mid,
		{
			head="Carmine Mask +1",
			legs="Carmine Cuisses +1", feet="Aya. Gambieras +2"
		})
		
	--Shockwave	
		sets.precast.WS['Shockwave'] = sets.midcast.Macc
		
	--Frostbite
		sets.precast.WS['Frostbite'] = set_combine(sets.precast.JA['Swipe'],
		{
			rear="Moonshade Earring",
		})
		
	--Freezebite
		sets.precast.WS['Freezebite'] =  sets.precast.WS['Frostbite']
		
		
	--Upheavel
		sets.precast.WS['Upheavel'] = sets.precast.WS['Resolution']
	
		sets.precast.WS['Upheavel'].Low = sets.precast.WS['Resolution'].Low
		
		sets.precast.WS['Upheavel'].Mid = sets.precast.WS['Resolution'].Mid
	
		sets.precast.WS['Upheavel'].High = sets.precast.WS['Resolution'].High
	
	--------------------------------------
	-- Melee sets
	--------------------------------------

		sets.engaged =
		{
			ammo="Yamarang",
			head="Adhemar Bonnet +1", neck="Anu Torque", lear="Sherida Earring", rear="Telos Earring",
			body="Adhemar Jacket +1", hands="Adhemar Wrist. +1", lring="Niqmaddu Ring", rring="Epona's Ring",
			back=gear.RUNCape_STP, waist="Windbuffet Belt +1", legs="Samnuha Tights", feet=gear.HBoots_TP
		}
	
		sets.engaged.AM3 = set_combine(sets.engaged,
		{
			rear="Dedition Earring",
			lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"},
			feet="Carmine Greaves +1"
		})

		sets.engaged.Low = set_combine(sets.engaged,
		{
			head="Dampening Tam", neck="Combatant's Torque", lear={name="Mache Earring +1", bag="wardrobe2"}, rear={name="Mache Earring +1", bag="wardrobe3"},
		})

		sets.engaged.Mid = set_combine(sets.engaged.Low,
		{
			body="Ayanmo Corazza +2", rring={name="Chirich Ring +1", bag="wardrobe3"},
			waist="Kentarch Belt +1", legs="Adhemar Kecks +1"
		})

		sets.engaged.High = set_combine(sets.engaged.Mid,
		{
			head="Carmine Mask +1",
			hands="Aya. Manopolas +2", lring={name="Chirich Ring +1", bag="wardrobe2"}, 
			legs="Carmine Cuisses +1", feet="Aya. Gambieras +2"
		})
		
		
	------------------------------------------------------------------------------------------------
	---------------------------------------  Hybrid Sets -------------------------------------------
	------------------------------------------------------------------------------------------------	
	
	---Base Hybrid Set
		sets.engaged.Hybrid =
		{
			ammo="Staunch Tathlum +1",
			head="Dampening Tam", neck="Futhark Torque +1",
			body="Ayanmo Corazza +2", lring="Defending Ring", rring="Moonbeam Ring",
			back=gear.RUNCape_STP, waist="Flume Belt +1"
		}
		
		sets.engaged.Hybrid2 =
		{
			ammo="Staunch Tathlum +1",
			neck="Futhark Torque +1",
			body="Runeist's Coat +2", lring="Defending Ring", rring="Moonbeam Ring",
			back="Moonlight Cape", waist="Flume Belt +1"
		}
		
	---Hybrid Combat
		sets.engaged.DT 			= set_combine(sets.engaged, 		sets.engaged.Hybrid)
		sets.engaged.Low.DT 		= set_combine(sets.engaged.Low, 	sets.engaged.Hybrid)
		sets.engaged.Mid.DT			= set_combine(sets.engaged.Mid, 	sets.engaged.Hybrid)
		sets.engaged.High.DT		= set_combine(sets.engaged.High, 	sets.engaged.Hybrid)

		sets.engaged.DTMAX 			= set_combine(sets.engaged, 		sets.engaged.Hybrid2)
		sets.engaged.Low.DTMAX 		= set_combine(sets.engaged.Low, 	sets.engaged.Hybrid2)
		sets.engaged.Mid.DTMAX		= set_combine(sets.engaged.Mid, 	sets.engaged.Hybrid2)
		sets.engaged.High.DTMAX		= set_combine(sets.engaged.High, 	sets.engaged.Hybrid2)


end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
function job_precast(spell, action, spellMap, eventArgs)
	currentSpell = spell.english
	
	if state.CastingMode.value ~= 'Normal' or (spell.action_type == 'Magic' and buffactive['Fast Cast']) then
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

function job_post_precast(spell, action, spellMap, eventArgs)
    if buffactive['Fast Cast'] then
        equip{legs="Futhark Trousers +1"}
	end
end

function job_midcast(spell, action, spellMap, eventArgs)
    currentSpell = spell.english
	
	if spell.action_type == 'Magic' then
		if state.CastingMode.value == 'HP' then
			if spell.English == 'Flash' or spell.English == 'Foil' or spell.English == 'Stun' or spellMap == 'Debuffs' then
				equip(sets.Enmity.HP)
			else
				equip(sets.midcast.FC.HP)
				equip(sets.midcast['currentSpell'])
			end
		elseif state.CastingMode.value == 'SIRD' then
			eventArgs.handled = true
			
			if spellMap == 'Debuffs' then
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

function job_aftercast(spell,action, spellMap, eventArgs)
	equip(sets[state.WeaponSet.current])
	equip(sets[state.GripSet.current])
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------
function job_buff_change(buff,gain)
	if buff == "doom" then
        if gain then
            equip(sets.buff.Doom)
            disable('neck', 'lring','rring','waist')
        else
            enable('neck','lring','rring','waist')
            handle_equipping_gear(player.status)
        end
    end
	if buffactive['Embolden'] and player.in_combat ~= true then
		equip(sets.Buff['Embolden])
	end
		
	if buffactive['Battuta'] and player.in_combat == true then
		meleeSet = set_combine(meleeSet, sets.Buff['Battuta'])
		defenseSet = set_combine(defenseSet, sets.Buff['Battuta'])
	end
	
	if buffactive['Aftermath: Lv.3'] and player.equipment.main == "Epeolatry" then
		classes.CustomMeleeGroups:append('AM3')
		handle_equipping_gear(player.status)
	end
end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
	equip(sets[state.WeaponSet.current])
	equip(sets[state.GripSet.current])
end
-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
	equip(sets[state.WeaponSet.current])
	equip(sets[state.GripSet.current])
end

-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
	local msg = state.WeaponSet.value .. ' '

	msg = msg .. '[IDLE: ' .. state.IdleMode.value .. ']'
	
	if state.CombatForm.has_value then
		msg = msg .. ' [COMBAT FORM: ' .. state.CombatForm.value .. '|'
	end

	msg = msg .. ': '

	msg = msg .. state.OffenseMode.value
	if state.HybridMode.value ~= 'Normal' then
		msg = msg .. ' ' .. state.HybridMode.value .. '] '
	end
	msg = msg .. ' [WS: ' .. state.WeaponskillMode.value .. '] '

	if state.DefenseMode.value ~= 'None' then
		msg = msg .. ', ' .. 'Defense: ' .. state.DefenseMode.value .. ' (' .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ')'
	end

	if state.Kiting.value == true then
		msg = msg .. '  ~KITING~  '
	end
	
	if state.CastingMode.value ~= 'Normal' then
		msg = msg .. ' || ' .. 'Casting Mode:' .. state.CastingMode.value .. ' || '
	end

	add_to_chat(122, msg)

	eventArgs.handled = true
end
-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
function update_active_abilities()
	state.Buff['Embolden'] = buffactive['Embolden'] or false
	state.Buff['Battuta'] = buffactive['Battuta'] or false
end

function apply_ability_bonuses(spell, action, spellMap)
	if state.Buff['Embolden'] and spell.skill == 'Enhancing Magic' then
		equip(sets.buff['Embolden'])
	end
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	if player.sub_job == 'DRK' then
		set_macro_page(1, 14)
	elseif player.sub_job == 'WAR' or player.sub_job == 'SAM' then
		set_macro_page(4, 14)
	elseif player.sub_job == 'BLU' then
		set_macro_apage(7,15)
	end
end

function set_lockstyle()
    send_command('wait 3; input /lockstyleset ' .. lockstyleset)
end
