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
	include('Mote-TreasureHunter')

    determine_haste_group()
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Low', 'Mid', 'High')
    state.WeaponskillMode:options('Normal', 'Low', 'Mid', 'High')
	state.HybridMode:options('Normal', 'DT')
    state.CastingMode:options('Normal','Enmity','SIRD')
    state.IdleMode:options('Normal', 'DT')
	
	state.MainStep = M{['description']='Main Step', 'Box Step', 'Quickstep','Stutter Step'}
	state.Runes = M{['description']='Runes', 'Ignis', 'Gelus', 'Flabra', 'Tellus', 'Sulpor', 'Unda', 'Lux', 'Tenebrae'}
	
	
	state.MainWeaponSet = M{['description']='Main Weapon Set',
		'Heishi',
		'Tauret',
		'Naegling'
	}
	
	state.SubWeaponSet = M{['description']='Sub Weapon Set',
		'Fudo',
		'Ternion',
		'Gokotai',
		'Hitaki'
	}	
	
    gear.DayFeet = "Danzo Sune-ate"
    gear.NightFeet = "Hachi. Kyahan +1"
	
	
	send_command('bind ^` gs c cycle treasuremode')

	send_command('bind pageup gs c cycle MainWeaponSet')
	send_command('bind pagedown gs c cycleback MainWeaponSet')
	
	send_command('bind ^pageup gs c cycle SubWeaponSet')
	send_command('bind ^pagedown gs c cycleback SubWeaponSet')

	
	if player.sub_job == 'DNC' then
		send_command('bind ^= gs c cycle mainstep')
	elseif player.sub_job == 'RUN' then
		send_command('bind ^= gs c cycle Runes')
		send_command('bind ^- gs c cycleback Runes')
	end
	
    apply_job_change()
end

function user_unload()
	send_command('unbind ^`')
	send_command('unbind pageup')
	send_command('unbind pagedown')
	send_command('unbind ^pageup')
	send_command('unbind ^pagedown')
		
	if player.sub_job == 'DNC' then
		send_command('unbind ^= gs')
	elseif player.sub_job == 'RUN' then
		send_command('unbind ^=')
		send_command('unbind ^-')
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

	--------------------------------------
	-- Special Sets
	--------------------------------------
	

		sets.Enmity =
		{--Enmity + 95	PDT: -29%
			ammo="Date Shuriken",
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
		
		sets.TreasureHunter = 
		{ 
			head=gear.HHead_TH, 
			hands="Volte Bracers",
			waist="Chaac Belt"
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
			head=gear.HHead_TH, neck="Orunmila's Torque", lear="Etiolation Earring", rear="Loquac. Earring",
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
		
		sets.midcast.FC.SIRD = 
		{
			ammo="Staunch Tathlum +1",
			head=gear.THead_Phalanx, neck="Moonlight Necklace", lear="Genmei Earring", rear="Tuisto Earring",
			body=gear.TBody_Phalanx, hands="Rawhide Gloves", lring="Defending Ring", rring="Gelatinous Ring +1",
			back=gear.NINCape_FC, waist="Audumbla Sash", legs=gear.TLegs_Phalanx, feet=gear.TFeet_Phalanx
		}

		
		sets.midcast['Enhancing Magic'] = 
		{
			neck="Incanter's Torque", lear="Andoaa Earring", rear="Mimir Earring",
			lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back=gear.NINCape_FC, waist="Olympus Sash",
		}
		
		sets.midcast['Ninjutsu'] =
		{
			hands="Mochizuki Tekko +1"
		}
		
		sets.midcast.Utsusemi =
		{
			head=gear.HHead_WSD,
			hands="Mochizuki Tekko +1",
			back=gear.NINCape_FC, feet="Hattori Kyahan +1"
		}
		
		sets.midcast['Migawari: Ichi'] =
		{
			head="Hachiya Hatsu. +3", neck="Incanter's Torque",
			hands="Mochizuki Tekko +1", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back=gear.NINCape_FC, feet="Mochi. Kyahan +3"
		}
	
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
			back=gear.NINCape_FC, waist="Audumbla Sash", legs="Malignance Tights", feet="Malignance Boots"
		}

		sets.midcast.Genjutsu =
		{
			neck="Moonlight Necklace",
			hands="Mochizuki Tekko +1",
			feet="Mochi. Kyahan +3"
		}
		
		sets.midcast['Enfeebling Magic'] = sets.midcast.Macc
		
		sets.midcast['Dark Magic'] = sets.midcast.Macc
		
		sets.midcast.Stun = sets.midcast.Macc
		
		sets.midcast.Wheel =
		{
			ammo="Ghastly Tathlum +1",
			head="Mochi. Hatsuburi +3", neck="Sanctity Necklace", lear="Friomisi Earring", rear="Crematio Earring",
			body="Gyve Doublet", hands="Leyline Gloves", lring="Dingir Ring", rring="Metamor. Ring +1",
			back=gear.NINCape_Nuke, waist="Orpheus's Sash", legs="Gyve Trousers", feet="Mochi. Kyahan +3"
		}

		sets.midcast['Elemental Magic'] =
		{
			ammo="Ghastly Tathlum +1",
			head="Mochi. Hatsuburi +3", neck="Sanctity Necklace", lear="Friomisi Earring", rear="Crematio Earring",
			body="Gyve Doublet", hands="Leyline Gloves", lring="Dingir Ring", rring="Metamor. Ring +1",
			back=gear.NINCape_Nuke, waist="Orpheus's Sash", legs="Gyve Trousers", feet="Adhemar Gamashes +1"
		}
		
		sets.magic_burst =
		{
			ammo="Ghastly Tathlum +1",
			head="Mochi. Hatsuburi +3", neck="Warder's Charm +1", lear="Friomisi Earring", rear="Static Earring",
			body="Samnuha Coat", hands=gear.HHands_Burst, lring="Locus Ring", rring="Mujin Band",
			back=gear.NINCape_Nuke, waist="Orpheus's Sash", legs="Gyve Trousers", feet="Mochi. Kyahan +3"
		}

	
	
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
	
		sets.Heishi 	= { 	main="Heishi Shorinken" 		}
			
		sets.Tauret 	= { 	main="Tauret" 		}
		
		sets.Naegling 	= { 	main="Naegling" 		}
	
		sets.Fudo 		= { 	sub="Fudo Masamune" 		}
		
		sets.Ternion 	= { 	sub="Ternion Dagger +1" 	}
		
		sets.Gokotai 	= { 	sub="Gokotai" 		}
		
		sets.Hitaki 	= { 	sub="Hitaki" 		}
		
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
			head="Hachiya Hatsu. +3", neck="Fotia Gorget", lear="Ishvara Earring", rear="Moonshade Earring",
			body="Herculean Vest", hands="Adhemar Wrist. +1", lring="Epaminondas's Ring", rring="Regal Ring",
			back="Sacro Mantle", waist="Fotia Belt", legs="Mochi. Hakama +3", feet=gear.HBoots_WSD
		}
		
	--	***Katana***
	--------Blade: Physical	
	--Blade Shun
		sets.precast.WS['Blade: Shun'] =
		{
			ammo="Cath Palug Stone",
			head="Ken. Jinpachi +1", neck="Fotia Gorget", lear={name="Mache Earring +1", bag="wardrobe2"}, rear={name="Mache Earring +1", bag="wardrobe3"},
			body="Adhemar Jacket +1",hands="Ken. Tekko +1", lring="Ilabrat Ring", rring="Regal Ring",
			back="Sacro Mantle", waist="Fotia Belt", legs="Jokushu Haidate", feet="Ken. Sune-Ate +1"
		}
	
	--Blade: Hi
		sets.precast.WS['Blade: Hi'] =
		{
			ammo="Yetshila +1",
			head="Hachiya Hatsu. +3", neck="Ninja Nodowa +2", lear="Odr Earring", rear="Ishvara Earring",
			body="Ken. Samue +1", hands="Adhemar Wrist. +1", lring="Epaminondas's Ring", rring="Regal Ring",
			back="Sacro Mantle", waist="Fotia Belt", legs="Mochi. Hakama +3", feet=gear.HBoots_WSD
		}
		
		sets.precast.WS['Blade: Rin'] = sets.precast.WS['Blade: Hi']

	--Blade: Ten
		sets.precast.WS['Blade: Ten'] =
		{
			ammo="Aurgelmir Orb +1",
			head="Hachiya Hatsu. +3", neck="Fotia Gorget", lear="Ishvara Earring", rear="Moonshade Earring",
			body="Herculean Vest", hands="Adhemar Wrist. +1", lring="Epaminondas's Ring", rring="Regal Ring",
			back="Sacro Mantle", waist="Sailfi Belt +1", legs="Mochi. Hakama +3", feet=gear.HBoots_WSD
		}
		
	--Blade: Kamu
		sets.precast.WS['Blade: Kamu'] =
		{
			ammo="Aurgelmir Orb +1",
			head=gear.HHead_WSD, neck="Fotia Gorget", lear="Brutal Earring", rear="Ishvara Earring",
			body="Herculean Vest", hands="Adhemar Wrist. +1", lring="Epaminondas's Ring", rring="Regal Ring",
			back="Sacro Mantle", waist="Sailfi Belt +1", legs="Mochi. Hakama +3", feet=gear.HBoots_WSD
		}

	--Blade: Jin
		sets.precast.WS['Blade: Jin'] = 
		{
			ammo="Yetshila +1",
			head=gear.AHead_TP, neck="Fotia Gorget", lear="Odr Earring", rear={name="Mache Earring +1", bag="wardrobe3"},
			body="Ken. Samue +1", hands="Ken. Tekko +1", lring="Ilabrat Ring", rring="Regal Ring",
			back="Sacro Mantle", waist="Fotia Belt", legs="Jokushu Haidate", feet=gear.HBoots_Crit
		}
		
	--Blade: Ku
		sets.precast.WS['Blade: Ku'] =
		{
			ammo="Aurgelmir Orb +1",
			head="Blistering Sallet +1", neck="Fotia Gorget", lear={name="Mache Earring +1", bag="wardrobe2"}, rear={name="Mache Earring +1", bag="wardrobe3"},
			body="Adhemar Jacket +1", hands="Adhemar Wrist. +1", lring="Ilabrat Ring", rring="Regal Ring",
			back="Sacro Mantle", waist="Fotia Belt", legs="Mochi. Hakama +3", feet=gear.HBoots_TP
		}
		
	--------Blade: Hybrid
	-- Blade: Teki
		sets.precast.WS['Blade: Teki'] =
		{
			ammo="Seeth. Bomblet +1",
			head="Mochi. Hatsuburi +3", neck="Sanctity Necklace", lear="Friomisi Earring", rear="Moonshade Earring",
			body="Samnuha Coat", hands=gear.HHands_MWS, lring="Epaminondas's Ring", rring="Dingir Ring",
			back=gear.NINCape_Nuke, waist="Orpheus's Sash", legs="Mochi. Hakama +3", feet="Adhe. Gamashes +1"
		}
		
	-- Blade: To
		sets.precast.WS['Blade: To'] = 
		{
			ammo="Seeth. Bomblet +1",
			head="Mochi. Hatsuburi +3", neck="Sanctity Necklace", lear="Friomisi Earring", rear="Moonshade Earring",
			body="Samnuha Coat", hands=gear.HHands_MWS, lring="Epaminondas's Ring", rring="Dingir Ring",
			back=gear.NINCape_Nuke, waist="Orpheus's Sash", legs="Mochi. Hakama +3", feet="Adhe. Gamashes +1"
		}
		
		
	-- Blade: Chi
		sets.precast.WS['Blade: Chi'] = 
		{
			ammo="Seeth. Bomblet +1",
			head="Mochi. Hatsuburi +3", neck="Fotia Gorget", lear="Friomisi Earring", rear="Moonshade Earring",
			body="Gyve Doublet", hands=gear.HHands_MWS, lring="Epaminondas's Ring", rring="Gere Ring",
			back=gear.NINCape_Nuke, waist="Orpheus's Sash", legs="Mochi. Hakama +3", feet="Adhe. Gamashes +1"
		}
		
		
		
	--------Blade: Magical
	--Blade: Yu
		sets.precast.WS['Blade: Yu'] =
		{
			ammo="Seeth. Bomblet +1",
			head="Mochi. Hatsuburi +3", neck="Sanctity Necklace", lear="Friomisi Earring", rear="Crematio Earring",
			body="Gyve Doublet", hands=gear.HHands_MWS, lring="Dingir Ring", rring="Epaminondas's Ring",
			back=gear.NINCape_Nuke, waist="Orpheus's Sash", legs="Gyve Trousers", feet="Adhe. Gamashes +1"
		}

		sets.precast.WS['Blade: Ei'] = set_combine(sets.precast.WS['Blade: Yu'],
		{
			head="Pixie Hairpin +1",
			lring="Archon Ring"
		})
		
		
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
			ammo="Date Shuriken",
			head="Ryuo Somen +1", neck="Ninja Nodowa +2", lear="Eabani Earring", rear="Suppanomimi",
			body="Mochi. Chainmail +3", hands="Adhemar Wrist. +1", lring="Epona's Ring", rring="Gere Ring",
			back=gear.NINCape_STP, waist="Reiki Yotai", legs="Hachiya Hakama +3", feet=gear.HBoots_TP
		}

		sets.engaged.Low = set_combine(sets.engaged,
		{
			ammo="Date Shuriken",
			head="Blistering Sallet +1", neck="Ninja Nodowa +2", lear="Eabani Earring", rear="Suppanomimi",
			body="Adhemar Jacket +1", hands="Adhemar Wrist. +1", lring="Epona's Ring", rring="Gere Ring",
			back=gear.NINCape_STP, waist="Reiki Yotai", legs="Mochi. Hakama +3", feet="Hiza. Sune-Ate +2"
		})

		sets.engaged.Mid = set_combine(sets.engaged.Low,
		{
			lear={name="Mache Earring +1", bag="wardrobe2"},
			body="Mochi. Chainmail +3", hands="Malignance Gloves", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"}
		})

		sets.engaged.High = set_combine(sets.engaged.Mid,
		{
			lear={name="Mache Earring +1", bag="wardrobe2"}, rear={name="Mache Earring +1", bag="wardrobe3"},
			feet="Malignance Boots"
		})
	
	
	
	----------------------------------------------------------
	--					(DW5 + 15% Haste)
	----------------------------------------------------------

	--30 DW = 32 DW needed		
	
	----------------------------------------------------------	
	
		sets.engaged.Min =
		{
			ammo="Date Shuriken",
			head="Ryuo Somen +1", neck="Ninja Nodowa +2", lear="Brutal Earring", rear="Telos Earring",
			body="Adhemar Jacket +1", hands="Adhemar Wrist. +1", lring="Epona's Ring", rring="Gere Ring",
			back=gear.NINCape_STP, waist="Reiki Yotai", legs="Mochi. Hakama +3", feet=gear.HBoots_TP
		}

		sets.engaged.Low.Min =
		{
			ammo="Date Shuriken",
			head="Blistering Sallet +1", neck="Ninja Nodowa +2", lear="Eabani Earring", rear="Suppanomimi",
			body="Adhemar Jacket +1", hands="Adhemar Wrist. +1", lring="Epona's Ring", rring="Gere Ring",
			back=gear.NINCape_STP, waist="Reiki Yotai", legs="Mochi. Hakama +3", feet="Ken. Sune-Ate +1"
		}

		sets.engaged.Mid.Min = set_combine(sets.engaged.Low.Min,
		{
			lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"}
		})

		sets.engaged.High.Min = set_combine(sets.engaged.Mid.Min,
		{
			lear={name="Mache Earring +1", bag="wardrobe2"}, rear={name="Mache Earring +1", bag="wardrobe3"},
			feet="Hiza. Sune-Ate +2"
		})

	
	----------------------------------------------------------
	--					(DW5 + 30% Haste)
	----------------------------------------------------------

	--30 DW = 21 DW needed		
	
	----------------------------------------------------------	
	
		sets.engaged.Med =
		{
			ammo="Date Shuriken",
			head="Ryuo Somen +1", neck="Ninja Nodowa +2", lear="Dedition Earring", rear="Suppanomimi",
			body="Ken. Samue +1", hands="Adhemar Wrist. +1", lring="Epona's Ring", rring="Gere Ring",
			back=gear.NINCape_STP, waist="Reiki Yotai", legs="Ken. Hakama +1", feet="Ken. Sune-Ate +1"
		}

		sets.engaged.Low.Med =
		{
			ammo="Date Shuriken",
			head="Blistering Sallet +1", neck="Ninja Nodowa +2", lear="Eabani Earring", rear="Telos Earring",
			body="Ken. Samue +1", hands="Adhemar Wrist. +1", lring="Epona's Ring", rring="Gere Ring",
			back=gear.NINCape_STP, waist="Reiki Yotai", legs="Mochi. Hakama +3", feet="Ken. Sune-Ate +1"
		}

		sets.engaged.Mid.Med =
		{
			ammo="Date Shuriken",
			head="Blistering Sallet +1", neck="Ninja Nodowa +2", lear="Eabani Earring", rear={name="Mache Earring +1", bag="wardrobe3"},
			body="Ken. Samue +1", hands="Adhemar Wrist. +1", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring="Gere Ring",
			back=gear.NINCape_STP, waist="Reiki Yotai", legs="Mochi. Hakama +3", feet="Ken. Sune-Ate +1"
		}

		sets.engaged.High.Med =
		{
			ammo="Date Shuriken",
			head="Ken. Jinpachi +1", neck="Ninja Nodowa +2", lear={name="Mache Earring +1", bag="wardrobe2"}, rear={name="Mache Earring +1", bag="wardrobe3"},
			body="Adhemar Jacket +1", hands="Adhemar Wrist. +1", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"},
			back=gear.NINCape_STP, waist="Reiki Yotai", legs="Ken. Hakama +1", feet="Hiza. Sune-Ate +2"
		}

	
	
	----------------------------------------------------------
	--					(DW5 + Max Haste)
	----------------------------------------------------------

	--30 DW = 1 DW needed
	
	----------------------------------------------------------
	
		sets.engaged.Max =
		{
			ammo="Date Shuriken",
			head="Ken. Jinpachi +1", neck="Ninja Nodowa +2", lear="Dedition Earring", rear="Telos Earring",
			body="Ken. Samue +1", hands="Adhemar Wrist. +1", lring="Epona's Ring", rring="Gere Ring",
			back=gear.NINCape_STP, waist="Sailfi Belt +1", legs="Samnuha Tights", feet="Ken. Sune-Ate +1"
		}

		sets.engaged.Low.Max = 
		{
			ammo="Date Shuriken",
			head="Ken. Jinpachi +1", neck="Ninja Nodowa +2", lear="Brutal Earring", rear="Telos Earring",
			body="Ken. Samue +1", hands="Adhemar Wrist. +1", lring="Epona's Ring", rring="Gere Ring",
			back=gear.NINCape_STP, waist="Windbuffet Belt +1", legs="Ken. Hakama +1", feet="Ken. Sune-Ate +1"
		}

		sets.engaged.Mid.Max = 
		{
			ammo="Date Shuriken",
			head="Blistering Sallet +1", neck="Ninja Nodowa +2", lear={name="Mache Earring +1", bag="wardrobe2"}, rear={name="Mache Earring +1", bag="wardrobe3"},
			body="Ken. Samue +1", hands="Adhemar Wrist. +1", lring="Epona's Ring", rring="Gere Ring",
			back=gear.NINCape_STP, waist="Kentarch Belt +1", legs="Ken. Hakama +1", feet="Ken. Sune-Ate +1"
		}

		sets.engaged.High.Max =
		{
			ammo="Date Shuriken",
			head="Ken. Jinpachi +1", neck="Ninja Nodowa +2", lear={name="Mache Earring +1", bag="wardrobe2"}, rear={name="Mache Earring +1", bag="wardrobe3"},
			body="Malignance Tabard", hands="Adhemar Wrist. +1",  lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"},
			back=gear.NINCape_STP, waist="Kentarch Belt +1", legs="Ken. Hakama +1", feet="Ken. Sune-Ate +1"
		}


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
	
	if spell.action_type == 'Magic' then
		equip(sets.precast.FC)
		equip(sets.precast.FC['currentSpell'])
	elseif spell.action_type == 'Ability' and spellMap ~= 'Rune' then
		equip(sets.Enmity)
		equip(sets.precast.JA[currentSpell])
	end
	
	if spell.action_type == 'Ability' and spellMap ~= 'Rune' then
		equip(sets.Enmity)
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
	
	if spell.english == 'Provoke' and state.TreasureMode.value ~= 'None' then
		equip(sets.TreasureHunter)
	end
end

function job_midcast(spell, action, spellMap, eventArgs)
	currentSpell = spell.english
	
	if spell.action_type == 'Magic' then
		if state.CastingMode.value == 'Enmity' then
			if spell.English == 'Flash' or spell.English == 'Foil' or spell.English == 'Stun' or spell.English == 'Poisonga' or spell.English == 'Banishga' or spell.skill == 'Blue Magic' then
				equip(sets.Enmity)
			elseif spellMap == 'Utsusemi' then
				equip(sets.Enmity)
				equip(sets.midcast['currentSpell'])
			else
				equip(sets.midcast.FC)
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

	if (spell.skill == 'Elemental Magic' or spellMap == 'Wheel') and state.MagicBurst.value then
		equip(sets.magic_burst)
	end
	
	if spellMap == 'Wheel' and buffactive['Futae'] then
		equip { hands="Hattori Tekko +1" }
	end
	
	if (spell.skill == 'Elemental Magic' or spellMap == 'Wheel') and (spell.element ~= world.day_element and spell.element ~= world.weather_element) then
		if spell.target.distance < (15 - spell.target.model_size) then
			equip { waist="Orpheus's Sash" }
		end
	elseif (spell.skill == 'Elemental Magic' or spellMap == 'Wheel') and (spell.element == world.day_element and spell.element == world.weather_element)
			or (spell.element == world.weather_element and get_weather_intensity() == 2 and world.day_element ~= elements.strong_to[spell.element]) then
		if spellMap ~= 'Helix' then
			equip { waist="Hachirin-no-Obi" }
		elseif spell.target.distance < (15 - spell.target.model_size) then
			equip { waist="Orpheus's Sash" }
		end
	elseif (spell.skill == 'Elemental Magic' or spellMap == 'Wheel') and (spell.element == world.day_element or (spell.element == world.weather_element and get_weather_intensity() == 1)
		or (spell.element == world.weather_element and get_weather_intensity() == 2 and world.day_element == elements.strong_to[spell.element])) then
		if spell.target.distance < (7 - spell.target.model_size) then
			equip { waist="Orpheus's Sash" }
		elseif spellMap ~= 'Helix' then
			equip { waist="Hachirin-no-Obi" }
		end
	end
end

function job_aftercast(spell, action, spellMap, eventArgs)
	determine_haste_group()
	--add_to_chat(8,'****Aftercast****')
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
    if S{'haste','march','embrava','haste samba', 'mighty guard', 'geo-haste','indi-haste','slow','indi-slow','elegy'}:contains(buff:lower()) then
        determine_haste_group()
        handle_equipping_gear(player.status)
    elseif state.Buff[buff] ~= nil then
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

function customize_idle_set(idleSet)
    if state.DefenseMode.value == 'None' then
		if world.time >= 17*60 or world.time < 7*60 then
			idleSet = set_combine(idleSet,
			{
				feet=gear.NightFeet
			})
		else
			if state.IdleMode.value ~= 'DT' then
				idleSet = set_combine(idleSet,
				{
					feet=gear.DayFeet
				})
			end
		end
	end
	
	return idleSet
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the default 'update' self-command.
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

	if state.DefenseMode.value ~= 'None' then
		msg = msg .. ', ' .. 'Defense: ' .. state.DefenseMode.value .. ' (' .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ')'
	end

	if state.Kiting.value == true then
		msg = msg .. ', KITING'
	end

	if state.TreasureMode.has_value then
		msg = msg .. ', TH: ' .. state.TreasureMode.value
	end
		
	add_to_chat(122, msg)

	eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- User self-commands.
-------------------------------------------------------------------------------------------------------------------


function job_self_command(cmdParams, eventArgs)
   
    if cmdParams[1]:lower() == 'rune' then
        send_command('@input /ja '..state.Runes.value..' <me>')
    end
	
	if cmdParams[1] == 'step' then
		 send_command('@input /ja "'..state.MainStep.current..'" <t>')		 	 
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
				(buffactive[33] and (buffactive[580] or buffactive.embrava)) or buffactive.march == 2) then
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