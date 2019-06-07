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

	-- For th_action_check():
	-- JA IDs for actions that always have TH: Provoke, Animated Flourish
	info.default_ja_ids = S{35, 204}
	-- Unblinkable JA IDs for actions that always have TH: Quick/Box/Stutter Step, Desperate/Violent Flourish
	info.default_u_ja_ids = S{201, 202, 203, 205, 207}

	determine_haste_group()

	lockstyleset = 8
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	state.OffenseMode:options('Normal', 'Low', 'Mid', 'High')
	state.WeaponskillMode:options('Normal', 'Low', 'Mid', 'High')	
	state.HybridMode:options('Normal','DT','DTMAX')
	state.IdleMode:options('Normal', 'DT')

	-- Additional local binds
	send_command('bind ^= gs c cycle treasuremode')

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

	-------------------
	-- Job Abilities --
	------------------- 

	sets.precast.JA['Collaborator'] =
	{
		head="Skulker's Bonnet +1"
	}
	sets.precast.JA['Accomplice'] =
	{
		head="Skulker's Bonnet +1"
	}

	sets.precast.JA['Flee'] =
	{
		feet="Pill. Poulaines +1"
	}
	sets.precast.JA['Steal'] =
	{
		head=gear.AHead_TP, neck="Pentalagus Charm", lear="Dawn Earring", rear="Infused Earring",
		body="Adhemar Jacket +1", hands="Pill. Armlets +1", lring="Ilabrat Ring", rring="Regal Ring",
		waist="Chaac Belt", feet="Pill. Poulaines +1"
	}

	sets.precast.JA['Despoil'] =
	{
		feet="Skulk. Poulaines +1"
	}

	sets.precast.JA['Perfect Dodge'] =
	{
		hands="Plun. Armlets +1"
	}

	sets.precast.Waltz =
	{
		ammo="Yamarang",
		body="Passion Jacket",
		feet="Rawhide Boots"
	}

	
	-------------------
	-- Precast Magic --
	------------------- 
	
	sets.precast.FC =
	{
		ammo="Sapience Orb",
		head=gear.HHead_WSD, neck="Orunmila's Torque", lear="Etiolation Earring", rear="Loquac. Earring",
		body=gear.TBody_Phalanx, hands="Leyline Gloves", lring="Prolix Ring", rring="Rahab Ring",
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
			head=gear.THead_Phalanx, neck="Incanter's Torque", lear="Andoaa Earring", rear="Augment. Earring",
			body=gear.TBody_Phalanx, hands=gear.THands_Phalanx, lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back="Fi Follet Cape +1", waist="Olympus Sash", legs=gear.TLegs_Phalanx, feet=gear.TFeet_Phalanx
		}
		
		sets.midcast['Elemental Magic'] =
		{
			ammo="Pemphredo Tathlum",
			head=gear.HHead_MAB, neck="Sanctity Necklace", lear="Friomisi Earring", rear="Crematio Earring",
			body="Samnuha Coat", hands="Leyline Gloves", lring="Dingir Ring", rring={name="Shiva Ring +1", bag="wardrobe3"},
			back=gear.THFCape_STP, waist="Eschan Stone", legs="Herculean Trousers", feet=gear.HBoots_WSD
		}
		
	
	
	
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
		{--	DT: 35%		PDT: 51%	MDT: 35%
			ammo="Staunch Tathlum +1",
			head=gear.AHead_PDT, neck="Loricate Torque +1", lear="Dawn Earring", rear="Infused Earring",
			body="Meg. Cuirie +2", hands="Meg. Gloves +2", lring="Defending Ring", rring="Moonbeam Ring",
			back="Moonlight Cape", waist="Carrier's Sash", legs="Mummu Kecks +2", feet="Jute Boots +1"
		}

		sets.idle.DT = set_combine (sets.idle,
		{--	DT: 35%		PDT: 51%	MDT: 35%
			head=gear.AHead_PDT, neck="Loricate Torque +1",
			lring="Defending Ring", rring="Moonbeam Ring",
			waist="Carrier's Sash", legs="Mummu Kecks +2",
		})

		sets.idle.Town = set_combine(sets.idle,
		{
			feet="Jute Boots +1"
		})
		
		sets.idle.Adoulin = set_combine(sets.idle,
		{
			body="Councilor's Garb"
		})

		sets.idle.Weak = sets.idle.PDT


		-- Defense sets

		sets.defense.PDT = sets.idle.DT

		sets.defense.MDT = set_combine(sets.idle.DT,
		{--	DT: 29%		PDT: 45%	MDT: 29%
			neck="Warder's Charm",
			hands="Leyline Gloves"
		})
	
	
	--------------------------------------
	-- Special sets (required by rules)
	--------------------------------------

		sets.TreasureHunter =
		{
			hands="Plun. Armlets +1",
			feet="Skulk. Poulaines +1"
		}

		sets.Kiting = { feet="Jute Boots +1" }

		sets.buff['Sneak Attack'] =
		{
			ammo="Yetshila",
			head=gear.AHead_TP, neck="Caro Necklace", lear="Sherida Earring", rear="Suppanomimi",
			body="Adhemar Jacket +1", hands="Meg. Gloves +2", lring="Ilabrat Ring", rring="Regal Ring",
			back=gear.THFCape_STP, waist="Chaac Belt", legs="Samnuha Tights", feet="Meg. Jam. +2"
		}

		sets.buff['Trick Attack'] =
		{
			ammo="Yetshila",
			head=gear.AHead_TP, neck="Pentalagus Charm", lear="Dawn Earring", rear="Suppanomimi",
			body="Adhemar Jacket +1", hands="Meg. Gloves +2", lring="Ilabrat Ring", rring="Regal Ring",
			back=gear.THFCape_STP, waist="Chaac Belt", legs="Meg. Chausses +2", feet="Meg. Jam. +2"
		}
		
		sets.buff.Doom = 
		{
			neck="Nicander's Necklace",
			lring={name="Eshmun's Ring", bag="wardrobe2"}, rring={name="Eshmun's Ring", bag="wardrobe3"},
			waist="Gishdubar Sash"
		}
	
		sets.buff['Feint'] = sets.TreasureHunter

		-- Actions we want to use to tag TH.
		sets.precast.Step = sets.TreasureHunter
		sets.precast.Flourish1 = sets.TreasureHunter
		sets.precast.JA.Provoke = sets.TreasureHunter	
		
	
	
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
			ammo="Seeth. Bomblet +1",
			head="Lilitu Headpiece", neck="Fotia Gorget", lear="Sherida Earring", rear="Moonshade Earring",
			body="Adhemar Jacket +1", hands="Meg. Gloves +2", lring="Ilabrat Ring", rring="Epona's Ring",
			back=gear.THFCape_STP, waist="Fotia Belt", legs="Samnuha Tights", feet=gear.HBoots_TP
		} 

		sets.precast.WS.Low = set_combine(sets.precast.WS,
		{
			head="Dampening Tam"
		})
		
		sets.precast.WS.Mid = set_combine(sets.precast.WS.Low,
		{
			lear={name="Mache Earring +1", bag="wardrobe2"}
		})
		
		sets.precast.WS.High = set_combine(sets.precast.WS.Mid,
		{
			rear={name="Mache Earring +1", bag="wardrobe3"},			
			body="Meg. Cuirie +2", rring="Regal Ring",
			legs="Meg. Chausses +2"
		})

		sets.precast.WS.SA = set_combine(sets.precast.WS,
		{
			ammo="Yetshila",
			head=gear.AHead_TP, lear={name="Mache Earring +1", bag="wardrobe2"}, rear={name="Mache Earring +1", bag="wardrobe3"},
			body="Abnoba Kaftan", rring="Regal Ring",
			feet=gear.HBoots_Crit
		})

		sets.precast.WS.TA = sets.precast.WS.SA


	---Exenterator
		sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS,
		{
			head=gear.AHead_TP, rear={name="Mache Earring +1", bag="wardrobe3"},
			hands="Floral Gauntlets",
			legs="Meg. Chausses +2"
		})

		sets.precast.WS['Exenterator'].Low = set_combine(sets.precast.WS['Exenterator'],
		{
			head="Dampening Tam",
		})
		
		sets.precast.WS['Exenterator'].Mid = sets.precast.WS['Exenterator'].Low

		sets.precast.WS['Exenterator'].High = set_combine(sets.precast.WS['Exenterator'].Mid,
		{
			lear={name="Mache Earring +1", bag="wardrobe2"},
			body="Meg. Cuirie +2", rring="Regal Ring",
			legs="Meg. Chausses +2"
		})

		
		sets.precast.WS['Exenterator'].SA = set_combine(sets.precast.WS['Exenterator'],
		{
			ammo="Yetshila",
			head=gear.AHead_TP, lear={name="Mache Earring +1", bag="wardrobe2"}, rear={name="Mache Earring +1", bag="wardrobe3"},
			bbody="Abnoba Kaftan", rring="Regal Ring",
			feet=gear.HBoots_Crit
		})

		sets.precast.WS['Exenterator'].TA = sets.precast.WS['Exenterator'].SA

	---Evisceration
		sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS,
		{
			ammo="Yetshila",
			head=gear.AHead_TP, rear={name="Mache Earring +1", bag="wardrobe3"},
			body="Abnoba Kaftan", hands="Mummu Wrists +2", lring="Begrudging Ring",
			back=gear.THFCape_Crit, feet=gear.HBoots_Crit
		})

		sets.precast.WS['Evisceration'].Low = set_combine(sets.precast.WS['Evisceration'],
		{
			head="Dampening Tam"
		})
		
		sets.precast.WS['Evisceration'].Mid = sets.precast.WS['Evisceration'].Low
		
		sets.precast.WS['Evisceration'].High = set_combine(sets.precast.WS['Evisceration'].Mid,
		{
			lear={name="Mache Earring +1", bag="wardrobe2"},
			body="Meg. Cuirie +2", rring="Regal Ring",
			legs="Meg. Chausses +2"
		})

		sets.precast.WS['Evisceration'].SA = set_combine(sets.precast.WS['Evisceration'],
		{
			ammo="Yetshila",
			head=gear.AHead_TP, lear={name="Mache Earring +1", bag="wardrobe2"}, rear={name="Mache Earring +1", bag="wardrobe3"},
			body="Abnoba Kaftan", rring="Regal Ring",
			feet=gear.HBoots_Crit
		})

		sets.precast.WS['Evisceration'].TA = sets.precast.WS['Evisceration'].SA
		
	---Dancing Edge
		sets.precast.WS['Dancing Edge'] = set_combine(sets.precast.WS,
		{
			ammo="Falcon Eye",
			head=gear.AHead_TP,
			hands="Adhemar Wrist. +1", lring="Regal Ring",
		})

		sets.precast.WS['Dancing Edge'].Low = set_combine(sets.precast.WS['Dancing Edge'],
		{
			head="Dampening Tam"
		})
		
		sets.precast.WS['Dancing Edge'].Mid = set_combine(sets.precast.WS['Dancing Edge'].Low,
		{
			rear="Mache Earring +1"
		})
		
		sets.precast.WS['Dancing Edge'].High = set_combine(sets.precast.WS['Dancing Edge'].Mid,
		{
			lear={name="Mache Earring +1", bag="wardrobe2"},			
			body="Meg. Cuirie +2", rring="Regal Ring",
			legs="Meg. Chausses +2"
		})

		sets.precast.WS['Dancing Edge'].SA = set_combine(sets.precast.WS['Dancing Edge'],
		{
			ammo="Yetshila",
			head=gear.AHead_TP,
			body="Abnoba Kaftan", rring="Regal Ring",
			feet=gear.HBoots_Crit
		})

		sets.precast.WS['Dancing Edge'].TA = sets.precast.WS['Dancing Edge'].SA

	---Rudra's Storm
		sets.precast.WS['Rudra\'s Storm'] = set_combine(sets.precast.WS,
		{
			neck="Caro Necklace", lear={name="Mache Earring +1", bag="wardrobe2"},
			body="Herculean Vest", rring="Karieyh Ring +1",
			legs="Herculean Trousers", waist="Grunfeld Rope", feet=gear.HBoots_WSD
		})

		sets.precast.WS['Rudra\'s Storm'].Low = sets.precast.WS["Rudra's Storm"]
		
		sets.precast.WS['Rudra\'s Storm'].Mid = sets.precast.WS["Rudra's Storm"]
		
		sets.precast.WS['Rudra\'s Storm'].High = sets.precast.WS["Rudra's Storm"]

		sets.precast.WS['Rudra\'s Storm'].SA = set_combine(sets.precast.WS["Rudra's Storm"],
		{
			ammo="Yetshila",
			head=gear.AHead_TP, lear={name="Mache Earring +1", bag="wardrobe2"}, rear="Mache Earring +1"
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
			head=gear.HHead_MAB, lear="Friomisi Earring",
			body="Samnuha Coat", hands="Leyline Gloves", lring="Dingir Ring", rring="Karieyh Ring +1",
			back="Toutatis's Cape", waist="Orpheus's Sash", legs="Herculean Trousers", feet=gear.HBoots_WSD
		})

		sets.precast.WS['Aeolian Edge'].TH = set_combine(sets.precast.WS['Aeolian Edge'], sets.TreasureHunter)

		sets.precast.WS['Cyclone'] = sets.precast.WS['Aeolian Edge']

		sets.precast.WS['Gust Slash'] = sets.precast.WS['Aeolian Edge']




	--------------------------------------
	-- Melee sets
	--------------------------------------

	
	----------------------------------------------------------
	--					(DW3 + No Haste)
	----------------------------------------------------------

	--25 DW = 49 DW needed		
	
	----------------------------------------------------------	
	
		sets.engaged =
		{
			ammo="Yamarang",
			head=gear.AHead_TP, neck="Anu Torque", lear="Eabani Earring", rear="Suppanomimi",
			body="Adhemar Jacket +1", hands="Floral Gauntlets", lring="Hetairoi Ring", rring="Epona's Ring",
			back=gear.THFCape_STP, waist="Reiki Yotai", legs="Samnuha Tights", feet=gear.TFeet_TP
		}

		sets.engaged.Low = set_combine(sets.engaged,
		{
			head="Dampening Tam", neck="Combatant's Torque",
			lring={name="Chirich Ring +1", bag="wardrobe2"}
		})

		sets.engaged.Mid = set_combine(sets.engaged.Low,
		{
			rring={name="Chirich Ring +1", bag="wardrobe3"},
			legs="Meg. Chausses +2"
		})

		sets.engaged.High = set_combine(sets.engaged.Mid,
		{
			lear={name="Mache Earring +1", bag="wardrobe2"}, rear={name="Mache Earring +1", bag="wardrobe3"},
			waist="Kentarch Belt +1", feet="Meg. Jam. +2"
		})
	
	
	
	----------------------------------------------------------
	--					(DW3 + 15% Haste)
	----------------------------------------------------------

	--25 DW = 42 DW needed		
	
	----------------------------------------------------------	
	
		sets.engaged.Min =
		{
			ammo="Yamarang",
			head=gear.AHead_TP, neck="Anu Torque", lear="Eabani Earring", rear="Suppanomimi",
			body="Adhemar Jacket +1", hands="Floral Gauntlets", lring="Hetairoi Ring", rring="Epona's Ring",
			back=gear.THFCape_STP, waist="Reiki Yotai", legs="Samnuha Tights", feet=gear.TFeet_TP
		}

		sets.engaged.Low.Min = set_combine(sets.engaged.Min,
		{
			head="Dampening Tam", neck="Combatant's Torque",
			lring={name="Chirich Ring +1", bag="wardrobe2"}
		})

		sets.engaged.Mid.Min = set_combine(sets.engaged.Low.Min,
		{
			rring={name="Chirich Ring +1", bag="wardrobe3"},
			legs="Meg. Chausses +2"
		})

		sets.engaged.High.Min = set_combine(sets.engaged.Mid.Min,
		{
			lear={name="Mache Earring +1", bag="wardrobe2"}, rear={name="Mache Earring +1", bag="wardrobe3"},
			waist="Kentarch Belt +1", feet="Meg. Jam. +2"
		})

	
	----------------------------------------------------------
	--					(DW3 + 30% Haste)
	----------------------------------------------------------

	--25 DW = 31 DW needed		
	
	----------------------------------------------------------	
	
		sets.engaged.Med =
		{
			ammo="Yamarang",
			head=gear.AHead_TP, neck="Anu Torque", lear="Eabani Earring", rear="Suppanomimi",
			body="Adhemar Jacket +1", hands="Floral Gauntlets", lring="Hetairoi Ring", rring="Epona's Ring",
			back=gear.THFCape_STP, waist="Reiki Yotai", legs="Samnuha Tights", feet=gear.TFeet_TP
		}

		sets.engaged.Low.Med = set_combine(sets.engaged.Med,
		{
			head="Dampening Tam", neck="Combatant's Torque",
			lring={name="Chirich Ring +1", bag="wardrobe2"}
		})

		sets.engaged.Mid.Med = set_combine(sets.engaged.Low.Med,
		{
			rring={name="Chirich Ring +1", bag="wardrobe3"},
			legs="Meg. Chausses +2"
		})

		sets.engaged.High.Med = set_combine(sets.engaged.Mid.Med,
		{
			lear={name="Mache Earring +1", bag="wardrobe2"}, rear={name="Mache Earring +1", bag="wardrobe3"},
			waist="Kentarch Belt +1", feet="Meg. Jam. +2"
		})

	
	
	----------------------------------------------------------
	--					(DW3 + Max Haste)
	----------------------------------------------------------

	--25 DW = 11 DW needed
	
	----------------------------------------------------------
	
		sets.engaged.Max =
		{
			ammo="Yamarang",
			head=gear.AHead_TP, neck="Anu Torque", lear="Sherida Earring", rear="Suppanomimi",
			body="Adhemar Jacket +1", hands="Adhemar Wrist. +1", lring="Hetairoi Ring", rring="Epona's Ring",
			back=gear.THFCape_STP, waist="Windbuffet Belt +1", legs="Samnuha Tights", feet=gear.HBoots_TP
		}

		sets.engaged.Low.Max = set_combine(sets.engaged.Max,
		{
			head="Dampening Tam", neck="Combatant's Torque",
			lring={name="Chirich Ring +1", bag="wardrobe2"}
		})

		sets.engaged.Mid.Max = set_combine(sets.engaged.Low.Max,
		{
			hands="Meg. Gloves +2", rring={name="Chirich Ring +1", bag="wardrobe3"},
			legs="Meg. Chausses +2"
		})

		sets.engaged.High.Max = set_combine(sets.engaged.Mid.Max,
		{
			lear={name="Mache Earring +1", bag="wardrobe2"}, rear={name="Mache Earring +1", bag="wardrobe3"},
			waist="Kentarch Belt +1", feet="Meg. Jam. +2"
		})

	
	--------------------------------------
	-- Hybrid Sets
	--------------------------------------
		sets.engaged.Hybrid = 
		{--	DT: 23%		PDT: 27%	MDT: 23%
			ammo="Staunch Tathlum +1",
			head=gear.AHead_PDT, neck="Loricate Torque +1",
			lring="Defending Ring", rring="Moonbeam Ring",
		}
		
		sets.engaged.Hybrid2 = 
		{--	DT: 29%		PDT: 43%	MDT: 29%
			ammo="Staunch Tathlum +1",
			head=gear.AHead_PDT, neck="Loricate Torque +1",
			lring="Defending Ring", rring="Moonbeam Ring",
			back="Moonlight Cape", waist="Flume Belt +1", legs="Meg. Chausses +2"
		}
	

		----------------------------------------------------------
		-- No Haste
		----------------------------------------------------------	
	    	sets.engaged.DT 			= set_combine(sets.engaged, 		sets.engaged.Hybrid)
		sets.engaged.Low.DT 			= set_combine(sets.engaged.Low, 	sets.engaged.Hybrid)
		sets.engaged.Mid.DT 			= set_combine(sets.engaged.Mid, 	sets.engaged.Hybrid)
		sets.engaged.High.DT			= set_combine(sets.engaged.High, 	sets.engaged.Hybrid)
	
	
	    	sets.engaged.DTMAX 			= set_combine(sets.engaged, 		sets.engaged.Hybrid)
		sets.engaged.Low.DTMAX 			= set_combine(sets.engaged.Low, 	sets.engaged.Hybrid)
		sets.engaged.Mid.DTMAX 			= set_combine(sets.engaged.Mid, 	sets.engaged.Hybrid)
		sets.engaged.High.DTMAX			= set_combine(sets.engaged.High, 	sets.engaged.Hybrid)
	
	
	
		----------------------------------------------------------
		-- Minimum Haste
		----------------------------------------------------------	
	    	sets.engaged.DT.Min 			= set_combine(sets.engaged, 		sets.engaged.Hybrid)
		sets.engaged.Low.DT.Min			= set_combine(sets.engaged.Low, 	sets.engaged.Hybrid)
		sets.engaged.Mid.DT.Min			= set_combine(sets.engaged.Mid, 	sets.engaged.Hybrid)
		sets.engaged.High.DT.Min		= set_combine(sets.engaged.High, 	sets.engaged.Hybrid)
	
	
	    	sets.engaged.DTMAX.Min 			= set_combine(sets.engaged, 		sets.engaged.Hybrid)
		sets.engaged.Low.DTMAX.Min		= set_combine(sets.engaged.Low, 	sets.engaged.Hybrid)
		sets.engaged.Mid.DTMAX.Min		= set_combine(sets.engaged.Mid, 	sets.engaged.Hybrid)
		sets.engaged.High.DTMAX.Min		= set_combine(sets.engaged.High, 	sets.engaged.Hybrid)	
	
	
	
		----------------------------------------------------------
		-- Medium Haste
		----------------------------------------------------------	
	    	sets.engaged.DT.Med 			= set_combine(sets.engaged, 		sets.engaged.Hybrid)
		sets.engaged.Low.DT.Med			= set_combine(sets.engaged.Low, 	sets.engaged.Hybrid)
		sets.engaged.Mid.DT.Med			= set_combine(sets.engaged.Mid, 	sets.engaged.Hybrid)
		sets.engaged.High.DT.Med		= set_combine(sets.engaged.High, 	sets.engaged.Hybrid)	
	
	
	    	sets.engaged.DTMAX.Med 			= set_combine(sets.engaged, 		sets.engaged.Hybrid)
		sets.engaged.Low.DTMAX.Med		= set_combine(sets.engaged.Low, 	sets.engaged.Hybrid)
		sets.engaged.Mid.DTMAX.Med		= set_combine(sets.engaged.Mid, 	sets.engaged.Hybrid)
		sets.engaged.High.DTMAX.Med		= set_combine(sets.engaged.High, 	sets.engaged.Hybrid)		
	
	
	
		----------------------------------------------------------
		-- Maximum Haste
		----------------------------------------------------------		
	    	sets.engaged.DT.Max 			= set_combine(sets.engaged, 		sets.engaged.Hybrid)
		sets.engaged.Low.DT.Max			= set_combine(sets.engaged.Low, 	sets.engaged.Hybrid)
		sets.engaged.Mid.DT.Max			= set_combine(sets.engaged.Mid, 	sets.engaged.Hybrid)
		sets.engaged.High.DT.Max		= set_combine(sets.engaged.High, 	sets.engaged.Hybrid)
	
	
	    	sets.engaged.DTMAX.Max 			= set_combine(sets.engaged, 		sets.engaged.Hybrid)
		sets.engaged.Low.DTMAX.Max		= set_combine(sets.engaged.Low, 	sets.engaged.Hybrid)
		sets.engaged.Mid.DTMAX.Max		= set_combine(sets.engaged.Mid, 	sets.engaged.Hybrid)
		sets.engaged.High.DTMAX.Max		= set_combine(sets.engaged.High, 	sets.engaged.Hybrid)		

	
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)
	if spell.english == 'Aeolian Edge' and state.TreasureMode.value ~= 'None' then
		equip(sets.TreasureHunter)
	elseif spell.english=='Sneak Attack' or spell.english=='Trick Attack' or spell.type == 'WeaponSkill' then
		if state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime' then
			equip(sets.TreasureHunter)
		end
	end
end

-- Run after the general midcast() set is constructed.
function job_post_midcast(spell, action, spellMap, eventArgs)
	if state.TreasureMode.value ~= 'None' and spell.action_type == 'Ranged Attack' then
		equip(sets.TreasureHunter)
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


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function job_update(cmdParams, eventArgs)
	determine_haste_group()
end

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
		if state.IdleMode.value == 'Normal' then
			idleSet = set_combine(idleSet, 
			{
				head="Meghanada Visor +2", neck="Sanctity Necklace",
				lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"},
				waist="Flume Belt +1", waist="Meg. Chuasses +2"
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
	th_update(cmdParams, eventArgs)
end

-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
	local msg = 'Melee'

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
	set_macro_page(1, 15)
	
	send_command('wait 3; input /lockstyleset ' .. lockstyleset)
end