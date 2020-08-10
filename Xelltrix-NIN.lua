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
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Low', 'Mid', 'High')
    state.HybridMode:options('Normal', 'DT')
    state.WeaponskillMode:options('Normal', 'Low', 'Mid', 'High')
	
    state.CastingMode:options('Normal','Resistant','Enmity')
	
    state.IdleMode:options('Normal', 'DT')
	
    gear.DayFeet = "Danzo Sune-ate"
    gear.NightFeet = "Hachi. Kyahan +1"
	
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
			head="Malignance Chapeau", neck="Moonlight Necklace", lear="Cryptic Earring", rear="Trux Earring",
			body="Emet Harness +1", hands="Kurys Gloves", lring="Eihwaz Ring", rring="Supershear Ring",
			back="Reiki Cloak", waist="Trance Belt", legs="Zoar Subligar +1", feet="Ahosi Leggings"
		}
		
		sets.buff.Doom = 
		{
			neck="Nicander's Necklace",
			lring={name="Eshmun's Ring", bag="wardrobe2"}, rring={name="Eshmun's Ring", bag="wardrobe3"},
			waist="Gishdubar Sash"
		}
			
			
	-------------------
	-- Job Abilities --
	------------------- 

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
			head=gear.HHead_MAB, neck="Orunmila's Torque", lear="Etiolation Earring", rear="Loquac. Earring",
			body=gear.TBody_Phalanx, hands="Leyline Gloves", lring="Kishar Ring", rring="Weather. Ring +1",
			back=gear.NINCape_FC, waist="Audumbla Sash", legs="Rawhide Trousers", feet=gear.TFeet_Phalanx
		}
		
		sets.precast.FC.Utsusemi = set_combine(sets.precast.FC,
		{
			neck="Magoraga Beads"
		})
		
	
----------------------------------------------------------------------------
--------------------									--------------------
------------							 						------------
--------					Midcast Gear Sets						--------
------------							 						------------
--------------------									--------------------
----------------------------------------------------------------------------



    --------------------------------------
    -- Buffing Midcast sets
    --------------------------------------

		sets.midcast.FC = sets.precast.FC
		
		sets.midcast['Ninjutsu'] = set_combine(sets.midcast.FC,
		{
			hands="Mochizuki Tekko +1",
		})
		
		sets.midcast.Utsusemi = set_combine(sets.precast.FC,
		{
			hands="Mochizuki Tekko +1",
			back=gear.NINCape_FC, feet="Hattori Kyahan +1"
		})
		
		sets.midcast['Migawari: Ichi'] = set_combine(sets.precast.FC,
		{
			head="Hachi. Hatsu. +1",
			hands="Mochizuki Tekko +1", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back=gear.NINCape_FC
		})
	
		sets.midcast.Phalanx = 
		{
			ammo="Staunch Tathlum +1",
			head=gear.THead_Phalanx, neck="Incanter's Torque", lear="Andoaa Earring", rear="Mimir Earring",
			body=gear.TBody_Phalanx, hands=gear.THands_Phalanx, lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back=gear.NINCape_FC, waist="Olympus Sash", legs=gear.TLegs_Phalanx, feet=gear.TFeet_Phalanx
		}
		
		sets.midcast.Stoneskin =
		{
			ammo="Staunch Tathlum +1",
			head=gear.THead_Phalanx, neck="Stone Gorget", lear="Earthcry Earring", rear="Mimir Earring",
			body=gear.TBody_Phalanx, hands=gear.THands_Phalanx, lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back=gear.NINCape_FC, waist="Olympus Sash", legs=gear.TLegs_Phalanx, feet=gear.TFeet_Phalanx
		}
		
		sets.midcast.Cures =
		{
			ammo="Staunch Tathlum +1",
			head="Blistering Sallet +1", neck="Incanter's Torque", lear="Mendi. Earring", rear="Meili Earring",
			body="Hiza. Haramaki +2", hands="Malignance Gloves", lring="Lebeche Ring", rring="Menelaus's Ring",
			back="Moonlight Cape", waist="Bishop's Sash", legs="Malignance Tights", feet="Malignance Boots"
		}
		
    --------------------------------------
    -- Offensive Midcast sets
    --------------------------------------		
		
		sets.midcast.Macc =
		{
			ammo="Yamarang",
			head="Malignance Chapeau", neck="Incanter's Torque", lear="Gwati Earring", rear="Digni. Earring",
			body="Malignance Tabard", hands="Malignance Gloves", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back=gear.NINCape_FC, waist="Engraved Belt", legs="Malignance Tights", feet="Malignance Boots"
		}

		sets.midcast.Genjutsu = set_combine(sets.midcast.Macc,
		{
			neck="Moonlight Necklace",
			hands="Mochizuki Tekko +1"
		})
		
		sets.midcast['Enfeebling Magic'] = sets.midcast.Macc
		
		sets.midcast['Dark Magic'] = sets.midcast.Macc

		sets.midcast.Wheel =
		{
			ammo="Pemphredo Tathlum",
			head=gear.HHead_MAB, neck="Sanctity Necklace", lear="Friomisi Earring", rear="Crematio Earring",
			body="Gyve Doublet", hands="Leyline Gloves", lring="Dingir Ring", rring="Metamor. Ring +1",
			back=gear.NINCape_FC, waist="Orpheus's Sash", legs="Gyve Trousers", feet="Adhemar Gamashes +1"
		}


		sets.midcast['Elemental Magic'] =
		{
			ammo="Pemphredo Tathlum",
			head=gear.HHead_MAB, neck="Sanctity Necklace", lear="Friomisi Earring", rear="Crematio Earring",
			body="Gyve Doublet", hands="Leyline Gloves", lring="Dingir Ring", rring="Metamor. Ring +1",
			back=gear.NINCape_FC, waist="Orpheus's Sash", legs="Gyve Trousers", feet="Adhemar Gamashes +1"
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
		{
			ammo="Staunch Tathlum +1",
			head="Malignance Chapeau", neck="Warder's Charm +1", lear="Dawn Earring", rear="Infused Earring",
			body="Hiza. Haramaki +2", hands="Malignance Gloves", lring="Defending Ring", rring="Gelatinous Ring +1",
			back="Moonlight Cape", waist="Engraved Belt", legs="Malignance Tights", feet="Malignance Boots"
		}

		sets.idle.DT = set_combine(sets.idle,
		{
			ammo="Yamarang",
			head="Malignance Chapeau", neck="Loricate Torque +1", lear="Dawn Earring", rear="Infused Earring",
			body="Malignance Tabard", hands="Malignance Gloves", lring="Defending Ring", rring="Gelatinous Ring +1",
			back="Moonlight Cape", waist="Engraved Belt", legs="Malignance Tights", feet="Malignance Boots"
		})

		sets.idle.Adoulin = set_combine(sets.idle,
		{
			body="Councilor's Garb"
		})
		
		sets.idle.Weak = sets.idle


	------------------------------------------------------------------------------------------------
	--------------------------------------- Defense Sets -------------------------------------------
	------------------------------------------------------------------------------------------------
	
		sets.defense.PDT =
		{
			ammo="Yamarang",
			head="Malignance Chapeau", neck="Warder's Charm +1", lear="Eabani Earring", rear="Sanare Earring",
			body="Malignance Tabard", hands="Malignance Gloves", lring="Defending Ring", rring="Gelatinous Ring +1",
			back="Moonlight Cape", waist="Engraved Belt", legs="Malignance Tights", feet="Malignance Boots"
		}

		sets.defense.MDT = sets.defense.PDT
	
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
			ammo="Aurgelmir Orb +1",
			head=gear.AHead_TP, neck="Fotia Gorget", lear="Brutal Earring", rear="Moonshade Earring",
			body="Adhemar Jacket +1", hands="Adhemar Wrist. +1", lring="Epaminondas's Ring", rring="Regal Ring",
			back="Sacro Mantle", waist="Fotia Belt", legs="Hiza. Hizayoroi +2", feet=gear.HBoots_WSD
		}
		
	--	***Katana***
		
	--Blade Shun
		sets.precast.WS['Blade: Shun'] =
		{
			ammo="Cath Palug Stone",
			head=gear.AHead_TP, neck="Fotia Gorget", lear={name="Mache Earring +1", bag="wardrobe2"}, rear="Moonshade Earring",
			body="Adhemar Jacket +1", hands="Adhemar Wrist. +1", lring="Ilabrat Ring", rring="Regal Ring",
			back="Sacro Mantle", waist="Fotia Belt", legs="Samnuha Tights", feet=gear.HBoots_TP
		}
		
		sets.precast.WS['Blade: Shun'] = set_combine(sets.precast.WS['Blade: Shun'],
		{
			rear={name="Mache Earring +1", bag="wardrobe3"},
		})
	
	--Blade: Hi
		sets.precast.WS['Blade: Hi'] =
		{
			ammo="Yetshila +1",
			head=gear.AHead_TP, neck="Fotia Gorget", lear="Ishvara Earring", rear="Moonshade Earring",
			body="Herculean Vest", hands="Adhemar Wrist. +1", lring="Epaminondas's Ring", rring="Regal Ring",
			back="Sacro Mantle", waist="Windbuffet Belt +1", legs="Mummu Kecks +2", feet=gear.HBoots_Crit
		}

	--Blade: Ten
		sets.precast.WS['Blade: Ten'] =
		{
			ammo="Aurgelmir Orb +1",
			head=gear.HHead_WSD, neck="Fotia Gorget", lear="Ishvara Earring", rear="Moonshade Earring",
			body="Herculean Vest", hands="Adhemar Wrist. +1", lring="Epaminondas's Ring", rring="Regal Ring",
			back="Sacro Mantle", waist="Sailfi Belt +1", legs="Hiza. Hizayoroi +2", feet=gear.HBoots_WSD
		}
		
	--Blade: Kamu
		sets.precast.WS['Blade: Kamu'] =
		{
			ammo="Aurgelmir Orb +1",
			head=gear.HHead_WSD, neck="Fotia Gorget", lear="Ishvara Earring", rear="Moonshade Earring",
			body="Herculean Vest", hands="Adhemar Wrist. +1", lring="Epaminondas's Ring", rring="Regal Ring",
			back="Sacro Mantle", waist="Sailfi Belt +1", legs="Hiza. Hizayoroi +2", feet=gear.HBoots_WSD
		}

	--Blade: Jin
		sets.precast.WS['Blade: Jin'] = 
		{
			ammo="Yetshila +1",
			head=gear.AHead_TP, neck="Fotia Gorget", lear="Odr Earring", rear={name="Mache Earring +1", bag="wardrobe3"},
			body="Adhemar Jacket +1", hands="Adhemar Wrist. +1", lring="Ilabrat Ring", rring="Regal Ring",
			back="Sacro Mantle", waist="Fotia Belt", legs="Samnuha Tights", feet=gear.HBoots_Crit
		}
		
	--Blade: Ku
		sets.precast.WS['Blade: Ku'] =
		{
			ammo="Aurgelmir Orb +1",
			head=gear.AHead_TP, neck="Fotia Gorget", lear={name="Mache Earring +1", bag="wardrobe2"}, rear={name="Mache Earring +1", bag="wardrobe3"},
			body="Adhemar Jacket +1", hands="Adhemar Wrist. +1", lring="Ilabrat Ring", rring="Regal Ring",
			back="Sacro Mantle", waist="Fotia Belt", legs="Samnuha Tights", feet=gear.HBoots_TP
		}
		
	--Blade: Hybrids
		sets.precast.WS['Blade: Yu'] =
		{
			ammo="Pemphredo Tathlum",
			head=gear.HHead_MAB, neck="Sanctity Necklace", lear="Friomisi Earring", rear="Crematio Earring",
			body="Gyve Doublet", hands="Leyline Gloves", lring="Dingir Ring", rring="Epaminondas's Ring",
			back=gear.NINCape_FC, waist="Orpheus's Sash", legs="Gyve Trousers", feet=gear.HBoots_WSD
		}

		sets.precast.WS['Blade: Ei'] = set_combine(sets.precast.WS['Blade: Yu'],
		{
			head="Pixie Hairpin +1",
			lring="Archon Ring"
		})

		sets.precast.WS['Blade: Teki'] = sets.precast.WS['Blade: Yu']
		
		
	-- **Daggers** --
		sets.precast.WS['Evisceration'] = sets.precast.WS['Blade: Jin']

		sets.precast.WS['Gust Slash'] = sets.precast.WS['Blade: Yu']

		sets.precast.WS['Cyclone'] = sets.precast.WS['Blade: Yu']

		sets.precast.WS['Aeolian Edge'] = sets.precast.WS['Blade: Yu']
	
	
	-- **Swords** --
		sets.precast.WS['Savage Blade'] = sets.precast.WS['Blade: Ten']
		
		sets.precast.WS['Red Lotus Blade'] = sets.precast.WS['Blade: Yu']
		
		sets.precast.WS['Seraph Blade'] = set_combine(sets.precast.WS['Blade: Yu'],
		{
			lring="Weather. Ring +1"
		})


	
	--------------------------------------
	-- Melee sets
	--------------------------------------

	
	----------------------------------------------------------
	--					(DW5 + No Haste)
	----------------------------------------------------------

	--30 DW = 39 DW needed		
	
	----------------------------------------------------------	
	
		sets.engaged =
		{--	
			ammo="Seki Shuriken",
			head="Ryuo Somen +1", neck="Ninja Nodowa +2", lear="Eabani Earring", rear="Suppanomimi",
			body="Adhemar Jacket +1", hands="Adhemar Wrist. +1", lring="Epona's Ring", rring="Gere Ring",
			back=gear.NINCape_STP, waist="Reiki Yotai", legs="Samnuha Tights", feet="Hiza. Sune-Ate +2"
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

	--30 DW = 32 DW needed		
	
	----------------------------------------------------------	
	
		sets.engaged.Min =
		{
			ammo="Seki Shuriken",
			head="Ryuo Somen +1", neck="Ninja Nodowa +2", lear="Brutal Earring", rear="Suppanomimi",
			body="Adhemar Jacket +1", hands="Floral Gauntlets", lring="Epona's Ring", rring="Gere Ring",
			back=gear.NINCape_STP, waist="Reiki Yotai", legs="Samnuha Tights", feet=gear.HBoots_TP
		}

		sets.engaged.Low.Min = set_combine(sets.engaged.Min,
		{
			head="Malignance Chapeau",
			legs="Malignance Tights", feet="Hiza. Sune-Ate +2"
		})

		sets.engaged.Mid.Min = set_combine(sets.engaged.Low.Min,
		{
			lear="Eabani Earring",
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
			ammo="Seki Shuriken",
			head="Ryuo Somen +1", neck="Ninja Nodowa +2", lear="Brutal Earring", rear="Cessance Earring",
			body="Adhemar Jacket +1", hands="Adhemar Wrist. +1", lring="Epona's Ring", rring="Gere Ring",
			back=gear.NINCape_STP, waist="Reiki Yotai", legs="Samnuha Tights", feet=gear.HBoots_TP
		}

		sets.engaged.Low.Med = set_combine(sets.engaged.Med,
		{
			head="Malignance Chapeau", lear="Eabani Earring", rear="Suppanomimi",
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
			feet="Hiza. Sune-Ate +2"
		})

	
	
	----------------------------------------------------------
	--					(DW5 + Max Haste)
	----------------------------------------------------------

	--30 DW = 1 DW needed
	
	----------------------------------------------------------
	
		sets.engaged.Max =
		{
			ammo="Seki Shuriken",
			head="Dampening Tam", neck="Ninja Nodowa +2", lear="Dedition Earring", rear="Telos Earring",
			body="Malignance Tabard", hands="Adhemar Wrist. +1", lring="Epona's Ring", rring="Gere Ring",
			back=gear.NINCape_STP, waist="Windbuffet Belt +1", legs="Samnuha Tights", feet=gear.HBoots_TP
		}

		sets.engaged.Low.Max = set_combine(sets.engaged.Max,
		{
			head="Malignance Chapeau",
			legs="Malignance Tights"
		})

		sets.engaged.Mid.Max = set_combine(sets.engaged.Low.Max,
		{
			hands="Malignance Gloves", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"},
			waist="Kentarch Belt +1", feet="Malignance Boots"
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
			body="Malignance Tabard", hands="Malignance Gloves", lring="Defending Ring",
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
	    sets.engaged.DT.Med 			= set_combine(sets.engaged.Med, 		sets.engaged.Hybrid,
		{
			lear="Eabani Earring", rear="Suppanomimi",
			hands="Floral Gauntlets"
		})
		sets.engaged.Low.DT.Med			= set_combine(sets.engaged.Low.Med, 	sets.engaged.Hybrid)
		sets.engaged.Mid.DT.Med			= set_combine(sets.engaged.Mid.Med, 	sets.engaged.Hybrid)
		sets.engaged.High.DT.Med		= set_combine(sets.engaged.High.Med, 	sets.engaged.Hybrid)	
	
	
	    sets.engaged.DTMAX.Med 			= set_combine(sets.engaged.Med, 		sets.engaged.Hybrid2,
		{
			lear="Eabani Earring", rear="Suppanomimi",
			hands="Floral Gauntlets"
		})
		sets.engaged.Low.DTMAX.Med		= set_combine(sets.engaged.DTMAX.Med,
		{
			hands="Floral Gauntlets"
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
	
	
	    sets.engaged.DTMAX.Max 			= set_combine(sets.engaged.Max, 		sets.engaged.Hybrid2)
		sets.engaged.Low.DTMAX.Max		= set_combine(sets.engaged.DTMAX.Max)
		sets.engaged.Mid.DTMAX.Max		= set_combine(sets.engaged.Low.DTMAX.Max)
		sets.engaged.High.DTMAX.Max		= set_combine(sets.engaged.Mid.DTMAX.Max)			

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_precast(spell, action, spellMap, eventArgs)
	currentSpell = spell.english
	
	if spell.action_type == 'Ability' and spellMap ~= 'Rune' then
		equip(sets.Enmity)
	end
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
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
    if S{'haste','march','embrava','haste samba'}:contains(buff:lower()) then
        determine_haste_group()
        handle_equipping_gear(player.status)
    elseif state.Buff[buff] ~= nil then
        handle_equipping_gear(player.status)
    end
end

function customize_idle_set(idleSet)
    if world.time >= 17*60 or world.time < 7*60 then
        idleSet = set_combine(idleSet,
		{
			feet=gear.NightFeet
		})
    else
        idleSet = set_combine(idleSet,
		{
			feet=gear.DayFeet
		})
    end
	
	return idleSet
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the default 'update' self-command.
function job_update(cmdParams, eventArgs)
    determine_haste_group()
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
	if not midaction() and (player.equipment.lring ~= "Warp Ring"  and player.equipment.rring ~= "Warp Ring") then
	
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
end


-- Select default macro book on initial load or subjob change.
function apply_job_change()
    set_macro_page(1, 13)
	
	send_command('wait 3; input /lockstyleset 13')
end