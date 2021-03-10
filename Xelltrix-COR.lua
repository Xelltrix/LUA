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
	state.EnmityDown = M(false)
	
	state.QDMode = M{['description']='Quick Draw Mode','STP','Magic Attack','Resistant'}
	state.QDraw = M{['description']='Primary Shot', 'Fire Shot', 'Ice Shot', 'Wind Shot', 'Earth Shot', 'Thunder Shot', 'Water Shot'}
 
 -- Whether to use Luzaf's Ring
    state.Luzaf = M(true)

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
	
	state.MainWeaponSet = M{['description']='Main Weapon Set',
		'Rostam',
		'Lanun',
		'Tauret',
		'Naegling'
	}
	
	-- state.SubWeaponSet = M{['description']='Sub Weapon Set',
		-- 'Blurred',
		-- 'Degen'
	-- }	
	
	state.RangeWeaponSet = M{['description']='Ranged Weapon Set',
		'Penalty',
		'Fomalhaut',
		'Ataktos'
	}	
	

	-- Additional local binds
	
	send_command('bind ^insert gs c toggle Luzaf')

	send_command('bind ^delete gs c cycle QDMode')
	
	send_command('bind ^home gs c cycle QDraw')
	send_command('bind ^end gs c cycleback QDraw')
	
	send_command('bind pageup gs c cycle MainWeaponSet')
	send_command('bind pagedown gs c cycleback MainWeaponSet')
	
	send_command('bind ^pageup gs c cycle RangeWeaponSet')
	send_command('bind ^pagedown gs c cycleback RangeWeaponSet')
	
	send_command('bind numpad. gs c toggle EnmityDown')	
	
	determine_haste_group()
	
    apply_job_change()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
	
	send_command('unbind ^insert')
	
	send_command('unbind ^delete')
	
	send_command('unbind ^home')
	send_command('unbind ^end')
	
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

	
	-------------------
	-- Job Abilities --
	------------------- 

		sets.precast.JA['Wild Card'] =  { feet="Lanun Bottes +3" }
		
		sets.precast.JA['Snake Eye'] = { legs="Lanun Trews +1" }
		
		--sets.precast.JA['Fold'] = { hands="Lanun Gants +3" }
		
		sets.precast.JA['Random Deal'] =  { body="Lanun Frac +3" }
		
		sets.precast.CorsairRoll =
		{
			main={ name="Lanun Knife", augments={'Path: C',}}, range="Compensator",
			head="Lanun Tricorne +3", neck="Regal Necklace", lear="Odnowa Earring +1", rear="Etiolation Earring",
			body="Malignance Tabard", hands="Chasseur's Gants +1", lring="Defending Ring", rring="Gelatinous Ring +1",
			back=gear.CORCape_Snap, waist="Flume Belt +1", legs="Desultor Tassets", feet="Malignance Boots"
		}
		
		sets.precast.CorsairRoll["Blitzer's Roll"] = set_combine(sets.precast.CorsairRoll, 
		{
			head="Chass. Tricorne +1"
		})
		
		sets.precast.CorsairRoll["Tactician's Roll"] = set_combine(sets.precast.CorsairRoll,
		{
			body="Chasseur's Frac +1"
		})
		
		sets.midcast.CorsairShot =
		{
			ammo="Living Bullet",
			head=gear.HHead_MAB, neck="Sanctity Necklace", lear="Friomisi Earring", rear="Crematio Earring",
			body="Lanun Frac +3", hands="Carmine Fin. Ga. +1", lring="Dingir Ring", rring="Shiva Ring +1",
			back=gear.CORCape_STP, waist="Eschan Stone", legs="Herculean Trousers", feet="Lanun Bottes +3"
		}
		
		sets.midcast.CorsairShot.Resistant =
		{
			ammo="Living Bullet",
			head="Laksa. Tricorne +2", neck="Sanctity Necklace", lear="Digni. Earring", rear="Gwati Earring",
			body="Malignance Tabard", hands="Malignance Gloves", lring="Metamor. Ring +1", rring="Regal Ring",
			back=gear.CORCape_STP, waist="Eschan Stone", legs="Malignance Tights", feet="Lanun Bottes +3"
			
		}
		
		sets.midcast.CorsairShot.STP =
		{
			ammo="Chrono Bullet",
			head="Malignance Chapeau", neck="Iskur Gorget", lear="Telos Earring", rear="Dedition Earring",
			body="Malignance Tabard", hands="Malignance Gloves", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"},
			back=gear.CORCape_STP, waist="Kentarch Belt +1", legs="Malignance Tights", feet="Malignance Boots"
		}
		
		sets.midcast.CorsairShot['Light Shot'] = sets.midcast.CorsairShot.Resistant
		
		sets.midcast.CorsairShot['Dark Shot'] = sets.midcast.CorsairShot.Resistant
		
		
	-------------------
	-- Precast Magic --
	------------------- 
	
		sets.precast.FC =
		{
			head="Carmine Mask +1", neck="Orunmila's Torque", lear="Etiolation Earring", rear="Loquac. Earring",
			body=gear.TBody_Phalanx, hands="Leyline Gloves", lring="Kishar Ring", rring="Weather. Ring +1",
			back="Moonlight Cape", waist="Flume Belt +1", legs="Rawhide Trousers", feet="Carmine Greaves +1"
		}

		
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
		
		sets.midcast.Utsusemi = sets.precast.FC
	
		sets.midcast.Phalanx = 
		{
			head=gear.THead_Phalanx, neck="Incanter's Torque", lear="Andoaa Earring", rear="Mimir Earring",
			body=gear.TBody_Phalanx, hands=gear.THands_Phalanx, lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back="Moonlight Cape", waist="Olympus Sash", legs=gear.TLegs_Phalanx, feet=gear.TFeet_Phalanx
		}
		
		sets.midcast.Stoneskin =
		{
			head=gear.THead_Phalanx, neck="Stone Gorget", lear="Earthcry Earring", rear="Mimir Earring",
			body=gear.TBody_Phalanx, hands=gear.THands_Phalanx, lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back="Moonlight Cape", waist="Olympus Sash", legs=gear.TLegs_Phalanx, feet=gear.TFeet_Phalanx
		}
		
		sets.midcast.Cures =
		{
			head="Malignance Chapeau", neck="Incanter's Torque", lear="Mendi. Earring", rear="Meili Earring",
			body="Malignance Tabard", hands="Malignance Gloves", lring="Lebeche Ring", rring="Menelaus's Ring",
			back="Moonlight Cape", waist="Bishop's Sash", legs="Malignance Tights", feet="Malignance Boots"
		}
		
		sets.midcast['Elemental Magic'] =
		{
			head=gear.HHead_MAB, neck="Sanctity Necklace", lear="Friomisi Earring", rear="Crematio Earring",
			body="Lanun Frac +3", hands="Carmine Fin. Ga. +1", lring="Shiva Ring +1", rring="Metamor. Ring +1",
			back="Camulus's Mantle", waist="Orpheus's Sash", legs="Herculean Trousers", feet="Adhemar Gamashes +1"
		}
		
		sets.midcast.Macc =
		{
			head="Malignance Chapeau", neck="Sanctity Necklace", lear="Digni. Earring", rear="Gwati Earring",
			body="Malignance Tabard", hands="Malignance Gloves", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back="Moonlight Cape", waist="Flume Belt +1", legs="Malignance Tights", feet="Malignance Boots"
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
	
		sets.Rostam		= { 	main="Rostam"	}
		
		sets.Lanun 		= { 	main={ name="Lanun Knife", augments={'Path: A',}}		}
			
		sets.Tauret 	= { 	main="Tauret" 			}
		
		sets.Naegling 	= { 	main="Naegling" 		}

		sets.Penalty 	= { 	ranged="Death Penalty", ammo="Living Bullet" 	}
		
		sets.Fomalhaut 	= { 	ranged="Fomalhaut", ammo="Chrono Bullet" 		}
		
		sets.Ataktos 	= { 	ranged="Ataktos", ammo="Chrono Bullet"  		}
		
	
	
	
	
	------------------------------------------------------------------------------------------------
	------------------------------------------ Idle Sets -------------------------------------------
	------------------------------------------------------------------------------------------------
		
		sets.idle =
		{
			head="Malignance Chapeau", neck="Warder's Charm +1", lear="Etiolation Earring", rear="Genmei Earring",
			body="Malignance Tabard", hands="Malignance Gloves", lring="Defending Ring", rring="Gelatinous Ring +1",
			back="Moonlight Cape", waist="Carrier's Sash", legs="Carmine Cuisses +1", feet="Malignance Boots"
		}

		sets.idle.Town = set_combine(sets.idle,
		{
			legs="Carmine Cuisses +1"
		})
		
		sets.idle.Adoulin = set_combine(sets.idle,
		{
			body="Councilor's Garb"
		})

		
    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Defense Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------
		
		sets.defense.PDT = 
		{
			head="Malignance Chapeau", neck="Warder's Charm +1", lear="Etiolation Earring", rear="Genmei Earring",
			body="Malignance Tabard", hands="Malignance Gloves", lring="Defending Ring", rring="Gelatinous Ring +1",
			back="Moonlight Cape", waist="Carrier's Sash", legs="Carmine Cuisses +1", feet="Malignance Boots"
		}
		
		sets.defense.MDT = 
		{
			head="Malignance Chapeau", neck="Warder's Charm +1", lear="Etiolation Earring", rear="Genmei Earring",
			body="Malignance Tabard", hands="Malignance Gloves", lring="Defending Ring", rring="Gelatinous Ring +1",
			back="Moonlight Cape", waist="Carrier's Sash", legs="Malignance Tights", feet="Malignance Boots"
		}
		
		sets.Kiting =  { legs="Carmine Cuisses +1" }
		
    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Special Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------
		
		sets.EnmityDown =
		{
			lear="Beyla Earring", rear="Novia Earring",
			lring="Kuchekula Ring", rring="Lebeche Ring"
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
			waist="Chaac Belt", legs="Volte Hose"
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
		{--	Snapshot 60%(+10%)  Rapid Shot 	27%(+30%)
			-- ammo="Chrono Bullet",
			-- head="Chass. Tricorne +1",
			-- body="Oshosi Vest +1", hands="Lanun Gants +3",
			-- back=gear.CORCape_Snap, waist="Impulse Belt", legs="Adhemar Kecks +1", feet="Adhe. Gamashes +1"
			ammo="Chrono Bullet",
			head="Chass. Tricorne +1",
			body="Laksa. Frac +3", hands="Lanun Gants +3",
			back=gear.CORCape_Snap, waist="Yemaya Belt", legs="Adhemar Kecks +1", feet="Adhe. Gamashes +1"
		}
		
		sets.precast.RA.Flurry1 =
		{--	Snapshot 46%(+10%)+Flurry(15%)  	Rapid Shot 	47%(+30%)
			ammo="Chrono Bullet",
			head="Chass. Tricorne +1",
			body="Laksa. Frac +3", hands="Lanun Gants +3",
			back=gear.CORCape_Snap, waist="Impulse Belt", legs="Adhemar Kecks +1", feet="Adhe. Gamashes +1"
		}
		
		sets.precast.RA.Flurry2 =
		{--	Snapshot 38%(+10%)+Flurry(30%)  	Rapid Shot 	62%(+30%)
			ammo="Chrono Bullet",
			head="Chass. Tricorne +1",
			body="Laksa. Frac +3", hands="Lanun Gants +3",
			back=gear.CORCape_Snap, waist="Yemaya Belt", legs="Adhemar Kecks +1", feet="Adhe. Gamashes +1"
		}
		
		sets.midcast.RA =
		{
			ammo="Chrono Bullet",
			head="Malignance Chapeau", neck="Iskur Gorget", lear="Telos Earring", rear="Dedition Earring",
			body="Malignance Tabard",  hands="Malignance Gloves", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"},
			back=gear.CORCape_STP, waist="Yemaya Belt", legs="Malignance Tights", feet="Malignance Boots"
		}
		
		sets.buff.TripleShot =
		{
			head="Oshosi Mask +1",
			body="Chasseur's Frac +1", hands="Lanun Gants +3",
			back=gear.CORCape_STP, legs="Osh. Trousers +1", feet="Oshosi Leggings +1"
		}
		
	-------------------------
	-- Weaponskill Sets
	-------------------------
		sets.precast.WS = 
		{
			head=gear.HHead_WSD, neck="Fotia Gorget", lear="Ishvara Earring", rear="Moonshade Earring",
			body="Laksa. Frac +3", hands="Meg. Gloves +2", lring="Regal Ring", rring="Epaminondas's Ring",
			back=gear.CORCape_SWSD, waist="Fotia Belt", legs="Meg. Chausses +2", feet=gear.HBoots_WSD
		}
		
		--	***Guns***
		sets.precast.WS['Leaden Salute'] =
		 {
			ammo="Living Bullet",
			head="Pixie Hairpin +1", neck="Sanctity Necklace", lear="Friomisi Earring", rear="Moonshade Earring",
			body="Lanun Frac +3", hands="Carmine Fin. Ga. +1", lring="Archon Ring", rring="Epaminondas's Ring", 
			back=gear.CORCape_RWSD, waist="Eschan Stone", legs="Herculean Trousers", feet="Lanun Bottes +3"
		}
		
		sets.precast.WS['Wildfire'] =
		{
			ammo="Living Bullet",
			head=gear.HHead_MAB, neck="Sanctity Necklace", lear="Friomisi Earring", rear="Moonshade Earring",
			body="Lanun Frac +3", hands="Carmine Fin. Ga. +1", lring="Dingir Ring", rring="Epaminondas's Ring",
			back=gear.CORCape_RWSD, waist="Eschan Stone", legs="Herculean Trousers", feet="Lanun Bottes +3"
		}
		
		sets.precast.WS['Detonator'] = 
		{
			ammo="Chrono Bullet",
			head=gear.HHead_WSD, neck="Fotia Gorget", lear="Ishvara Earring", rear="Moonshade Earring",
			body="Laksa. Frac +3", hands="Meg. Gloves +2", lring="Regal Ring", rring="Epaminondas's Ring",
			back=gear.CORCape_RWSD, waist="Fotia Belt", legs="Meg. Chausses +2", feet="Lanun Bottes +3"
		}
		
		sets.precast.WS['Last Stand'] =
		{
			ammo="Chrono Bullet",
			head="Lanun Tricorne +3", neck="Fotia Gorget", lear="Ishvara Earring", rear="Moonshade Earring",
			body="Laksa. Frac +3", hands="Meg. Gloves +2", lring="Regal Ring", rring="Epaminondas's Ring",
			back=gear.CORCape_RWSD, waist="Fotia Belt", legs="Meg. Chausses +2", feet="Lanun Bottes +3"
		}
		
		sets.precast.WS['Slug Shot'] = sets.precast.WS['Last Stand']
		
		sets.precast.WS['Detonator'] = sets.precast.WS['Last Stand']
		
		sets.precast.WS['Numbing Shot'] = sets.precast.WS['Last Stand']
		
		
		--	***Swords***
		sets.precast.WS['Sanguine Blade'] = set_combine(sets.precast.WS['Leaden Salute'],
		{
			lring="Epaminondas's Ring",
			back=gear.CORCape_SWSD,
		})
		
		sets.precast.WS['Seraph Blade'] = set_combine(sets.precast.WS['Wildfire'],
		{
			lring="Weather. Ring +1"
		})
		
		sets.precast.WS['Red Lotus Blade'] = set_combine(sets.precast.WS['Wildfire'],
		{
			lring="Shiva Ring +1"
		})
		
		sets.precast.WS['Vorpal Blade'] = 
		{
			head=gear.AHead_TP, lear="Odr Earring", rear="Brutal Earring",
			body="Adhemar Jacket +1", hands="Adhemar Wrist. +1", lring="Hetairoi Ring", rring="Regal Ring",
			back=gear.CORCape_SWSD, waist="Fotia Belt", legs="Zoar Subligar +1", feet=gear.HBoots_Crit
		}
		
		sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, 
		{
			head=gear.HHead_WSD, neck="Fotia Gorget", lear="Ishvara Earring", rear="Moonshade Earring",
			body="Laksa. Frac +3", hands="Meg. Gloves +2", lring="Regal Ring", rring="Epaminondas's Ring",
			back=gear.CORCape_SWSD, waist="Sailfi Belt +1", legs="Meg. Chausses +2", feet=gear.HBoots_WSD
		})
		
		sets.precast.WS['Swift Blade'] = sets.precast.WS['Savage Blade']
		
		sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, 
		{
			head="Adhemar Bonnet +1", lear="Moonshade Earring", rear="Brutal Earring",
			body="Adhemar Jacket +1", lring="Metamor. Ring +1", rring="Epona's Ring", 
			legs="Meg. Chausses +2", feet="Carmine Greaves +1"
		})
			
			
		
		--	***Daggers***	
		sets.precast.WS['Evisceration'] =
		{
			head=gear.AHead_TP, neck="Fotia Gorget", lear="Odr Earring", rear={name="Mache Earring +1", bag="wardrobe3"},
			body="Adhemar Jacket +1", hands="Adhemar Wrist. +1", lring="Ilabrat Ring", rring="Regal Ring",
			back=gear.CORCape_SWSD, waist="Fotia Belt", legs="Zoar Subligar +1", feet=gear.HBoots_Crit
		}
		
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
			head="Dampening Tam", neck="Iskur Gorget", lear="Telos Earring", rear="Brutal Earring",
			body="Malignance Tabard", hands="Adhemar Wrist. +1", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring="Epona's Ring",
			back=gear.CORCape_DA, waist="Windbuffet Belt +1", legs="Samnuha Tights", feet="Malignance Boots"
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
			head="Dampening Tam", neck="Iskur Gorget", lear="Eabani Earring", rear="Suppanomimi",
			body="Adhemar Jacket +1", hands="Floral Gauntlets", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring="Epona's Ring",
			back=gear.CORCape_DA, waist="Reiki Yotai", legs="Carmine Cuisses +1", feet=gear.TFeet_TP
		}
		-----------------------------------------------------------------------------------
		---	TP/h:63		(DW:36	STP:29		QA:0%	TA:4%	DA:7%)
		---	Primary Accuracy: 1130 		/ Primary Attack: 1017
		--- Auxiliary Accuracy: 1106 	/ Auxiliary Attack: 937
		-----------------------------------------------------------		
		sets.engaged.DW2.Low = set_combine(sets.engaged.DW2,
		{
			head="Blistering Sallet +1", neck="Combatant's Torque"
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
			hands="Gazu Bracelet +1",
			feet="Malignance Boots"
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
			head="Dampening Tam", neck="Iskur Gorget", lear="Eabani Earring", rear="Suppanomimi",
			body="Adhemar Jacket +1", hands="Floral Gauntlets", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring="Epona's Ring",
			back=gear.CORCape_DA, waist="Reiki Yotai", legs="Carmine Cuisses +1", feet=gear.TFeet_TP
		}
		-----------------------------------------------------------------------------------
		---	TP/h:58		(DW:36	STP:29		QA:0%	TA:4%	DA:7%)
		---	Primary Accuracy: 1153		/ Primary Attack: 1024
		--- Auxiliary Accuracy: 1129 	/ Auxiliary Attack: 942
		-----------------------------------------------------------	
		sets.engaged.DW3.Low = set_combine(sets.engaged.DW3,
		{
			head="Blistering Sallet +1", neck="Combatant's Torque"
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
			hands="Gazu Bracelet +1",
			feet="Malignance Boots"
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
			head="Dampening Tam", neck="Iskur Gorget", lear="Eabani Earring", rear="Suppanomimi",
			body="Adhemar Jacket +1", hands="Floral Gauntlets", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring="Epona's Ring",
			back=gear.CORCape_DA, waist="Reiki Yotai", legs="Samnuha Tights", feet=gear.TFeet_TP
		}
		
		-----------------------------------------------------------------------------------
		---	TP/h:65		(DW:32	STP:39		QA:0%	TA:2%	DA:13%)
		---	Primary Accuracy: 1160 		/ Primary Attack: 1018
		--- Auxiliary Accuracy: 1136 	/ Auxiliary Attack: 932
		-----------------------------------------------------------		
		sets.engaged.DW3.Low.Med = set_combine(sets.engaged.DW3.Med,
		{
			head="Malignance Chapeau",
			legs="Malignance Tights"
		})
		
		-----------------------------------------------------------------------------------
		---	TP/h:62		(DW:33	STP:34		QA:0%	TA:2%	DA:12%)
		---	Primary Accuracy: 1169 		/ Primary Attack: 1016
		--- Auxiliary Accuracy: 1145	/ Auxiliary Attack: 930
		-----------------------------------------------------------	
		sets.engaged.DW3.Mid.Med = 
		{
			head="Carmine Mask +1", neck="Combatant's Torque", lear="Eabani Earring", rear="Suppanomimi",
			body="Adhemar Jacket +1", hands="Malignance Gloves", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"},
			back=gear.CORCape_DA, waist="Reiki Yotai", legs="Carmine Cuisses +1", feet=gear.TFeet_TP
		}
		
		-----------------------------------------------------------------------------------
		---	TP/h:70		(DW:21	STP:35		QA:0%	TA:0%	DA:11%)
		---	Primary Accuracy: 1198 		/ Primary Attack: 1002
		--- Auxiliary Accuracy: 1174 	/ Auxiliary Attack: 918
		-----------------------------------------------------------	
		sets.engaged.DW3.High.Med = 
		{
			head="Carmine Mask +1", neck="Combatant's Torque", lear="Eabani Earring", rear="Suppanomimi",
			body="Adhemar Jacket +1", hands="Gazu Bracelet +1", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"},
			back=gear.CORCape_DA, waist="Reiki Yotai", legs="Carmine Cuisses +1", feet="Malignance Boots"
		}
	
	
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
			back=gear.CORCape_DA, waist="Reiki Yotai", legs="Samnuha Tights", feet=gear.HBoots_TP
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
		sets.engaged.DW2.Mid.Max = 
		{
			head="Malignance Chapeau", neck="Combatant's Torque", lear="Telos Earring", rear="Suppanomimi",
			body="Adhemar Jacket +1", hands="Malignance Gloves", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"},
			back=gear.CORCape_DA, waist="Reiki Yotai", legs="Carmine Cuisses +1", feet="Malignance Boots"
		}
		
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
			head="Dampening Tam", neck="Iskur Gorget", lear="Telos Earring", rear="Dedition Earring",
			body="Adhemar Jacket +1", hands="Adhemar Wrist. +1", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring="Epona's Ring",
			back=gear.CORCape_DA, waist="Reiki Yotai", legs="Samnuha Tights", feet=gear.HBoots_TP
		}
		
		-----------------------------------------------------------------------------------
		---	TP/h:78		(DW:10	STP:40		QA:2%	TA:8%	DA:18%)
		---	Primary Accuracy: 1121 		/ Primary Attack: 945
		--- Auxiliary Accuracy: 1096 	/ Auxiliary Attack: 859
		-----------------------------------------------------------	
		sets.engaged.DW3.Low.Max = 
		{
			head="Dampening Tam", neck="Combatant's Torque", lear="Telos Earring", rear="Suppanomimi",
			body="Adhemar Jacket +1", hands="Adhemar Wrist. +1", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"},
			back="Camulus's Mantle", waist="Windbuffet Belt +1", legs="Malignance Tights", feet="Malignance Boots"
		}
		
		-----------------------------------------------------------------------------------
		---	TP/h:78		(DW:10	STP:40		QA:2%	TA:6%	DA:14%)
		---	Primary Accuracy: 1138 		/ Primary Attack: 951
		--- Auxiliary Accuracy: 1113 	/ Auxiliary Attack: 867
		-----------------------------------------------------------	
		sets.engaged.DW3.Mid.Max = 
		{
			head="Malignance Chapeau", neck="Combatant's Torque", lear="Telos Earring", rear={name="Mache Earring +1", bag="wardrobe3"},
			body="Adhemar Jacket +1", hands="Malignance Gloves", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"},
			back=gear.CORCape_DA, waist="Reiki Yotai", legs="Malignance Tights", feet="Malignance Boots"
		}
		
		-----------------------------------------------------------------------------------
		---	TP/h:78~	(DW:10	STP:34~38	QA:0%	TA:4%	DA:14%)
		---	Primary Accuracy: 1181 		/ Primary Attack: 953
		--- Auxiliary Accuracy: 1156 	/ Auxiliary Attack: 868
		-----------------------------------------------------------	
		sets.engaged.DW3.High.Max = 
		{
			head="Carmine Mask +1", neck="Combatant's Torque", lear={name="Mache Earring +1", bag="wardrobe2"}, rear={name="Mache Earring +1", bag="wardrobe3"},
			body="Adhemar Jacket +1", hands="Gazu Bracelet +1", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"},
			back=gear.CORCape_DA, waist="Kentarch Belt +1", legs="Carmine Cuisses +1", feet="Malignance Boots"
		}
	
	
	
	
	
	------------------------------------------------------------------------------------------------
    ---------------------------------------- Hybrid Sets -------------------------------------------
    ------------------------------------------------------------------------------------------------
		
		
		sets.engaged.Hybrid = 
		{
			head="Malignance Chapeau",
			body="Malignance Tabard", hands="Malignance Gloves",
			legs="Malignance Tights", feet="Malignance Boots"
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
		
		
		sets.engaged.DW3.DT.Med 	 = set_combine(sets.engaged.DW3.Med, 		sets.engaged.Hybrid,
		{
			hands="Floral Gauntlets"
		})
		sets.engaged.DW3.Low.DT.Med  = set_combine(sets.engaged.DW3.Low.Med, 	sets.engaged.Hybrid,
		{
			body="Malignance Tabard"
		})
		sets.engaged.DW3.Mid.DT.Med  = set_combine(sets.engaged.DW3.Mid.Med, 	sets.engaged.Hybrid)
		sets.engaged.DW3.High.DT.Med = set_combine(sets.engaged.DW3.High.Min, 	sets.engaged.Hybrid)
		
		----------------------------------------------------------
		-- Maximum Haste
		----------------------------------------------------------		
		sets.engaged.DW2.DT.Max 	 = set_combine(sets.engaged.DW2.Max, 		sets.engaged.Hybrid)
		sets.engaged.DW2.Low.DT.Max  = set_combine(sets.engaged.DW2.Low.Max, 	sets.engaged.Hybrid)
		sets.engaged.DW2.Mid.DT.Max  = set_combine(sets.engaged.DW2.Mid.Max, 	sets.engaged.Hybrid)
		sets.engaged.DW2.High.DT.Max = set_combine(sets.engaged.DW2.High.Max, 	sets.engaged.Hybrid)
		
		
		sets.engaged.DW3.DT.Max 	 = set_combine(sets.engaged.DW3.Max, 		sets.engaged.Hybrid,
		{
			lear="Telos Earring", rear="Eabani Earring",
			waist="Reiki Yotai"
		})
		sets.engaged.DW3.Low.DT.Max  = set_combine(sets.engaged.DW3.Low.Max, 	sets.engaged.Hybrid,
		{
			lear="Telos Earring", rear="Eabani Earring",
			waist="Reiki Yotai"
		})
		sets.engaged.DW3.Mid.DT.Max  = set_combine(sets.engaged.DW3.Mid.Max, 	sets.engaged.Hybrid,
		{
			lear="Telos Earring", rear="Eabani Earring",
			waist="Reiki Yotai"
		})
		sets.engaged.DW3.High.DT.Max = set_combine(sets.engaged.DW3.High.Max, 	sets.engaged.Hybrid,
		{
			lear="Telos Earring", rear="Eabani Earring",
			waist="Reiki Yotai"
		})
	
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
function job_post_precast(spell, action, spellMap, eventArgs)
    if state.EnmityDown.value and spell.type == 'WeaponSkill' then
		equip(sets.EnmityDown)
	end
	
	-- Gear
    if (spell.type == 'CorsairRoll' or spell.english == "Double-Up") and state.Luzaf.value then
            equip{ rring="Luzaf's Ring" }
	end
	
	if spell.action_type == 'Ranged Attack' then
        if flurry == 2 then
            equip(sets.precast.RA.Flurry2)
        elseif flurry == 1 then
            equip(sets.precast.RA.Flurry1)
        end
	end

	-- Handles equipment modifications based of distance and spell weather/day alignment.
    if spell.type == 'WeaponSkill' and magical_ws:contains(spell.name) then
		-- If the spell element does not match either the weather or the day and there is less than 15 yalms between the caster and the target
		if spell.element ~= world.day_element and spell.element ~= world.weather_element then
			if spell.target.distance < (15 - spell.target.model_size) then
				equip { waist="Orpheus's Sash" }
			end
		-- If the element of a spell matches both the day and weather with a net intensity of at least 2
		elseif (spell.element == world.day_element and spell.element == world.weather_element)
				or (spell.element == world.weather_element and get_weather_intensity() == 2 and world.day_element ~= elements.strong_to[spell.element]) then
			equip { waist="Hachirin-no-Obi" }
		-- If the element of a non-helix spell matches either day or weather with a net intensity of 1.	
		elseif (spell.element == world.day_element or (spell.element == world.weather_element and get_weather_intensity() == 1)
				or (spell.element == world.weather_element and get_weather_intensity() == 2 and world.day_element == elements.strong_to[spell.element])) then
			if (spell.target.distance < (7 - spell.target.model_size)) then
				equip { waist="Orpheus's Sash" }
			else
				equip { waist="Hachirin-no-Obi" }
			end
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
	
	if state.TreasureMode.value ~= 'None' and spell.action_type == 'Ranged Attack' then
		equip(sets.TreasureHunter)
	elseif spell.action_type == 'Magic' and spell.target.type == 'MONSTER' and state.TreasureMode.value ~= 'None' then
		equip(sets.TreasureHunter)
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
	equip(sets[state.MainWeaponSet.current])
	equip(sets[state.RangeWeaponSet.current])
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
    equip(sets[state.MainWeaponSet.current])
	equip(sets[state.RangeWeaponSet.current])
	
	determine_haste_group()
	
	th_update(cmdParams, eventArgs)
	update_combat_form()
	handle_equipping_gear(player.status)
end

function customize_idle_set(idleSet)
	idleSet = set_combine(idleSet, sets[state.MainWeaponSet.current], sets[state.RangeWeaponSet.current])
	
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
			})
		end
	end

	return idleSet
end

-------------------------------------------------------------------------------------------------------------------
-- User self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called for custom player commands.
function job_self_command(cmdParams, eventArgs)
	if cmdParams[1] == 'qdraw' then
		 send_command('@input /ja "'..state.QDraw.current..'" <stnpc>')		 		 
	end
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
				buffactive[581] = Flurry
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
	
	-- if buffactive[581] then
		-- sets.precast.RA.Flurry1
	-- end
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
    local msg = '[' .. state.MainWeaponSet.value .. '|    |' .. state.RangeWeaponSet.value .. ']'

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
    local rollsize = (state.Luzaf.value and 'Large') or 'Small'

    if rollinfo then
        add_to_chat(104, '[ Lucky: '..tostring(rollinfo.lucky)..' / Unlucky: '..tostring(rollinfo.unlucky)..' ] '..spell.english..': '..rollinfo.bonus..' ('..rollsize..') ')
    end
end



-- Select default macro book on initial load or subjob change.
function apply_job_change()
    set_macro_page(1, 17)
	
	send_command('wait 3; input /lockstyleset 17')
end