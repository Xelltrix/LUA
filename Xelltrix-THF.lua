-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--[[
	Custom commands:
	gs c cycle treasuremode (set on ctrl-= by default): Cycles through the available treasure hunter modes.
	Treasure hunter modes:
		None - Will never equip TH gear
		Tag - Will equip TH gear sufficient for initial contact with a mob (either melee, ranged hit, or Aeolian Edge AOE)
		SATA - Will equip TH gear sufficient for initial contact with a mob, and when using SATA
		Fulltime - Will keep TH gear equipped fulltime
--]]

-- Initialization function for this job file.
function get_sets()
	mote_include_version = 2

	-- Load and initialize the include file.
	include('Mote-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
	state.Buff['Sneak Attack'] = buffactive['Sneak Attack'] or false
	state.Buff['Trick Attack'] = buffactive['Trick Attack'] or false
	state.Buff['Feint'] = buffactive['Feint'] or false

	include('Mote-TreasureHunter')
	
	state.EnmityDown = M(false)

	customize_idle_set()

	-- For th_action_check():
	-- JA IDs for actions that always have TH: Provoke, Animated Flourish
	info.default_ja_ids = S{35, 204}
	-- Unblinkable JA IDs for actions that always have TH: Quick/Box/Stutter Step, Desperate/Violent Flourish
	info.default_u_ja_ids = S{201, 202, 203, 205, 207}

	determine_haste_group()
	
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	state.OffenseMode:options('Normal', 'Low', 'Mid', 'High')
	state.WeaponskillMode:options('Normal', 'Low', 'Mid', 'High')	
	state.HybridMode:options('Normal','DT','DTMAX')
	state.IdleMode:options('Normal','DT')
	
	state.MainWeaponSet = M{['description']='Main Weapon Set',
		'Tauret',
		'Twashtar'
	}
	
	state.SubWeaponSet = M{['description']='Sub Weapon Set',
		'subTwashtar',
		'Ternion',
		'Centovente'
	}
	

	-- Additional local binds
	send_command('bind ^= gs c cycle treasuremode')
	
	send_command('bind numpad. gs c toggle EnmityDown')
	
	send_command('bind pageup gs c cycle MainWeaponSet')
	send_command('bind pagedown gs c cycleback MainWeaponSet')
	
	send_command('bind ^pageup gs c cycle SubWeaponSet')
	send_command('bind ^pagedown gs c cycleback SubWeaponSet')

	apply_job_change()
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
	send_command('unbind ^=')
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
	-- Special sets 
	--------------------------------------

		sets.TreasureHunter =
		{
			hands="Plun. Armlets +3",
			waist="Chaac Belt"
		}
		
		sets.TreasureHunter2 =
		{
			head=gear.HHead_TH,
			hands="Plun. Armlets +3"
		}
		
		sets.Enmity = 
		{--		Enmity: +75
			ammo="Sapience Orb",
			head="Rabid Visor", neck="Unmoving Collar +1", lear="Cryptic Earring", rear="Trux Earring",
			body="Plunderer's Vest +3", hands="Nilas Gloves", lring="Eihwaz Ring", rring="Supershear Ring",
			back="Reiki Cloak", waist="Trance Belt", legs="Zoar Subligar +1", feet="Ahosi Leggings"
		}
		
		sets.EnmityDown =
		{--		Enmity: -27
			rear="Novia Earring",
			body="Adhemar Jacket +1",
			lring="Lebeche Ring", rring="Kuchekula Ring"
		}

		sets.Kiting = { feet="Jute Boots +1" }

		sets.buff.Doom = 
		{
			neck="Nicander's Necklace",
			lring={name="Eshmun's Ring", bag="wardrobe2"}, rring={name="Eshmun's Ring", bag="wardrobe3"},
			waist="Gishdubar Sash"
		}
	
		sets.buff['Feint'] = sets.TreasureHunter
		
		
		
	-------------------
	-- Job Abilities --
	------------------- 

		sets.precast.JA['Collaborator'] = set_combine(sets.Enmity,
		{
			head="Skulker's Bonnet +1"
		})
		
		sets.precast.JA['Accomplice'] = sets.precast.JA['Collaborator']
		
		sets.precast.JA['Feint'] =
		{
			legs="Plun. Culottes +3"
		}
		
		sets.precast.JA['Steal'] = 
		{
			head="Plun. Bonnet +3",
			legs="Pill. Culottes +1",feet="Pill. Poulaines +2"
		}
		
		sets.precast.JA['Mug'] =
		{
			ammo="C. Palug Stone",
			head="Plun. Bonnet +3", neck="Asn. Gorget +1", lear="Odr Earring", rear={name="Mache Earring +1", bag="wardrobe3"},
			body="Malignance Tabard", hands="Malignance Gloves", lring="Ilabrat Ring", rring="Regal Ring", 
			back="Sacro Mantle", waist="Chaac Belt", legs="Plun. Culottes +3", feet="Turms Leggings +1"
		}
		
		sets.precast.JA['Hide'] =
		{
			body="Pillager's Vest +3"
		}

		sets.precast.JA['Flee'] =
		{
			feet="Pill. Poulaines +2"
		}
		sets.precast.JA['Steal'] =
		{
			hands="Pill. Armlets +2",
			feet="Pill. Poulaines +2"
		}
		
		sets.precast.JA['Perfect Dodge'] =
		{
			hands="Plun. Armlets +3"
		}

		sets.precast.Waltz =
		{
			ammo="Yamarang",
			body="Passion Jacket",
			legs="Dashing Subligar", feet="Rawhide Boots"
		}

	
	-------------------
	-- Precast Magic --
	------------------- 
	
		sets.precast.FC =
		{
			ammo="Sapience Orb",
			head=gear.HHead_WSD, neck="Orunmila's Torque", lear="Etiolation Earring", rear="Loquac. Earring",
			body=gear.TBody_Phalanx, hands="Leyline Gloves", lring="Rahab Ring", rring="Weather. Ring +1",
			back="Moonlight Cape", waist="Flume Belt +1", legs="Rawhide Trousers", gear.TFeet_Phalanx
		}
		
		sets.precast.Utsusemi = set_combine(sets.precast.FC, 
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
			body="Pillager's Vest +3", hands="Turms Mittens +1", lring="Lebeche Ring", rring="Menelaus's Ring",
			back="Moonlight Cape", waist="Bishop's Sash", legs="Turms Subligar +1", feet="Turms Leggings +1"
		}
		
		sets.midcast['Elemental Magic'] =
		{
			ammo="Pemphredo Tathlum",
			head=gear.HHead_MAB, neck="Sanctity Necklace", lear="Friomisi Earring", rear="Crematio Earring",
			body="Samnuha Coat", hands="Leyline Gloves", lring="Shiva Ring +1", rring="Dingir Ring",
			back=gear.THFCape_STP, waist="Orpheus's Sash", legs="Herculean Trousers", feet="Adhemar Gamashes +1"
		}
		
		sets.midcast.Macc =
		{
			ammo="Yamarang",
			head="Malignance Chapeau", neck="Asn. Gorget +1", lear="Gwati Earring", rear="Digni. Earring",
			body="Malignance Tabard", hands="Malignance Gloves", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back="Sacro Mantle", waist="Engraved Belt", legs="Malignance Tights", feet="Malignance Boots"
		}
		
		sets.midcast['Enfeebling Magic'] = sets.midcast.Macc
		
		sets.midcast['Dark Magic'] = sets.midcast.Macc
		
		-- sets.midcast.Stonega =
		-- {
			-- main=none, sub=none, ammo="Staunch Tathlum +1",
			-- head="Malignance Chapeau", neck="Loricate Torque +1", lear="Eabani Earring", rear="Sanare Earring",
			-- body="Malignance Tabard", hands="Plun. Armelts +1", lring="Defending Ring", rring="Moonlight Ring",
			-- back="Moonlight Cape", waist="Chaac Belt", legs="Malignance Tights", feet="Malignance Boots"
		-- }
		
		-- sets.midcast.Poisonga =
		-- {
			-- main=none, sub=none, ammo="Staunch Tathlum +1",
			-- head=gear.AHead_PDT, neck="Loricate Torque +1", lear="Genmei Earring", rear="Sanare Earring",
			-- body="Ashera Harness", hands="Plun. Armlets +3", lring="Defending Ring", rring="Gelatinous Ring +1",
			-- back="Moonlight Cape", waist="Chaac Belt",  legs="Meg. Chausses +2", feet="Malignance Boots"
		-- }
		
	
	
	
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
	
		sets.Twashtar 		= { 		main="Twashtar"			}
	
		sets.subTwashtar 	= { 		sub="Twashtar" 			}
		
		sets.Tauret 		= { 		main="Tauret" 			}
		
		sets.Ternion 		= { 		sub="Ternion Dagger +1" }
		
		sets.Centovente		= { 		sub="Centovente"		}
		
		
	------------------------------------------------------------------------------------------------
	------------------------------------------ Idle Sets -------------------------------------------
	------------------------------------------------------------------------------------------------

		sets.idle =
		{--	DT: 35%		PDT: 51%	MDT: 35%
			ammo="Staunch Tathlum +1",
			head="Turms Cap +1", neck="Warder's Charm +1", lear="Dawn Earring", rear="Infused Earring",
			body="Malignance Tabard", hands="Turms Mittens +1", lring="Defending Ring", rring="Moonlight Ring",
			back="Moonlight Cape", waist="Engraved Belt", legs="Turms Subligar +1", feet="Jute Boots +1"
		}
		
		sets.idle.DT =
		{--	DT: 35%		PDT: 51%	MDT: 35%
			ammo="Yamarang",
			head="Malignance Chapeau",  neck="Loricate Torque +1", lear="Dawn Earring", rear="Infused Earring",
			body="Malignance Tabard", hands="Malignance Gloves", lring="Defending Ring", rring="Moonlight Ring",
			back="Moonlight Cape", waist="Engraved Belt", legs="Malignance Tights", feet="Jute Boots +1"
		}

		sets.idle.Town = set_combine(sets.idle,
		{
			feet="Jute Boots +1"
		})
		
		sets.idle.Adoulin = set_combine(sets.idle,
		{
			body="Councilor's Garb"
		})

		sets.idle.Weak = sets.idle


		-- Defense sets

		sets.defense.PDT =
		{
			ammo="Yamarang",
			head="Malignance Chapeau", neck="Warder's Charm +1", lear="Eabani Earring", rear="Sanare Earring",
			body="Malignance Tabard", hands="Malignance Gloves", lring="Defending Ring", rring="Moonlight Ring",
			back="Moonlight Cape", waist="Engraved Belt", legs="Malignance Tights", feet="Malignance Boots"
		}

		sets.defense.MDT = sets.defense.PDT

		
	
	
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
			head="Pill. Bonnet +2", neck="Fotia Gorget", lear="Sherida Earring", rear="Moonshade Earring",
			body="Adhemar Jacket +1", hands="Meg. Gloves +2", lring="Epaminondas's Ring", rring="Regal Ring", 
			back="Sacro Mantle", waist="Fotia Belt", legs="Plun. Culottes +3", feet="Plun. Poulaines +3"
		} 

		sets.precast.WS.Low = set_combine(sets.precast.WS,
		{
			head="Plun. Bonnet +3"
		})
		
		sets.precast.WS.Mid = set_combine(sets.precast.WS.Low,
		{
			lear={name="Mache Earring +1", bag="wardrobe2"}
		})
		
		sets.precast.WS.High = set_combine(sets.precast.WS.Mid,
		{
			rear={name="Mache Earring +1", bag="wardrobe3"},	
			body="Malignance Tabard",
		})

		sets.precast.WS.SA = set_combine(sets.precast.WS,
		{
			ammo="Yetshila +1",
			head="Pill. Bonnet +2", neck="Asn. Gorget +1", lear="Odr Earring", rear={name="Mache Earring +1", bag="wardrobe3"},
			body="Plunderer's Vest +3", rring="Ilabrat Ring",
			waist="Grunfeld Rope"
		})

		sets.precast.WS.TA = set_combine(sets.precast.WS.SA,
		{
			neck="Fotia Gorget", lear="Ishvara Earring", rear="Moonshade Earring",
			body="Plunderer's Vest +3", hands="Pill. Armlets +2", rring="Ilabrat Ring",
			waist="Fotia Belt", feet="Malignance Boots"
		})


	---Exenterator
		sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS,
		{
			ammo="C. Palug Stone",
			head="Plun. Bonnet +3", rear="Brutal Earring",
			body="Plunderer's Vest +3", hands="Floral Gauntlets", lring="Ilabrat Ring", rring="Regal Ring",
			legs="Meg. Chausses +2", feet="Plun. Poulaines +3"
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

		
		sets.precast.WS['Exenterator'].SA = set_combine(sets.precast.WS['Exenterator'],
		{
			ammo="Yetshila +1",
			head="Pill. Bonnet +2", lear={name="Mache Earring +1", bag="wardrobe2"}, rear={name="Mache Earring +1", bag="wardrobe3"},
			hands="Malignance Gloves",
			leg="Pill. Culottes +3", feet=gear.HBoots_Crit
		})

		sets.precast.WS['Exenterator'].TA = set_combine(sets.precast.WS['Exenterator'].SA,
		{
			hands="Pill. Armlets +2",
			feet="Malignance Boots"
		})

	---Evisceration
		sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS,
		{
			ammo="Yetshila +1",
			head=gear.AHead_TP, lear="Odr Earring", rear={name="Mache Earring +1", bag="wardrobe3"},
			body="Plunderer's Vest +3", hands="Adhemar Wrist. +1", lring="Ilabrat Ring", rring="Regal Ring",
			back="Sacro Mantle", legs="Pill. Culottes +3", feet=gear.HBoots_Crit
		})

		sets.precast.WS['Evisceration'].Low = set_combine(sets.precast.WS['Evisceration'],
		{
			head="Blistering Sallet +1"
		})
		
		sets.precast.WS['Evisceration'].Mid = sets.precast.WS['Evisceration'].Low
		
		sets.precast.WS['Evisceration'].High = set_combine(sets.precast.WS['Evisceration'].Mid,
		{
			legs="Malignance Tights", feet="Malignance Boots"
		})

		sets.precast.WS['Evisceration'].SA = set_combine(sets.precast.WS['Evisceration'],
		{
			head=gear.AHead_TP,
			rring="Regal Ring",
			leg="Pill. Culottes +3", feet=gear.HBoots_Crit
		})

		sets.precast.WS['Evisceration'].TA = set_combine(sets.precast.WS['Evisceration'].SA,
		{
			hands="Pill. Armlets +2",
			back="Sacro Mantle", legs="Pill. Culottes +3", feet=gear.HBoots_Crit
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
			rear={name="Mache Earring +1", bag="wardrobe3"},
		})
		
		sets.precast.WS['Dancing Edge'].High = set_combine(sets.precast.WS['Dancing Edge'].Mid,
		{
			lear="Odr Earring",			
			body="Malignance Tabard",
			legs="Malignance Tights"
		})

		sets.precast.WS['Dancing Edge'].SA = set_combine(sets.precast.WS['Dancing Edge'],
		{
			ammo="Yetshila +1",
			head=gear.AHead_TP, lear="Odr Earring", rear={name="Mache Earring +1", bag="wardrobe3"},
			body="Plunderer's Vest +3", hands="Adhemar Wrist. +1", rring="Regal Ring",
			leg="Pill. Culottes +3", feet=gear.HBoots_Crit
		})

		sets.precast.WS['Dancing Edge'].TA = set_combine(sets.precast.WS['Dancing Edge'].SA,
		{
			body="Plunderer's Vest +3",
			leg="Pill. Culottes +3", feet=gear.HBoots_Crit
		})

	---Rudra's Storm
		sets.precast.WS['Rudra\'s Storm'] =
		{
			ammo="Aurgelmir Orb +1",
			head="Pill. Bonnet +2", neck="Asn. Gorget +1", lear="Odr Earring", rear={name="Mache Earring +1", bag="wardrobe3"},
			body="Herculean Vest", hands="Meg. Gloves +2", lring="Epaminondas's Ring", rring="Regal Ring",
			back="Sacro Mantle", waist="Grunfeld Rope", legs="Plun. Culottes +3", feet="Plun. Poulaines +3"
		}

		sets.precast.WS['Rudra\'s Storm'].Low = sets.precast.WS["Rudra's Storm"]
		
		sets.precast.WS['Rudra\'s Storm'].Mid = sets.precast.WS["Rudra's Storm"]
		
		sets.precast.WS['Rudra\'s Storm'].High = sets.precast.WS["Rudra's Storm"]

		sets.precast.WS['Rudra\'s Storm'].SA = set_combine(sets.precast.WS["Rudra's Storm"],
		{
			ammo="Yetshila +1",
			feet=gear.HBoots_Crit
		})

		sets.precast.WS['Rudra\'s Storm'].TA = sets.precast.WS["Rudra's Storm"].SA

	---Mandalic Stab
		sets.precast.WS['Mandalic Stab'] = sets.precast.WS["Rudra's Storm"]

		sets.precast.WS['Mandalic Stab'].Low = sets.precast.WS['Mandalic Stab']
		
		sets.precast.WS['Mandalic Stab'].Mid = sets.precast.WS['Mandalic Stab']
		
		sets.precast.WS['Mandalic Stab'].High = sets.precast.WS['Mandalic Stab']

		sets.precast.WS['Mandalic Stab'].SA = sets.precast.WS["Rudra's Storm"].SA

		sets.precast.WS['Mandalic Stab'].TA = sets.precast.WS["Rudra's Storm"].TA
	
	---Aeolian Edge
		sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS,
		{
			ammo="Pemphredo Tathlum",
			head=gear.HHead_MAB, neck="Sanctity Necklace", lear="Friomisi Earring",
			body="Samnuha Coat", lring="Epaminondas's Ring", rring="Dingir Ring",
			back="Sacro Mantle", waist="Orpheus's Sash", legs="Herculean Trousers", feet="Adhemar Gamashes +1"
		})

		sets.precast.WS['Aeolian Edge'].TH = set_combine(sets.precast.WS['Aeolian Edge'], sets.TreasureHunter)

		sets.precast.WS['Cyclone'] = sets.precast.WS['Aeolian Edge']

		sets.precast.WS['Gust Slash'] = sets.precast.WS['Aeolian Edge']




	--------------------------------------
	-- Melee sets
	--------------------------------------

	
		----------------------------------------------------------
		--					(DW4 + No Haste)
		----------------------------------------------------------

		--30 DW = 44 DW needed
		
		----------------------------------------------------------
	
		sets.engaged =
		{
			ammo="Aurgelmir Orb +1",
			head="Plun. Bonnet +3", neck="Asn. Gorget +1", lear="Eabani Earring", rear="Suppanomimi",
			body="Adhemar Jacket +1", hands="Floral Gauntlets", lring="Hetairoi Ring", rring="Gere Ring",
			back=gear.THFCape_DW, waist="Reiki Yotai", legs="Samnuha Tights", feet=gear.TFeet_TP
		}

		sets.engaged.Low = set_combine(sets.engaged,
		{
			ammo="Yamarang",
			legs="Pill. Culottes +3"
		})

		sets.engaged.Mid = set_combine(sets.engaged.Low,
		{
			hands="Pill. Armlets +2", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring="Regal Ring"
		})

		sets.engaged.High = set_combine(sets.engaged.Mid,
		{
			ammo="C. Palug Stone",
			lear="Odr Earring", rear={name="Mache Earring +1", bag="wardrobe3"},
			body="Pillager's Vest +3", hands="Malignance Gloves",
			feet="Malignance Boots"
		})
	
	
	
		----------------------------------------------------------
		--					(DW4 + 15% Haste)
		----------------------------------------------------------

		--30 DW = 37 DW needed
		
		----------------------------------------------------------
	
		sets.engaged.Min =
		{
			ammo="Aurgelmir Orb +1",
			head="Plun. Bonnet +3", neck="Asn. Gorget +1", lear="Eabani Earring", rear="Suppanomimi",
			body="Adhemar Jacket +1", hands="Floral Gauntlets", lring="Hetairoi Ring", rring="Gere Ring",
			back=gear.THFCape_DW, waist="Reiki Yotai", legs="Samnuha Tights", feet="Plun. Poulaines +3"
		}

		sets.engaged.Low.Min = set_combine(sets.engaged.Min,
		{
			ammo="Yamarang",
			legs="Pill. Culottes +3"
		})

		sets.engaged.Mid.Min = set_combine(sets.engaged.Low.Min,
		{
			hands="Pill. Armlets +2", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring="Regal Ring",
		})

		sets.engaged.High.Min = set_combine(sets.engaged.Mid.Min,
		{
			ammo="C. Palug Stone",
			lear="Odr Earring", rear={name="Mache Earring +1", bag="wardrobe3"},
			body="Pillager's Vest +3", hands="Malignance Gloves",
			feet="Malignance Boots"
		})

	
		----------------------------------------------------------
		--					(DW4 + 30% Haste)
		----------------------------------------------------------

		--30 DW = 26 DW needed
		
		----------------------------------------------------------
	
		sets.engaged.Med =
		{
			ammo="Aurgelmir Orb +1",
			head="Plun. Bonnet +3", neck="Asn. Gorget +1", lear="Eabani Earring", rear="Suppanomimi",
			body="Pillager's Vest +3", hands="Adhemar Wrist. +1", lring="Epona's Ring", rring="Gere Ring",
			back=gear.THFCape_DW, waist="Reiki Yotai", legs="Samnuha Tights", feet="Plun. Poulaines +3"
		}

		sets.engaged.Low.Med = set_combine(sets.engaged.Med,
		{
			ammo="Yamarang",
			legs="Pill. Culottes +3",
		})

		sets.engaged.Mid.Med = set_combine(sets.engaged.Low.Med,
		{
			hands="Pill. Armlets +2", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring="Regal Ring",
		})

		sets.engaged.High.Med = set_combine(sets.engaged.Mid.Med,
		{
			ammo="C. Palug Stone",
			lear="Odr Earring",
			feet="Malignance Boots"
		})

	
	
		----------------------------------------------------------
		--					(DW4 + Max Haste)
		----------------------------------------------------------

		--30 DW = 6 DW needed
		
		----------------------------------------------------------
	
		sets.engaged.Max =
		{-- QA+2% TA+32% DA+9%
			ammo="Aurgelmir Orb +1",
			head="Plun. Bonnet +3", neck="Asn. Gorget +1", lear="Sherida Earring", rear="Telos Earring",
			body="Adhemar Jacket +1", hands="Adhemar Wrist. +1", lring="Hetairoi Ring", rring="Gere Ring",
			back=gear.THFCape_STP, waist="Windbuffet Belt +1", legs="Samnuha Tights", feet="Plun. Poulaines +3"
		}

		sets.engaged.Low.Max = set_combine(sets.engaged.Max,
		{
			ammo="Yamarang",
			body="Pillager's Vest +3",
			waist="Reiki Yotai", legs="Pill. Culottes +3"
		})

		sets.engaged.Mid.Max = set_combine(sets.engaged.Low.Max,
		{
			lear="Odr Earring", 
			hands="Malignance Gloves", lring={name="Chirich Ring +1", bag="wardrobe2"},
			feet="Malignance Boots"
		})

		sets.engaged.High.Max = set_combine(sets.engaged.Mid.Max,
		{
			ammo="C. Palug Stone",
			rear={name="Mache Earring +1", bag="wardrobe3"},
			hands="Malignance Gloves", rring="Regal Ring",
		})

	
	--------------------------------------
	-- Hybrid Sets
	--------------------------------------
		sets.engaged.Hybrid = 
		{--	DT: 23%		PDT: 27%	MDT: 23%
			head="Malignance Chapeau",
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
			waist="Reiki Yotai"
		})
		sets.engaged.Low.DTMAX.Max		= set_combine(sets.engaged.DTMAX.Max,
		{
			rear="Telos Earring"
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
-------------------------------------------------------------------------------------------------------------------

-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)
	if state.EnmityDown.value and spell.type == 'WeaponSkill' then
		equip(sets.EnmityDown)
	end
	
	if (spell.english == 'Cyclone' or (spell.action_type == 'Ability' and spell.target.type == 'MONSTER')) and state.TreasureMode.value ~= 'None' then
		equip(sets.TreasureHunter2)
	elseif spell.english=='Sneak Attack' or spell.english=='Trick Attack' or spell.type == 'WeaponSkill' then
		if state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime' then
			equip(sets.TreasureHunter)
		end
	end
end

-- Run after the general midcast() set is constructed.
function job_post_midcast(spell, action, spellMap, eventArgs)
	if spellMap == 'Cures' and spell.target.type == 'SELF' then
        	equip { waist="Gishdubar Sash" }
	end
	
	if spellMap == 'Refresh' and spell.target.type == 'SELF' then
		equip
		{
			waist="Gishdubar Sash"
		}
	end
	
	if state.TreasureMode.value ~= 'None' and spell.action_type == 'Ranged Attack' then
		equip(sets.TreasureHunter)
	elseif spell.action_type == 'Magic' and spell.target.type == 'MONSTER' and state.TreasureMode.value ~= 'None' then
		equip(sets.TreasureHunter2)
	end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
	-- Weaponskills wipe SATA/Feint.  Turn those state vars off before default gearing is attempted.
	if spell.type == 'WeaponSkill' and not spell.interrupted then
		state.Buff['Sneak Attack'] = false
		state.Buff['Trick Attack'] = false
		state.Buff['Feint'] = false
	end
end

-- Called after the default aftercast handling is complete.
function job_post_aftercast(spell, action, spellMap, eventArgs)
	-- If Feint is active, put that gear set on on top of regular gear.
	-- This includes overlaying SATA gear.
	check_buff('Feint', eventArgs)
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff,gain)
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
			disable('head')
		else
			enable('head')
			handle_equipping_gear(player.status)
		end
	end
	

	-- If we gain or lose any haste buffs, adjust which gear set we target.
	if S{'haste','march','embrava','haste samba', 'mighty guard'}:contains(buff:lower()) then
		determine_haste_group()
		handle_equipping_gear(player.status)
	elseif state.Buff['Sneak Attack'] == false or state.Buff['Trick Attack'] == false then
		handle_equipping_gear(player.status)
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

function get_custom_wsmode(spell, spellMap, defaut_wsmode)
	local wsmode

	if state.Buff['Sneak Attack'] then
		wsmode = 'SA'
	end
	if state.Buff['Trick Attack'] then
		wsmode = (wsmode or '') .. 'TA'
	end

	return wsmode
end


-- Called any time we attempt to handle automatic gear equips (ie: engaged or idle gear).
function job_handle_equipping_gear(playerStatus, eventArgs)
	-- Check for SATA when equipping gear.  If either is active, equip
	-- that gear specifically, and block equipping default gear.
	check_buff('Sneak Attack', eventArgs)
	check_buff('Trick Attack', eventArgs)
end


function customize_idle_set(idleSet)
	if player.hpp < 80 then
		if state.IdleMode.value == 'Normal' and state.DefenseMode.value == 'None' then
			idleSet = set_combine(idleSet, 
			{
				neck="Sanctity Necklace",
				lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"}
			})
		end
	elseif player.mpp < 60 and (player.sub_job == "BLM" or player.sub_job == "WHM" or player.sub_job == "RDM") then
		if state.IdleMode.value == 'Normal' and state.DefenseMode.value == 'None' then
			idleSet = set_combine(idleSet, 
			{
				head="Rawhide Mask",
				hands=gear.HHands_Refresh, lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
				legs="Rawhide Trousers"
			})
		end
	end

	return idleSet
end


function customize_melee_set(meleeSet)
	if state.TreasureMode.value == 'Fulltime' then
		meleeSet = set_combine(meleeSet, sets.TreasureHunter)
	end

	return meleeSet
end


-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
	equip(sets[state.MainWeaponSet.current])
	equip(sets[state.SubWeaponSet.current])

	determine_haste_group()

	th_update(cmdParams, eventArgs)
end

-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
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

	if state.Kiting.value == true then
		msg = msg .. ', Kiting'
	end

	msg = msg .. ', TH: ' .. state.TreasureMode.value

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
			classes.CustomMeleeGroups:append('Max')							-- 43.75% Magical Haste
			--add_to_chat(8, '*********Maximum Haste Set***********')
		elseif buffactive[33] or buffactive.march == 2 or buffactive[580] or buffactive[228] then
			classes.CustomMeleeGroups:append('Med')							-- 30% Magical Haste
			--add_to_chat(8, '*********Medium Haste Set***********')
		elseif buffactive[214] or buffactive[604] then
			classes.CustomMeleeGroups:append('Min')							-- 15% Magical Haste
			--add_to_chat(8, '*********Minimum Haste Set***********')
		else
			classes.CustomMeleeGroups:append('')							-- No Magical Haste
			--add_to_chat(8, '*********No Haste Set***********')
		end
	end
end


-- State buff checks that will equip buff gear and mark the event as handled.
function check_buff(buff_name, eventArgs)
	if state.Buff[buff_name] then
		equip(sets.buff[buff_name] or {})
		if state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime' then
			equip(sets.TreasureHunter)
		end
		eventArgs.handled = true
	end
end


-- Check for various actions that we've specified in user code as being used with TH gear.
-- This will only ever be called if TreasureMode is not 'None'.
-- Category and Param are as specified in the action event packet.
function th_action_check(category, param)
	if category == 2 or -- any ranged attack
		--category == 4 or -- any magic action
		(category == 3 and param == 30) or -- Aeolian Edge
		(category == 6 and info.default_ja_ids:contains(param)) or -- Provoke, Animated Flourish
		(category == 14 and info.default_u_ja_ids:contains(param)) -- Quick/Box/Stutter Step, Desperate/Violent Flourish
		then return true
	end
end


-- Select default macro book on initial load or subjob change.
function apply_job_change()
	if player.sub_job == 'WAR' or player.sub_job == 'NIN' then
		set_macro_page(1, 6)
	elseif player.sub_job == 'DNC' then
		set_macro_page(4, 6)
	elseif player.sub_job == 'RDM' or player.sub_job == 'WHM' or player.sub_job == 'BLM' then
		set_macro_page(7, 6)
	end
	
	send_command('wait 3; input /lockstyleset 6')
end