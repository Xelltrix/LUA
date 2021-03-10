--------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------
Blu_spells = require("Blue_Mage_Spells")

--[[
	Custom commands:
	gs c cycle treasuremode (set on ctrl-= by default): Cycles through the available treasure hunter modes.
	Treasure hunter modes:
		None - Will never equip TH gear
		Tag - Will equip TH gear sufficient for initial contact with a mob
--]]

-- Initialization function for this job file.
function get_sets()
	mote_include_version = 2

	-- Load and initialize the include file.
	include('Mote-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
	state.EnmityDown = M(false)

	determine_haste_group()
	update_combat_form()
	customize_idle_set()

end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	state.OffenseMode:options('Normal', 'Low', 'Mid', 'High')
	state.HybridMode:options('Normal', 'DT', 'DTMAX', 'SB')
	state.WeaponskillMode:options('Normal', 'Low', 'Mid', 'High')
	state.IdleMode:options('Normal', 'DT', 'MEVA', 'Refresh')
	state.CastingMode:options('Normal','Alternate')
	
	state.MainStep = M{['description']='Main Step', 'Box Step', 'Quickstep','Stutter Step'}
	state.Runes = M{['description']='Runes', 'Ignis', 'Gelus', 'Flabra', 'Tellus', 'Sulpor', 'Unda', 'Lux', 'Tenebrae'}
	

	state.MainWeaponSet = M{['description']='Main Weapon Set',
		'Tizona',
		'Sequence',
		'Maxentius'
	}
	
	state.SubWeaponSet = M{['description']='Sub Weapon Set',
		'Thibron',
		'Almace',
		'Naegling'
	}
	
	send_command('bind numpad. gs c toggle EnmityDown')
	
	send_command('bind pageup gs c cycle MainWeaponSet')
	send_command('bind pagedown gs c cycleback MainWeaponSet')
	
	send_command('bind ^pageup gs c cycle SubWeaponSet')
	send_command('bind ^pagedown gs c cycleback SubWeaponSet')
	
	
	if player.sub_job == 'DNC' then
		send_command('bind ^= gs c cycle mainstep')
		send_command('bind ^- gs c cycleback mainstep')
	elseif player.sub_job == 'RUN' then
		send_command('bind ^= gs c cycle Runes')
		send_command('bind ^- gs c cycleback Runes')
	end

	apply_job_change()
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
	send_command('unbind numpad.')
	send_command('unbind pageup')
	send_command('unbind pagedown')
	send_command('unbind ^pageup')
	send_command('unbind ^pagedown')
	
	if player.sub_job == 'DNC' then
		send_command('unbind ^=')
		send_command('unbind ^-')
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

		sets.Kiting = { legs="Carmine Cuisses +1" }
		
		sets.TreasureHunter = 
		{ 
			ammo="Per. Lucky Egg",
			head=gear.HHead_TH, 
			waist="Chaac Belt"
		}
		
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
		
	---Buffs
		sets.buff.Doom = 
		{
			neck="Nicander's Necklace",
			lring={name="Eshmun's Ring", bag="wardrobe2"}, rring={name="Eshmun's Ring", bag="wardrobe3"},
			waist="Gishdubar Sash"
		}
		
		sets.buff['Chain Affinity'] = { feet="Assim. Charuqs +3" }
		
		sets.buff['Diffusion'] = { feet="Luhlaza Charuqs +3" }

	
	-------------------
	-- Job Abilities --
	------------------- 

		sets.precast.JA['Azure Lore'] = { hands="Luh. Bazubands +3" }
		
		sets.precast.JA['Provoke'] = sets.Enmity
		
		sets.precast.JA['Warcry'] = sets.Enmity
		
		sets.precast.JA['Pflug'] = sets.Enmity
		
		sets.precast.JA['Animated Flourish'] = sets.Enmity
		

	-------------------
	-- Precast Magic --
	------------------- 
	-- Fast Cast: 15%
	
		sets.precast.FC =
		{--		Fast Cast: 87%(+15%)
			ammo="Sapience Orb",
			head="Carmine Mask +1", neck="Orunmila's Torque", lear="Etiolation Earring", rear="Loquac. Earring",
			body="Pinga Tunic +1", hands="Leyline Gloves", lring="Lebeche Ring", rring="Weather. Ring +1",
			back="Fi Follet Cape +1", waist="Witful Belt", legs="Pinga Pants +1", feet="Carmine Greaves +1"
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

		sets.midcast.FC = set_combine(sets.precast.FC,
		{--		Fast Cast: 84%(+15%)
			lring="Kishar Ring",
			legs="Aya. Cosciales +2"
		})

		
		sets.midcast.FC.SIRD = set_combine(sets.midcast.FC,
		{--		Fast Cast: 43%(+15%)	SIRD: 92%(+10%)
			ammo="Staunch Tathlum +1",
			head=gear.THead_Phalanx,
			hands="Rawhide Gloves",
			waist="Emphatikos Rope", legs="Assim. Shalwar +3", feet="Amalric Nails +1"
		})
		
		sets.midcast.Duration =
		{--		Fast Cast: 46%(+15%)	Duration: x1.5
			ammo="Staunch Tathlum +1",
			head=gear.ENH_Head, neck="Orunmila's Torque", lear="Etiolation Earring", rear="Loquac. Earring",
			body=gear.ENH_Body, hands=gear.ENH_Gloves, lring="Kishar Ring", rring="Weather. Ring +1",
			back="Fi Follet Cape +1", waist="Witful Belt", legs=gear.ENH_Legs, feet="Telchine Pigaches"
		}

		sets.midcast.ConserveMP = set_combine(sets.midcast.FC,
		{--		Fast Cast: 44%(+15%)	CMP: 36
			ammo="Pemphredo Tathlum",
			head=gear.ENH_Head, neck="Incanter's Torque", lear="Gwati Earring", rear="Mendi. Earring",
			body="Amalric Doublet +1",
			back="Fi Follet Cape +1", waist="Witful Belt", legs="Lengo Pants", feet="Carmine Greaves +1"
		})


    --------------------------------------
	-- Buffing Midcast sets
	--------------------------------------
	
		sets.midcast['Magic Barrier'] =
		{--		Fast Cast: 5%(+15%)		Skill: 628
			ammo="Mavi Tathlum",
			head="Luh. Keffiyeh +3", neck="Mirage Stole +2", lear="Njordr Earring", rear="Loquac. Earring",
			body="Assim. Jubbah +3", hands="Rawhide Gloves", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back="Cornflower Cape", waist="Witful Belt", legs="Hashishin Tayt +1", feet="Luhlaza Charuqs +3"
		}
		
		sets.midcast['BlueSkin'] = set_combine(sets.midcast.ConserveMP,
		{--		Fast Cast: 48%(+15%)	Skill: 501
			head="Carmine Mask +1",
			hands="Leyline Gloves",
			back="Cornflower Cape", 
		})
		
		sets.midcast.Occultation = set_combine(sets.midcast['Magic Barrier'],
		{--		Fast Cast: 19%(+15%)	Skill: 601 		Recast Delay -14%
			head="Carmine Mask +1",
			hands="Hashi. Bazu. +1",
			waist="Witful Belt"
		})
		
		sets.midcast.Occultation.Alternate = set_combine(sets.midcast.FC,
		{--		Fast Cast: 42%(+15%)	Skill: 50 		Recast Delay: -14%
			ammo="Mavi Tathlum",
			neck="Mirage Stole +2", lear="Njordr Earring",
			body="Assim. Jubbah +3", hands="Hashi. Bazu. +1",
			back="Cornflower Cape", legs="Lengo Pants"
		})

		sets.midcast.Buffs = set_combine(sets.midcast.ConserveMP,
		{--		Fast Cast: 36%(+15%)	Recsat Delay: -14%
			lear="Tuisto Earring",
			body="Luhlaza Jubbah +3", hands="Hashi. Bazu. +1", lring="Defending Ring", rring="Gelatinous Ring +1",
			legs="Aya. Cosciales +2"
		})
		
		sets.midcast['Cocoon'] = sets.midcast.FC
		
		sets.midcast['Zephy Mantle'] = sets.midcast.FC
		
		sets.midcast['Regeneration'] = set_combine(sets.midcast.ConserveMP,
		{
			body=gear.ENH_Body
		})
		
		
    --------------------------------------
	-- Healing Midcast sets
	--------------------------------------	
	
		sets.midcast.Cures =
		{--		Cure Potency: 53%	Cure Received: 14%
			ammo="Staunch Tathlum +1",
			head=gear.ENH_Head, neck="Incanter's Torque", lear="Meili Earring", rear="Mendi. Earring",
			body="Pinga Tunic +1", hands=gear.ENH_Gloves, lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back="Fi Follet Cape +1", waist="Bishop's Sash", legs="Pinga Pants +1", feet="Medium's Sabots"
		}
		
		sets.midcast.Cures.Alternate = 
		{--		Cure Potency: 54%	PDT:37% 	MDT:35%
			ammo="Staunch Tathlum +1",
			head="Malignance Chapeau", neck="Loricate Torque +1", lear="Odnowa Earring +1", rear="Mendi. Earring",
			body="Pinga Tunic +1", hands="Malignance Gloves", lring="Defending Ring", rring="Menelaus's Ring",
			back="Oretan. Cape +1", waist="Flume Belt +1", legs="Pinga Pants +1", feet="Medium's Sabots"
		}

		sets.midcast['White Wind'] =
		{--		Cure Potency: 53%		HP+1149
			ammo="Pemphredo Tathlum",
			head=gear.ENH_Head, neck="Unmoving Collar +1", lear="Tuisto Earring", rear="Odnowa Earring +1",
			body="Pinga Tunic +1", hands=gear.ENH_Gloves, lring="Lebeche Ring", rring="Gelatinous Ring +1",
			back="Moonlight Cape", waist="Gishdubar Sash", legs="Pinga Pants +1", feet="Medium's Sabots"
		}
		
		sets.midcast.StatusRemoval = sets.midcast.FC

		sets.midcast.Cursna = set_combine(sets.precast.FC,
		{-- Healing Magic Skill + 60		Cursna + 65
			neck="Debilis Medallion", lear="Meili Earring", rear="Beatific Earring",
			hands="Hieros Mittens", lring="Haoma's Ring", rring="Menelaus's Ring",
			back="Oretan. Cape +1", waist="Bishop's Sash", legs="Carmine Cuisses +1"
		})

		sets.midcast.Raise = sets.midcast.ConserveMP
		
		sets.midcast.Reraise = sets.midcast.ConserveMP
		
    --------------------------------------
	-- Offensive Midcast sets
	--------------------------------------    
	

	---Offensive Magic
		sets.midcast['Elemental Magic'] =
		{
			ammo="Ghastly Tathlum +1",
			head="Jhakri Coronal +2", neck="Sanctity Necklace", lear="Friomisi Earring", rear="Regal Earring",
			body="Amalric Doublet +1", hands="Amalric Gages +1", lring="Shiva Ring +1", rring="Metamor. Ring +1",
			back=gear.BLUCape_Nuke, waist="Sacro Cord", legs="Amalric Slops +1", feet="Amalric Nails +1"
		}
		
		sets.midcast.Macc =
		{
			ammo="Pemphredo Tathlum",
			head=empty, neck="Mirage Stole +2", lear="Digni. Earring", rear="Regal Earring",
			body="Cohort Cloak +1", hands="Malignance Gloves", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring="Metamor. Ring +1",
			back="Aurist's Cape +1", waist="Acuity Belt +1", legs="Assim. Shalwar +3", feet="Luhlaza Charuqs +3"
		}
	
		sets.midcast['Enfeebling Magic'] =
		{
			ammo="Pemphredo Tathlum",
			head=empty, neck="Mirage Stole +2", lear="Digni. Earring", rear="Regal Earring",
			body="Cohort Cloak +1", hands="Regal Cuffs", lring="Kishar Ring", rring="Metamor. Ring +1",
			back="Aurist's Cape +1", waist="Acuity Belt +1", legs="Assim. Shalwar +3", feet="Medium's Sabots"
		}
		
		sets.midcast['Dark Magic'] = set_combine(sets.midcast.Macc,
		{
			neck="Erra Pendant",
			hands="Malignance Gloves", rring={name="Stikini Ring +1", bag="wardrobe3"}
		})
		
		sets.midcast.Sap = set_combine(sets.midcast['Dark Magic'],
		{
			head="Pixie Hairpin +1", lear="Mani Earring",
			lring="Archon Ring", rring="Evanescence Ring",
			waist="Fucho-no-Obi"
		})

		sets.midcast.Stun = set_combine(sets.midcast.Macc,
		{
			head="Carmine Mask +1", neck="Erra Pendant", rear="Gwati Earring",
			body="Luhlaza Jubbah +3", hands="Leyline Gloves",
			legs="Aya. Cosciales +2", feet="Amalric Nails +1"
		})
		
		sets.midcast.Flash = sets.Enmity	
	

	
	--- Physical Spells
		sets.midcast.Physical =
		{
			ammo="Aurgelmir Orb +1",
			head="Luh. Keffiyeh +3", neck="Mirage Stole +2", lear="Telos Earring", rear={name="Mache Earring +1", bag="wardrobe3"},
			body="Luhlaza Jubbah +3", hands="Luh. Bazubands +3", lring="Ilabrat Ring", rring="Shukuyu Ring",
			back=gear.BLUCape_WSD, waist="Kentarch Belt +1", legs="Jhakri Slops +2", feet="Luhlaza Charuqs +3"
		}

		sets.midcast.AddEffect =
		{
			ammo="Pemphredo Tathlum",
			head="Luh. Keffiyeh +3", neck="Mirage Stole +2", lear="Digni. Earring", rear="Njordr Earring",
			body="Luhlaza Jubbah +3", hands="Malignance Gloves", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back="Aurist's Cape +1", waist="Acuity Belt +1", legs="Aya. Cosciales +2", feet="Luhlaza Charuqs +3"
		}
		
		sets.midcast.AddEffect.Alternate = sets.midcast.Physical
		
		sets.midcast['Sudden Lunge'] = sets.midcast.AddEffect
		
		sets.midcast['Sudden Lunge'].Alternate = sets.midcast.AddEffect

		sets.midcast.Magical = sets.midcast['Elemental Magic']
		
		sets.midcast['Scouring Spate'] =
		{
			ammo="Ghastly Tathlum +1",
			head=empty, neck="Sanctity Necklace", lear="Friomisi Earring", rear="Regal Earring",
			body="Cohort Cloak +1", hands="Amalric Gages +1", lring="Shiva Ring +1", rring="Metamor. Ring +1",
			back=gear.BLUCape_Nuke, waist="Orpheus's Sash", legs="Amalric Slops +1", feet="Amalric Nails +1"
		}
		
		sets.midcast['Anvil Lightning'] = sets.midcast['Scouring Spate']
		
		sets.midcast['Entomb'] =
		{
			ammo="Ghastly Tathlum +1",
			head=empty, neck="Sanctity Necklace", lear="Friomisi Earring", rear="Regal Earring",
			body="Cohort Cloak +1", hands="Amalric Gages +1", lring="Shiva Ring +1", rring="Metamor. Ring +1",
			back=gear.BLUCape_Nuke, waist="Orpheus's Sash", legs="Luhlaza Shalwar +3", feet="Amalric Nails +1"
		}
		
		sets.midcast['Silent Storm'] = sets.midcast['Entomb']
		
		sets.midcast['Silent Storm'].Alternate = sets.midcast.Debuffs
			
		sets.midcast['Searing Tempest'] = sets.midcast['Entomb']
		
		sets.midcast.Darkness = set_combine(sets.midcast.Magical,
		{
			head="Pixie Hairpin +1",
			body="Amalric Doublet +1", lring="Archon Ring", rring="Metamor. Ring +1"
		})

		sets.midcast.Brightness = set_combine(sets.midcast.Magical,
		{
			head=empty,
			body="Cohort Cloak +1",	lring="Metamor. Ring +1", rring="Weather. Ring +1",
			legs="Luhlaza Shalwar +3"
		})

		sets.midcast.Breath =
		{
			ammo="Mavi Tathlum",
			head="Luh. Keffiyeh +3", neck="Unmoving Collar +1", lear="Tuisto Earring", rear="Odnowa Earring +1",
			body="Assim. Jubbah +3", hands="Regal Cuffs", lring="Eihwaz Ring", rring="Gelatinous Ring +1",
			back="Moonlight Cape", waist="Orpheus's Sash", legs="Assim. Shalwar +3", feet="Assim. Charuqs +3"
		}

		sets.midcast.Debuffs = set_combine(sets.midcast.Macc,
		{
			rring={name="Stikini Ring +1", bag="wardrobe3"}
		})
	
		sets.midcast['Dream Flower'] = set_combine(sets.midcast.Debuffs,
		{
			head="Malignance Chapeau",
			body="Malignance Tabard",
		})

		sets.midcast['Dream Flower'].Alternate =
		{--		DT: -37%	PDT: 54%
			ammo="Staunch Tathlum +1",
			head="Malignance Chapeau", neck="Mirage Stole +2", lear="Digni. Earring", rear="Njordr Earring",
			body="Malignance Tabard", hands="Malignance Gloves", lring="Defending Ring", rring="Gelatinous Ring +1",
			back=gear.BLUCape_Nuke, waist="Rumination Sash", legs="Assim. Shalwar +3", feet="Malignance Boots"
		}
		
		sets.midcast['Embalming Earth'] = sets.midcast['Entomb']
		
		sets.midcast['Embalming Earth'].Alternate = sets.midcast.Debuffs

		sets.midcast.BlueDrain = set_combine(sets.midcast.Debuffs,
		{
			ammo="Mavi Tathlum",
			head="Luh. Keffiyeh +3", lear="Njordr Earring",
			body="Assim. Jubbah +3", hands="Rawhide Gloves", rring={name="Stikini Ring +1", bag="wardrobe3"},
			back="Cornflower Cape", legs="Hashishin Tayt +1", feet="Luhlaza Charuqs +3"
		})
		
		sets.midcast['Actinic Burst'] = sets.Enmity
		
		sets.midcast.Fantod =  sets.Enmity
		
		sets.midcast.Exuviation = sets.Enmity



	--------------------------------------
	-- Suppoort Job Midcast sets
	--------------------------------------
	
	---Defensive Magic
		sets.midcast['Enhancing Magic'] =
		{--	 Enhancing Skill + 96
			ammo="Staunch Tathlum +1",
			head="Carmine Mask +1", neck="Incanter's Torque", lear="Andoaa Earring", rear="Mimir Earring",
			body=gear.ENH_Body, hands=gear.ENH_Gloves, lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back="Fi Follet Cape +1", waist="Olympus Sash", legs="Carmine Cuisses +1", feet="Telchine Pigaches"
		}
		
		sets.midcast.Phalanx = set_combine(sets.midcast['Enhancing Magic'],
		{--		Phalanx: +15
			head=gear.THead_Phalanx,
			body=gear.TBody_Phalanx, hands=gear.THands_Phalanx,
			legs=gear.TLegs_Phalanx, feet=gear.TFeet_Phalanx
		})
		
		
		sets.midcast.Stoneskin = set_combine(sets.midcast.Duration,
		{--		Stoneskin +125
			neck="Stone Gorget", rear="Earthcry Earring",
			hands="Stone Mufflers",
			waist="Siegel Sash", legs="Shedir Seraweels"
		})

		sets.midcast.Refresh = set_combine(sets.midcast.ConserveMP,
		{--		Refresh +2
			head="Amalric Coif +1", 
			body=gear.ENH_Body, hands=gear.ENH_Gloves,
			legs=gear.ENH_Legs, feet="Telchine Pigaches"
		})

		sets.midcast.Regen = set_combine(sets.midcast.ConserveMP,
		{
			head=gear.ENH_Head, 
			body=gear.ENH_Body, hands=gear.ENH_Gloves, 
			legs=gear.ENH_Legs, feet="Telchine Pigaches"
		})

		sets.midcast.Aquaveil = set_combine(sets.midcast.Duration,
		{--		Aquaveil +6
			ammo="Staunch Tathlum +1",
			head="Amalric Coif +1",
			hands="Regal Cuffs",
			waist="Emphatikos Rope", legs="Shedir Seraweels"
		})
		
		sets.midcast.BarElement = set_combine(sets.midcast['Enhancing Magic'],
		{
			legs="Shedir Seraweels"
		})

		sets.midcast.BarStatus = sets.midcast.Duration

		sets.midcast.Statless = sets.midcast.Duration
		
		sets.midcast.Protection = sets.midcast.Duration
		

	---Offensive Magic
		sets.midcast['Elemental Magic'] = set_combine(sets.midcast.Magical,
		{
			waist="Sacro Cord"
		})
	
		sets.midcast['Enfeebling Magic'] =
		{
			ammo="Pemphredo Tathlum",
			head=empty, neck="Mirage Stole +2", lear="Digni. Earring", rear="Regal Earring",
			body="Cohort Cloak +1", hands="Regal Cuffs", lring="Kishar Ring", rring={name="Stikini Ring +1", bag="wardrobe3"},
			back=gear.BLUCape_Nuke, waist="Acuity Belt +1", legs="Assim. Shalwar +3", feet="Malignance Boots"
		}
		
		sets.midcast['Dark Magic'] = set_combine(sets.midcast['Enfeebling Magic'],
		{
			neck="Erra Pendant",
			hands="Malignance Gloves", lring={name="Stikini Ring +1", bag="wardrobe2"}
		})
		
		sets.midcast.Sap = set_combine(sets.midcast['Dark Magic'],
		{
			head="Pixie Hairpin +1", lear="Mani Earring",
			lring="Archon Ring", rring="Evanescence Ring",
			waist="Fucho-no-Obi"
		})

		sets.midcast.Stun = set_combine(sets.midcast['Enfeebling Magic'],
		{
			head="Carmine Mask +1", neck="Erra Pendant", rear="Mani Earring",
			body="Luhlaza Jubbah +3", hands="Leyline Gloves",
			legs="Aya. Cosciales +2", feet="Amalric Nails +1"
		})
		
		sets.midcast.Flash = sets.midcast.Fantod

		
	
	--------------------------------------
	-- Miscellaneous Midcast sets
	--------------------------------------  
	
	
		sets.midcast.Utsusemi = sets.midcast.FC

		sets.midcast.Teleport = sets.midcast.ConserveMP

	
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
	
		sets.Tizona 	= { 	main="Tizona" 		}
			
		sets.Sequence 	= { 	main="Sequence"		}
	
		sets.Almace 	= { 	sub="Almace" 		}
		
		sets.Maxentius 	= { 	main="Maxentius" 	}
		
		sets.Naegling 	= { 	sub="Naegling" 		}
		
		sets.Thibron 	= { 	sub="Thibron" 		}
	
	------------------------------------------------------------------------------------------------
	------------------------------------------ Idle Sets -------------------------------------------
	------------------------------------------------------------------------------------------------

		sets.idle =
		{--		DT: -9%		PDT: -27%	MDT: -9%	Refresh: 9	Regen: 4
			ammo="Staunch Tathlum +1",
			head="Rawhide Mask", neck="Sanctity Necklace", lear="Dawn Earring", rear="Infused Earring",
			body="Shamash Robe", hands=gear.HHands_Refresh, lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back="Moonlight Cape", waist="Flume Belt +1", legs="Carmine Cuisses +1", feet=gear.HBoots_Refresh
		}

		sets.idle.DT = set_combine(sets.idle,
		{--		DT: -33%	PDT: -52%	MDT: -34%	Refresh: 5	Regen: 0
			head="Malignance Chapeau", neck="Warder's Charm +1",  lear="Sanare Earring", rear="Odnowa Earring +1",
			hands="Malignance Gloves", lring="Defending Ring", rring="Gelatinous Ring +1",
			waist="Carrier's Sash"
		})
		
		sets.idle.MEVA = set_combine(sets.idle,
		{--		DT: -27%	PDT: -37%	MDT: -29%	Refresh: 5	Regen: 0
			head="Malignance Chapeau", neck="Warder's Charm +1", lear="Sanare Earring", rear="Odnowa Earring +1",
			body="Shamash Robe", hands="Malignance Gloves",
			waist="Carrier's Sash", feet="Malignance Boots"
		})
		
		sets.idle.Refresh = set_combine(sets.idle,
		{--		DT: -9%		PDT: -17%	MDT: -9%	Refresh: 11	Regen: 4
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
		{--		DT: -42%	PDT: -51%	MDT: -43%
			ammo="Staunch Tathlum +1",
			head="Malignance Chapeau", neck="Warder's Charm +1", lear="Genmei Earring", rear="Odnowa Earring +1",
			body="Malignance Tabard", hands="Malignance Gloves", lring="Defending Ring", rring="Gelatinous Ring +1",
			back="Moonlight Cape", waist="Carrier's Sash", legs="Carmine Cuisses +1", feet="Hippo. Socks +1"
		}

		sets.defense.MDT = set_combine(sets.defense.PDT,
		{--		DT: -53%	PDT: -53%	MDT: -53%
			head="Malignance Chapeau", neck="Warder's Charm +1", lear="Eabani Earring", rear="Sanare Earring",
			rring="Shadow Ring",
			legs="Malignance Tights", feet="Malignance Boots"
		})



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
			head=gear.HHead_WSD, neck="Fotia Gorget", lear="Brutal Earring", rear="Moonshade Earring",
			body="Assim. Jubbah +3", hands="Jhakri Cuffs +2", lring="Shukuyu Ring", rring="Epaminondas's Ring",
			back=gear.BLUCape_WSD, waist="Fotia Belt", legs="Samnuha Tights", feet=gear.HBoots_TP
		}

		sets.precast.WS.Low = set_combine(sets.precast.WS,
		{
			head="Jhakri Coronal +2", lear={name="Mache Earring +1", bag="wardrobe2"}, rear={name="Mache Earring +1", bag="wardrobe3"},
			feet="Jhakri Pigaches +2"
		})
		
		sets.precast.WS.Mid = sets.precast.WS.Low

		sets.precast.WS.High = sets.precast.WS.Mid
		
	--	***Swords***
	
		--Tizona/Almace TP: 80/h		Almace/Naegling TP:79/h		(DW3 STP25 or DW4 STP30)
		
	--Chant du Cygne
		sets.precast.WS['Chant du Cygne'] =
		{
			ammo="Aurgelmir Orb +1",
			head=gear.AHead_TP, neck="Mirage Stole +2", lear="Odr Earring", rear={name="Mache Earring +1", bag="wardrobe3"},
			body="Adhemar Jacket +1", hands="Adhemar Wrist. +1", lring="Ilabrat Ring", rring="Epona's Ring", 
			back=gear.BLUCape_Crit, waist="Fotia Belt", legs="Zoar Subligar +1", feet=gear.HBoots_Crit
		}

		sets.precast.WS['Chant du Cygne'].Low = sets.precast.WS['Chant du Cygne']
		
		sets.precast.WS['Chant du Cygne'].Mid = set_combine(sets.precast.WS['Chant du Cygne'].Low,
		{
			head="Blistering Sallet +1",
			hands="Malignance Gloves",
		})
		
		sets.precast.WS['Chant du Cygne'].High = set_combine(sets.precast.WS['Chant du Cygne'].Mid,
		{
			legs="Malignance Tights", waist="Kentarch Belt +1", feet="Luhlaza Charuqs +3"
		})

	---Vorpal Blade
		sets.precast.WS['Vorpal Blade'] = set_combine(sets.precast.WS['Chant du Cygne'],
		{
			ammo="Aurgelmir Orb +1",
			rear="Moonshade Earring",
			lring="Shukuyu Ring"
		})

		sets.precast.WS['Vorpal Blade'].Low = set_combine(sets.precast.WS['Vorpal Blade'],
		{
			rring="Ilabrat Ring",
			legs="Malignance Tights"
		})
		
		sets.precast.WS['Vorpal Blade'].Mid = set_combine(sets.precast.WS['Vorpal Blade'].Low,
		{
			head="Blistering Sallet +1",
			hands="Malignance Gloves"
		})
		
		sets.precast.WS['Vorpal Blade'].High = set_combine(sets.precast.WS['Vorpal Blade'].Mid,
		{
			head="Malignance Chapeau",
			feet="Luhlaza Charuqs +3"
		})
		
	---Requiescat
		sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS,
		{
			head="Jhakri Coronal +2", lear="Regal Earring",
			body="Luhlaza Jubbah +3", hands="Luh. Bazubands +3", lring="Metamor. Ring +1", rring="Epona's Ring", 
			legs="Jhakri Slops +2", feet="Luhlaza Charuqs +3"
		})

		sets.precast.WS['Requiescat'].Low = set_combine(sets.precast.WS['Requiescat'],
		{
			rear={name="Mache Earring +1", bag="wardrobe3"},
		})
		
		sets.precast.WS['Requiescat'].Mid = set_combine(sets.precast.WS['Requiescat'].Low,
		{
			lear={name="Mache Earring +1", bag="wardrobe2"},
			rring={name="Chirich Ring +1", bag="wardrobe3"}
		})
		
		sets.precast.WS['Requiescat'].High = set_combine(sets.precast.WS['Requiescat'].Mid,
		{
			neck="Mirage Stole +2",
			legs="Malignance Tights"
		})

	---Savage Blade
		sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS,
		{
			neck="Mirage Stole +2", lear="Ishvara Earring", rear="Regal Earring",
			lring="Metamor. Ring +1",
			waist="Sailfi Belt +1", legs="Luhlaza Shalwar +3", feet=gear.HBoots_WSD
		})

		sets.precast.WS['Savage Blade'].Low = sets.precast.WS['Savage Blade']
		
		sets.precast.WS['Savage Blade'].Mid = sets.precast.WS['Savage Blade'].Low
		
		sets.precast.WS['Savage Blade'].High = set_combine(sets.precast.WS['Savage Blade'].Mid,
		{
			head="Jhakri Coronal +2", lear={name="Mache Earring +1", bag="wardrobe2"}, rear={name="Mache Earring +1", bag="wardrobe3"},
			waist="Kentarch Belt +1", feet="Assim. Charuqs +3"
		})

	---Expiacion
		sets.precast.WS['Expiacion'] = set_combine(sets.precast.WS['Savage Blade'],
		{
			lear="Ishvara Earring", rear="Moonshade Earring",
			lring="Shukuyu Ring"
		})

		sets.precast.WS['Expiacion'].Low = sets.precast.WS['Expiacion']
		
		sets.precast.WS['Expiacion'].Mid = sets.precast.WS['Expiacion'].Low
		
		sets.precast.WS['Expiacion'].High = set_combine(sets.precast.WS['Expiacion'].Mid,
		{
			head="Jhakri Coronal +2", lear={name="Mache Earring +1", bag="wardrobe2"}, rear={name="Mache Earring +1", bag="wardrobe3"},
			waist="Kentarch Belt +1", feet="Assim. Charuqs +3"
		})

	---Sanguine Blade
		sets.precast.WS['Sanguine Blade'] =
		{
			ammo="Pemphredo Tathlum",
			head="Pixie Hairpin +1", neck="Sanctity Necklace", lear="Regal Earring", rear="Friomisi Earring",
			body="Amalric Doublet +1", hands="Jhakri Cuffs +2", lring="Archon Ring", rring="Epaminondas's Ring",
			back=gear.BLUCape_WSD, waist="Orpheus's Sash", legs="Luhlaza Shalwar +3", feet="Amalric Nails +1"
		}
	
	---Seraph Blade
		sets.precast.WS['Seraph Blade'] = set_combine(sets.precast.WS['Sanguine Blade'],
		{
			head=empty,
			body="Cohort Cloak +1", lring="Weather. Ring +1"
		})
		
		sets.precast.WS['Shining Blade'] = sets.precast.WS['Seraph Blade']
		
	---Red Lotus Blade	
		sets.precast.WS['Red Lotus Blade'] = set_combine(sets.precast.WS['Seraph Blade'],
		{
			lring="Metamor. Ring +1"
		})
		
		sets.precast.WS['Burning Blade'] = sets.precast.WS['Red Lotus Blade']
	
	---Spirits Within
		sets.precast.WS['Spirits Within'] =
		{
			head="Luh. Keffiyeh +3", neck="Sanctity Necklace", lear="Tuisto Earring", rear="Odnowa Earring +1",
			body="Assim. Jubbah +3", hands="Regal Cuffs", lring="Ilabrat Ring", rring="Gelatinous Ring +1",
			back="Moonlight Cape", waist="Sacro Cord", legs="Assim. Shalwar +3", feet="Assim. Charuqs +3"
		}
	

	
	--	***Clubs***
	
		sets.precast.WS['True Strike'] =
		{
			ammo="Aurgelmir Orb +1",
			head=gear.HHead_WSD, neck="Mirage Stole +2", lear="Telos Earring", rear="Ishvara Earring",
			body="Assim. Jubbah +3", hands="Jhakri Cuffs +2", lring="Shukuyu Ring", rring="Epaminondas's Ring",
			back=gear.BLUCape_WSD, waist="Sailfi Belt +1", legs="Luhlaza Shalwar +3", feet=gear.HBoots_WSD

		}

		sets.precast.WS['True Strike'].Low = sets.precast.WS['True Strike']
		
		sets.precast.WS['True Strike'].Mid = sets.precast.WS['True Strike'].Low
		
		sets.precast.WS['True Strike'].High = set_combine(sets.precast.WS['True Strike'].Mid,
		{
			head="Jhakri Coronal +2", lear={name="Mache Earring +1", bag="wardrobe2"}, rear={name="Mache Earring +1", bag="wardrobe3"},
			feet="Assim. Charuqs +3"
		})
		
		sets.precast.WS['Judgment'] = sets.precast.WS['Savage Blade']

		sets.precast.WS['Judgment'].Low = sets.precast.WS['Savage Blade'].Low
		
		sets.precast.WS['Judgment'].Mid = sets.precast.WS['Savage Blade'].Mid
		
		sets.precast.WS['Judgment'].High = sets.precast.WS['Savage Blade'].High

		sets.precast.WS['Black Halo'] = set_combine(sets.precast.WS['Savage Blade'],
		{
			feet="Malignance Boots"
		})

		sets.precast.WS['Black Halo'].Low = sets.precast.WS['Black Halo']
		
		sets.precast.WS['Black Halo'].Mid = sets.precast.WS['Black Halo'].Low
		
		sets.precast.WS['Black Halo'].High = set_combine(sets.precast.WS['Black Halo'].Mid,
		{
			head="Jhakri Coronal +2", lear={name="Mache Earring +1", bag="wardrobe2"}, rear={name="Mache Earring +1", bag="wardrobe3"},
			feet="Assim. Charuqs +3"
		})

		sets.precast.WS['Realmrazer'] = sets.precast.WS['Requiescat']
		
		sets.precast.WS['Realmrazer'].Low = sets.precast.WS['Requiescat'].Low
		
		sets.precast.WS['Realmrazer'].Mid = sets.precast.WS['Requiescat'].Mid
		
		sets.precast.WS['Realmrazer'].High = sets.precast.WS['Requiescat'].High

		sets.precast.WS['Flash Nova'] = sets.precast.WS['Seraph Blade']
	
	
	
	--------------------------------------
	-- Melee sets
	--------------------------------------
	------------------------------------------------
	----------------------------------------------------------
	--	*************************************************** --
	----------------------------------------------------------
	-- Sword & Board
	----------------------------------------------------------	
	
		sets.engaged =
		{
			sub="Genmei Shield", ammo="Aurgelmir Orb +1",
			head="Dampening Tam", neck="Mirage Stole +2", lear="Brutal Earring", rear="Telos Earring",
			body="Malignance Tabard", hands="Adhemar Wrist. +1", lring="Hetairoi Ring", rring="Epona's Ring",
			back=gear.BLUCape_STP, waist="Windbuffet Belt +1", legs="Samnuha Tights", feet=gear.HBoots_TP
		}
		sets.engaged.AM3 =
		{
			sub="Genmei Shield", ammo="Aurgelmir Orb +1",
			head="Malignance Chapeau", neck="Mirage Stole +2", lear="Telos Earring", rear="Dedition Earring",
			body="Malignance Tabard", hands="Malignance Gloves", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"},
			back=gear.BLUCape_STP, waist="Windbuffet Belt +1", legs="Malignance Tights", feet="Malignance Boots"
		}
		
		sets.engaged.Low = set_combine(sets.engaged,
		{
			head="Dampening Tam", rear="Digni. Earring",
			lring={name="Chirich Ring +1", bag="wardrobe2"},
		})

		sets.engaged.Mid = set_combine(sets.engaged.Low,
		{
			ammo="Aurgelmir Orb +1",
			rear={name="Mache Earring +1", bag="wardrobe3"},
			rring={name="Chirich Ring +1", bag="wardrobe3"},
			legs="Malignance Tights"
		})

		sets.engaged.High = set_combine(sets.engaged.Mid,
		{
			head="Carmine Mask +1", lear={name="Mache Earring +1", bag="wardrobe2"}, 
			body="Luhlaza Jubbah +3", hands="Luh. Bazubands +3",
			waist="Kentarch Belt +1", feet="Assim. Charuqs +3"
		})
	
	
	----------------------------------------------------------
	-- No Haste
	----------------------------------------------------------
	
	--15 DW = 59 DW needed		(DNC Sub)

	--25 DW = 49 DW needed		(NIN Sub or BLU Trait)

	--30 DW = 44 DW needed		(Tier 2 BLU Trait)
	
	--35 DW = 39 DW needed		(Tier 3 BLU Trait)
	
	----------------------------------------------------------

		----------------------------------------------------------
		--					(DW2 + No Haste)
		----------------------------------------------------------

		--15 DW = 59 DW needed		(DNC Sub)
		
		----------------------------------------------------------
		-----------------------------------------------------------------------------------
		---	TP/h:79	(DW:42	STP:39		QA:0%	TA:16%	DA:5%)
		-----------------------------------------------------------
		sets.engaged.DW2 =
		{
			ammo="Aurgelmir Orb +1",
			head="Dampening Tam", neck="Mirage Stole +2", lear="Eabani Earring", rear="Suppanomimi",
			body="Adhemar Jacket +1", hands="Adhemar Wrist. +1", lring="Hetairoi Ring", rring="Epona's Ring",
			back=gear.BLUCape_DW, waist="Reiki Yotai", legs="Carmine Cuisses +1", feet=gear.TFeet_TP
		}
		
		sets.engaged.DW2.AM3 =
		{
			ammo="Aurgelmir Orb +1",
			head="Dampening Tam", neck="Mirage Stole +2", lear="Eabani Earring", rear="Suppanomimi",
			body="Adhemar Jacket +1", hands="Malignance Gloves", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"},
			back=gear.BLUCape_DW, waist="Reiki Yotai", legs="Carmine Cuisses +1", feet=gear.TFeet_TP
		}
		
		
		-----------------------------------------------------------------------------------
		---	TP/h:79	(DW:42	STP:39		QA:0%	TA:16%	DA:5%)
		-----------------------------------------------------------
		sets.engaged.DW2.Low = set_combine(sets.engaged.DW2,
		{
			ammo="Aurgelmir Orb +1",
			head="Dampening Tam"
		})

		-----------------------------------------------------------------------------------
		---	TP/h:79	(DW:42	STP:39		QA:0%	TA:16%	DA:5%)
		-----------------------------------------------------------
		sets.engaged.DW2.Mid = set_combine(sets.engaged.DW2.Low,
		{
			
			hands="Luh. Bazubands +3", lring={name="Chirich Ring +1", bag="wardrobe2"}
		})

		-----------------------------------------------------------------------------------
		---	TP/h:79	(DW:42	STP:39		QA:0%	TA:16%	DA:5%)
		-----------------------------------------------------------
		sets.engaged.DW2.High = set_combine(sets.engaged.DW2.Mid,
		{
			head="Carmine Mask +1",
			rring={name="Chirich Ring +1", bag="wardrobe3"}
		})
		
		
		----------------------------------------------------------
		--					(DW3 + No Haste)
		----------------------------------------------------------

		--25 DW = 49 DW needed		(NIN Sub or BLU Trait)
		
		----------------------------------------------------------
		
		-----------------------------------------------------------------------------------
		---	TP/h:79	(DW:42	STP:39		QA:0%	TA:16%	DA:5%)
		-----------------------------------------------------------
		sets.engaged.DW3 =
		{
			ammo="Aurgelmir Orb +1",
			head="Dampening Tam", neck="Mirage Stole +2", lear="Eabani Earring", rear="Suppanomimi",
			body="Adhemar Jacket +1", hands="Adhemar Wrist. +1", lring="Hetairoi Ring", rring="Epona's Ring",
			back=gear.BLUCape_DW, waist="Reiki Yotai", legs="Carmine Cuisses +1", feet=gear.TFeet_TP
		}
		
		sets.engaged.DW3.AM3 =
		{
			ammo="Aurgelmir Orb +1",
			head="Dampening Tam", neck="Mirage Stole +2", lear="Eabani Earring", rear="Suppanomimi",
			body="Adhemar Jacket +1", hands="Malignance Gloves", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"},
			back=gear.BLUCape_DW, waist="Reiki Yotai", legs="Carmine Cuisses +1", feet=gear.TFeet_TP
		}
		
		
		-----------------------------------------------------------------------------------
		---	TP/h:79	(DW:42	STP:39		QA:0%	TA:16%	DA:5%)
		-----------------------------------------------------------
		sets.engaged.DW3.Low = set_combine(sets.engaged.DW3,
		{
			ammo="Aurgelmir Orb +1",
			head="Dampening Tam"
		})

		-----------------------------------------------------------------------------------
		---	TP/h:79	(DW:42	STP:39		QA:0%	TA:16%	DA:5%)
		-----------------------------------------------------------
		sets.engaged.DW3.Mid = set_combine(sets.engaged.DW3.Low,
		{
			hands="Luh. Bazubands +3", lring={name="Chirich Ring +1", bag="wardrobe2"}
		})

		-----------------------------------------------------------------------------------
		---	TP/h:79	(DW:42	STP:39		QA:0%	TA:16%	DA:5%)
		-----------------------------------------------------------
		sets.engaged.DW3.High = set_combine(sets.engaged.DW3.Mid,
		{
			head="Carmine Mask +1",
			rring={name="Chirich Ring +1", bag="wardrobe3"}
		})
		
		
		----------------------------------------------------------
		--					(DW4 + No Haste)
		----------------------------------------------------------

		--30 DW = 44 DW needed		(Tier 2 Blu Trait)
		
		----------------------------------------------------------
		
		-----------------------------------------------------------------------------------
		---	TP/h:79	(DW:42	STP:39		QA:0%	TA:16%	DA:5%)
		-----------------------------------------------------------
		sets.engaged.DW4 =
		{
			ammo="Aurgelmir Orb +1",
			head="Dampening Tam", neck="Mirage Stole +2", lear="Eabani Earring", rear="Suppanomimi",
			body="Adhemar Jacket +1", hands="Adhemar Wrist. +1", lring="Hetairoi Ring", rring="Epona's Ring",
			back=gear.BLUCape_DW, waist="Reiki Yotai", legs="Carmine Cuisses +1", feet=gear.TFeet_TP
		}
		
		sets.engaged.DW4.AM3 =
		{
			ammo="Aurgelmir Orb +1",
			head="Dampening Tam", neck="Mirage Stole +2", lear="Eabani Earring", rear="Suppanomimi",
			body="Adhemar Jacket +1", hands="Malignance Gloves", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"},
			back=gear.BLUCape_DW, waist="Reiki Yotai", legs="Carmine Cuisses +1", feet=gear.TFeet_TP
		}
		
		-----------------------------------------------------------------------------------
		---	TP/h:79	(DW:42	STP:39		QA:0%	TA:16%	DA:5%)
		-----------------------------------------------------------
		sets.engaged.DW4.Low = set_combine(sets.engaged.DW4,
		{	
			ammo="Aurgelmir Orb +1",
			head="Dampening Tam"
		})

		-----------------------------------------------------------------------------------
		---	TP/h:79	(DW:42	STP:39		QA:0%	TA:16%	DA:5%)
		-----------------------------------------------------------
		sets.engaged.DW4.Mid = set_combine(sets.engaged.DW4.Low,
		{
			hands="Luh. Bazubands +3", lring={name="Chirich Ring +1", bag="wardrobe2"}
		})

		-----------------------------------------------------------------------------------
		---	TP/h:79	(DW:42	STP:39		QA:0%	TA:16%	DA:5%)
		-----------------------------------------------------------
		sets.engaged.DW4.High = set_combine(sets.engaged.DW4.Mid,
		{
			head="Carmine Mask +1",
			rring={name="Chirich Ring +1", bag="wardrobe3"}
		})
		
		

		----------------------------------------------------------
		--					(DW5 + No Haste)
		----------------------------------------------------------

		--35 DW = 39 DW needed		(Tier 3 Blu Trait)
		
		----------------------------------------------------------
		
		-----------------------------------------------------------------------------------
		---	TP/h:79	(DW:38	STP:39		QA:0%	TA:16%	DA:5%)
		-----------------------------------------------------------
		sets.engaged.DW5 =
		{
			ammo="Aurgelmir Orb +1",
			head=gear.AHead_TP, neck="Mirage Stole +2", lear="Eabani Earring", rear="Suppanomimi",
			body="Adhemar Jacket +1", hands="Adhemar Wrist. +1", lring="Hetairoi Ring", rring="Epona's Ring",
			back=gear.BLUCape_DW, waist="Reiki Yotai", legs="Carmine Cuisses +1", feet="Malignance Boots"
		}
		
		sets.engaged.DW5.AM3 =
		{
			ammo="Aurgelmir Orb +1",
			head=gear.AHead_TP, neck="Mirage Stole +2", lear="Eabani Earring", rear="Suppanomimi",
			body="Adhemar Jacket +1", hands="Malignance Gloves", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"},
			back=gear.BLUCape_DW, waist="Reiki Yotai", legs="Carmine Cuisses +1", feet="Malignance Boots"
		}
		
		-----------------------------------------------------------------------------------
		---	TP/h:79	(DW:38	STP:39		QA:0%	TA:16%	DA:5%)
		-----------------------------------------------------------
		sets.engaged.DW5.Low = set_combine(sets.engaged.DW5,
		{	
			ammo="Aurgelmir Orb +1"
		})

		-----------------------------------------------------------------------------------
		---	TP/h:79	(DW:38	STP:39		QA:0%	TA:16%	DA:5%)
		-----------------------------------------------------------
		sets.engaged.DW5.Mid = set_combine(sets.engaged.DW5.Low,
		{
			hands="Luh. Bazubands +3", lring={name="Chirich Ring +1", bag="wardrobe2"}
		})

		-----------------------------------------------------------------------------------
		---	TP/h:79	(DW:38	STP:39		QA:0%	TA:16%	DA:5%)
		-----------------------------------------------------------
		sets.engaged.DW5.High = set_combine(sets.engaged.DW5.Mid,
		{
			head="Carmine Mask +1",
			rring={name="Chirich Ring +1", bag="wardrobe3"}
		})	
		

	----------------------------------------------------------
	-- Minimum Haste
	----------------------------------------------------------
	
	--15 DW = 52 DW needed		(DNC Sub)

	--25 DW = 42 DW needed		(NIN Sub or BLU Trait)

	--30 DW = 37  DW needed		(Tier 2 BLU Trait)
	
	--35 DW = 32 DW needed		(Tier 3 BLU Trait)
	
	----------------------------------------------------------			

	
		----------------------------------------------------------
		--					(DW2 + 15% Haste)
		----------------------------------------------------------

		--15 DW = 52 DW needed		(DNC Sub)
		
		----------------------------------------------------------

		-----------------------------------------------------------------------------------
		---	TP/h:79	(DW:42	STP:39		QA:0%	TA:16%	DA:5%)
		-----------------------------------------------------------
		sets.engaged.DW2.Min =
		{
			ammo="Aurgelmir Orb +1",
			head="Dampening Tam", neck="Mirage Stole +2", lear="Eabani Earring", rear="Suppanomimi",
			body="Adhemar Jacket +1", hands="Adhemar Wrist. +1", lring="Hetairoi Ring", rring="Epona's Ring",
			back=gear.BLUCape_DW, waist="Reiki Yotai", legs="Carmine Cuisses +1", feet=gear.TFeet_TP
		}
		
		sets.engaged.DW2.Min.AM3 =
		{
			ammo="Aurgelmir Orb +1",
			head=gear.AHead_TP, neck="Mirage Stole +2", lear="Eabani Earring", rear="Suppanomimi",
			body="Adhemar Jacket +1", hands="Malignance Gloves", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"},
			back=gear.BLUCape_DW, waist="Reiki Yotai", legs="Carmine Cuisses +1", feet=gear.TFeet_TP
		}
		-----------------------------------------------------------------------------------
		---	TP/h:79	(DW:42	STP:39		QA:0%	TA:16%	DA:5%)
		-----------------------------------------------------------
		sets.engaged.DW2.Low.Min = set_combine(sets.engaged.DW2.Min,
		{
			ammo="Aurgelmir Orb +1",
			head="Dampening Tam"
		})

		-----------------------------------------------------------------------------------
		---	TP/h:79	(DW:42	STP:39		QA:0%	TA:16%	DA:5%)
		-----------------------------------------------------------
		sets.engaged.DW2.Mid.Min = set_combine(sets.engaged.DW2.Low.Min,
		{
			hands="Luh. Bazubands +3", lring={name="Chirich Ring +1", bag="wardrobe2"}
		})

		-----------------------------------------------------------------------------------
		---	TP/h:79	(DW:42	STP:39		QA:0%	TA:16%	DA:5%)
		-----------------------------------------------------------
		sets.engaged.DW2.High.Min = set_combine(sets.engaged.DW2.Mid.Min,
		{
			head="Carmine Mask +1",
			rring={name="Chirich Ring +1", bag="wardrobe3"}
		})	
	
	
		----------------------------------------------------------
		--					(DW3 + 15% Haste)
		----------------------------------------------------------

		--25 DW = 42 DW needed		(NIN Sub or BLU Trait)
		
		----------------------------------------------------------

		-----------------------------------------------------------------------------------
		---	TP/h:79	(DW:42	STP:39		QA:0%	TA:16%	DA:5%)
		-----------------------------------------------------------
		sets.engaged.DW3.Min =
		{
			ammo="Aurgelmir Orb +1",
			head="Dampening Tam", neck="Mirage Stole +2", lear="Eabani Earring", rear="Suppanomimi",
			body="Adhemar Jacket +1", hands="Adhemar Wrist. +1", lring="Hetairoi Ring", rring="Epona's Ring",
			back=gear.BLUCape_DW, waist="Reiki Yotai", legs="Carmine Cuisses +1", feet=gear.TFeet_TP
		}
		
		sets.engaged.DW3.Min.AM3 =
		{
			ammo="Aurgelmir Orb +1",
			head=gear.AHead_TP, neck="Mirage Stole +2", lear="Eabani Earring", rear="Suppanomimi",
			body="Adhemar Jacket +1", hands="Malignance Gloves", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"},
			back=gear.BLUCape_DW, waist="Reiki Yotai", legs="Carmine Cuisses +1", feet=gear.TFeet_TP
		}
		
		-----------------------------------------------------------------------------------
		---	TP/h:79	(DW:42	STP:39		QA:0%	TA:16%	DA:5%)
		-----------------------------------------------------------
		sets.engaged.DW3.Low.Min = set_combine(sets.engaged.DW3.Min,
		{
			ammo="Aurgelmir Orb +1",
			head="Dampening Tam"
		})

		-----------------------------------------------------------------------------------
		---	TP/h:79	(DW:42	STP:39		QA:0%	TA:16%	DA:5%)
		-----------------------------------------------------------
		sets.engaged.DW3.Mid.Min = set_combine(sets.engaged.DW3.Low.Min,
		{
			hands="Luh. Bazubands +3", lring={name="Chirich Ring +1", bag="wardrobe2"}
		})

		-----------------------------------------------------------------------------------
		---	TP/h:79	(DW:42	STP:39		QA:0%	TA:16%	DA:5%)
		-----------------------------------------------------------
		sets.engaged.DW3.High.Min = set_combine(sets.engaged.DW3.Mid.Min,
		{
			head="Carmine Mask +1",
			rring={name="Chirich Ring +1", bag="wardrobe3"}
		})
	
	
		----------------------------------------------------------
		--					(DW4 + 15% Haste)
		----------------------------------------------------------

		--30 DW = 37 DW needed		(Tier 2 Blu Trait)
		
		----------------------------------------------------------

		-----------------------------------------------------------------------------------
		---	TP/h:79	(DW:38	STP:39		QA:0%	TA:16%	DA:5%)
		-----------------------------------------------------------	
		sets.engaged.DW4.Min =
		{
			ammo="Aurgelmir Orb +1",
			head="Dampening Tam", neck="Mirage Stole +2", lear="Eabani Earring", rear="Suppanomimi",
			body="Adhemar Jacket +1", hands="Adhemar Wrist. +1", lring="Hetairoi Ring", rring="Epona's Ring",
			back=gear.BLUCape_DW, waist="Reiki Yotai", legs="Carmine Cuisses +1", feet=gear.HBoots_TP
		}
		
		sets.engaged.DW4.Min.AM3 =
		{
			ammo="Aurgelmir Orb +1",
			head=gear.AHead_TP, neck="Mirage Stole +2", lear="Eabani Earring", rear="Suppanomimi",
			body="Adhemar Jacket +1", hands="Adhemar Wrist. +1", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"},
			back=gear.BLUCape_DW, waist="Reiki Yotai", legs="Carmine Cuisses +1", feet="Malignance Boots"
		}
		
		-----------------------------------------------------------------------------------
		---	TP/h:79	(DW:37	STP:39		QA:0%	TA:16%	DA:5%)
		-----------------------------------------------------------
		sets.engaged.DW4.Low.Min = set_combine(sets.engaged.DW4.Min,
		{
			ammo="Aurgelmir Orb +1",
			head="Dampening Tam"
		})

		-----------------------------------------------------------------------------------
		---	TP/h:79	(DW:37	STP:39		QA:0%	TA:16%	DA:5%)
		-----------------------------------------------------------
		sets.engaged.DW4.Mid.Min = set_combine(sets.engaged.DW4.Low.Min,
		{
			head="Carmine Mask +1",
			hands="Luh. Bazubands +3", lring={name="Chirich Ring +1", bag="wardrobe2"}
		})

		-----------------------------------------------------------------------------------
		---	TP/h:79	(DW:37	STP:39		QA:0%	TA:16%	DA:5%)
		-----------------------------------------------------------
		sets.engaged.DW4.High.Min = set_combine(sets.engaged.DW4.Mid.Min,
		{
			rring={name="Chirich Ring +1", bag="wardrobe3"},
			feet="Malignance Boots"
		})
	
	
		----------------------------------------------------------
		--					(DW5 + 15% Haste)
		----------------------------------------------------------

		--30 DW = 32 DW needed		(Tier 3 Blu Trait)
		
		----------------------------------------------------------

		-----------------------------------------------------------------------------------
		---	TP/h:79	(DW:32	STP:39		QA:0%	TA:16%	DA:5%)
		-----------------------------------------------------------	
		sets.engaged.DW5.Min =
		{
			ammo="Aurgelmir Orb +1",
			head="Dampening Tam", neck="Mirage Stole +2", lear="Eabani Earring", rear="Suppanomimi",
			body="Adhemar Jacket +1", hands="Adhemar Wrist. +1", lring="Hetairoi Ring", rring="Epona's Ring",
			back=gear.BLUCape_DW, waist="Reiki Yotai", legs="Samnuha Tights", feet=gear.HBoots_TP
		}
		
		sets.engaged.DW5.Min.AM3 =
		{
			ammo="Aurgelmir Orb +1",
			head=gear.AHead_TP, neck="Mirage Stole +2", lear="Eabani Earring", rear="Suppanomimi",
			body="Malignance Tabard", hands="Adhemar Wrist. +1", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"},
			back=gear.BLUCape_DW, waist="Reiki Yotai", legs="Carmine Cuisses +1", feet="Malignance Boots"
		}
		
		-----------------------------------------------------------------------------------
		---	TP/h:79	(DW:32	STP:39		QA:0%	TA:16%	DA:5%)
		-----------------------------------------------------------
		sets.engaged.DW5.Low.Min = set_combine(sets.engaged.DW5.Min,
		{
			ammo="Aurgelmir Orb +1",
			head="Dampening Tam"
		})

		-----------------------------------------------------------------------------------
		---	TP/h:79	(DW:32	STP:39		QA:0%	TA:16%	DA:5%)
		-----------------------------------------------------------
		sets.engaged.DW5.Mid.Min = set_combine(sets.engaged.DW5.Low.Min,
		{
			head="Malignance Chapeau",
			hands="Malignance Gloves", lring={name="Chirich Ring +1", bag="wardrobe2"},
			legs="Malignance Tights"
		})

		-----------------------------------------------------------------------------------
		---	TP/h:79	(DW:32	STP:39		QA:0%	TA:16%	DA:5%)
		-----------------------------------------------------------
		sets.engaged.DW5.High.Min = set_combine(sets.engaged.DW5.Mid.Min,
		{
			head="Carmine Mask +1",
			body="Malignance Tabard", hands="Luh. Bazubands +3",  rring={name="Chirich Ring +1", bag="wardrobe3"},
			legs="Carmine Cuisses +1", feet="Malignance Boots"
		})
	
	
	
	----------------------------------------------------------
	-- Medium Haste
	----------------------------------------------------------
	
	--15 DW = 41 DW needed		(DNC Sub)

	--25 DW = 31 DW needed		(NIN Sub or BLU Trait)

	--30 DW = 26  DW needed		(Tier 2 BLU Trait)
	
	--35 DW = 21  DW needed		(Tier 3 BLU Trait)
	
	----------------------------------------------------------	
	
	
		----------------------------------------------------------
		--					(DW2 + 30% Haste)
		----------------------------------------------------------

		--15 DW = 41 DW needed		(DNC Sub)
		
		----------------------------------------------------------
	
		-----------------------------------------------------------------------------------
		---	TP/h:79	(DW:42	STP:39		QA:0%	TA:16%	DA:5%)
		-----------------------------------------------------------
		sets.engaged.DW2.Med =
		{
			ammo="Aurgelmir Orb +1",
			head="Dampening Tam", neck="Mirage Stole +2", lear="Eabani Earring", rear="Suppanomimi",
			body="Adhemar Jacket +1", hands="Adhemar Wrist. +1", lring="Hetairoi Ring", rring="Epona's Ring",
			back=gear.BLUCape_DW, waist="Reiki Yotai", legs="Carmine Cuisses +1", feet=gear.TFeet_TP
		}
		
		-----------------------------------------------------------------------------------
		---	TP/h:100	(DW:6	STP:50		QA:2%	TA:20%	DA:11%)
		-----------------------------------------------------------
		sets.engaged.DW2.Med.AM3 =
		{
			ammo="Aurgelmir Orb +1",
			head=gear.AHead_TP, neck="Mirage Stole +2", lear="Eabani Earring", rear="Suppanomimi",
			body="Adhemar Jacket +1", hands="Malignance Gloves", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"},
			back=gear.BLUCape_DW, waist="Reiki Yotai", legs="Carmine Cuisses +1", feet=gear.TFeet_TP
		}

		-----------------------------------------------------------------------------------
		---	TP/h:79	(DW:42	STP:39		QA:0%	TA:16%	DA:5%)
		-----------------------------------------------------------
		sets.engaged.DW2.Low.Med = set_combine(sets.engaged.DW2.Med,
		{
			ammo="Aurgelmir Orb +1",
			head="Dampening Tam"
		})

		-----------------------------------------------------------------------------------
		---	TP/h:79	(DW:42	STP:39		QA:0%	TA:16%	DA:5%)
		-----------------------------------------------------------
		sets.engaged.DW2.Mid.Med = set_combine(sets.engaged.DW2.Low.Med,
		{
			hands="Luh. Bazubands +3", lring={name="Chirich Ring +1", bag="wardrobe2"}
		})

		-----------------------------------------------------------------------------------
		---	TP/h:79	(DW:42	STP:39		QA:0%	TA:16%	DA:5%)
		-----------------------------------------------------------
		sets.engaged.DW2.High.Med = set_combine(sets.engaged.DW2.Mid.Med,
		{
			head="Carmine Mask +1",
			rring={name="Chirich Ring +1", bag="wardrobe3"}
		})
	
	
		----------------------------------------------------------
		--					(DW3 + 30% Haste)
		----------------------------------------------------------

		--25 DW = 31 DW needed		(NIN Sub or BLU Trait)
		
		----------------------------------------------------------
	
		-----------------------------------------------------------------------------------
		---	TP/h:79	(DW:32	STP:39		QA:0%	TA:16%	DA:5%)
		-----------------------------------------------------------
		sets.engaged.DW3.Med =
		{
			ammo="Aurgelmir Orb +1",
			head="Dampening Tam", neck="Mirage Stole +2", lear="Eabani Earring", rear="Suppanomimi",
			body="Adhemar Jacket +1", hands="Adhemar Wrist. +1", lring="Hetairoi Ring", rring="Epona's Ring",
			back=gear.BLUCape_DW, waist="Reiki Yotai", legs="Samnuha Tights", feet=gear.HBoots_TP
		}
		
		-----------------------------------------------------------------------------------
		---	TP/h:100	(DW:32	STP:50		QA:2%	TA:20%	DA:11%)
		-----------------------------------------------------------
		sets.engaged.DW3.Med.AM3 =
		{
			ammo="Aurgelmir Orb +1",
			head="Dampening Tam", neck="Mirage Stole +2", lear="Eabani Earring", rear="Suppanomimi",
			body="Adhemar Jacket +1", hands="Malignance Gloves", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"},
			back=gear.BLUCape_DW, waist="Reiki Yotai", legs="Malignance Tights", feet="Malignance Boots"
		}

		-----------------------------------------------------------------------------------
		---	TP/h:79	(DW:32	STP:40		QA:2%	TA:10%	DA:2%)
		-----------------------------------------------------------
		sets.engaged.DW3.Low.Med = set_combine(sets.engaged.DW3.Med,
		{
			ammo="Aurgelmir Orb +1",
			head="Dampening Tam",
			lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"},
			legs="Malignance Tights"
		})

		-----------------------------------------------------------------------------------
		---	TP/h:78	(DW:31	STP:36		QA:2%	TA:8%	DA:3%)
		-----------------------------------------------------------
		sets.engaged.DW3.Mid.Med = set_combine(sets.engaged.DW3.Low.Med,
		{
			head="Malignance Chapeau", lear="Eabani Earring",
			hands="Malignance Gloves",
			feet="Malignance Boots"
		})

		-----------------------------------------------------------------------------------
		---	TP/h:78	(DW:32	STP:36		QA:0%	TA:5%	DA:0%)
		-----------------------------------------------------------
		sets.engaged.DW3.High.Med = set_combine(sets.engaged.DW3.Mid.Med,
		{
			head="Carmine Mask +1",
			body="Assim. Jubbah +3", 
			legs="Carmine Cuisses +1", feet="Assim. Charuqs +3"
		})

		
		----------------------------------------------------------
		--					(DW4 + 30% Haste)
		----------------------------------------------------------

		--30 DW = 26 DW needed		(Tier 2 Blu Trait)
		
		----------------------------------------------------------
	
		-----------------------------------------------------------------------------------
		---	TP/h:84	(DW:25	STP:46		QA:0%	TA:19%	DA:8%)
		-----------------------------------------------------------
		sets.engaged.DW4.Med =
		{
			ammo="Aurgelmir Orb +1",
			head="Dampening Tam", neck="Mirage Stole +2", lear="Eabani Earring", rear="Suppanomimi",
			body="Adhemar Jacket +1", hands="Adhemar Wrist. +1", lring="Hetairoi Ring", rring="Epona's Ring",
			back=gear.BLUCape_DW, waist="Windbuffet Belt +1", legs="Samnuha Tights", feet=gear.HBoots_TP
		}
		
		-----------------------------------------------------------------------------------
		---	TP/h:100	(DW:27	STP:50		QA:2%	TA:20%	DA:11%)
		-----------------------------------------------------------
		sets.engaged.DW4.Med.AM3 =
		{
			ammo="Aurgelmir Orb +1",
			head="Dampening Tam", neck="Mirage Stole +2", lear="Eabani Earring", rear="Dedition Earring",
			body="Adhemar Jacket +1", hands="Adhemar Wrist. +1", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"},
			back=gear.BLUCape_DW, waist="Reiki Yotai", legs="Malignance Tights", feet="Malignance Boots"
		}

		-----------------------------------------------------------------------------------
		---	TP/h:84	(DW:26	STP:47		QA:2%	TA:16%	DA:6%)
		-----------------------------------------------------------
		sets.engaged.DW4.Low.Med = set_combine(sets.engaged.DW4.Med,
		{
			ammo="Aurgelmir Orb +1",
			head="Malignance Chapeau", lear="Telos Earring",
			lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"},
			waist="Reiki Yotai", legs="Malignance Tights"
		})

		-----------------------------------------------------------------------------------
		---	TP/h:85	(DW:27	STP:48		QA:2%	TA:8%	DA:4%)I 
		-----------------------------------------------------------
		sets.engaged.DW4.Mid.Med = set_combine(sets.engaged.DW4.Low.Med,
		{
			lear="Eabani Earring", rear={name="Mache Earring +1", bag="wardrobe3"},
			hands="Malignance Gloves",
			feet="Malignance Boots"
		})

		-----------------------------------------------------------------------------------
		---	TP/h:78	(DW:26	STP:36		QA:0%	TA:3%	DA:0%)
		-----------------------------------------------------------
		sets.engaged.DW4.High.Med = set_combine(sets.engaged.DW4.Mid.Med,
		{
			head="Carmine Mask +1", rear="Suppanomimi",
			body="Assim. Jubbah +3", hands="Luh. Bazubands +3",
			waist="Kentarch Belt +1", legs="Carmine Cuisses +1", feet="Assim. Charuqs +3"
		})

		
		----------------------------------------------------------
		--					(DW5 + 30% Haste)
		----------------------------------------------------------

		--35 DW = 21 DW needed		(Tier 3 Blu Trait)
		
		----------------------------------------------------------
	
		-----------------------------------------------------------------------------------
		---	TP/h:84	(DW:21	STP:46		QA:0%	TA:19%	DA:8%)
		-----------------------------------------------------------
		sets.engaged.DW5.Med =
		{
			ammo="Aurgelmir Orb +1",
			head="Dampening Tam", neck="Mirage Stole +2", lear="Brutal Earring", rear="Suppanomimi",
			body="Adhemar Jacket +1", hands="Adhemar Wrist. +1", lring="Hetairoi Ring", rring="Epona's Ring",
			back=gear.BLUCape_DW, waist="Windbuffet Belt +1", legs="Samnuha Tights", feet=gear.HBoots_TP
		}
		
		-----------------------------------------------------------------------------------
		---	TP/h:100	(DW:21	STP:50		QA:2%	TA:20%	DA:11%)
		-----------------------------------------------------------
		sets.engaged.DW5.Med.AM3 =
		{
			ammo="Aurgelmir Orb +1",
			head="Malignance Chapeau", neck="Mirage Stole +2", lear="Eabani Earring", rear="Dedition Earring",
			body="Malignance Tabard", hands="Malignance Gloves", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"},
			back=gear.BLUCape_DW, waist="Reiki Yotai", legs="Malignance Tights", feet="Malignance Boots"
		}

		-----------------------------------------------------------------------------------
		---	TP/h:84	(DW:21	STP:47		QA:2%	TA:16%	DA:6%)
		-----------------------------------------------------------
		sets.engaged.DW5.Low.Med = set_combine(sets.engaged.DW5.Med,
		{
			ammo="Aurgelmir Orb +1",
			head="Dampening Tam", lear={name="Mache Earring +1", bag="wardrobe2"},
			lring={name="Chirich Ring +1", bag="wardrobe2"}
		})

		-----------------------------------------------------------------------------------
		---	TP/h:85	(DW:23	STP:48		QA:2%	TA:8%	DA:4%)I 
		-----------------------------------------------------------
		sets.engaged.DW5.Mid.Med = set_combine(sets.engaged.DW5.Low.Med,
		{
			rear={name="Mache Earring +1", bag="wardrobe3"},
			rring={name="Chirich Ring +1", bag="wardrobe3"},
			waist="Reiki Yotai", legs="Malignance Tights"
		})

		-----------------------------------------------------------------------------------
		---	TP/h:78	(DW:21	STP:36		QA:0%	TA:3%	DA:0%)
		-----------------------------------------------------------
		sets.engaged.DW5.High.Med = set_combine(sets.engaged.DW5.Mid.Med,
		{
			head="Carmine Mask +1", rear="Suppanomimi",
			body="Luhlaza Jubbah +3", hands="Luh. Bazubands +3",
			waist="Kentarch Belt +1", legs="Carmine Cuisses +1", feet="Assim. Charuqs +3"
		})
	
	

	----------------------------------------------------------
	-- Maximum Haste
	----------------------------------------------------------
	
	--15 DW = 21 DW needed		(DNC Sub)

	--25 DW = 11 DW needed		(NIN Sub or BLU Trait)

	--30 DW = 6  DW needed		(Tier 2 BLU Trait)
	
	----------------------------------------------------------	

	
		----------------------------------------------------------
		--					(DW2 + Max Haste)
		----------------------------------------------------------

		--25 DW = 21 DW needed		(DNC Sub)
		
		----------------------------------------------------------
	
		-----------------------------------------------------------------------------------
		---		(DW:21	STP:52		QA:2%	TA:22%	DA:9%)
		-----------------------------------------------------------
		sets.engaged.DW2.Max =
		{
			ammo="Aurgelmir Orb +1",
			head="Dampening Tam", neck="Mirage Stole +2", lear="Brutal Earring", rear="Suppanomimi",
			body="Adhemar Jacket +1", hands="Adhemar Wrist. +1", lring="Hetairoi Ring", rring="Epona's Ring",
			back=gear.BLUCape_DW, waist="Windbuffet Belt +1", legs="Samnuha Tights", feet=gear.HBoots_TP
		}
		
		-----------------------------------------------------------------------------------
		---		(DW:21	STP:52		QA:2%	TA:22%	DA:9%)
		-----------------------------------------------------------
		sets.engaged.DW2.Max.AM3 =
		{
			ammo="Aurgelmir Orb +1",
			head="Malignance Chapeau", neck="Mirage Stole +2", lear="Telos Earring", rear="Suppanomimi",
			body="Adhemar Jacket +1", hands="Adhemar Wrist. +1", lring="Hetairoi Ring", rring="Epona's Ring",
			back=gear.BLUCape_DW, waist="Windbuffet Belt +1", legs="Malignance Tights", feet="Malignance Boots"
		}

		-----------------------------------------------------------------------------------
		---		(DW:21	STP:53		QA:4%	TA:19%	DA:7%)
		-----------------------------------------------------------
		sets.engaged.DW2.Low.Max = set_combine(sets.engaged.DW2.Max,
		{
			ammo="Aurgelmir Orb +1",
			head="Dampening Tam", lear={name="Mache Earring +1", bag="wardrobe2"},
			lring={name="Chirich Ring +1", bag="wardrobe2"}
		})

		-----------------------------------------------------------------------------------
		---		(DW:22	STP:54		QA:2%	TA:14%	DA:14%)
		-----------------------------------------------------------
		sets.engaged.DW2.Mid.Max = set_combine(sets.engaged.DW2.Low.Max,
		{
			rear={name="Mache Earring +1", bag="wardrobe3"},
			rring={name="Chirich Ring +1", bag="wardrobe3"},
			waist="Reiki Yotai", legs="Malignance Tights"
		})

		-----------------------------------------------------------------------------------
		---		(DW:23	STP:46~50	QA:0%	TA:5%	DA:15%)
		-----------------------------------------------------------
		sets.engaged.DW2.High.Max = set_combine(sets.engaged.DW2.Mid.Max,
		{
			head="Carmine Mask +1", rear="Suppanomimi",
			body="Luhlaza Jubbah +3", hands="Luh. Bazubands +3",
			waist="Kentarch Belt +1", legs="Carmine Cuisses +1", feet="Assim. Charuqs +3"
		})
	
	
		----------------------------------------------------------
		--					(DW3 + Max Haste)
		----------------------------------------------------------

		--25 DW = 11 DW needed		(NIN Sub or BLU Trait)
		
		----------------------------------------------------------
	
		-----------------------------------------------------------------------------------
		---		(DW:11	STP:33		QA:2%	TA:28%	DA:11%)
		-----------------------------------------------------------
		sets.engaged.DW3.Max =
		{
			ammo="Aurgelmir Orb +1",
			head="Dampening Tam", neck="Mirage Stole +2", lear="Brutal Earring", rear="Suppanomimi",
			body="Adhemar Jacket +1", hands="Adhemar Wrist. +1", lring="Hetairoi Ring", rring="Epona's Ring",
			back=gear.BLUCape_STP, waist="Windbuffet Belt +1", legs="Samnuha Tights", feet=gear.HBoots_TP
		}
		
		-----------------------------------------------------------------------------------
		---		(DW:13	STP:70		QA:4%	TA:14%	DA:8%)
		-----------------------------------------------------------
		sets.engaged.DW3.Max.AM3 =
		{
			ammo="Aurgelmir Orb +1",
			head="Malignance Chapeau", neck="Mirage Stole +2", lear="Telos Earring", rear="Suppanomimi",
			body="Adhemar Jacket +1", hands="Malignance Gloves",  lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"},
			back=gear.BLUCape_STP, waist="Windbuffet Belt +1", legs="Malignance Tights", feet="Malignance Boots"
		}

		-----------------------------------------------------------------------------------
		---		(DW:11	STP:32		QA:5%	TA:24%	DA:8%)
		-----------------------------------------------------------
		sets.engaged.DW3.Low.Max = set_combine(sets.engaged.DW3.Max,
		{
			
			head="Malignance Chapeau", lear="Telos Earring", 
			lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"},
			legs="Malignance Tights"
		})

		-----------------------------------------------------------------------------------
		---		(DW:12	STP:38		QA:3%	TA:22%	DA:10%)
		-----------------------------------------------------------
		sets.engaged.DW3.Mid.Max = set_combine(sets.engaged.DW3.Low.Max,
		{
			head="Malignance Chapeau", rear="Suppanomimi",
			hands="Luh. Bazubands +3",
			waist="Kentarch Belt +1"
		})

		-----------------------------------------------------------------------------------
		---		(DW:13	STP:24		QA:0%	TA:0%	DA:11%)
		-----------------------------------------------------------
		sets.engaged.DW3.High.Max = set_combine(sets.engaged.DW3.Mid.Max,
		{
			head="Carmine Mask +1", lear={name="Mache Earring +1", bag="wardrobe2"},
			body="Assim. Jubbah +3", hands="Malignance Gloves",
			back=gear.BLUCape_DW, legs="Malignance Tights", feet="Assim. Charuqs +3"
		})

		
		----------------------------------------------------------
		--					(DW4 + Max Haste)
		----------------------------------------------------------

		--30 DW = 6 DW needed		(Tier 2 Blu Trait)
		
		----------------------------------------------------------
	
		-----------------------------------------------------------------------------------
		---		(DW:6	STP:38		QA:2%	TA:28%	DA:14%)
		-----------------------------------------------------------
		sets.engaged.DW4.Max =
		{
			ammo="Aurgelmir Orb +1",
			head="Dampening Tam", neck="Mirage Stole +2", lear="Telos Earring", rear="Brutal Earring",
			body="Adhemar Jacket +1", hands="Adhemar Wrist. +1", lring="Hetairoi Ring", rring="Epona's Ring",
			back=gear.BLUCape_STP, waist="Windbuffet Belt +1", legs="Samnuha Tights", feet=gear.HBoots_TP
		}
		
		-----------------------------------------------------------------------------------
		---		(DW:6	STP:61		QA:6%	TA:16%	DA:11%)
		-----------------------------------------------------------
		sets.engaged.DW4.Max.AM3 =
		{
			ammo="Aurgelmir Orb +1",
			head="Dampening Tam", neck="Mirage Stole +2", lear="Telos Earring", rear="Dedition Earring",
			body="Adhemar Jacket +1", hands="Malignance Gloves",  lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"},
			back=gear.BLUCape_STP, waist="Windbuffet Belt +1", legs="Malignance Tights", feet="Malignance Boots"
		}

		-----------------------------------------------------------------------------------
		---		(DW:6	STP:34		QA:5%	TA:24%	DA:10%)
		-----------------------------------------------------------
		sets.engaged.DW4.Low.Max = set_combine(sets.engaged.DW4.Max,
		{
			ammo="Aurgelmir Orb +1",
			lear="Telos Earring", rear={name="Mache Earring +1", bag="wardrobe3"},
			lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"},
			legs="Malignance Tights", feet="Malignance Boots"
		})

		-----------------------------------------------------------------------------------
		---		(DW:6	STP:37~41	QA:3%	TA:17%	DA:10%)
		-----------------------------------------------------------
		sets.engaged.DW4.Mid.Max = set_combine(sets.engaged.DW4.Low.Max,
		{
			head="Malignance Chapeau", lear={name="Mache Earring +1", bag="wardrobe2"}, 
			hands="Malignance Gloves",
			waist="Kentarch Belt +1"
		})

		-----------------------------------------------------------------------------------
		---		(DW:6	STP:23~27	QA:0%	TA:0%	DA:15%)
		-----------------------------------------------------------
		sets.engaged.DW4.High.Max = set_combine(sets.engaged.DW4.Mid.Max,
		{
			head="Carmine Mask +1",
			body="Assim. Jubbah +3",
			legs="Carmine Cuisses +1", feet="Assim. Charuqs +3"
		})

		
		----------------------------------------------------------
		--					(DW5 + Max Haste)
		----------------------------------------------------------

		--35 DW = 1 DW needed		(Tier 3 Blu Trait)
		
		----------------------------------------------------------
	
		-----------------------------------------------------------------------------------
		---		(DW:6	STP:38		QA:2%	TA:28%	DA:14%)
		-----------------------------------------------------------
		sets.engaged.DW5.Max =
		{
			ammo="Aurgelmir Orb +1",
			head="Dampening Tam", neck="Mirage Stole +2", lear="Brutal Earring", rear="Digni. Earring",
			body="Malignance Tabard", hands="Adhemar Wrist. +1", lring="Hetairoi Ring", rring="Epona's Ring",
			back=gear.BLUCape_STP, waist="Windbuffet Belt +1", legs="Samnuha Tights", feet=gear.HBoots_TP
		}
		
		-----------------------------------------------------------------------------------
		---		(DW:6	STP:61		QA:6%	TA:16%	DA:11%)
		-----------------------------------------------------------
		sets.engaged.DW5.Max.AM3 =
		{
			ammo="Aurgelmir Orb +1",
			head="Dampening Tam", neck="Mirage Stole +2", lear="Telos Earring", rear="Dedition Earring",
			body="Malignance Tabard", hands="Malignance Gloves", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"},
			back=gear.BLUCape_STP, waist="Windbuffet Belt +1", legs="Malignance Tights", feet="Malignance Boots"
		}

		-----------------------------------------------------------------------------------
		---		(DW:6	STP:34		QA:5%	TA:24%	DA:10%)
		-----------------------------------------------------------
		sets.engaged.DW5.Low.Max = set_combine(sets.engaged.DW5.Max,
		{
			ammo="Aurgelmir Orb +1",
			head="Dampening Tam", lear="Telos Earring", rear={name="Mache Earring +1", bag="wardrobe3"},
			lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"}
		})

		-----------------------------------------------------------------------------------
		---		(DW:6	STP:37~41	QA:3%	TA:17%	DA:10%)
		-----------------------------------------------------------
		sets.engaged.DW5.Mid.Max = set_combine(sets.engaged.DW5.Low.Max,
		{
			lear={name="Mache Earring +1", bag="wardrobe2"}, 
			hands="Malignance Gloves",
			legs="Malignance Tights", feet="Malignance Boots"
		})

		-----------------------------------------------------------------------------------
		---		(DW:6	STP:23~27	QA:0%	TA:0%	DA:15%)
		-----------------------------------------------------------
		sets.engaged.DW5.High.Max = set_combine(sets.engaged.DW5.Mid.Max,
		{
			head="Malignance Chapeau",
			body="Luhlaza Jubbah +3", hands="Luh. Bazubands +3",
			waist="Kentarch Belt +1", feet="Assim. Charuqs +3"
		})

		
		
		
		
	--------------------------------------
	-- Hybrid Sets
	--------------------------------------
		sets.engaged.Hybrid = 
		{-- DT: 31%		PDT: 31%	MDT: 31%
			head="Malignance Chapeau",
			body="Malignance Tabard", hands="Malignance Gloves",
			legs="Malignance Tights", feet="Malignance Boots"
		}
		
		sets.engaged.Hybrid2 = 
		{-- DT: 44%		PDT: 51%	MDT: 43%
			ammo="Staunch Tathlum +1",
			head="Malignance Chapeau",
			body="Malignance Tabard", hands="Malignance Gloves", lring="Defending Ring",
			legs="Malignance Tights", feet="Malignance Boots"
		}
				
		sets.SubtleBlow =
		{--		Subtle Blow 50
			head="Dampening Tam", lear="Digni. Earring",
			hands="Luh. Bazubands +3", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"},
			feet=gear.HBoots_TP
		}
		
		
		----------------------------------------------------------
		-- Sword & Board
		----------------------------------------------------------	
	    sets.engaged.DT 					= set_combine(sets.engaged, 		sets.engaged.Hybrid)
		sets.engaged.DT.AM3 				= set_combine(sets.engaged.AM3,		sets.engaged.Hybrid)
		sets.engaged.Low.DT 				= set_combine(sets.engaged.Low, 	sets.engaged.Hybrid)
		sets.engaged.Mid.DT 				= set_combine(sets.engaged.Mid, 	sets.engaged.Hybrid)
		sets.engaged.High.DT				= set_combine(sets.engaged.High, 	sets.engaged.Hybrid)
		
	
		sets.engaged.DTMAX 					= set_combine(sets.engaged, 		sets.engaged.Hybrid2)
		sets.engaged.DTMAX.AM3 				= set_combine(sets.engaged.AM3,		sets.engaged.Hybrid2)
		sets.engaged.Low.DTMAX 				= set_combine(sets.engaged.Low, 	sets.engaged.Hybrid2)
		sets.engaged.Mid.DTMAX				= set_combine(sets.engaged.Mid, 	sets.engaged.Hybrid2)
		sets.engaged.High.DTMAX				= set_combine(sets.engaged.High, 	sets.engaged.Hybrid2)
		
		sets.engaged.SB 					= set_combine(sets.engaged, 		sets.SubtleBlow)
		sets.engaged.SB.AM3 				= set_combine(sets.engaged.AM3,		sets.SubtleBlow)
		sets.engaged.Low.SB 				= set_combine(sets.engaged.Low, 	sets.SubtleBlow)
		sets.engaged.Mid.SB 				= set_combine(sets.engaged.Mid, 	sets.SubtleBlow)
		sets.engaged.High.SB				= set_combine(sets.engaged.High, 	sets.SubtleBlow)

		
	
		----------------------------------------------------------
		-- No Haste
		----------------------------------------------------------
		sets.engaged.DW2.DT 				= set_combine(sets.engaged.DW2, 		sets.engaged.Hybrid,
		{
			body="Adhemar Jacket +1"
		})
		sets.engaged.DW2.DT.AM3 			= set_combine(sets.engaged.DW2.AM3, 	sets.engaged.Hybrid,
		{
			body="Adhemar Jacket +1"
		})
		sets.engaged.DW2.Low.DT 			= set_combine(sets.engaged.DW2.Low, 	sets.engaged.Hybrid,
		{
			body="Adhemar Jacket +1"
		})
		sets.engaged.DW2.Mid.DT 			= set_combine(sets.engaged.DW2.Mid, 	sets.engaged.Hybrid,
		{
			body="Adhemar Jacket +1"
		})
		sets.engaged.DW2.High.DT 			= set_combine(sets.engaged.DW2.High, 	sets.engaged.Hybrid,
		{
			body="Adhemar Jacket +1"
		})

	
		sets.engaged.DW3.DT 				= set_combine(sets.engaged.DW3, 		sets.engaged.Hybrid)
		sets.engaged.DW3.DT.AM3 			= set_combine(sets.engaged.DW3.AM3, 	sets.engaged.Hybrid)
		sets.engaged.DW3.Low.DT 			= set_combine(sets.engaged.DW3.Low, 	sets.engaged.Hybrid)
		sets.engaged.DW3.Mid.DT 			= set_combine(sets.engaged.DW3.Mid, 	sets.engaged.Hybrid)
		sets.engaged.DW3.High.DT 			= set_combine(sets.engaged.DW3.High, 	sets.engaged.Hybrid)
		
	
		sets.engaged.DW4.DT 				= set_combine(sets.engaged.DW4, 		sets.engaged.Hybrid)
		sets.engaged.DW4.DT.AM3 			= set_combine(sets.engaged.DW4.AM3, 	sets.engaged.Hybrid)
		sets.engaged.DW4.Low.DT 			= set_combine(sets.engaged.DW4.Low, 	sets.engaged.Hybrid)
		sets.engaged.DW4.Mid.DT 			= set_combine(sets.engaged.DW4.Mid, 	sets.engaged.Hybrid)
		sets.engaged.DW4.High.DT 			= set_combine(sets.engaged.DW4.High, 	sets.engaged.Hybrid)
		
	
		sets.engaged.DW5.DT 				= set_combine(sets.engaged.DW5, 		sets.engaged.Hybrid)
		sets.engaged.DW5.DT.AM3 			= set_combine(sets.engaged.DW5.AM3, 	sets.engaged.Hybrid)
		sets.engaged.DW5.Low.DT 			= set_combine(sets.engaged.DW5.Low, 	sets.engaged.Hybrid)
		sets.engaged.DW5.Mid.DT 			= set_combine(sets.engaged.DW5.Mid, 	sets.engaged.Hybrid)
		sets.engaged.DW5.High.DT 			= set_combine(sets.engaged.DW5.High, 	sets.engaged.Hybrid)
		
		
		
		sets.engaged.DW2.DTMAX 				= set_combine(sets.engaged.DW2, 		sets.engaged.Hybrid)
		sets.engaged.DW2.DTMAX.AM3 			= set_combine(sets.engaged.DW2.AM3, 	sets.engaged.Hybrid)
		sets.engaged.DW2.Low.DTMAX 			= set_combine(sets.engaged.DW2.Low, 	sets.engaged.Hybrid)
		sets.engaged.DW2.Mid.DTMAX 			= set_combine(sets.engaged.DW2.Mid, 	sets.engaged.Hybrid)
		sets.engaged.DW2.High.DTMAX			= set_combine(sets.engaged.DW2.High, 	sets.engaged.Hybrid)

	
		sets.engaged.DW3.DTMAX 				= set_combine(sets.engaged.DW3, 		sets.engaged.Hybrid)
		sets.engaged.DW3.DTMAX.AM3 			= set_combine(sets.engaged.DW3.AM3, 	sets.engaged.Hybrid)
		sets.engaged.DW3.Low.DTMAX 			= set_combine(sets.engaged.DW3.Low, 	sets.engaged.Hybrid)
		sets.engaged.DW3.Mid.DTMAX 			= set_combine(sets.engaged.DW3.Mid, 	sets.engaged.Hybrid)
		sets.engaged.DW3.High.DTMAX			= set_combine(sets.engaged.DW3.High, 	sets.engaged.Hybrid)
		
	
		sets.engaged.DW4.DTMAX 				= set_combine(sets.engaged.DW4, 		sets.engaged.Hybrid)
		sets.engaged.DW4.DTMAX.AM3 			= set_combine(sets.engaged.DW4.AM3, 	sets.engaged.Hybrid)
		sets.engaged.DW4.Low.DTMAX 			= set_combine(sets.engaged.DW4.Low, 	sets.engaged.Hybrid)
		sets.engaged.DW4.Mid.DTMAX 			= set_combine(sets.engaged.DW4.Mid, 	sets.engaged.Hybrid)
		sets.engaged.DW4.High.DTMAX			= set_combine(sets.engaged.DW4.High, 	sets.engaged.Hybrid)
		
		
		sets.engaged.DW5.DTMAX 				= set_combine(sets.engaged.DW5, 		sets.engaged.Hybrid)
		sets.engaged.DW5.DTMAX.AM3 			= set_combine(sets.engaged.DW5.AM3, 	sets.engaged.Hybrid)
		sets.engaged.DW5.Low.DTMAX 			= set_combine(sets.engaged.DW5.Low, 	sets.engaged.Hybrid)
		sets.engaged.DW5.Mid.DTMAX 			= set_combine(sets.engaged.DW5.Mid, 	sets.engaged.Hybrid)
		sets.engaged.DW5.High.DTMAX			= set_combine(sets.engaged.DW5.High, 	sets.engaged.Hybrid)
		
		
		
		sets.engaged.DW2.SB 				= set_combine(sets.engaged.DW2, 		sets.SubtleBlow)
		sets.engaged.DW2.SB.AM3 			= set_combine(sets.engaged.DW2.AM3, 	sets.SubtleBlow)
		sets.engaged.DW2.Low.SB 			= set_combine(sets.engaged.DW2.Low, 	sets.SubtleBlow)
		sets.engaged.DW2.Mid.SB 			= set_combine(sets.engaged.DW2.Mid, 	sets.SubtleBlow)
		sets.engaged.DW2.High.SB			= set_combine(sets.engaged.DW2.High, 	sets.SubtleBlow)

	
		sets.engaged.DW3.SB 				= set_combine(sets.engaged.DW3, 		sets.SubtleBlow)
		sets.engaged.DW3.SB.AM3 			= set_combine(sets.engaged.DW3.AM3, 	sets.SubtleBlow)
		sets.engaged.DW3.Low.SB 			= set_combine(sets.engaged.DW3.Low, 	sets.SubtleBlow)
		sets.engaged.DW3.Mid.SB 			= set_combine(sets.engaged.DW3.Mid, 	sets.SubtleBlow)
		sets.engaged.DW3.High.SB			= set_combine(sets.engaged.DW3.High, 	sets.SubtleBlow)
		
	
		sets.engaged.DW4.SB 				= set_combine(sets.engaged.DW4, 		sets.SubtleBlow)
		sets.engaged.DW4.SB.AM3 			= set_combine(sets.engaged.DW4.AM3, 	sets.SubtleBlow)
		sets.engaged.DW4.Low.SB 			= set_combine(sets.engaged.DW4.Low, 	sets.SubtleBlow)
		sets.engaged.DW4.Mid.SB 			= set_combine(sets.engaged.DW4.Mid, 	sets.SubtleBlow)
		sets.engaged.DW4.High.SB			= set_combine(sets.engaged.DW4.High, 	sets.SubtleBlow)
		
		
		sets.engaged.DW5.SB 				= set_combine(sets.engaged.DW5, 		sets.SubtleBlow)
		sets.engaged.DW5.SB.AM3 			= set_combine(sets.engaged.DW5.AM3, 	sets.SubtleBlow)
		sets.engaged.DW5.Low.SB 			= set_combine(sets.engaged.DW5.Low, 	sets.SubtleBlow)
		sets.engaged.DW5.Mid.SB 			= set_combine(sets.engaged.DW5.Mid, 	sets.SubtleBlow)
		sets.engaged.DW5.High.SB			= set_combine(sets.engaged.DW5.High, 	sets.SubtleBlow)
		
		
	
		----------------------------------------------------------
		-- Minimum Haste
		----------------------------------------------------------
		sets.engaged.DW2.DT.Min 			= set_combine(sets.engaged.DW2.Min,			sets.engaged.Hybrid)
		sets.engaged.DW2.DT.Min.AM3  		= set_combine(sets.engaged.DW2.Min.AM3, 	sets.engaged.Hybrid)
		sets.engaged.DW2.Low.DT.Min  		= set_combine(sets.engaged.DW2.Low.Min, 	sets.engaged.Hybrid)
		sets.engaged.DW2.Mid.DT.Min  		= set_combine(sets.engaged.DW2.Mid.Min, 	sets.engaged.Hybrid)
		sets.engaged.DW2.High.DT.Min 		= set_combine(sets.engaged.DW2.High.Min, 	sets.engaged.Hybrid)
		
	
		sets.engaged.DW3.DT.Min 	 		= set_combine(sets.engaged.DW3.Min, 		sets.engaged.Hybrid)
		sets.engaged.DW3.DT.Min.AM3  		= set_combine(sets.engaged.DW3.Min.AM3, 	sets.engaged.Hybrid)
		sets.engaged.DW3.Low.DT.Min  		= set_combine(sets.engaged.DW3.Low.Min, 	sets.engaged.Hybrid)
		sets.engaged.DW3.Mid.DT.Min  		= set_combine(sets.engaged.DW3.Mid.Min, 	sets.engaged.Hybrid)
		sets.engaged.DW3.High.DT.Min 		= set_combine(sets.engaged.DW3.High.Min, 	sets.engaged.Hybrid)
		
	
		sets.engaged.DW4.DT.Min				= set_combine(sets.engaged.DW4.Min, 		sets.engaged.Hybrid)
		sets.engaged.DW4.DT.Min.AM3  		= set_combine(sets.engaged.DW4.Min.AM3, 	sets.engaged.Hybrid)
		sets.engaged.DW4.Low.DT.Min  		= set_combine(sets.engaged.DW4.Low.Min, 	sets.engaged.Hybrid)
		sets.engaged.DW4.Mid.DT.Min  		= set_combine(sets.engaged.DW4.Mid.Min, 	sets.engaged.Hybrid)
		sets.engaged.DW4.High.DT.Min 		= set_combine(sets.engaged.DW4.High.Min, 	sets.engaged.Hybrid)
		
	
		sets.engaged.DW5.DT.Min				= set_combine(sets.engaged.DW5.Min, 		sets.engaged.Hybrid)
		sets.engaged.DW5.DT.Min.AM3  		= set_combine(sets.engaged.DW5.Min.AM3, 	sets.engaged.Hybrid)
		sets.engaged.DW5.Low.DT.Min  		= set_combine(sets.engaged.DW5.Low.Min, 	sets.engaged.Hybrid)
		sets.engaged.DW5.Mid.DT.Min  		= set_combine(sets.engaged.DW5.Mid.Min, 	sets.engaged.Hybrid)
		sets.engaged.DW5.High.DT.Min 		= set_combine(sets.engaged.DW5.High.Min, 	sets.engaged.Hybrid)
		
		
		
		sets.engaged.DW2.DTMAX.Min 	 		= set_combine(sets.engaged.DW2.Min, 		sets.engaged.Hybrid)
		sets.engaged.DW2.DTMAX.Min.AM3  	= set_combine(sets.engaged.DW2.Min.AM3, 	sets.engaged.Hybrid)
		sets.engaged.DW2.Low.DTMAX.Min  	= set_combine(sets.engaged.DW2.Low.Min, 	sets.engaged.Hybrid)
		sets.engaged.DW2.Mid.DTMAX.Min  	= set_combine(sets.engaged.DW2.Mid.Min, 	sets.engaged.Hybrid)
		sets.engaged.DW2.High.DTMAX.Min		= set_combine(sets.engaged.DW2.High.Min, 	sets.engaged.Hybrid)
		
	
		sets.engaged.DW3.DTMAX.Min 	 		= set_combine(sets.engaged.DW3.Min, 		sets.engaged.Hybrid)
		sets.engaged.DW3.DTMAX.Min.AM3  	= set_combine(sets.engaged.DW3.Min.AM3, 	sets.engaged.Hybrid)
		sets.engaged.DW3.Low.DTMAX.Min  	= set_combine(sets.engaged.DW3.Low.Min, 	sets.engaged.Hybrid)
		sets.engaged.DW3.Mid.DTMAX.Min  	= set_combine(sets.engaged.DW3.Mid.Min, 	sets.engaged.Hybrid)
		sets.engaged.DW3.High.DTMAX.Min 	= set_combine(sets.engaged.DW3.High.Min, 	sets.engaged.Hybrid)
		
	
		sets.engaged.DW4.DTMAX.Min 	 		= set_combine(sets.engaged.DW4.Min, 		sets.engaged.Hybrid)
		sets.engaged.DW4.DTMAX.Min.AM3  	= set_combine(sets.engaged.DW4.Min.AM3, 	sets.engaged.Hybrid)
		sets.engaged.DW4.Low.DTMAX.Min  	= set_combine(sets.engaged.DW4.Low.Min, 	sets.engaged.Hybrid)
		sets.engaged.DW4.Mid.DTMAX.Min  	= set_combine(sets.engaged.DW4.Mid.Min, 	sets.engaged.Hybrid)
		sets.engaged.DW4.High.DTMAX.Min 	= set_combine(sets.engaged.DW4.High.Min, 	sets.engaged.Hybrid)
		
	
		sets.engaged.DW5.DTMAX.Min			= set_combine(sets.engaged.DW5.Min, 		sets.engaged.Hybrid)
		sets.engaged.DW5.DTMAX.Min.AM3  	= set_combine(sets.engaged.DW5.Min.AM3, 	sets.engaged.Hybrid)
		sets.engaged.DW5.Low.DTMAX.Min  	= set_combine(sets.engaged.DW5.Low.Min, 	sets.engaged.Hybrid)
		sets.engaged.DW5.Mid.DTMAX.Min  	= set_combine(sets.engaged.DW5.Mid.Min, 	sets.engaged.Hybrid)
		sets.engaged.DW5.High.DTMAX.Min 	= set_combine(sets.engaged.DW5.High.Min, 	sets.engaged.Hybrid)
		
		
		
		sets.engaged.DW2.SB.Min 	 		= set_combine(sets.engaged.DW2.Min, 		sets.SubtleBlow)
		sets.engaged.DW2.SB.Min.AM3  		= set_combine(sets.engaged.DW2.Min.AM3, 	sets.SubtleBlow)
		sets.engaged.DW2.Low.SB.Min  		= set_combine(sets.engaged.DW2.Low.Min, 	sets.SubtleBlow)
		sets.engaged.DW2.Mid.SB.Min  		= set_combine(sets.engaged.DW2.Mid.Min, 	sets.SubtleBlow)
		sets.engaged.DW2.High.SB.Min		= set_combine(sets.engaged.DW2.High.Min, 	sets.SubtleBlow)
		
	
		sets.engaged.DW3.SB.Min 	 		= set_combine(sets.engaged.DW3.Min, 		sets.SubtleBlow)
		sets.engaged.DW3.SB.Min.AM3  		= set_combine(sets.engaged.DW3.Min.AM3, 	sets.SubtleBlow)
		sets.engaged.DW3.Low.SB.Min  		= set_combine(sets.engaged.DW3.Low.Min, 	sets.SubtleBlow)
		sets.engaged.DW3.Mid.SB.Min  		= set_combine(sets.engaged.DW3.Mid.Min, 	sets.SubtleBlow)
		sets.engaged.DW3.High.SB.Min 		= set_combine(sets.engaged.DW3.High.Min, 	sets.SubtleBlow)
		
	
		sets.engaged.DW4.SB.Min 	 		= set_combine(sets.engaged.DW4.Min, 		sets.SubtleBlow)
		sets.engaged.DW4.SB.Min.AM3  		= set_combine(sets.engaged.DW4.Min.AM3, 	sets.SubtleBlow)
		sets.engaged.DW4.Low.SB.Min  		= set_combine(sets.engaged.DW4.Low.Min, 	sets.SubtleBlow)
		sets.engaged.DW4.Mid.SB.Min  		= set_combine(sets.engaged.DW4.Mid.Min, 	sets.SubtleBlow)
		sets.engaged.DW4.High.SB.Min 		= set_combine(sets.engaged.DW4.High.Min, 	sets.SubtleBlow)
		
	
		sets.engaged.DW5.SB.Min				= set_combine(sets.engaged.DW5.Min, 		sets.SubtleBlow)
		sets.engaged.DW5.SB.Min.AM3  		= set_combine(sets.engaged.DW5.Min.AM3, 	sets.SubtleBlow)
		sets.engaged.DW5.Low.SB.Min  		= set_combine(sets.engaged.DW5.Low.Min, 	sets.SubtleBlow)
		sets.engaged.DW5.Mid.SB.Min  		= set_combine(sets.engaged.DW5.Mid.Min, 	sets.SubtleBlow)
		sets.engaged.DW5.High.SB.Min 		= set_combine(sets.engaged.DW5.High.Min, 	sets.SubtleBlow)
		
		
	
		----------------------------------------------------------
		-- Medium Haste
		----------------------------------------------------------
		sets.engaged.DW2.DT.Med 	 		= set_combine(sets.engaged.DW2.Med, 		sets.engaged.Hybrid)
		sets.engaged.DW2.DT.Med.AM3  		= set_combine(sets.engaged.DW2.Med.AM3, 	sets.engaged.Hybrid)
		sets.engaged.DW2.Low.DT.Med  		= set_combine(sets.engaged.DW2.Low.Med, 	sets.engaged.Hybrid)
		sets.engaged.DW2.Mid.DT.Med  		= set_combine(sets.engaged.DW2.Mid.Med, 	sets.engaged.Hybrid)
		sets.engaged.DW2.High.DT.Med 		= set_combine(sets.engaged.DW2.High.Med, 	sets.engaged.Hybrid)

	
		sets.engaged.DW3.DT.Med 	 		= set_combine(sets.engaged.DW3.Med, 		sets.engaged.Hybrid,
		{
			body="Adhemar Jacket +1"
		})
		sets.engaged.DW3.DT.Med.AM3  		= set_combine(sets.engaged.DW3.Med.AM3, 	sets.engaged.Hybrid,
		{
			body="Adhemar Jacket +1"
		})
		sets.engaged.DW3.Low.DT.Med  		= set_combine(sets.engaged.DW3.Low.Med, 	sets.engaged.Hybrid,
		{
			body="Adhemar Jacket +1"
		})
		sets.engaged.DW3.Mid.DT.Med  		= set_combine(sets.engaged.DW3.Mid.Med, 	sets.engaged.Hybrid,
		{
			body="Adhemar Jacket +1"
		})
		sets.engaged.DW3.High.DT.Min 		= set_combine(sets.engaged.DW3.High.Min, 	sets.engaged.Hybrid,
		{
			body="Adhemar Jacket +1"
		})

	
		sets.engaged.DW4.DT.Med 	 		= set_combine(sets.engaged.DW4.Med, 		sets.engaged.Hybrid,
		{
			waist="Reiki Yotai"
		})
		sets.engaged.DW4.DT.Med.AM3  		= set_combine(sets.engaged.DW4.Med.AM3, 	sets.engaged.Hybrid,
		{
			rear="Suppanomimi"
		})
		sets.engaged.DW4.Low.DT.Med  		= set_combine(sets.engaged.DW4.Low.Med, 	sets.engaged.Hybrid,
		{
			lear="Eabani Earring",
			waist="Reiki Yotai"
		})
		sets.engaged.DW4.Mid.DT.Med  		= set_combine(sets.engaged.DW4.Mid.Med, 	sets.engaged.Hybrid,
		{
			rear="Suppanomimi",
			waist="Reiki Yotai"
		})
		sets.engaged.DW4.High.DT.Med 		= set_combine(sets.engaged.DW4.High.Med, 	sets.engaged.Hybrid,
		{
			waist="Reiki Yotai"
		})
		
		sets.engaged.DW5.DT.Med 	 		= set_combine(sets.engaged.DW5.Med, 		sets.engaged.Hybrid,
		{
			lear="Eabani Earring", rear="Dedition Earring",
			waist="Reiki Yotai"
		})
		sets.engaged.DW5.DT.Med.AM3  		= set_combine(sets.engaged.DW5.Med.AM3, 	sets.engaged.Hybrid)
		sets.engaged.DW5.Low.DT.Med  		= set_combine(sets.engaged.DW5.Low.Med, 	sets.engaged.Hybrid,
		{
			waist="Reiki Yotai"
		})
		sets.engaged.DW5.Mid.DT.Med  		= set_combine(sets.engaged.DW5.Mid.Med, 	sets.engaged.Hybrid,
		{
			lear="Eabani Earring",
			waist="Reiki Yotai"
		})
		sets.engaged.DW5.High.DT.Med 		= set_combine(sets.engaged.DW5.High.Med, 	sets.engaged.Hybrid,
		{
			waist="Reiki Yotai"
		})
		
		
		
		sets.engaged.DW2.DTMAX.Med 	 		= set_combine(sets.engaged.DW2.Med, 		sets.engaged.Hybrid2)
		sets.engaged.DW2.DTMAX.Med.AM3  	= set_combine(sets.engaged.DW2.Med.AM3, 	sets.engaged.Hybrid2)
		sets.engaged.DW2.Low.DTMAX.Med  	= set_combine(sets.engaged.DW2.Low.Med, 	sets.engaged.Hybrid2)
		sets.engaged.DW2.Mid.DTMAX.Med  	= set_combine(sets.engaged.DW2.Mid.Med, 	sets.engaged.Hybrid2)
		sets.engaged.DW2.High.DTMAX.Med 	= set_combine(sets.engaged.DW2.High.Med, 	sets.engaged.Hybrid2)

	
		sets.engaged.DW3.DTMAX.Med 	 		= set_combine(sets.engaged.DW3.Med, 		sets.engaged.Hybrid2,
		{
			body="Adhemar Jacket +1"
		})
		sets.engaged.DW3.DTMAX.Med.AM3  	= set_combine(sets.engaged.DW3.Med.AM3, 	sets.engaged.Hybrid2,
		{
			body="Adhemar Jacket +1"
		})
		sets.engaged.DW3.Low.DTMAX.Med  	= set_combine(sets.engaged.DW3.DTMAX.Med,
		{
			feet="Malignance Chapeau"
		})
		sets.engaged.DW3.Mid.DTMAX.Med  	= sets.engaged.DW3.Low.DTMAX.Med
		sets.engaged.DW3.High.DTMAX.Med 	= sets.engaged.DW3.Mid.DTMAX.Med

	
		sets.engaged.DW4.DTMAX.Med 	 		= set_combine(sets.engaged.DW4.Med, 		sets.engaged.Hybrid2,
		{
			rring="Epona's Ring",
			waist="Reiki Yotai"
		})
		sets.engaged.DW4.DTMAX.Med.AM3  	= set_combine(sets.engaged.DW4.DTMAX.Med,
		{
			rear="Suppanomimi",
			rring="Epona's Ring"
		})
		sets.engaged.DW4.Low.DTMAX.Med  	= set_combine(sets.engaged.DW4.DTMAX.Med,
		{
			rring={name="Chirich Ring +1", bag="wardrobe3"}
		})
		sets.engaged.DW4.Mid.DTMAX.Med  	= sets.engaged.DW4.Low.DTMAX.Med
		sets.engaged.DW4.High.DTMAX.Med 	= sets.engaged.DW4.Mid.DTMAX.Med

	
		sets.engaged.DW5.DTMAX.Med 	 		= set_combine(sets.engaged.DW5.Med, 		sets.engaged.Hybrid2,
		{
			body="Adhemar Jacket +1"
		})
		sets.engaged.DW5.DTMAX.Med.AM3  	= set_combine(sets.engaged.DW5.Med.AM3, 	sets.engaged.Hybrid2,
		{
			rring="Epona's Ring"
		})
		sets.engaged.DW5.Low.DTMAX.Med  	= set_combine(sets.engaged.DW5.DTMAX.Med,
		{
			lear={name="Mache Earring +1", bag="wardrobe2"},
			waist="Kentarch Belt +1"
		})
		sets.engaged.DW5.Mid.DTMAX.Med  	= set_combine(sets.engaged.DW5.Low.DTMAX.Med,
		{
			body="Malignance Tabard", rring={name="Chirich Ring +1", bag="wardrobe3"},
			waist="Reiki Yotai"
		})
		sets.engaged.DW5.High.DTMAX.Med 	= sets.engaged.DW5.Mid.DTMAX.Med
		
		
		
		sets.engaged.DW2.SB.Med 	 		= set_combine(sets.engaged.DW2.Med, 		sets.SubtleBlow)
		sets.engaged.DW2.SB.Med.AM3  		= set_combine(sets.engaged.DW2.Med.AM3, 	sets.SubtleBlow)
		sets.engaged.DW2.Low.SB.Med  		= set_combine(sets.engaged.DW2.Low.Med, 	sets.SubtleBlow)
		sets.engaged.DW2.Mid.SB.Med  		= set_combine(sets.engaged.DW2.Mid.Med, 	sets.SubtleBlow)
		sets.engaged.DW2.High.SB.Med		= set_combine(sets.engaged.DW2.High.Med, 	sets.SubtleBlow)
		
	
		sets.engaged.DW3.SB.Med 	 		= set_combine(sets.engaged.DW3.Med, 		sets.SubtleBlow)
		sets.engaged.DW3.SB.Med.AM3  		= set_combine(sets.engaged.DW3.Med.AM3, 	sets.SubtleBlow)
		sets.engaged.DW3.Low.SB.Med  		= set_combine(sets.engaged.DW3.Low.Med, 	sets.SubtleBlow)
		sets.engaged.DW3.Mid.SB.Med  		= set_combine(sets.engaged.DW3.Mid.Med, 	sets.SubtleBlow)
		sets.engaged.DW3.High.SB.Med 		= set_combine(sets.engaged.DW3.High.Med, 	sets.SubtleBlow)
		
	
		sets.engaged.DW4.SB.Med 	 		= set_combine(sets.engaged.DW4.Med, 		sets.SubtleBlow)
		sets.engaged.DW4.SB.Med.AM3  		= set_combine(sets.engaged.DW4.Med.AM3, 	sets.SubtleBlow)
		sets.engaged.DW4.Low.SB.Med  		= set_combine(sets.engaged.DW4.Low.Med, 	sets.SubtleBlow)
		sets.engaged.DW4.Mid.SB.Med  		= set_combine(sets.engaged.DW4.Mid.Med, 	sets.SubtleBlow)
		sets.engaged.DW4.High.SB.Med 		= set_combine(sets.engaged.DW4.High.Med, 	sets.SubtleBlow)
		
	
		sets.engaged.DW5.SB.Med				= set_combine(sets.engaged.DW5.Med, 		sets.SubtleBlow)
		sets.engaged.DW5.SB.Med.AM3  		= set_combine(sets.engaged.DW5.Med.AM3, 	sets.SubtleBlow)
		sets.engaged.DW5.Low.SB.Med  		= set_combine(sets.engaged.DW5.Low.Med, 	sets.SubtleBlow)
		sets.engaged.DW5.Mid.SB.Med  		= set_combine(sets.engaged.DW5.Mid.Med, 	sets.SubtleBlow)
		sets.engaged.DW5.High.SB.Med 		= set_combine(sets.engaged.DW5.High.Med, 	sets.SubtleBlow)
		
	
	
		----------------------------------------------------------
		-- Maximum Haste
		----------------------------------------------------------		
		sets.engaged.DW2.DT.Max 	 		= set_combine(sets.engaged.DW2.Max, 		sets.engaged.Hybrid)
		sets.engaged.DW2.DT.Max.AM3  		= set_combine(sets.engaged.DW2.Max.AM3, 	sets.engaged.Hybrid)
		sets.engaged.DW2.Low.DT.Max  		= set_combine(sets.engaged.DW2.Low.Max, 	sets.engaged.Hybrid)
		sets.engaged.DW2.Mid.DT.Max  		= set_combine(sets.engaged.DW2.Mid.Max, 	sets.engaged.Hybrid)
		sets.engaged.DW2.High.DT.Max 		= set_combine(sets.engaged.DW2.High.Max, 	sets.engaged.Hybrid)
		
	
		sets.engaged.DW3.DT.Max 	 		= set_combine(sets.engaged.DW3.Max, 		sets.engaged.Hybrid,
		{
			waist="Reiki Yotai"
		})
		sets.engaged.DW3.DT.Max.AM3  		= set_combine(sets.engaged.DW3.Max.AM3, 	sets.engaged.Hybrid,
		{
			waist="Reiki Yotai"
		})
		sets.engaged.DW3.Low.DT.Max  		= set_combine(sets.engaged.DW3.Low.Max, 	sets.engaged.Hybrid,
		{
			waist="Reiki Yotai"
		})
		sets.engaged.DW3.Mid.DT.Max  		= set_combine(sets.engaged.DW3.Mid.Max, 	sets.engaged.Hybrid,
		{
			waist="Reiki Yotai"
		})
		sets.engaged.DW3.High.DT.Max 		= set_combine(sets.engaged.DW3.High.Max, 	sets.engaged.Hybrid,
		{
			rear={name="Mache Earring +1", bag="wardrobe3"},
			waist="Kentarch Belt +1"
		})

	
		sets.engaged.DW4.DT.Max 	 		= set_combine(sets.engaged.DW4.Max, 		sets.engaged.Hybrid,
		{
			waist="Reiki Yotai"
		})
		sets.engaged.DW4.DT.Max.AM3  		= set_combine(sets.engaged.DW4.Max.AM3, 	sets.engaged.Hybrid,
		{
			waist="Reiki Yotai"
		})
		sets.engaged.DW4.Low.DT.Max  		= set_combine(sets.engaged.DW4.Low.Max, 	sets.engaged.Hybrid,
		{
			waist="Reiki Yotai"
		})
		sets.engaged.DW4.Mid.DT.Max  		= set_combine(sets.engaged.DW4.Mid.Max, 	sets.engaged.Hybrid,
		{
			waist="Reiki Yotai"
		})
		sets.engaged.DW4.High.DT.Max 		= set_combine(sets.engaged.DW4.High.Max, 	sets.engaged.Hybrid,
		{
			waist="Reiki Yotai"
		})

	
		sets.engaged.DW5.DT.Max 	 		= set_combine(sets.engaged.DW5.Max, 		sets.engaged.Hybrid)
		sets.engaged.DW5.DT.Max.AM3  		= set_combine(sets.engaged.DW5.Max.AM3, 	sets.engaged.Hybrid)
		sets.engaged.DW5.Low.DT.Max  		= set_combine(sets.engaged.DW5.Low.Max, 	sets.engaged.Hybrid)
		sets.engaged.DW5.Mid.DT.Max  		= set_combine(sets.engaged.DW5.Mid.Max, 	sets.engaged.Hybrid)
		sets.engaged.DW5.High.DT.Max 		= set_combine(sets.engaged.DW5.High.Max, 	sets.engaged.Hybrid)
		
		
		
		sets.engaged.DW2.DTMAX.Max 	 		= set_combine(sets.engaged.DW2.Max, 		sets.engaged.Hybrid2,
		{
			waist="Reiki Yotai"
		})
		sets.engaged.DW2.DTMAX.Max.AM3  	= set_combine(sets.engaged.DW2.Max.AM3, 	sets.engaged.Hybrid2,
		{
			rring="Epona's Ring"
		})
		sets.engaged.DW2.Low.DTMAX.Max  	= set_combine(sets.engaged.DW2.DTMAX.Max,
		{
			lear={name="Mache Earring +1", bag="wardrobe2"},
			waist="Kentarch Belt +1"
		})
		sets.engaged.DW2.Mid.DTMAX.Max  	= set_combine(sets.engaged.DW2.Low.DTMAX.Max,
		{
			body="Malignance Tabard", rring={name="Chirich Ring +1", bag="wardrobe3"},
			waist="Reiki Yotai"
		})
		sets.engaged.DW2.High.DTMAX.Max 	= sets.engaged.DW2.Mid.DTMAX.Max
		
	
		sets.engaged.DW3.DTMAX.Max 	 		= set_combine(sets.engaged.DW3.Max, 		sets.engaged.Hybrid2,
		{
			rear="Digni. Earring",
			rring="Epona's Ring",
			back=gear.BLUCape_DW
		})
		sets.engaged.DW3.DTMAX.Max.AM3  	= set_combine(sets.engaged.DW3.Max.AM3, 	sets.engaged.Hybrid2,
		{
			rear="Digni. Earring",
			rring="Epona's Ring",
			back=gear.BLUCape_DW
		})
		sets.engaged.DW3.Low.DTMAX.Max  	= set_combine(sets.engaged.DW3.DTMAX.Max,
		{
			lear="Telos Earring", rear={name="Mache Earring +1", bag="wardrobe3"},
			rring={name="Chirich Ring +1", bag="wardrobe3"}
		})
		sets.engaged.DW3.Mid.DTMAX.Max  	= set_combine(sets.engaged.DW3.Low.DTMAX.Max,
		{
			lear={name="Mache Earring +1", bag="wardrobe2"},
			rring={name="Chirich Ring +1", bag="wardrobe3"}
		})
		sets.engaged.DW3.High.DTMAX.Max 	= set_combine(sets.engaged.DW3.Mid.DTMAX.Max,
		{
			waist="Kentarch Belt +1"
		})

	
		sets.engaged.DW4.DTMAX.Max 	 		= set_combine(sets.engaged.DW4.Max, 		sets.engaged.Hybrid2,
		{
			rear="Suppanomimi",
			rring="Epona's Ring"
		})
		sets.engaged.DW4.DTMAX.Max.AM3  	= set_combine(sets.engaged.DW4.Max.AM3, 	sets.engaged.Hybrid2,
		{
			rear="Suppanomimi",
			rring="Epona's Ring"
		})
		sets.engaged.DW4.Low.DTMAX.Max  	= set_combine(sets.engaged.DW4.DTMAX.Max,
		{
			lear="Telos Earring"
		})
		sets.engaged.DW4.Mid.DTMAX.Max  	= set_combine(sets.engaged.DW4.Low.DTMAX.Max,
		{
			rring={name="Chirich Ring +1", bag="wardrobe3"}
		})
		sets.engaged.DW4.High.DTMAX.Max 	= set_combine(sets.engaged.DW4.Mid.DTMAX.Max,
		{
			lear={name="Mache Earring +1", bag="wardrobe2"},
			waist="Kentarch Belt +1"
		})
		
		

	
		sets.engaged.DW5.DTMAX.Max 	 		= set_combine(sets.engaged.DW5.Max, 		sets.engaged.Hybrid2,
		{
			rring="Epona's Ring"
		})
		sets.engaged.DW5.DTMAX.Max.AM3  	= set_combine(sets.engaged.DW5.Max.AM3, 	sets.engaged.Hybrid2,
		{
			rring={name="Chirich Ring +1", bag="wardrobe3"}
		})
		sets.engaged.DW5.Low.DTMAX.Max  	= sets.engaged.DW5.DTMAX.Max
		sets.engaged.DW5.Mid.DTMAX.Max  	= set_combine(sets.engaged.DW5.Low.DTMAX.Max,
		{
			lear={name="Mache Earring +1", bag="wardrobe2"}, rear={name="Mache Earring +1", bag="wardrobe3"}
		})
		sets.engaged.DW5.High.DTMAX.Max 	= set_combine(sets.engaged.DW5.Mid.Max, 	
		{
			rring={name="Chirich Ring +1", bag="wardrobe3"},
			waist="Kentarch Belt +1"
		})
		
		
		
		sets.engaged.DW2.SB.Max 	 		= set_combine(sets.engaged.DW2.Max, 		sets.SubtleBlow)
		sets.engaged.DW2.SB.Max.AM3  		= set_combine(sets.engaged.DW2.Max.AM3, 	sets.SubtleBlow)
		sets.engaged.DW2.Low.SB.Max  		= set_combine(sets.engaged.DW2.Low.Max, 	sets.SubtleBlow)
		sets.engaged.DW2.Mid.SB.Max  		= set_combine(sets.engaged.DW2.Mid.Max, 	sets.SubtleBlow)
		sets.engaged.DW2.High.SB.Max		= set_combine(sets.engaged.DW2.High.Max, 	sets.SubtleBlow)
		
	
		sets.engaged.DW3.SB.Max 	 		= set_combine(sets.engaged.DW3.Max, 		sets.SubtleBlow)
		sets.engaged.DW3.SB.Max.AM3  		= set_combine(sets.engaged.DW3.Max.AM3, 	sets.SubtleBlow)
		sets.engaged.DW3.Low.SB.Max  		= set_combine(sets.engaged.DW3.Low.Max, 	sets.SubtleBlow)
		sets.engaged.DW3.Mid.SB.Max  		= set_combine(sets.engaged.DW3.Mid.Max, 	sets.SubtleBlow)
		sets.engaged.DW3.High.SB.Max 		= set_combine(sets.engaged.DW3.High.Max, 	sets.SubtleBlow)
		
	
		sets.engaged.DW4.SB.Max 	 		= set_combine(sets.engaged.DW4.Max, 		sets.SubtleBlow)
		sets.engaged.DW4.SB.Max.AM3  		= set_combine(sets.engaged.DW4.Max.AM3, 	sets.SubtleBlow)
		sets.engaged.DW4.Low.SB.Max  		= set_combine(sets.engaged.DW4.Low.Max, 	sets.SubtleBlow)
		sets.engaged.DW4.Mid.SB.Max  		= set_combine(sets.engaged.DW4.Mid.Max, 	sets.SubtleBlow)
		sets.engaged.DW4.High.SB.Max 		= set_combine(sets.engaged.DW4.High.Max, 	sets.SubtleBlow)
		
	
		sets.engaged.DW5.SB.Max				= set_combine(sets.engaged.DW5.Max, 		sets.SubtleBlow)
		sets.engaged.DW5.SB.Max.AM3  		= set_combine(sets.engaged.DW5.Max.AM3, 	sets.SubtleBlow)
		sets.engaged.DW5.Low.SB.Max  		= set_combine(sets.engaged.DW5.Low.Max, 	sets.SubtleBlow)
		sets.engaged.DW5.Mid.SB.Max  		= set_combine(sets.engaged.DW5.Mid.Max, 	sets.SubtleBlow)
		sets.engaged.DW5.High.SB.Max 		= set_combine(sets.engaged.DW5.High.Max, 	sets.SubtleBlow)
end





-- Calculates the current dual wield level
function determine_DW()

	local sub_job_dw = 0
	local main_job_dw = 0
	local jp_boost = 2
	local player_has_sj = false
	
	if player.sub_job then
		if 		player.sub_job == 'DNC' then 
			sub_job_dw = 15
		elseif 	player.sub_job == 'NIN' then 
			sub_job_dw = 25
		end
	end
		
	local spells_set = T(windower.ffxi.get_mjob_data().spells):filter(function(id) return id ~= 512 end):map(function(id) return id end)
	local spell_value = 0
	for key, spell_id in pairs(spells_set) do
		if Blu_spells[spell_id].trait == 'Dual Wield' then
			spell_value = spell_value + Blu_spells[spell_id]['points']
		end
	end
		
	if spell_value > 0 then
		spell_value  = math.floor(spell_value / 8) + jp_boost
	else
		spell_value = 0
	end
		
	--the we determine the actual % value of DW equipped via blu spells 
	if 	spell_value == 0 then main_job_dw = 0
	elseif 	spell_value == 1 then main_job_dw = 10
	elseif 	spell_value == 2 then main_job_dw = 15
	elseif 	spell_value == 3 then main_job_dw = 25
	elseif 	spell_value == 4 then main_job_dw = 30
	elseif 	spell_value == 5 then main_job_dw = 35
	elseif 	spell_value == 6 then main_job_dw = 40
	end

	-- if the sub job DW is higher return that instead of blue mage spell DW
	if sub_job_dw > main_job_dw then
		return sub_job_dw
	else
		return main_job_dw
	end
end



-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function precast(spell,abil)
    if midaction() then
            return
    else
        windower.send_command('wait 1;gs c midact')
    end
end
 
function self_command(cmd)
    if cmd == 'midact' then
        midaction(false)
    end
end


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
	
	if spell.english == 'Provoke' and state.TreasureMode.value ~= 'None' then
		equip(sets.TreasureHunter)
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
			back="Grapevine Cape", waist="Gishdubar Sash"
		}
	end
	
	if (spell.skill =='Elemental Magic' or spellMap == 'Magical' or spellMap == 'Darkness' or spellMap == 'Brightness' or spellMap == 'Breath') then
		if spell.element ~= world.day_element and spell.element ~= world.weather_element then
			if spell.target.distance < (15 - spell.target.model_size) then
				equip { waist="Orpheus's Sash" }
			end
		elseif (spell.element == world.day_element and spell.element == world.weather_element)
				or (spell.element == world.weather_element and get_weather_intensity() == 2 and world.day_element ~= elements.strong_to[spell.element]) then
			if spellMap ~= 'Helix' then
				equip { waist="Hachirin-no-Obi" }
			elseif spell.target.distance < (15 - spell.target.model_size) then
				equip { waist="Orpheus's Sash" }
			end
		elseif (spell.element == world.day_element or (spell.element == world.weather_element and get_weather_intensity() == 1)
				or (spell.element == world.weather_element and get_weather_intensity() == 2 and world.day_element == elements.strong_to[spell.element])) then
			if spell.target.distance < (7 - spell.target.model_size) then
				equip { waist="Orpheus's Sash" }
			elseif spellMap ~= 'Helix' then
				equip { waist="Hachirin-no-Obi" }
			end
		end
	end
	
	if spell.action_type == 'Magic' then
		apply_ability_bonuses(spell, action, spellMap, eventArgs)
	end
	
	if state.TreasureMode.value ~= 'None' and spell.action_type == 'Magic' and spell.target.type == 'MONSTER' 
				and spellMap ~= 'Magical' and spellMap ~= 'Brightness' and spellMap ~='Darkness' and spellMap ~= 'AddEffect' then
		equip(sets.TreasureHunter)
	end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.

-- Called after the default aftercast handling is complete.


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

--[[ Called when a player gains or loses a buff.
		buff == buff gained or lost
		gain == true if the buff was gained, false if it was lost. ]]
function job_buff_change(buff,gain)
	
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
	
	-- If we gain or lose any haste buffs, adjust which gear set we target.
	if S{'haste','march','embrava','haste samba', 'mighty guard', 'geo-haste', 'indi-haste', 'slow', 'indi-slow', 'elegy',}:contains(buff:lower()) then
		if not midaction() then
			determine_haste_group()
		end
	elseif state.Buff[buff] ~= nil then
        if not midaction() then
			handle_equipping_gear(player.status)
		end
	end
	
	if buffactive['Aftermath: Lv.3'] and player.equipment.main == "Tizona" then
		classes.CustomMeleeGroups:append('AM3')
		handle_equipping_gear(player.status)
	end
	
end

function job_status_change(new_status, old_status)
	if new_status == 'Engaged' then
		determine_haste_group()
		update_combat_form()
	end
	
	if buffactive['Aftermath: Lv.3'] and player.equipment.main == "Tizona" then
		classes.CustomMeleeGroups:append('AM3')
		handle_equipping_gear(player.status)
	end
end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
	equip(sets[state.MainWeaponSet.current])
	equip(sets[state.SubWeaponSet.current])
	
	if buffactive['Aftermath: Lv.3'] and player.equipment.main == "Tizona" then
		classes.CustomMeleeGroups:append('AM3')
		handle_equipping_gear(player.status)
	end
end

function customize_idle_set(idleSet)
    if player.mpp < 51 and state.IdleMode.value ~= 'DT' and state.DefenseMode.value == 'None' then
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
-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
	equip(sets[state.MainWeaponSet.current])
	equip(sets[state.SubWeaponSet.current])
	
	if buffactive['Aftermath: Lv.3'] and player.equipment.main == "Tizona" then
		classes.CustomMeleeGroups:append('AM3')
		handle_equipping_gear(player.status)
	end
	
	if not midaction() then
		determine_haste_group()
		update_active_abilities()
		update_combat_form()
		th_update(cmdParams, eventArgs)
	end
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
		
		if buffactive['Aftermath: Lv.3'] and player.equipment.main == "Tizona" then
			classes.CustomMeleeGroups:append('AM3')
			handle_equipping_gear(player.status)
		end
		
	end
end

-- Determines Dual Wield level for Combat Form
function update_combat_form()
    if determine_DW() == 35  then
		state.CombatForm:set('DW5')
		--add_to_chat(8, '-------------Dual Wield Level 5 Detected--------------')
	elseif determine_DW() == 30  then
		state.CombatForm:set('DW4')
		--add_to_chat(8, '-------------Dual Wield Level 4 Detected--------------')
	elseif determine_DW() == 25  then
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

function update_active_abilities()
	state.Buff['Chain Affinity']	= buffactive['Chain Affinity'] or false
	state.Buff['Diffusion'] 		= buffactive['Diffusion'] or false
end

-- State buff checks that will equip buff gear and mark the event as handled.
function apply_ability_bonuses(spell, action, spellMap)
	if state.Buff['Chain Affinity'] and spellMap == 'Physical' then
		equip(sets.buff['Chain Affinity'])
	end
	if state.Buff['Diffusion'] and (spellMap == 'Buffs' or spellMap == 'BlueSkill') then
		equip(sets.buff['Diffusion'])
	end

	if state.Buff['Chain Affinity'] then equip (sets.buff['Chain Affinity']) end
	if state.Buff['Diffusion'] then equip (sets.buff['Diffusion']) end
end


-- Select default macro book on initial load or subjob change.
function apply_job_change()
	set_macro_page(1, 16)
	
	send_command('lua l azuresets')
	
	send_command('wait 3; input /lockstyleset 16')
end