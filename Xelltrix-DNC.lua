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
    state.Buff['Climactic Flourish'] = buffactive['climactic flourish'] or false

    state.MainStep = M{['description']='Main Step', 'Box Step', 'Quickstep', 'Feather Step', 'Stutter Step'}
    state.AltStep = M{['description']='Alt Step', 'Quickstep', 'Feather Step', 'Stutter Step', 'Box Step'}
	--state.Samba = M{['description']='Samba', 'Haste Samba', 'Drain Samba', 'Aspir Samba'}
	state.Runes = M{['description']='Runes', 'Ignis', 'Gelus', 'Flabra', 'Tellus', 'Sulpor', 'Unda', 'Lux', 'Tenebrae'}
	
	state.EnmityDown = M(false)

    determine_haste_group()
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	state.OffenseMode:options('Normal', 'Low', 'Mid', 'High')
    state.HybridMode:options('Normal', 'DT', 'DTMAX')
	state.WeaponskillMode:options('Normal', 'Low', 'Mid', 'High')
    state.IdleMode:options('Normal','DT')
	
	state.MainWeaponSet = M{['description']='Main Weapon Set',
		'Twashtar',
		'Tauret'
	}
	
	state.SubWeaponSet = M{['description']='Sub Weapon Set',
		'Centovente',
		'Ternion',
		'subTwashtar'
	}

    -- Additional local binds
    send_command('bind ^home gs c cycle mainstep')
	send_command('bind ^end gs c cycleback mainstep')
    send_command('bind !home gs c cycle altstep')
	send_command('bind !end gs c cycle altstep')
	
	if player.sub_job == 'RUN' then
		send_command('bind != gs c cycle Runes')
		send_command('bind !- gs c cycleback Runes')
	end
	
	send_command('bind numpad. gs c toggle EnmityDown')
	
	send_command('bind pageup gs c cycle MainWeaponSet')
	send_command('bind pagedown gs c cycleback MainWeaponSet')
	
	send_command('bind ^pageup gs c cycle SubWeaponSet')
	send_command('bind ^pagedown gs c cycleback SubWeaponSet')

    apply_job_change()
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
    send_command('unbind ^=')
    send_command('unbind ^-')
	send_command('unbind !=')
	send_command('unbind !-')
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
		{--		Enmity: +75
			ammo="Sapience Orb",
			head="Rabid Visor", neck="Unmoving Collar +1", lear="Cryptic Earring", rear="Trux Earring",
			body="Emet Harness +1", hands="Nilas Gloves", lring="Eihwaz Ring", rring="Supershear Ring",
			back="Reiki Cloak", waist="Trance Belt", legs="Zoar Subligar +1", feet="Ahosi Leggings"
		}
		
		sets.EnmityDown =
		{--		Enmity: -27
			rear="Novia Earring",
			body="Adhemar Jacket +1",
			lring="Lebeche Ring", rring="Kuchekula Ring"
		}
		
		sets.MAXHP =
		{
			ammo="Staunch Tathlum +1",
			head="Turms Cap +1", neck="Unmoving Collar +1", lear="Odnowa Earring +1", rear="Tuisto Earring",
			body="Malignance Tabard", hands="Turms Mittens +1", lring="Gelatinous Ring +1", rring="Moonlight Ring",
			back="Moonlight Cape", waist="Carrier's Sash", legs="Turms Subligar +1", feet="Turms Leggings +1"
		}



	-------------------
	-- Job Abilities --
	------------------- 

		sets.precast.JA['No Foot Rise'] =
		{
			body="Horos Casaque +3",
			back="Toetapper Mantle"
		}

		sets.precast.JA['Trance'] =
		{
			head="Horos Tiara +1"
		}

		sets.precast.Waltz =
		{
			ammo="Yamarang",
			head="Mummu Bonnet +2", neck="Etoile Gorget +2", lear="Sjofn Earring", rear="Tuisto Earring",
			body="Maxixi Casaque +1", hands="Malignance Gloves", lring="Metamor. Ring +1", rring="Moonlight Ring",
			back=gear.DNCCape_STP, waist="Flume Belt +1", legs="Dashing Subligar", feet="Malignance Boots"
		}


		sets.precast.Samba =
		{
			head="Maxixi Tiara +1",
			back=gear.DNCCape_STP
		}

		sets.precast.Jig =
		{
			legs="Horos Tights +3", feet="Maxixi Shoes +1"
		}

		sets.precast.Step = sets.engaged.High

		sets.precast.Flourish1 = {}
		sets.precast.Flourish1['Violent Flourish'] = set_combine(sets.engaged.High,
		{
			neck="Sanctity Necklace", lear="Digni. Earring",ear2="Gwati Earring",
			body="Horos Casaque +3",lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
		})
		sets.precast.Flourish1['Desperate Flourish'] = sets.engaged.High

		sets.precast.Flourish2 = {}
		
		sets.precast.Flourish2['Reverse Flourish'] =
		{
			hands="Macu. Bangles +1",
			back="Toetapper Mantle"
		}

		sets.precast.Flourish3 = {}
		
		sets.precast.Flourish3['Climactic Flourish'] =
		{
			head="Maculele Tiara +1"
		}
	
	
	-------------------
	-- Precast Magic --
	------------------- 

		sets.precast.FC =
		{
			ammo="Sapience Orb",
			head=gear.HHead_MAB, neck="Orunmila's Torque", lear="Etiolation Earring", rear="Loquac. Earring",
			body="Samnuha Coat", hands="Leyline Gloves", lring="Rahab Ring", rring="Weather. Ring +1",
			back="Moonlight Cape", waist="Flume Belt +1", legs="Rawhide Trousers", feet="Malignance Boots"
		}

		sets.precast.FC.Utsusemi = set_combine(sets.precast.FC,
		{
			neck="Magoraga Beads",
			body="Passion Jacket"
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
		
		sets.midcast.Utsusemi = sets.precast.FC
		
		sets.midcast.Phalanx = 
		{
			ammo="Staunch Tathlum +1",
			head=gear.THead_Phalanx, neck="Incanter's Torque", lear="Andoaa Earring", rear="Mimir Earring",
			body=gear.TBody_Phalanx, hands=gear.THands_Phalanx, lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back="Moonlight Cape", waist="Olympus Sash", legs=gear.TLegs_Phalanx, feet=gear.TFeet_Phalanx
		}
		
		sets.midcast.Stoneskin =
		{
			ammo="Staunch Tathlum +1",
			head=gear.THead_Phalanx, neck="Stone Gorget", lear="Earthcry Earring", rear="Mimir Earring",
			body=gear.TBody_Phalanx, hands=gear.THands_Phalanx, lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back="Moonlight Cape", waist="Olympus Sash", legs=gear.TLegs_Phalanx, feet=gear.TFeet_Phalanx
		}
		
		sets.midcast.Cures =
		{
			ammo="Staunch Tathlum +1",
			head="Turms Cap +1", neck="Incanter's Torque", lear="Mendi. Earring", rear="Meili Earring",
			body="Malignance Tabard", hands="Turms Mittens +1", lring="Lebeche Ring", rring="Menelaus's Ring",
			back="Moonlight Cape", waist="Bishop's Sash", legs="Turms Subligar +1", feet="Turms Leggings +1"
		}
		
		sets.midcast['Elemental Magic'] =
		{
			ammo="Pemphredo Tathlum",
			head=gear.HHead_MAB, neck="Sanctity Necklace", lear="Friomisi Earring", rear="Crematio Earring",
			body="Samnuha Coat", hands="Leyline Gloves", lring="Shiva Ring +1", rring="Metamor. Ring +1",
			back="Sacro Mantle", waist="Orpheus's Sash", legs="Herculean Trousers", feet="Adhemar Gamashes +1"
		}
		
		sets.midcast.Macc =
		{
			ammo="Yamarang",
			head="Malignance Chapeau", neck="Etoile Gorget +2", lear="Gwati Earring", rear="Digni. Earring",
			body="Malignance Tabard", hands="Malignance Gloves", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back="Sacro Mantle", waist="Engraved Belt", legs="Malignance Tights", feet="Malignance Boots"
		}
		
		sets.midcast['Enfeebling Magic'] = sets.midcast.Macc
		
		sets.midcast['Dark Magic'] = sets.midcast.Macc
	
	
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
	
		sets.Ternion 		= { 	sub="Ternion Dagger +1" 		}
			
		sets.Twashtar 		= { 	main="Twashtar"		}
	
		sets.subTwashtar 	= { 	sub="Twashtar" 		}
		
		sets.Tauret 		= { 	main="Tauret" 		}
		
		sets.Centovente		= { 	sub="Centovente"	}
		
		
	------------------------------------------------------------------------------------------------
	------------------------------------------ Idle Sets -------------------------------------------
	------------------------------------------------------------------------------------------------

		sets.idle =
		{
			ammo="Staunch Tathlum +1",
			head="Turms Cap +1", neck="Warder's Charm +1", lear="Dawn Earring", rear="Infused Earring",
			body="Tu. Harness +1", hands="Turms Mittens +1", lring="Defending Ring", rring="Moonlight Ring",
			back="Moonlight Cape", waist="Engraved Belt", legs="Turms Subligar +1", feet="Skd. Jambeaux +1"
		}
		
		sets.idle.DT =
		{--	DT: 35%		PDT: 51%	MDT: 35%
			ammo="Yamarang",
			head="Malignance Chapeau",  neck="Warder's Charm +1", lear="Dawn Earring", rear="Infused Earring",
			body="Malignance Tabard", hands="Malignance Gloves", lring="Defending Ring", rring="Moonlight Ring",
			back="Moonlight Cape", waist="Engraved Belt", legs="Malignance Tights", feet="Malignance Boots"
		}

		sets.idle.Town = set_combine(sets.idle,
		{
			feet="Skd. Jambeaux +1"
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
	
	-- Defense sets

		sets.defense.PDT = 
		{
			ammo="Staunch Tathlum +1",
			head="Malignance Chapeau", neck="Warder's Charm +1", lear="Dawn Earring", rear="Infused Earring",
			body="Malignance Tabard", hands="Malignance Gloves", lring="Defending Ring", rring="Moonlight Ring",
			back="Moonlight Cape", waist="Engraved Belt", legs="Malignance Tights", feet="Malignance Boots"
		}

		sets.defense.MDT = sets.defense.PDT

	
	--------------------------------------
	-- Special Sets
	--------------------------------------
	
		sets.Kiting =
		{
			feet="Skd. Jambeaux +1"
		}
	
	---Buffs
		sets.buff['Climactic Flourish'] =
		{
			head="Maculele Tiara +1"
		}
		
		sets.buff.Doom = 
		{
			neck="Nicander's Necklace",
			lring={name="Eshmun's Ring", bag="wardrobe2"}, rring={name="Eshmun's Ring", bag="wardrobe3"},
			waist="Gishdubar Sash"
		}
		
		sets.TreasureHunter = 
		{ 
			head=gear.HHead_TH, 
			hands="Volte Bracers",
			waist="Chaac Belt"
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
			ammo="Aurgelmir Orb +1",
			head=gear.HHead_WSD, neck="Fotia Gorget", lear="Sherida Earring", rear="Moonshade Earring",
			body="Adhemar Jacket +1", hands="Meg. Gloves +2", lring="Regal Ring", rring="Epona's Ring",
			back="Sacro Mantle", waist="Fotia Belt", legs="Horos Tights +3", feet=gear.HBoots_WSD
		}

		sets.precast.WS.Low = set_combine(sets.precast.WS,
		{
			feet="Malignance Boots"
		})
		
		sets.precast.WS.Mid = set_combine(sets.precast.WS.Low,
		{
			lear={name="Mache Earring +1", bag="wardrobe2"}, rear={name="Mache Earring +1", bag="wardrobe3"}
		})
		
		sets.precast.WS.High = set_combine(sets.precast.WS.Mid,
		{
			rear={name="Mache Earring +1", bag="wardrobe3"},	
			body="Malignance Tabard", rring="Regal Ring",
			legs="Meg. Chausses +2"
		})
		
		sets.precast.WS.CF = set_combine(sets.precast.WS,
		{
			head="Maculele Tiara +1",
		})

	
	---Exenterator
		sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS,
		{
			ammo="C. Palug Stone",
			head="Malignance Chapeau", rear="Brutal Earring",
			lring="Ilabrat Ring", rring="Regal Ring",
			legs="Meg. Chausses +2", feet=gear.HBoots_TP
		})

		sets.precast.WS['Exenterator'].Low = set_combine(sets.precast.WS['Exenterator'],
		{
			hands="Malignance Gloves"		
		})
		
		sets.precast.WS['Exenterator'].Mid = sets.precast.WS['Exenterator'].Low

		sets.precast.WS['Exenterator'].High = set_combine(sets.precast.WS['Exenterator'].Mid,
		{
			lear={name="Mache Earring +1", bag="wardrobe2"},
			body="Malignance Tabard",
			legs="Malignance Tights", feet="Malignance Boots"
		})

		sets.precast.WS['Exenterator'].CF = set_combine(sets.precast.WS['Exenterator'],
		{
			head="Maculele Tiara +1",
		})

	---Evisceration	
		sets.precast.WS['Evisceration'] =
		{
			ammo="Charis Feather",
			head=gear.AHead_TP, neck="Fotia Gorget", lear="Odr Earring", rear={name="Mache Earring +1", bag="wardrobe3"},
			body="Meg. Cuirie +2", hands="Adhemar Wrist. +1", lring="Ilabrat Ring", rring="Regal Ring",
			back="Sacro Mantle", waist="Fotia Belt", legs="Lustr. Subligar +1", feet=gear.HBoots_Crit
		}

		sets.precast.WS['Evisceration'].Low = set_combine(sets.precast.WS['Evisceration'],
		{
			head="Blistering Sallet +1"
		})
		
		sets.precast.WS['Evisceration'].Mid = set_combine(sets.precast.WS['Evisceration'].Low,
		{
			lear={name="Mache Earring +1", bag="wardrobe2"}, rear={name="Mache Earring +1", bag="wardrobe3"}
		})
		
		sets.precast.WS['Evisceration'].High = set_combine(sets.precast.WS['Evisceration'].Mid,
		{
			body="Malignance Tabard",
			legs="Malignance Tights", feet="Malignance Boots"
		})
		
		sets.precast.WS['Evisceration'].CF = set_combine(sets.precast.WS['Evisceration'],
		{
			head="Maculele Tiara +1",
		})

	---Dancing Edge
		sets.precast.WS['Dancing Edge'] = set_combine(sets.precast.WS,
		{
			head="Malignance Chapeau", rear="Brutal Earring",
			hands="Adhemar Wrist. +1", lring="Ilabrat Ring", rring="Regal Ring",
			legs="Meg. Chausses +2", feet="Malignance Boots"
		})

		sets.precast.WS['Dancing Edge'].Low = set_combine(sets.precast.WS['Dancing Edge'],
		{
			hands="Malignance Gloves"
		})
		
		sets.precast.WS['Dancing Edge'].Mid = set_combine(sets.precast.WS['Dancing Edge'].Low,
		{
			lear={name="Mache Earring +1", bag="wardrobe2"}, rear={name="Mache Earring +1", bag="wardrobe3"}
		})
		
		sets.precast.WS['Dancing Edge'].High = set_combine(sets.precast.WS['Dancing Edge'].Mid,
		{
			lear="Odr Earring",			
			body="Malignance Tabard",
			legs="Malignance Tights"
		})
		
		sets.precast.WS['Dancing Edge'].CF = set_combine(sets.precast.WS['Dancing Edge'],
		{
			head="Maculele Tiara +1"
		})
		
	---Rudra's Storm
		sets.precast.WS['Rudra\'s Storm'] = 
		{
			ammo="C. Palug Stone",
			head="Lustratio Cap +1", neck="Etoile Gorget +2", lear="Odr Earring", rear={name="Mache Earring +1", bag="wardrobe3"},
			body="Herculean Vest", hands="Meg. Gloves +2", lring="Regal Ring", rring="Epaminondas's Ring",
			back="Sacro Mantle", waist="Kentarch Belt +1", legs="Horos Tights +3", feet="Lustra. Leggings +1"
		}

		sets.precast.WS['Rudra\'s Storm'].Low = sets.precast.WS["Rudra's Storm"]
		
		sets.precast.WS['Rudra\'s Storm'].Mid = sets.precast.WS["Rudra's Storm"]
		
		sets.precast.WS['Rudra\'s Storm'].High = sets.precast.WS["Rudra's Storm"]

		sets.precast.WS['Rudra\'s Storm'].CF = set_combine(sets.precast.WS["Rudra's Storm"],
		{
			ammo="Charis Feather",
			head="Maculele Tiara +1",
			body="Meg. Cuirie +2",
			feet=gear.HBoots_Crit
		})

	---Pyrrhic Kleos
		sets.precast.WS['Pyrrhic Kleos'] = 
		{
			ammo="Aurgelmir Orb +1",
			head="Lustratio Cap +1", neck="Fotia Gorget", lear="Sherida Earring", rear="Odr Earring",
			body="Adhemar Jacket +1", hands="Adhemar Wrist. +1", lring="Regal Ring", rring="Gere Ring",
			back="Sacro Mantle", waist="Fotia Belt", legs="Samnuha Tights", feet="Lustra. Leggings +1"
		}

		sets.precast.WS['Pyrrhic Kleos'].Low = set_combine(sets.precast.WS['Pyrrhic Kleos'],
		{
			lear={name="Mache Earring +1", bag="wardrobe2"}, rear={name="Mache Earring +1", bag="wardrobe3"}
		})
		
		sets.precast.WS['Pyrrhic Kleos'].Mid = set_combine(sets.precast.WS['Pyrrhic Kleos'].Low,
		{
			head="Malignance Chapeau",
			legs="Meg. Chausses +2"
		})
		
		sets.precast.WS['Pyrrhic Kleos'].High = set_combine(sets.precast.WS['Pyrrhic Kleos'].Mid,
		{
			lear="Odr Earring",			
			body="Malignance Tabard",
			legs="Malignance Tights"
		})
		
		sets.precast.WS['Pyrrhic Kleos'].CF = set_combine(sets.precast.WS['Pyrrhic Kleos'],
		{
			head="Maculele Tiara +1"
		})
		
	---Aeolian Edge
		sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS,
		{
			ammo="Pemphredo Tathlum",
			head=gear.HHead_MAB, lear="Friomisi Earring",
			body="Samnuha Coat", hands="Leyline Gloves", lring="Shiva Ring +1", rring="Epaminondas's Ring",
			back="Sacro Mantle", waist="Orpheus's Sash", legs="Herculean Trousers", feet="Adhe. Gamashes +1"
		})


	sets.precast.WS['Cyclone'] = sets.precast.WS['Aeolian Edge']
	
	sets.precast.WS['Wasp Sting'] = sets.idle

	sets.precast.WS['Gust Slash'] = 
	{
		ammo="Pemphredo Tathlum",
		head="Malignance Chapeau", neck="Sanctity Necklace", lear="Friomisi Earring", rear="Moonshade Earring",
		body="Malignance Tabard", hands="Leyline Gloves", lring="Shiva Ring +1", rring="Epaminondas's Ring",
		back="Sacro Mantle", waist="Orpheus's Sash", legs="Herculean Trousers", feet="Adhe. Gamashes +1"
	}

	
	--------------------------------------
	-- Melee sets
	--------------------------------------

	
	----------------------------------------------------------
	--					(DW5 + No Haste)
	----------------------------------------------------------

	--30 DW = 41 DW needed		
	
	----------------------------------------------------------	
	
		sets.engaged =
		{--		DW36
			ammo="Yamarang",
			head="Dampening Tam", neck="Etoile Gorget +2", lear="Eabani Earring", rear="Suppanomimi",
			body="Adhemar Jacket +1", hands="Adhemar Wrist. +1", lring="Epona's Ring", rring="Gere Ring",
			back=gear.DNCCape_DW, waist="Reiki Yotai", legs="Samnuha Tights", feet=gear.TFeet_TP
		}

		sets.engaged.Low = set_combine(sets.engaged,
		{
			head="Malignance Chapeau",
			legs="Malignance Tights"
		})

		sets.engaged.Mid = set_combine(sets.engaged.Low,
		{
			hands="Malignance Gloves", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"},
			feet="Malignance Boots"
		})

		sets.engaged.High = set_combine(sets.engaged.Mid,
		{
			lear={name="Mache Earring +1", bag="wardrobe2"}, rear={name="Mache Earring +1", bag="wardrobe3"},
			waist="Kentarch Belt +1"
		})
	
	
	
	----------------------------------------------------------
	--					(DW5 + 15% Haste)
	----------------------------------------------------------

	--30 DW = 31 DW needed		
	
	----------------------------------------------------------	
	
		sets.engaged.Min =
		{
			ammo="Yamarang",
			head="Dampening Tam", neck="Etoile Gorget +2", lear="Eabani Earring", rear="Suppanomimi",
			body="Adhemar Jacket +1", hands="Adhemar Wrist. +1", lring="Hetairoi Ring", rring="Epona's Ring",
			back=gear.DNCCape_DW, waist="Reiki Yotai", legs="Samnuha Tights", feet="Horos T. Shoes +3"
		}

		sets.engaged.Low.Min = set_combine(sets.engaged.Min,
		{
			head="Malignance Chapeau", neck="Etoile Gorget +2",
			legs="Malignance Tights"
		})

		sets.engaged.Mid.Min = set_combine(sets.engaged.Low.Min,
		{
			hands="Malignance Gloves", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"},
			feet="Malignance Boots"
		})

		sets.engaged.High.Min = set_combine(sets.engaged.Mid.Min,
		{
			lear={name="Mache Earring +1", bag="wardrobe2"}, rear={name="Mache Earring +1", bag="wardrobe3"},
			waist="Kentarch Belt +1"
		})

	
	----------------------------------------------------------
	--					(DW5 + 30% Haste)
	----------------------------------------------------------

	--30 DW = 21 DW needed		
	
	----------------------------------------------------------	
	
		sets.engaged.Med =
		{
			ammo="Yamarang",
			head="Dampening Tam", neck="Etoile Gorget +2", lear="Sherida Earring", rear="Suppanomimi",
			body="Adhemar Jacket +1", hands="Adhemar Wrist. +1", lring="Epona's Ring", rring="Gere Ring",
			back=gear.DNCCape_DW, waist="Windbuffet Belt +1", legs="Samnuha Tights", feet="Horos T. Shoes +3"
		}

		sets.engaged.Low.Med = set_combine(sets.engaged.Med,
		{
			head="Malignance Chapeau",
			legs="Malignance Tights"
		})

		sets.engaged.Mid.Med = set_combine(sets.engaged.Low.Med,
		{
			hands="Malignance Gloves", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"},
			feet="Malignance Boots"
		})

		sets.engaged.High.Med = set_combine(sets.engaged.Mid.Med,
		{
			lear={name="Mache Earring +1", bag="wardrobe2"}, rear={name="Mache Earring +1", bag="wardrobe3"},
			waist="Kentarch Belt +1"
		})

	
	
	----------------------------------------------------------
	--					(DW5 + Max Haste)
	----------------------------------------------------------

	--30 DW = 1 DW needed
	
	----------------------------------------------------------
	
		sets.engaged.Max =
		{
			ammo="Yamarang",
			head="Dampening Tam", neck="Etoile Gorget +2", lear="Sherida Earring", rear="Telos Earring",
			body="Horos Casaque +3", hands="Adhemar Wrist. +1", lring="Epona's Ring", rring="Gere Ring",
			back=gear.DNCCape_STP, waist="Windbuffet Belt +1", legs="Samnuha Tights", feet=gear.HBoots_TP
		}

		sets.engaged.Low.Max = set_combine(sets.engaged.Max,
		{
			head="Malignance Chapeau",
			legs="Malignance Tights", feet="Horos T. Shoes +3"
		})

		sets.engaged.Mid.Max = set_combine(sets.engaged.Low.Max,
		{
			hands="Malignance Gloves", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"},
			waist="Kentarch Belt +1"
		})

		sets.engaged.High.Max = set_combine(sets.engaged.Mid.Max,
		{
			lear={name="Mache Earring +1", bag="wardrobe2"}, rear={name="Mache Earring +1", bag="wardrobe3"},
			body="Malignance Tabard"
		})


	--------------------------------------
	-- Hybrid Sets
	--------------------------------------
		sets.engaged.Hybrid = 
		{--	DT: 23%		PDT: 27%	MDT: 23%
			head="Malignance Chapeau",
			body="Malignance Tabard", hands="Malignance Gloves", 
			legs="Malignance Tights", feet="Malignance Boots"
		}
		
		sets.engaged.Hybrid2 = 
		{-- DT: 31%		PDT: 31%	MDT: 31%
			head="Malignance Chapeau",
			body="Malignance Tabard", hands="Malignance Gloves", lring="Defending Ring", rring="Moonlight Ring",
			legs="Malignance Tights", feet="Malignance Boots"
		}
	

		----------------------------------------------------------
		-- No Haste
		----------------------------------------------------------	
	    sets.engaged.DT 				= set_combine(sets.engaged, 			sets.engaged.Hybrid)
		sets.engaged.Low.DT 			= set_combine(sets.engaged.Low, 		sets.engaged.Hybrid)
		sets.engaged.Mid.DT 			= set_combine(sets.engaged.Mid, 		sets.engaged.Hybrid)
		sets.engaged.High.DT			= set_combine(sets.engaged.High, 		sets.engaged.Hybrid)
	
	
	    sets.engaged.DTMAX 				= set_combine(sets.engaged, 			sets.engaged.Hybrid2)
		sets.engaged.Low.DTMAX 			= set_combine(sets.engaged.Low, 		sets.engaged.Hybrid2)
		sets.engaged.Mid.DTMAX 			= set_combine(sets.engaged.Mid, 		sets.engaged.Hybrid2)
		sets.engaged.High.DTMAX			= set_combine(sets.engaged.High, 		sets.engaged.Hybrid2)
	
	
	
		----------------------------------------------------------
		-- Minimum Haste
		----------------------------------------------------------	
	    sets.engaged.DT.Min 			= set_combine(sets.engaged.Min, 		sets.engaged.Hybrid)
		sets.engaged.Low.DT.Min			= set_combine(sets.engaged.Low.Min, 	sets.engaged.Hybrid)
		sets.engaged.Mid.DT.Min			= set_combine(sets.engaged.Mid.Min, 	sets.engaged.Hybrid)
		sets.engaged.High.DT.Min		= set_combine(sets.engaged.High.Min, 	sets.engaged.Hybrid)
	
	
	    sets.engaged.DTMAX.Min 			= set_combine(sets.engaged.Min, 		sets.engaged.Hybrid2)
		sets.engaged.Low.DTMAX.Min		= set_combine(sets.engaged.Low.Min, 	sets.engaged.Hybrid2)
		sets.engaged.Mid.DTMAX.Min		= set_combine(sets.engaged.Mid.Min, 	sets.engaged.Hybrid2)
		sets.engaged.High.DTMAX.Min		= set_combine(sets.engaged.High.Min, 	sets.engaged.Hybrid2)	
	
	
	
		----------------------------------------------------------
		-- Medium Haste
		----------------------------------------------------------	
	    sets.engaged.DT.Med 			= set_combine(sets.engaged.Med, 		sets.engaged.Hybrid)
		sets.engaged.Low.DT.Med			= set_combine(sets.engaged.Low.Med, 	sets.engaged.Hybrid)
		sets.engaged.Mid.DT.Med			= set_combine(sets.engaged.Mid.Med, 	sets.engaged.Hybrid)
		sets.engaged.High.DT.Med		= set_combine(sets.engaged.High.Med, 	sets.engaged.Hybrid)	
	
	
	    sets.engaged.DTMAX.Med 			= set_combine(sets.engaged.Med, 		sets.engaged.Hybrid2,
		{
			rring="Epona's Ring",
			waist="Reiki Yotai"
		})
		sets.engaged.Low.DTMAX.Med		= set_combine(sets.engaged.DTMAX.Med,
		{
			rring={name="Chirich Ring +1", bag="wardrobe3"}
		})
		sets.engaged.Mid.DTMAX.Med		= sets.engaged.Low.DTMAX.Med
		sets.engaged.High.DTMAX.Med		= sets.engaged.Mid.DTMAX.Med	
	
	
	
		----------------------------------------------------------
		-- Maximum Haste
		----------------------------------------------------------		
	    sets.engaged.DT.Max 			= set_combine(sets.engaged.Max, 		sets.engaged.Hybrid)
		sets.engaged.Low.DT.Max			= set_combine(sets.engaged.Low.Max, 	sets.engaged.Hybrid)
		sets.engaged.Mid.DT.Max			= set_combine(sets.engaged.Mid.Max, 	sets.engaged.Hybrid)
		sets.engaged.High.DT.Max		= set_combine(sets.engaged.High.Max, 	sets.engaged.Hybrid)
	
	
	    sets.engaged.DTMAX.Max 			= set_combine(sets.engaged.Max, 		sets.engaged.Hybrid2,
		{
			rear="Suppanomimi",
			rring="Epona's Ring"
		})
		sets.engaged.Low.DTMAX.Max		= set_combine(sets.engaged.DTMAX.Max,
		{
			lear="Telos Earring"
		})
		sets.engaged.Mid.DTMAX.Max		= set_combine(sets.engaged.Low.DTMAX.Max,
		{
			rring={name="Chirich Ring +1", bag="wardrobe3"}
		})
		sets.engaged.High.DTMAX.Max		= set_combine(sets.engaged.Mid.DTMAX.Max,
		{
			lear={name="Mache Earring +1", bag="wardrobe2"},
			waist="Kentarch Belt +1"
		})	
		
		

end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
----------------------------------
---------------------------------------------------------------------------------

-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)
	if state.EnmityDown.value and spell.type == 'WeaponSkill' then
		equip(sets.EnmityDown)
	end
	
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

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff,gain)
    -- If we gain or lose any haste buffs, adjust which gear set we target.
    if S{'haste','march','embrava','haste samba', 'mighty guard', 'geo-haste','indi-haste','slow','indi-slow','elegy'}:contains(buff:lower()) then
		determine_haste_group()
		handle_equipping_gear(player.status)
    elseif buff == 'Climactic Flourish' then
        handle_equipping_gear(player.status)
	 elseif state.Buff[buff] ~= nil then
        handle_equipping_gear(player.status)
    end
	
	if buff == "sleep" then
		if gain then
			equip({head="Frenzy Sallet"})
		else
			handle_equipping_gear(player.status)
		end
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
        determine_haste_group()
    end
end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
	equip(sets[state.MainWeaponSet.current])
	equip(sets[state.SubWeaponSet.current])
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the default 'update' self-command.
function job_update(cmdParams, eventArgs)
	equip(sets[state.MainWeaponSet.current])
	equip(sets[state.SubWeaponSet.current])

    determine_haste_group()
end

function get_custom_wsmode(spell, spellMap, defaut_wsmode)
	local wsmode

	if state.Buff['Climactic Flourish'] then
		wsmode = 'CF'
	end

	return wsmode
end

function customize_melee_set(meleeSet)
    if state.DefenseMode.value ~= 'None' then
        if state.Buff['Climactic Flourish'] then
            meleeSet = set_combine(meleeSet, sets.buff['Climactic Flourish'])
        end
    end

    return meleeSet
end


-- Function to display the current relevant user state when doing an update.
-- Set eventArgs.handled to true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
    local msg = '[' .. state.MainWeaponSet.value .. '/' .. state.SubWeaponSet.value .. ']'

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

    if state.Kiting.value then
        msg = msg .. ', Kiting'
    end

    msg = msg .. ', ['..state.MainStep.current
	
	msg = msg .. '/'..state.AltStep.current

    msg = msg .. ']'

    add_to_chat(122, msg)

    eventArgs.handled = true
end


-------------------------------------------------------------------------------------------------------------------
-- User self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called for custom player commands.
function job_self_command(cmdParams, eventArgs)
	if cmdParams[1] == 'mstep' then
		 send_command('@input /ja "'..state.MainStep.current..'" <t>')		 
	elseif cmdParams[1] == 'astep' then
		send_command('@input /ja "'..state.AltStep.current..'" <t>')		 
	end
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
function determine_haste_group()
--[[
				buffactive[1]	= Weakness
				buffactive[13]	= Slow
				buffactive[33]	= Haste
				buffactive[189] = Haste Samba
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
			(buffactive[33] and (buffactive[580] or buffactive.embrava)) or buffactive.march == 2
			or (buffactive[189] and (buffactive[33] or buffactive.march == 2 or buffactive[228] or buffactive[580]))) then
			classes.CustomMeleeGroups:append('Max')							-- 43.75% Magical Haste
			--add_to_chat(8, '*********Maximum Haste Set***********')
		elseif buffactive[33] or buffactive.march == 2 or buffactive[580] or buffactive[228] then
			classes.CustomMeleeGroups:append('Med')							-- 30% Magical Haste
			--add_to_chat(8, '*********Medium Haste Set***********')
		elseif buffactive[214] or buffactive[604] or buffactive[189] then
			classes.CustomMeleeGroups:append('Min')							-- 15% Magical Haste
			--add_to_chat(8, '*********Minimum Haste Set***********')
		else
			classes.CustomMeleeGroups:append('')							-- No Magical Haste
			--add_to_chat(8, '*********No Haste Set***********')
		end
	end
end

-- Select default macro book on initial load or subjob change.
function apply_job_change()
    set_macro_page(1, 19)
	
	send_command('wait 3; input /lockstyleset 19')
end
