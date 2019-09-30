-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()	
	state.QDMode = M{['description']='Quick Draw Mode', 'STP', 'Magic Attack'}
    state.Currentqd = M{['description']='Current Quick Draw', 'Main', 'Alt'}
	
	-- Whether to use Luzaf's Ring
    state.LuzafRing = M(false, "Luzaf's Ring")

	include('Mote-TreasureHunter')

	update_combat_form()
	define_roll_values()
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Low', 'Mid', 'High')
    state.HybridMode:options('Normal', 'DT')
    state.RangedMode:options('Normal', 'Low', 'Mid', 'High')
    state.WeaponskillMode:options('Normal', 'Low', 'Mid', 'High')
    state.IdleMode:options('Normal')
	
	send_command('bind ^= gs c cycle treasuremode')
	
	-- Additional local binds
	send_command('bind numpad/ input /ja "Snake Eye" <me>')
    send_command('bind numpad* input /ja "Fold" <me>')
	send_command('bind numpad. input /ja "Double-up" <me>')
	
	send_command('bind ^insert gs c toggle LuzafRing')

	send_command('bind pageup gs c cycle QDMode')
	send_command('bind ^pageup gs c cycleback QDMode')
	
	determine_haste_group()
	
    apply_job_change()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind numpad/')
    send_command('unbind numpad*')
    send_command('unbind numpad.')
	
	send_command('unbind ^insert')
	
	send_command('unbind pageup')
	send_command('unbind ^pageup')
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

		sets.precast.JA['Wild Card'] =  { feet="Lanun Bottes +1" }
		
		sets.precast.JA['Snake Eye'] = { legs="Lanun Trews +1" }
		
		sets.precast.JA['Fold'] = { hands="Lanun Gants +1" }
		
		sets.precast.JA['Random Deal'] =  { body="Lanun Frac" }
		
		sets.precast.CorsairRoll =
		{
			range="Compensator",
			head="Lanun Tricorne", neck="Regal Necklace", lear="Etiolation Earring",
			body="Malignance Tabard", hands="Chasseur's Gants +1", lring="Defending Ring", rring="Gelatinous Ring +1",
			back="Moonlight Cape", waist="Flume Belt +1", legs="Desultor Tassets", feet="Lanun Bottes +1"
		}
		
		sets.precast.CorsairRoll["Blitzer's Roll"] = set_combine(sets.precast.CorsairRoll, 
		{
			head="Chass. Tricorne +1"
		})
		
		sets.precast.CorsairRoll["Tactician's Roll"] = set_combine(sets.precast.CorsairRoll,
		{
			body="Chasseur's Frac +1"
		})
		
		sets.precast.CorsairRoll["Allies' Roll"] = set_combine(sets.precast.CorsairRoll, 
		{
			hands="Chasseur's Gants +1"
		})
		
		sets.midcast.CorsairShot =
		{
			head=gear.HHead_MAB, neck="Sanctity Necklace", lear="Friomisi Earring", rear="Crematio Earring",
			body="Samnuha Coat", hands="Carmine Fin. Ga. +1", lring="Dingir Ring", rring={name="Shiva Ring +1", bag="wardrobe3"},
			back="Camulus's Mantle", waist="Orpheus's Sash", legs="Lak. Trews +1", feet="Adhemar Gamashes"
		}
		
		sets.midcast.CorsairShot.Resistant =
		{
			head="Malignance Chapeau", neck="Sanctity Necklace", lear="Digni. Earring", rring="Gwati Earring",
			body="Malignance Tabard", hands="Malignance Gloves", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back="Camulus's Mantle", waist="Orpheus's Sash", legs="Malignance Tights", feet="Malignance Boots"
			
		}
		
		sets.midcast.CorsairShot.STP =
		{
			head="Malignance Chapeau", neck="Iskur Gorget", lear="Telos Earring", rear="Dedition Earring",
			body="Malignance Tabard", hands="Malignance Gloves", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"},
			back="Camulus's Mantle", waist="Kentarch Belt +1", legs="Malignance Tights", feet="Malignance Boots"
		}
		
		sets.midcast.CorsairShot['Light Shot'] = sets.midcast.CorsairShot.Resistant
		sets.midcast.CorsairShot['Dark Shot'] = sets.midcast.CorsairShot.Resistant
		
		sets.precast.LuzafRing =  { rring="Luzaf's Ring" }
		
		
	-------------------
	-- Precast Magic --
	------------------- 
	
		sets.precast.FC =
		{
			head="Carmine Mask +1", neck="Orunmila's Torque", lear="Etiolation Earring", rear="Loquac. Earring",
			body=gear.TBody_Phalanx, hands="Leyline Gloves", lring="Kishar Ring", rring="Weather. Ring +1",
			back="Moonlight Cape", waist="Flume Belt +1", legs="Rawhide Trousers", feet="Carmine Greaves +1"
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
	-- Midcast Magic
	--------------------------------------
	
	sets.midcast.FC = sets.precast.FC
	
	sets.midcast.FC.Utsusemi = sets.midcast.FC
	
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
			ranged="Fomalhaut", ammo="Chrono Bullet",
			head="Malignance Chapeau", neck="Warder's Charm +1", lear="Etiolation Earring", "Sanare Earring",
			body="Malignance Tabard", hands="Malignance Gloves", lring="Defending Ring", rring="Gelatinous Ring +1",
			back="Moonlight Cape", waist="Engraved Belt", legs="Carmine Cuisses +1", feet="Malignance Boots"
		}

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
    ---------------------------------------- Defense Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------
		
		sets.defense.PDT = sets.idle
		
		sets.defense.MDT = sets.idle
		
		sets.Kiting =  { legs="Carmine Cuisses +1" }
		
    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Special Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------
		
		sets.buff.Doom = 
		{
			neck="Nicander's Necklace",
			lring={name="Eshmun's Ring", bag="wardrobe2"}, rring={name="Eshmun's Ring", bag="wardrobe3"},
			waist="Gishdubar Sash"
		}
		
		sets.TreasureHunter = 
		{ 
			head=gear.HHead_TH, 
			legs="Volte Hose",
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
	-- Ranged Sets
	-------------------------
		
		sets.precast.RA =
		{
			head="Chass. Tricorne +1",
			body="Lak. Frac +1", hands="Carmine Fin. Ga. +1", 
			waist="Impulse Belt", legs="Adhemar Kecks +1", feet="Meg. Jam. +2"
		}
		
		sets.midcast.RA =
		{
			head="Malignance Chapeau", neck="Iskur Gorget", lear="Telos Earring", rear="Dedition Earring",
			body="Malignance Tabard",  hands="Malignance Gloves", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"},
			back="Camulus's Mantle", waist="Yemaya Belt", legs="Malignance Tights", feet="Malignance Boots"
		}
		
		sets.buff.TripleShot =
		{
			body="Chasseur's Frac +1", hands="Oshosi Gloves",
			feet="Adhemar Gamashes"
		}
		
	-------------------------
	-- Weaponskill Sets
	-------------------------
		sets.precast.WS = 
		{
			head=gear.HHead_WSD, neck="Fotia Gorget", lear="Ishvara Earring", rear="Moonshade Earring",
			body="Herculean Vest", hands="Meg. Gloves +2", lring="Regal Ring", rring="Epaminondas's Ring",
			back="Camulus's Mantle", waist="Fotia Belt", legs="Herculean Trousers", feet=gear.HBoots_WSD
		}
		
		--	***Guns***
		sets.precast.WS['Leaden Salute'] = set_combine(sets.precast.WS, 
		{
			head="Pixie Hairpin +1", neck="Sanctity Necklace", lear="Friomisi Earring", rear="Crematio Earring",
			body="Samnuha Coat", hands="Herculean Gloves", lring="Archon Ring", rring="Epaminondas's Ring",
			back="Camulus's Mantle", waist="Orpheus's Sash", legs="Shned. Tights +1", feet="Adhemar Gamashes"
		})
		
		sets.precast.WS['Wildfire'] = set_combine(sets.precast.WS['Leaden Salute'],
		{
			head=gear.HHead_MAB,
			lring={name="Shiva Ring +1", bag="wardrobe2"}
		})
		sets.precast.WS['Hot Shot'] = sets.precast.WS['Wildfire']
		
		sets.precast.WS['Last Stand'] = set_combine(sets.precast.WS,
		{
			head="Malignance Chapeau",
			body="Malignance Tabard",
			legs="Meg. Chausses +2", feet="Malignance Boots"
		})
		
		--	***Swords***
		sets.precast.WS['Sanguine Blade'] = sets.precast.WS['Leaden Salute']
		
		sets.precast.WS['Seraph Blade'] = sets.precast.WS['Wildfire']
		
		sets.precast.WS['Red Lotus Blade'] = sets.precast.WS['Wildfire']
		
		sets.precast.WS['Vorpal Blade'] = set_combine(sets.precast.WS,
		{
			head=gear.AHead_TP, lear="Brutal Earring",
			body="Adhemar Jacket +1", hands="Adhemar Wrist. +1", lring="Begrudging Ring", rring="Epona's Ring",
			legs="Samnuha Tights", feet=gear.HBoots_TP
		})
		
		sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, 
		{
			head=gear.HHead_WSD,
			waist="Prosilio Belt +1", feet=gear.HBoots_WSD
		})
		
		sets.precast.WS['Swift Blade'] = sets.precast.WS['Savage Blade']
		
		sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, 
		{
			lear="Brutal Earring",
			lring={name="Stikini Ring +1", bag="wardrobe2"}, rring="Epona's Ring", 
			legs="Samnuha Tights", feet=gear.HBoots_TP
		})
			
			
		
		--	***Daggers***	
		sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS,
		{
			head=gear.AHead_TP, lear={name="Mache Earring +1", bag="wardrobe2"}, rear={name="Mache Earring +1", bag="wardrobe3"},
			body="Adhemar Jacket +1", hands="Adhemar Wrist. +1", lring="Begrudging Ring", rring="Epona's Ring",
			legs="Samnuha Tights", feet=gear.HBoots_TP
		})
		
		sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS,
		{
			head=gear.AHead_TP, lear="Brutal Earring",
			body="Adhemar Jacket +1", hands="Floral Gauntlets", lring="Dingir Ring", rring="Epona's Ring",
			legs="Samnuha Tights", feet=gear.HBoots_TP
		})
		sets.precast.WS['Aeolian Edge'] = sets.precast.WS['Wildfire']
	
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
			head=gear.AHead_TP, neck="Iskur Gorget", lear="Telos Earring", rear="Cessance Earring",
			body="Adhemar Jacket +1", hands="Adhemar Wrist. +1", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring="Epona's Ring",
			back="Camulus's Mantle", waist="Windbuffet Belt +1", legs="Samnuha Tights", feet="Carmine Greaves +1"
		}
		-----------------------------------------------------------------------------------
		---	TP/h:104	(STP:39		QA:2%	TA:8%	DA:24%)
		---	Primary Accuracy: 1093~		/ Primary Attack: 971~
		--- DT: 9%	PDT: 19%	MDT: 9%		Defense: 1074~
		-----------------------------------------------------------
		sets.engaged.Low = set_combine(sets.engaged,
		{
			head="Dampening Tam",
			lring={name="Chirich Ring +1", bag="wardrobe2"},
		})
		-----------------------------------------------------------------------------------
		---	TP/h:104	(STP:39		QA:2%	TA:2%	DA:24%)
		---	Primary Accuracy: 1124~		/ Primary Attack: 1004~
		--- DT: 11%	PDT: 21%	MDT: 11%		Defense: 1115~
		-----------------------------------------------------------
		sets.engaged.Mid = set_combine(sets.engaged.Low,
		{
			head="Carmine Mask +1",
			legs="Carmine Cuisses +1"
		})
		-----------------------------------------------------------------------------------
		---	TP/h:101~	(STP:31~35	QA:0%	TA:0%	DA:14%)
		---	Primary Accuracy: 1170~		/ Primary Attack: 1001~
		--- DT: 11%	PDT: 21%	MDT: 11%		Defense: 1120~
		-----------------------------------------------------------
		sets.engaged.High = set_combine(sets.engaged.Mid,
		{
			lear={name="Mache Earring +1", bag="wardrobe2"}, rear={name="Mache Earring +1", bag="wardrobe3"},
			hands="Meg. Gloves +2", rring={name="Chirich Ring +1", bag="wardrobe3"},
			waist="Kentarch Belt +1", feet="Malignance Boots"
		})
		
	
	----------------------------------------------------------
	--					(DW2 + No Haste)
	----------------------------------------------------------
	--15 DW = 59 DW needed		(DNC Sub)
	
	----------------------------------------------------------	
	
		-----------------------------------------------------------------------------------
		---	TP/h:65		(DW:35	STP:33		QA:0%	TA:4%	DA:10%)
		---	Primary Accuracy: 1140 		/ Primary Attack: 1018
		--- Auxiliary Accuracy: 1115 	/ Auxiliary Attack: 936
		-----------------------------------------------------------
		sets.engaged.DW2 =
		{
			head=gear.AHead_TP, neck="Iskur Gorget", lear="Eabani Earring", rear="Suppanomimi",
			body="Adhemar Jacket +1", hands="Floral Gauntlets", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring="Epona's Ring",
			back="Camulus's Mantle", waist="Reiki Yotai", legs="Carmine Cuisses +1", feet=gear.TFeet_TP
		}
		-----------------------------------------------------------------------------------
		---	TP/h:63		(DW:36	STP:29		QA:0%	TA:4%	DA:7%)
		---	Primary Accuracy: 1130 		/ Primary Attack: 1017
		--- Auxiliary Accuracy: 1106 	/ Auxiliary Attack: 937
		-----------------------------------------------------------		
		sets.engaged.DW2.Low = set_combine(sets.engaged.DW2,
		{
			head="Dampening Tam",
			lring={name="Chirich Ring +1", bag="wardrobe2"}
		})
		-----------------------------------------------------------------------------------
		---	TP/h:63		(DW:36	STP:29		QA:0%	TA:2%	DA:7%)
		---	Primary Accuracy: 1175 		/ Primary Attack: 1011
		--- Auxiliary Accuracy: 1151 	/ Auxiliary Attack: 927
		-----------------------------------------------------------		
		sets.engaged.DW2.Mid = set_combine(sets.engaged.DW2.Low,
		{
			head="Carmine Mask +1",
			rring={name="Chirich Ring +1", bag="wardrobe3"},
		})
		-----------------------------------------------------------------------------------
		---	TP/h:80~	(DW:16	STP:34~8	QA:0%	TA:0%	DA:14%)
		---	Primary Accuracy: 1209		/ Primary Attack: 996
		--- Auxiliary Accuracy: 1184 	/ Auxiliary Attack: 912
		-----------------------------------------------------------		
		sets.engaged.DW2.High = set_combine(sets.engaged.DW2.Mid,
		{
			neck="Combatant's Torque", lear={name="Mache Earring +1", bag="wardrobe2"}, rear={name="Mache Earring +1", bag="wardrobe3"},
			waist="Kentarch Belt +1", feet="Malignance Boots"
		})
	
	
	----------------------------------------------------------
	--					(DW3 + No Haste)
	----------------------------------------------------------
	--25 DW = 49 DW needed		(NIN Sub)
	
	----------------------------------------------------------	
	
		-----------------------------------------------------------------------------------
		---	TP/h:59		(DW:35	STP:33		QA:0%	TA:4%	DA:10%)
		---	Primary Accuracy: 1131 		/ Primary Attack: 1020
		--- Auxiliary Accuracy: 1106 	/ Auxiliary Attack: 9377
		-----------------------------------------------------------	
		sets.engaged.DW3 = 
		{
			head=gear.AHead_TP, neck="Iskur Gorget", lear="Eabani Earring", rear="Suppanomimi",
			body="Adhemar Jacket +1", hands="Floral Gauntlets", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring="Epona's Ring",
			back="Camulus's Mantle", waist="Reiki Yotai", legs="Carmine Cuisses +1", feet=gear.TFeet_TP
		}
		-----------------------------------------------------------------------------------
		---	TP/h:58		(DW:36	STP:29		QA:0%	TA:4%	DA:7%)
		---	Primary Accuracy: 1153		/ Primary Attack: 1024
		--- Auxiliary Accuracy: 1129 	/ Auxiliary Attack: 942
		-----------------------------------------------------------	
		sets.engaged.DW3.Low = set_combine(sets.engaged.DW3,
		{
			head="Dampening Tam"
		})
		-----------------------------------------------------------------------------------
		---	TP/h:58		(DW:36	STP:29		QA:0%	TA:2%	DA:7%)
		---	Primary Accuracy: 1165 		/ Primary Attack: 1012
		--- Auxiliary Accuracy: 1141 	/ Auxiliary Attack: 928
		-----------------------------------------------------------	
		sets.engaged.DW3.Mid = set_combine(sets.engaged.DW3.Low,
		{
			head="Carmine Mask +1",
			rring={name="Chirich Ring +1", bag="wardrobe3"},
		})
		-----------------------------------------------------------------------------------
		---	TP/h:74~	(DW:16	STP:34~8	QA:0%	TA:0%	DA:14%)
		---	Primary Accuracy: 1200		/ Primary Attack: 997
		--- Auxiliary Accuracy: 1175 	/ Auxiliary Attack: 913
		-----------------------------------------------------------	
		sets.engaged.DW3.High = set_combine(sets.engaged.DW3.Mid,
		{
			lear={name="Mache Earring +1", bag="wardrobe2"}, rear={name="Mache Earring +1", bag="wardrobe3"},
			waist="Kentarch Belt +1", feet="Malignance Boots"
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
		---	TP/h:64		(DW:31	STP:38		QA:0%	TA:4%	DA:15%)
		---	Primary Accuracy: 1135 		/ Primary Attack: 1023
		--- Auxiliary Accuracy: 1110 	/ Auxiliary Attack: 939
		-----------------------------------------------------------		
		sets.engaged.DW3.Med =
		{
			head=gear.AHead_TP, neck="Iskur Gorget", lear="Eabani Earring", rear="Suppanomimi",
			body="Adhemar Jacket +1", hands="Floral Gauntlets", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring="Epona's Ring",
			back="Camulus's Mantle", waist="Reiki Yotai", legs="Samnuha Tights", feet=gear.TFeet_TP
		}
		
		-----------------------------------------------------------------------------------
		---	TP/h:65		(DW:32	STP:39		QA:0%	TA:2%	DA:13%)
		---	Primary Accuracy: 1160 		/ Primary Attack: 1018
		--- Auxiliary Accuracy: 1136 	/ Auxiliary Attack: 932
		-----------------------------------------------------------		
		sets.engaged.DW3.Low.Med = set_combine(sets.engaged.DW3.Med,
		{
			head="Dampening Tam",
			lring={name="Chirich Ring +1", bag="wardrobe2"},
		})
		
		-----------------------------------------------------------------------------------
		---	TP/h:62		(DW:33	STP:34		QA:0%	TA:2%	DA:12%)
		---	Primary Accuracy: 1169 		/ Primary Attack: 1016
		--- Auxiliary Accuracy: 1145	/ Auxiliary Attack: 930
		-----------------------------------------------------------	
		sets.engaged.DW3.Mid.Med = set_combine(sets.engaged.DW3.Low.Med,
		{
			head="Carmine Mask +1", lear={name="Mache Earring +1", bag="wardrobe2"}, rear={name="Mache Earring +1", bag="wardrobe3"},
			legs="Carmine Cuisses +1", feet="Carmine Greaves +1"
		})
		-----------------------------------------------------------------------------------
		---	TP/h:70		(DW:21	STP:35		QA:0%	TA:0%	DA:11%)
		---	Primary Accuracy: 1198 		/ Primary Attack: 1002
		--- Auxiliary Accuracy: 1174 	/ Auxiliary Attack: 918
		-----------------------------------------------------------	
		sets.engaged.DW3.High.Med = set_combine(sets.engaged.DW3.Mid.Med,
		{
			rring={name="Chirich Ring +1", bag="wardrobe3"},
			feet="Malignance Boots"
		})
	
	
	----------------------------------------------------------
	--					(DW2 + Max Haste)
	----------------------------------------------------------
	--25 DW = 21 DW needed		(DNC Sub)
	
	----------------------------------------------------------	
		
		-----------------------------------------------------------------------------------
		---	TP/h:65		(DW:22	STP:33		QA:0%	TA:4%	DA:10%)
		---	Primary Accuracy: 1140 		/ Primary Attack: 1018
		--- Auxiliary Accuracy: 1115 	/ Auxiliary Attack: 936
		-----------------------------------------------------------	
		sets.engaged.DW2.Max =
		{
			head=gear.AHead_TP, neck="Iskur Gorget", lear="Eabani Earring", rear="Suppanomimi",
			body="Adhemar Jacket +1", hands="Adhemar Wrist. +1", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring="Epona's Ring",
			back="Camulus's Mantle", waist="Reiki Yotai", legs="Samnuha Tights", feet=gear.HBoots_TP
		}
		
		-----------------------------------------------------------------------------------
		---	TP/h:65		(DW:36	STP:33		QA:0%	TA:4%	DA:10%)
		---	Primary Accuracy: 1140 		/ Primary Attack: 1018
		--- Auxiliary Accuracy: 1115 	/ Auxiliary Attack: 936
		-----------------------------------------------------------	
		sets.engaged.DW2.Low.Max = set_combine(sets.engaged.DW2.Max,
		{
			head="Dampening Tam",
			lring={name="Chirich Ring +1", bag="wardrobe2"},
		})
		
		-----------------------------------------------------------------------------------
		---	TP/h:65		(DW:36	STP:33		QA:0%	TA:4%	DA:10%)
		---	Primary Accuracy: 1140 		/ Primary Attack: 1018
		--- Auxiliary Accuracy: 1115 	/ Auxiliary Attack: 936
		-----------------------------------------------------------	
		sets.engaged.DW2.Mid.Max = set_combine(sets.engaged.DW2.Low.Max,
		{
			head="Carmine Mask +1", 
			waist="Kentarch Belt +1", legs="Carmine Cuisses +1",
			feet="Carmine Greaves +1"
		})
		
		-----------------------------------------------------------------------------------
		---	TP/h:65		(DW:36	STP:33		QA:0%	TA:4%	DA:10%)
		---	Primary Accuracy: 1140 		/ Primary Attack: 1018
		--- Auxiliary Accuracy: 1115 	/ Auxiliary Attack: 936
		-----------------------------------------------------------	
		sets.engaged.DW2.High.Max = set_combine(sets.engaged.DW2.Mid.Max,
		{
			lear={name="Mache Earring +1", bag="wardrobe2"}, rear={name="Mache Earring +1", bag="wardrobe3"},
			rring={name="Chirich Ring +1", bag="wardrobe3"},
			feet="Malignance Boots"
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
			head=gear.AHead_TP, neck="Iskur Gorget", lear="Telos Earring", rear="Dedition Earring",
			body="Adhemar Jacket +1", hands="Adhemar Wrist. +1", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"},
			back="Camulus's Mantle", waist="Reiki Yotai", legs="Samnuha Tights", feet="Carmine Greaves +1"
		}
		
		-----------------------------------------------------------------------------------
		---	TP/h:78		(DW:10	STP:40		QA:2%	TA:8%	DA:18%)
		---	Primary Accuracy: 1121 		/ Primary Attack: 945
		--- Auxiliary Accuracy: 1096 	/ Auxiliary Attack: 859
		-----------------------------------------------------------	
		sets.engaged.DW3.Low.Max = set_combine(sets.engaged.DW3.Max,
		{
			neck="Combatant's Torque",
			rring={name="Chirich Ring +1", bag="wardrobe3"},
		})
		
		-----------------------------------------------------------------------------------
		---	TP/h:78		(DW:10	STP:40		QA:2%	TA:6%	DA:14%)
		---	Primary Accuracy: 1138 		/ Primary Attack: 951
		--- Auxiliary Accuracy: 1113 	/ Auxiliary Attack: 867
		-----------------------------------------------------------	
		sets.engaged.DW3.Mid.Max = set_combine(sets.engaged.DW3.Low.Max,
		{
			head="Dampening Tam", rear="Dedition Earring",
			waist="Kentarch Belt +1", legs="Carmine Cuisses +1"
		})
		-----------------------------------------------------------------------------------
		---	TP/h:78~	(DW:10	STP:34~38	QA:0%	TA:4%	DA:14%)
		---	Primary Accuracy: 1181 		/ Primary Attack: 953
		--- Auxiliary Accuracy: 1156 	/ Auxiliary Attack: 868
		-----------------------------------------------------------	
		sets.engaged.DW3.High.Max = set_combine(sets.engaged.DW3.Mid.Max,
		{
			head="Carmine Mask +1", lear={name="Mache Earring +1", bag="wardrobe2"}, rear={name="Mache Earring +1", bag="wardrobe3"},
		})	
	
	
	
	
	
	------------------------------------------------------------------------------------------------
    ---------------------------------------- Hybrid Sets -------------------------------------------
    ------------------------------------------------------------------------------------------------
		sets.engaged.Hybrid = 
		{
			head=gear.AHead_PDT, neck="Loricate Torque +1",
			lring="Defending Ring", rring="Gelatinous Ring +1"
		}
		----------------------------------------------------------
		-- Sword & Board
		----------------------------------------------------------	
	    sets.engaged.DT 			= set_combine(sets.engaged, 		sets.engaged.Hybrid)
		sets.engaged.Low.DT 		= set_combine(sets.engaged.Low, 	sets.engaged.Hybrid)
		sets.engaged.Mid.DT 		= set_combine(sets.engaged.Mid, 	sets.engaged.Hybrid)
		sets.engaged.High.DT		= set_combine(sets.engaged.High, 	sets.engaged.Hybrid)
		
		----------------------------------------------------------
		-- No Haste
		----------------------------------------------------------
		sets.engaged.DW2.DT 		= set_combine(sets.engaged.DW2, 		sets.engaged.Hybrid)
		sets.engaged.DW2.Low.DT 	= set_combine(sets.engaged.DW2.Low, 	sets.engaged.Hybrid)
		sets.engaged.DW2.Mid.DT 	= set_combine(sets.engaged.DW2.Mid, 	sets.engaged.Hybrid)
		sets.engaged.DW2.High.DT 	= set_combine(sets.engaged.DW2.High, 	sets.engaged.Hybrid)
		sets.engaged.DW3.DT 		= set_combine(sets.engaged.DW3, 		sets.engaged.Hybrid)
		sets.engaged.DW3.Low.DT 	= set_combine(sets.engaged.DW3.Low, 	sets.engaged.Hybrid)
		sets.engaged.DW3.Mid.DT 	= set_combine(sets.engaged.DW3.Mid, 	sets.engaged.Hybrid)
		sets.engaged.DW3.High.DT 	= set_combine(sets.engaged.DW3.High, 	sets.engaged.Hybrid)
		
		
		----------------------------------------------------------
		-- Minimum Haste
		----------------------------------------------------------
		sets.engaged.DW2.DT.Min 	 = set_combine(sets.engaged.DW2.Min, 		sets.engaged.Hybrid)
		sets.engaged.DW2.Low.DT.Min  = set_combine(sets.engaged.DW2.Low.Min, 	sets.engaged.Hybrid)
		sets.engaged.DW2.Mid.DT.Min  = set_combine(sets.engaged.DW2.Mid.Min, 	sets.engaged.Hybrid)
		sets.engaged.DW2.High.DT.Min = set_combine(sets.engaged.DW2.High.Min, 	sets.engaged.Hybrid)
		
		sets.engaged.DW3.DT.Min 	 = set_combine(sets.engaged.DW3.Min, 		sets.engaged.Hybrid)
		sets.engaged.DW3.Low.DT.Min  = set_combine(sets.engaged.DW3.Low.Min, 	sets.engaged.Hybrid)
		sets.engaged.DW3.Mid.DT.Min  = set_combine(sets.engaged.DW3.Mid.Min, 	sets.engaged.Hybrid)
		sets.engaged.DW3.High.DT.Min = set_combine(sets.engaged.DW3.High.Min, 	sets.engaged.Hybrid)
		
		
		----------------------------------------------------------
		-- Medium Haste
		----------------------------------------------------------
		sets.engaged.DW2.DT.Med 	 = set_combine(sets.engaged.DW2.Med, 		sets.engaged.Hybrid)
		sets.engaged.DW2.Low.DT.Med  = set_combine(sets.engaged.DW2.Low.Med, 	sets.engaged.Hybrid)
		sets.engaged.DW2.Mid.DT.Med  = set_combine(sets.engaged.DW2.Mid.Med, 	sets.engaged.Hybrid)
		sets.engaged.DW2.High.DT.Med = set_combine(sets.engaged.DW2.High.Med, 	sets.engaged.Hybrid)
		sets.engaged.DW3.DT.Med 	 = set_combine(sets.engaged.DW3.Med, 		sets.engaged.Hybrid)
		sets.engaged.DW3.Low.DT.Med  = set_combine(sets.engaged.DW3.Low.Med, 	sets.engaged.Hybrid)
		sets.engaged.DW3.Mid.DT.Med  = set_combine(sets.engaged.DW3.Mid.Med, 	sets.engaged.Hybrid)
		sets.engaged.DW3.High.DT.Min = set_combine(sets.engaged.DW3.High.Min, 	sets.engaged.Hybrid)
		
		----------------------------------------------------------
		-- Maximum Haste
		----------------------------------------------------------		
		sets.engaged.DW2.DT.Max 	 = set_combine(sets.engaged.DW2.Max, 		sets.engaged.Hybrid)
		sets.engaged.DW2.Low.DT.Max  = set_combine(sets.engaged.DW2.Low.Max, 	sets.engaged.Hybrid)
		sets.engaged.DW2.Mid.DT.Max  = set_combine(sets.engaged.DW2.Mid.Max, 	sets.engaged.Hybrid)
		sets.engaged.DW2.High.DT.Max = set_combine(sets.engaged.DW2.High.Max, 	sets.engaged.Hybrid)
		
		sets.engaged.DW3.DT.Max 	 = set_combine(sets.engaged.DW3.Max, 		sets.engaged.Hybrid)
		sets.engaged.DW3.Low.DT.Max  = set_combine(sets.engaged.DW3.Low.Max, 	sets.engaged.Hybrid)
		sets.engaged.DW3.Mid.DT.Max  = set_combine(sets.engaged.DW3.Mid.Max, 	sets.engaged.Hybrid)
		sets.engaged.DW3.High.DT.Max = set_combine(sets.engaged.DW3.High.Max, 	sets.engaged.Hybrid)
	
end
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
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
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    -- Gear
    if (spell.type == 'CorsairRoll' or spell.english == "Double-Up") then
        if state.LuzafRing.value then
            equip(sets.precast.LuzafRing)
        end
    elseif spell.type == 'CorsairShot' and state.CastingMode.value == 'Resistant' then
        classes.CustomClass = 'Acc'
    end
end

function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.action_type == 'Ranged Attack' then
        if flurry == 2 then
            equip(sets.precast.RA.Flurry2)
        elseif flurry == 1 then
            equip(sets.precast.RA.Flurry1)
        end
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

function job_post_midcast(spell, action, spellMap, eventArgs)
    -- Equip obi if weather/day matches for Quick Draw.
    if spell.type == 'CorsairShot' then
        if (spell.element == world.day_element or spell.element == world.weather_element) and
        (spell.english ~= 'Light Shot' and spell.english ~= 'Dark Shot') then
            equip{waist="Hachirin-no-Obi"}
		end
		if state.QDMode.value == 'STP' then
            equip(sets.midcast.CorsairShot.STP)
        end
	end
	 if spell.action_type == 'Ranged Attack' then
        if buffactive['Triple Shot'] then
            equip(sets.buff.TripleShot)
		end
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    if spell.type == 'CorsairRoll' and not spell.interrupted then
        display_roll_info(spell)
    end
end

function job_buff_change(buff,gain)
-- If we gain or lose any flurry buffs, adjust gear.
	if state.Buff[buff] ~= nil then
        if not midaction() then
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

	if S{'haste','march','embrava','haste samba', 'mighty guard', 'geo-haste', 'indi-haste', 'slow', 'indi-slow', 'elegy'}:contains(buff:lower()) then
		determine_haste_group()
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
    if stateField == 'Offense Mode' then
		if newValue == 'Normal' or newValue == 'Low' or newValue == 'Mid' or newValue == 'High' then
			disable('main','sub','range')
		else
			enable('main','sub','range')
		end
	end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    determine_haste_group()
	update_combat_form()
	handle_equipping_gear(player.status)
end

function customize_idle_set(idleSet)
	if player.hpp < 80 then
		if state.IdleMode.value == 'Normal' then
			idleSet = set_combine(idleSet, 
			{
				neck="Sanctity Necklace", lear="Dawn Earring", rear="Infused Earring",
				lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"}
			})
		end
	elseif player.mpp < 80 and (player.sub_job == "BLM" or player.sub_job == "WHM" or player.sub_job == "RDM") then
		if state.IdleMode.value == 'Normal' then
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

--Adjusts gear based on the level of magical haste received.
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
			(buffactive[33] and (buffactive[580] or buffactive.embrava)) or (buffactive.march == 2 and buffactive[604])) or buffactive.march == 2 then
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
		--add_to_chat(8, '-------------  No Dual Wield Detected   --------------')
    end
end


-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    local msg = ''

	if state.CombatForm.has_value then
		msg = msg .. ' (' .. state.CombatForm.value .. ')'
	end
	
    msg = msg .. '[ Offense/Ranged: '..state.OffenseMode.current

    if state.HybridMode.value ~= 'Normal' then
        msg = msg .. '/' .. state.HybridMode.value
    end

    msg = msg .. '/' ..state.RangedMode.current .. ' ]'

    if state.WeaponskillMode.value ~= 'Normal' then
        msg = msg .. '[ WS: '..state.WeaponskillMode.current .. ' ]'
    end

    if state.DefenseMode.value ~= 'None' then
        msg = msg .. '[ Defense: ' .. state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ' ]'
    end

    if state.Kiting.value then
        msg = msg .. '[ Kiting Mode: ON ]'
    end
	
	if state.TreasureMode.has_value then
		msg = msg .. ', TH: ' .. state.TreasureMode.value
	end

    msg = msg .. ']'

    add_to_chat(060, msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------


function define_roll_values()
    rolls = 
	{
        ["Corsair's Roll"] 		=	{lucky=5, unlucky=9,	bonus="Experience Points"},
        ["Ninja Roll"] 			=	{lucky=4, unlucky=8, 	bonus="Evasion"},
        ["Hunter's Roll"] 		=	{lucky=4, unlucky=8, 	bonus="Accuracy"},
        ["Chaos Roll"] 			=	{lucky=4, unlucky=8, 	bonus="Attack"},
        ["Magus's Roll"] 		=	{lucky=2, unlucky=6, 	bonus="Magic Defense"},
        ["Healer's Roll"]		=	{lucky=3, unlucky=7, 	bonus="Cure Potency Received"},
        ["Drachen Roll"] 		=	{lucky=4, unlucky=8, 	bonus="Pet Magic Accuracy/Attack"},
        ["Choral Roll"] 		=	{lucky=2, unlucky=6, 	bonus="Spell Interruption Rate"},
        ["Monk's Roll"] 		=	{lucky=3, unlucky=7, 	bonus="Subtle Blow"},
        ["Beast Roll"] 			=	{lucky=4, unlucky=8, 	bonus="Pet Attack"},
        ["Samurai Roll"] 		=	{lucky=2, unlucky=6, 	bonus="Store TP"},
        ["Evoker's Roll"] 		=	{lucky=5, unlucky=9, 	bonus="Refresh"},
        ["Rogue's Roll"] 		=	{lucky=5, unlucky=9, 	bonus="Critical Hit Rate"},
        ["Warlock's Roll"] 		=	{lucky=4, unlucky=8, 	bonus="Magic Accuracy"},
        ["Fighter's Roll"] 		=	{lucky=5, unlucky=9, 	bonus="Double Attack Rate"},
        ["Puppet Roll"] 		=	{lucky=3, unlucky=7, 	bonus="Pet Magic Attack/Accuracy"},
        ["Gallant's Roll"] 		=	{lucky=3, unlucky=7, 	bonus="Defense"},
        ["Wizard's Roll"] 		=	{lucky=5, unlucky=9, 	bonus="Magic Attack"},
        ["Dancer's Roll"] 		=	{lucky=3, unlucky=7, 	bonus="Regen"},
        ["Scholar's Roll"] 		=	{lucky=2, unlucky=6, 	bonus="Conserve MP"},
        ["Naturalist's Roll"] 	=	{lucky=3, unlucky=7, 	bonus="Enh. Magic Duration"},
        ["Runeist's Roll"] 		=	{lucky=4, unlucky=8, 	bonus="Magic Evasion"},
        ["Bolter's Roll"] 		=	{lucky=3, unlucky=9, 	bonus="Movement Speed"},
        ["Caster's Roll"] 		=	{lucky=2, unlucky=7, 	bonus="Fast Cast"},
        ["Courser's Roll"] 		=	{lucky=3, unlucky=9, 	bonus="Snapshot"},
        ["Blitzer's Roll"] 		=	{lucky=4, unlucky=9, 	bonus="Attack Delay"},
        ["Tactician's Roll"] 	=	{lucky=5, unlucky=8, 	bonus="Regain"},
        ["Allies' Roll"] 		=	{lucky=3, unlucky=10, 	bonus="Skillchain Damage"},
        ["Miser's Roll"] 		=	{lucky=5, unlucky=7, 	bonus="Save TP"},
        ["Companion's Roll"] 	=	{lucky=2, unlucky=10, 	bonus="Pet Regain and Regen"},
        ["Avenger's Roll"] 		=	{lucky=4, unlucky=8, 	bonus="Counter Rate"}
    }
end

function display_roll_info(spell)
    rollinfo = rolls[spell.english]
    local rollsize = (state.LuzafRing.value and 'Large') or 'Small'

    if rollinfo then
        add_to_chat(104, '[ Lucky: '..tostring(rollinfo.lucky)..' / Unlucky: '..tostring(rollinfo.unlucky)..' ] '..spell.english..': '..rollinfo.bonus..' ('..rollsize..') ')
    end
end



-- Select default macro book on initial load or subjob change.
function apply_job_change()
    set_macro_page(6, 10)
	
	send_command('wait 3; input /lockstyleset 14')
end