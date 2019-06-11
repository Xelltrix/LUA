--------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------
Blu_spells = require("Blue_Mage_Spells")

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
	update_combat_form()
	customize_idle_set()
	
	lockstyleset = 1

end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	state.OffenseMode:options('Normal', 'Low', 'Mid', 'High')
	state.HybridMode:options('Normal', 'DT', 'DTMAX')
	state.WeaponskillMode:options('Normal', 'Low', 'Mid', 'High')
	state.IdleMode:options('Normal', 'DT', 'MEVA', 'Refresh')
	state.MagicalDefenseMode:options('MEVA', 'MDT')
	state.CastingMode:options('Normal','Alternate')

	state.MainWeaponSet = M{['description']='Weapon Set',
		'Tizona',
		'Sequence',
		'Almace',
		'Maxentius'
	}
	
	state.SubWeaponSet = M{['description']='Weapon Set',
		'Naegling',
		'subAlmace',
		'Thiborion'
	}
	
	send_command('bind ^= gs c cycle treasuremode')
	send_command('bind pageup gs c cycle MainWeaponSet')
	send_command('bind pagedown gs c cycleback MainWeaponSet')
	send_command('bind pageup gs ^c cycle SubWeaponSet')
	send_command('bind pagedown gs ^c cycleback SubWeaponSet')

	apply_job_change()
end

-- Called when this job file is unloaded (eg: job change)
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

	
	-------------------
	-- Job Abilities --
	------------------- 

		sets.precast.JA['Azure Lore'] = { hands="Luh. Bazubands +3" }
		
		sets.precast.JA['Provoke'] =
		{--		Enmity: +64
			ammo="Sapience Orb",
			head="Rabid Visor", neck="Unmoving Collar +1", lear="Cryptic Earring", rear="Friomisi Earring",
			body="Emet Harness +1", hands="Nilas Gloves", lring="Eihwaz Ring", rring="Begrudging Ring",
			back="Reiki Cloak", waist="Trance Belt", legs="Zoar Subligar +1"
		}
		
		sets.precast.JA['Warcry'] = sets.precast.JA['Provoke']
		
		sets.precast.JA['Pflug'] = sets.precast.JA['Provoke']
		
		sets.precast.JA['Animated Flourish'] = sets.precast.JA['Provoke']
		

	-------------------
	-- Precast Magic --
	------------------- 
	-- Fast Cast: 15%
	
		sets.precast.FC =
		{--		Fast Cast: 73%(+15%)
			ammo="Sapience Orb",
			head="Carmine Mask +1", neck="Orunmila's Torque", lear="Etiolation Earring", rear="Loquac. Earring",
			body="Pinga Tunic", hands="Leyline Gloves", lring="Kishar Ring", rring="Rahab Ring",
			back="Moonlight Cape", waist="Witful Belt", legs="Pinga Pants", feet="Carmine Greaves +1"
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
		{--		Fast Cast: 66%(+15%)
			legs="Aya. Cosciales +2", feet="Amalric Nails +1"
		})
		
		sets.midcast.FC.SIRD = set_combine(sets.midcast.FC,
		{--		Fast Cast: 31%(+15%)
			ammo="Staunch Tathlum +1",
			head=THead_Phalanx,
			hands="Rawhide Gloves", rring="Evanescence Ring",
			waist="Emphatikos Rope", legs="Assim. Shalwar +3", feet="Amalric Nails +1"
		})
		
		sets.midcast.Duration =
		{--		Fast Cast: 19%(+15%)	Duration: x1.5
			ammo="Staunch Tathlum +1",
			head="Telchine Cap", neck="Orunmila's Torque", lear="Etiolation Earring", rear="Loquac. Earring",
			body="Telchine Chas.", hands=gear.ENH_Gloves, lring="Kishar Ring", rring="Rahab Ring",
			back="Fi Follet Cape +1", waist="Luminary Sash", legs="Telchine Braconi", feet="Telchine Pigaches"
		}

		sets.midcast.ConserveMP = set_combine(sets.midcast.FC,
		{--		Fast Cast: 33%(+15%)
			ammo="Pemphredo Tathlum",
			head="Carmine Mask +1", neck="Incanter's Torque", lear="Gwati Earring", rear="Mendi. Earring",
			body="Amalric Doublet +1", hands="Hashi. Bazu. +1",
			back="Fi Follet Cape +1", waist="Luminary Sash", legs="Lengo Pants", feet="Carmine Greaves +1"
		})


    --------------------------------------
	-- Buffing Midcast sets
	--------------------------------------
	
		sets.midcast.BlueSkill = set_combine(sets.midcast.ConserveMP,
		{
			ammo="Mavi Tathlum",
			head="Luh. Keffiyeh +3", neck="Mirage Stole +2",
			body="Assim. Jubbah +3", hands="Rawhide Gloves", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back="Cornflower Cape", legs="Hashishin Tayt +1", feet="Luhlaza Charuqs +3"
		})
		
		sets.midcast.Occultation = set_combine(sets.midcast.FC,
		{--		Fast Cast: 34%(+15%)	Blue Magic Recast Delay: -14%
			ammo="Pemphredo Tathlum", 
			neck="Mirage Stole +2",
			body="Assim. Jubbah +3", hands="Hashi. Bazu. +1", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back="Cornflower Cape", feet="Carmine Greaves +1"
		})

		sets.midcast.Buffs = sets.midcast.ConserveMP
		
		sets.midcast['Cocoon'] = sets.midcast.FC
		
		sets.midcast['Zephy Mantle'] = sets.midcast.FC
		
		sets.midcast['Regeneration'] = set_combine(sets.midcast.ConserveMP,
		{
			body="Telchine Chas."
		})
		
		sets.midcast.Fantod = 
		{--		Fast Cast: 10%(+15%)	Enmity: +64
			ammo="Sapience Orb",
			head="Rabid Visor", neck="Unmoving Collar +1", lear="Cryptic Earring", rear="Friomisi Earring",
			body="Emet Harness +1", hands="Nilas Gloves", lring="Eihwaz Ring", rring="Begrudging Ring",
			back="Reiki Cloak", waist="Trance Belt", legs="Zoar Subligar +1", feet="Carmine Greaves +1"
		}

    --------------------------------------
	-- Healing Midcast sets
	--------------------------------------	
	
		sets.midcast.Cures =
		{--		Cure Potency: 50%
			ammo="Staunch Tathlum +1",
			head="Carmine Mask +1", neck="Incanter's Torque", lear="Gwati Earring", rear="Beatific Earring",
			body="Pinga Tunic", hands=gear.ENH_Gloves, lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back="Oretan. Cape +1", waist="Bishop's Sash", legs="Pinga Pants", feet="Medium's Sabots"
		}

		sets.midcast['White Wind'] = set_combine(sets.midcast.Cures,
		{--		Cure Potency: 47%
			ammo="Psilomene", 
			head="Luh. Keffiyeh +3", neck="Sanctity Necklace", lear="Odnowa Earring +1", rear="Mendi. Earring",
			lring="Lebeche Ring", rring="Ilabrat Ring",
			back="Moonlight Cape"
		})
		
		sets.midcast.StatusRemoval = sets.midcast.FC

		sets.midcast.Cursna = set_combine(sets.precast.FC,
		{
			neck="Debilis Medallion", lear="Healing Earring", rear="Beatific Earring",
			hands="Hieros Mittens", lring="Haoma's Ring", rring="Menelaus's Ring",
			back="Oretan. Cape +1", waist="Bishop's Sash", legs="Carmine Cuisses +1"
		})

		sets.midcast.Raise = sets.midcast.ConserveMP
		
		sets.midcast.Reraise = sets.midcast.ConserveMP
		
    --------------------------------------
	-- Offensive Midcast sets
	--------------------------------------    
	
	--- Physical Spells
		sets.midcast.Physical =
		{
			ammo="Floestone",
			head="Luh. Keffiyeh +3", neck="Mirage Stole +2", lear="Telos Earring", rear="Tati Earring",
			body="Luhlaza Jubbah +3", hands="Luh. Bazubands +3", lring="Ilabrat Ring", rring="Shukuyu Ring",
			back=gear.BLUCape_WSD, waist="Prosilio Belt +1", legs="Jhakri Slops +2", feet="Luhlaza Charuqs +3"
		}

		sets.midcast.AddEffect =
		{
			ammo="Pemphredo Tathlum",
			head="Carmine Mask +1", neck="Mirage Stole +2", lear="Digni. Earring", rear="Gwati Earring",
			body="Luhlaza Jubbah +3", hands="Aya. Manopolas +2", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back="Cornflower Cape", waist="Eschan Stone", legs="Aya. Cosciales +2", feet="Luhlaza Charuqs +3"
		}

		sets.midcast.Magical =
		{
			ammo="Pemphredo Tathlum",
			head="Jhakri Coronal +2", neck="Sanctity Necklace", lear="Friomisi Earring", rear="Regal Earring",
			body="Amalric Doublet +1", hands="Amalric Gages +1", lring={name="Shiva Ring +1", bag="wardrobe2"}, rring={name="Shiva Ring +1", bag="wardrobe3"},
			back=gear.BLUCape_Nuke, waist="Orpheus's Sash", legs="Amalric Slops +1", feet="Amalric Nails +1"
		}
		
		sets.midcast.Entomb = set_combine(sets.midcast.Magical,
		{
			head="Assim. Keffiyeh +3",
			legs="Luhlaza Shalwar +3"
		})
				
		sets.midcast['Silent Storm'] = set_combine(sets.midcast.Magical,
		{
			head="Assim. Keffiyeh +3",
			legs="Luhlaza Shalwar +3"
		})
	
		sets.midcast['Silent Storm'].Alternate = sets.midcast.Debuffs
		
	
		sets.midcast['Searing Tempest'] = set_combine(sets.midcast.Magical,
		{
			legs="Luhlaza Shalwar +3"
		})
		
		sets.midcast['Blinding Fulgor'] = set_combine(sets.midcast.Magical,
		{
			legs="Luhlaza Shalwar +3"
		})

		sets.midcast.DarkBlue = set_combine(sets.midcast.Magical,
		{
			head="Pixie Hairpin +1",
			rring="Archon Ring"
		})

		sets.midcast.LightBlue = sets.midcast.Magical

		sets.midcast.Breath =
		{
			ammo="Mavi Tathlum",
			head="Luh. Keffiyeh +3", neck="Sanctity Necklace", lear="Etiolation Earring", rear="Odnowa Earring +1",
			body="Assim. Jubbah +3", hands="Regal Cuffs", lring="Ilabrat Ring", rring="Gelatinous Ring +1",
			back="Moonlight Cape", waist="Orpheus's Sash", legs="Assim. Shalwar +3", feet="Assim. Charuqs +3"
		}

		sets.midcast.Debuffs =
		{
			ammo="Pemphredo Tathlum",
			head="Assim. Keffiyeh +3", neck="Mirage Stole +2", lear="Digni. Earring", rear="Regal Earring",
			body="Luhlaza Jubbah +3", hands="Regal Cuffs", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back="Cornflower Cape", waist="Luminary Sash", legs="Assim. Shalwar +3", feet="Luhlaza Charuqs +3"
		}
	
		sets.midcast['Dream Flower'] = sets.midcast.Debuffs

		sets.midcast['Dream Flower'].Alternate =
		{--		DT: -28%	PDT: 49%
			ammo="Staunch Tathlum +1",
			head="Assim. Keffiyeh +3", neck="Mirage Stole +2", lear="Digni. Earring", rear="Regal Earring",
			body="Ayanmo Corazza +2", hands="Assim. Bazu. +3", lring="Defending Ring", rring="Gelatinous Ring +1",
			back=gear.BLUCape_Nuke, waist="Flume Belt +1", legs="Assim. Shalwar +3", feet="Aya. Gambieras +2"
		}

		sets.midcast.BlueDrain = set_combine(sets.midcast.Debuffs,
		{
			ammo="Mavi Tathlum",
			head="Luh. Keffiyeh +3",
			body="Assim. Jubbah +3", hands="Rawhide Gloves",
			legs="Hashishin Tayt +1", feet="Luhlaza Charuqs +3"
		})
		
		sets.midcast['Actinic Burst'] = sets.midcast.Fantod



	--------------------------------------
	-- Suppoort Job Midcast sets
	--------------------------------------
	
	---Defensive Magic
		sets.midcast['Enhancing Magic'] =
		{
			ammo="Staunch Tathlum +1",
			head="Carmine Mask +1", neck="Incanter's Torque", lear="Andoaa Earring", rear="Augment. Earring",
			body="Telchine Chas.", hands=gear.ENH_Gloves, lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back="Fi Follet Cape +1", waist="Olympus Sash", legs="Carmine Cuisses +1", feet="Telchine Pigaches"
		}
		
		sets.midcast.Phalanx = set_combine(sets.midcast['Enhancing Magic'],
		{--		Phalanx: +15
			head=gear.THead_Phalanx,
			body=gear.TBody_Phalanx, hands=gear.THands_Phalanx,
			legs=gear.TLegs_Phalanx, feet=gear.TFeet_Phalanx
		})
		
		
		sets.midcast.Stoneskin = set_combine(sets.midcast.Duration,
		{
			neck="Stone Gorget", rear="Earthcry Earring",
			waist="Siegel Sash", legs="Shedir Seraweels"
		})

		sets.midcast.Refresh = set_combine(sets.midcast.ConserveMP,
		{
			head="Amalric Coif +1", 
			body="Telchine Chas.", hands=gear.ENH_Gloves,
			legs="Telchine Braconi", feet="Telchine Pigaches"
		})

		sets.midcast.Regen = set_combine(sets.midcast.ConserveMP,
		{
			head="Telchine Cap", 
			body="Telchine Chas.", hands=gear.ENH_Gloves, 
			legs="Telchine Braconi", feet="Telchine Pigaches"
		})

		sets.midcast.Aquaveil = set_combine(sets.midcast.Duration,
		{--		Aquaveil: +5
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
		sets.midcast['Elemental Magic'] = sets.midcast.Magical
	
		sets.midcast['Enfeebling Magic'] =
		{
			ammo="Pemphredo Tathlum",
			head="Assim. Keffiyeh +3", neck="Mirage Stole +2", lear="Digni. Earring", rear="Regal Earring",
			body="Jhakri Robe +2", hands="Regal Cuffs", lring="Kishar Ring", rring={name="Stikini Ring +1", bag="wardrobe3"},
			back=gear.BLUCape_Nuke, waist="Luminary Sash", legs="Assim. Shalwar +3", feet="Jhakri Pigaches +2"
		}
		
		sets.midcast['Dark Magic'] = set_combine(sets.midcast['Enfeebling Magic'],
		{
			neck="Erra Pendant",
			hands="Aya. Manopolas +2", lring={name="Stikini Ring +1", bag="wardrobe2"}
		})
		
		sets.midcast.Sap = set_combine(sets.midcast['Dark Magic'],
		{
			rring="Evanescence Ring",
			waist="Fucho-no-Obi"
		})

		sets.midcast.Stun = set_combine(sets.midcast['Enfeebling Magic'],
		{
			head="Carmine Mask +1", neck="Erra Pendant", rear="Gwati Earring",
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
	
		sets.Tizona = { main="Tizona" }
			
		sets.Almace = { main="Almace" }
	
		sets.subAlmace = { sub="Almace" }
		
		sets.Sequence = { main="Sequence" }
		
		sets.Maxentius = { main="Maxentius" }
		
		sets.Naegling = { sub="Naegling" }
		
		sets.Thibron = { sub="Thibron" }

	
	------------------------------------------------------------------------------------------------
	------------------------------------------ Idle Sets -------------------------------------------
	------------------------------------------------------------------------------------------------

		sets.idle =
		{--		DT: -9%		PDT: -15%	MDT: -9%	Refresh: 8	Regen: 3
			ammo="Staunch Tathlum +1",
			head="Rawhide Mask", neck="Sanctity Necklace", lear="Dawn Earring", rear="Infused Earring",
			body="Assim. Jubbah +3", hands=gear.HHands_Refresh, lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back="Moonlight Cape", waist="Flume Belt +1", legs="Carmine Cuisses +1", feet=gear.HBoots_Refresh
		}

		sets.idle.DT = set_combine(sets.idle,
		{--		DT: -31%	PDT: -44%	MDT: -35%	Refresh: 5	Regen: 0
			neck="Loricate Torque +1", lear="Etiolation Earring", rear="Odnowa Earring +1",
			hands="Assim. Bazu. +3", lring="Defending Ring", rring="Gelatinous Ring +1"
		})
		
		sets.idle.MEVA = set_combine(sets.idle,
		{--		DT: -15%	PDT: -15%	MDT: -15%	Refresh: 5	Regen: 0
			head="Amalric Coif +1", neck="Warder's Charm +1", lear="Eabani Earring", rear="Sanare Earring",
			body="Amalric Doublet +1", hands="Assim. Bazu. +3",
			waist="Carrier's Sash", feet="Amalric Nails +1"
		})
		
		sets.idle.Refresh = set_combine(sets.idle,
		{--		DT: -9%		PDT: -15%	MDT: -9%	Refresh: 10	Regen: 3
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
		{--		DT: -40%	PDT: -51%	MDT: -44%
			ammo="Staunch Tathlum +1",
			head=gear.AHead_PDT, neck="Loricate Torque +1", lear="Etiolation Earring", rear="Odnowa Earring +1",
			body="Ayanmo Corazza +2", hands="Assim. Bazu. +3", lring="Defending Ring", rring="Gelatinous Ring +1",
			back="Moonlight Cape", waist="Carrier's Sash", legs="Carmine Cuisses +1", feet="Aya. Gambieras +2"
		}

		sets.defense.MDT = set_combine(sets.defense.PDT,
		{--		DT: -36%	PDT: -45%	MDT: -46%
			head="Amalric Coif +1", rear="Sanare Earring",
			rring="Shukuyu Ring",
			back="Reiki Cloak", legs="Aya. Cosciales +2", feet="Amalric Nails +1"
		})
		
		sets.defense.MEVA = set_combine(sets.defense.MDT,
		{--		DT: -24%	PDT: -24%	MDT: -31%
			neck="Warder's Charm +1", lear="Eabani Earring",
			body="Pinga Tunic",
			legs="Pinga Pants",
		})

	--------------------------------------
	-- Special Sets
	--------------------------------------

		sets.Kiting = { legs="Carmine Cuisses +1" }
		
		sets.TreasureHunter = { waist="Chaac Belt" }

	---Buffs
		sets.buff.Doom = 
		{--	Cursna Received: +55%
			neck="Nicander's Necklace",
			lring={name="Eshmun's Ring", bag="wardrobe2"}, rring={name="Eshmun's Ring", bag="wardrobe3"},
			waist="Gishdubar Sash"
		}
		
		sets.buff['Chain Affinity'] = { feet="Assim. Charuqs +3" }
		
		sets.buff['Diffusion'] = { feet="Luhlaza Charuqs +3" }


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
			ammo="Floestone",
			head=gear.HHead_WSD, neck="Fotia Gorget", lear="Brutal Earring", rear="Moonshade Earring",
			body="Assim. Jubbah +3", hands="Jhakri Cuffs +2", lring="Ilabrat Ring", rring="Karieyh Ring +1",
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
	
		sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS,
		{
			ammo="Falcon Eye",
			head=gear.AHead_TP, neck="Mirage Stole +2", lear={name="Mache Earring +1", bag="wardrobe2"}, rear={name="Mache Earring +1", bag="wardrobe3"},
			body="Adhemar Jacket +1", hands="Adhemar Wrist. +1", lring="Begrudging Ring", rring="Epona's Ring", 
			back=gear.BLUCape_Crit, feet=gear.HBoots_Crit
		})

		sets.precast.WS['Chant du Cygne'].Low = set_combine(sets.precast.WS['Chant du Cygne'],
		{
			rring="Ilabrat Ring",
			legs="Adhemar Kecks +1"
		})
		
		sets.precast.WS['Chant du Cygne'].Mid = set_combine(sets.precast.WS['Chant du Cygne'].Low,
		{
			hands="Luh. Bazubands +3",
			feet="Aya. Gambieras +2"
		})
		
		sets.precast.WS['Chant du Cygne'].High = set_combine(sets.precast.WS['Chant du Cygne'].Mid,
		{
			head="Dampening Tam",
			feet="Luhlaza Charuqs +3"
		})

	---Vorpal Blade
		sets.precast.WS['Vorpal Blade'] = set_combine(sets.precast.WS['Chant du Cygne'],
		{
			ammo="Floestone",
			lear="Brutal Earring", rear="Moonshade Earring"
		})

		sets.precast.WS['Vorpal Blade'].Low = set_combine(sets.precast.WS['Vorpal Blade'],
		{
			rring="Ilabrat Ring",
			legs="Adhemar Kecks +1", feet="Aya. Gambieras +2"
		})
		
		sets.precast.WS['Vorpal Blade'].Mid = set_combine(sets.precast.WS['Vorpal Blade'].Low,
		{
			ammo="Falcon Eye",
			hands="Luh. Bazubands +3"
		})
		
		sets.precast.WS['Vorpal Blade'].High = set_combine(sets.precast.WS['Vorpal Blade'].Mid,
		{
			head="Dampening Tam",
			feet="Luhlaza Charuqs +3"
		})
		
	---Requiescat
		sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS,
		{
			head="Jhakri Coronal +2", lear="Regal Earring",
			body="Luhlaza Jubbah +3", hands="Luh. Bazubands +3", lring="Rufescent Ring", rring="Epona's Ring", 
			legs="Jhakri Slops +2", feet="Luhlaza Charuqs +3"
		})

		sets.precast.WS['Requiescat'].Low = set_combine(sets.precast.WS['Requiescat'],
		{
			ammo="Falcon Eye",
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
			legs="Adhemar Kecks +1"
		})

	---Savage Blade
		sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS,
		{
			neck="Mirage Stole +2", lear="Ishvara Earring", rear="Regal Earring",
			lring="Rufescent Ring",
			legs="Luhlaza Shalwar +3", feet=gear.HBoots_WSD
		})

		sets.precast.WS['Savage Blade'].Low = sets.precast.WS['Savage Blade']
		
		sets.precast.WS['Savage Blade'].Mid = sets.precast.WS['Savage Blade'].Low
		
		sets.precast.WS['Savage Blade'].High = set_combine(sets.precast.WS['Savage Blade'].Mid,
		{
			ammo="Falcon Eye",
			head="Jhakri Coronal +2", lear={name="Mache Earring +1", bag="wardrobe2"}, rear={name="Mache Earring +1", bag="wardrobe3"},
			feet="Assim. Charuqs +3"
		})

	---Expiacion
		sets.precast.WS['Expiacion'] = set_combine(sets.precast.WS['Savage Blade'],
		{
			lear="Ishvara Earring",
			lring="Shukuyu Ring",
		})

		sets.precast.WS['Expiacion'].Low = sets.precast.WS['Expiacion']
		
		sets.precast.WS['Expiacion'].Mid = sets.precast.WS['Expiacion'].Low
		
		sets.precast.WS['Expiacion'].High = set_combine(sets.precast.WS['Expiacion'].Mid,
		{
			ammo="Falcon Eye",
			head="Jhakri Coronal +2", lear={name="Mache Earring +1", bag="wardrobe2"}, rear={name="Mache Earring +1", bag="wardrobe3"},
			lring="Ilabrat Ring",
			feet="Assim. Charuqs +3"
		})

	---Sanguine Blade
		sets.precast.WS['Sanguine Blade'] =
		{
			ammo="Pemphredo Tathlum",
			head="Pixie Hairpin +1", neck="Sanctity Necklace", lear="Regal Earring", rear="Friomisi Earring",
			body="Amalric Doublet +1", hands="Jhakri Cuffs +2", lring="Archon Ring", rring="Karieyh Ring +1",
			back=gear.BLUCape_WSD, waist="Orpheus's Sash", legs="Luhlaza Shalwar +3", feet="Amalric Nails +1"
		}
	
	---Spirits Within
		sets.precast.WS['Spirits Within'] =
		{
			ammo="Psilomene",
			head="Luh. Keffiyeh +3", neck="Sanctity Necklace", lear="Odnowa Earring +1", rear="Moonshade Earring",
			body="Assim. Jubbah +3", hands="Regal Cuffs", lring="Ilabrat Ring", rring="Gelatinous Ring +1",
			back="Moonlight Cape", waist="Eschan Stone", legs="Assim. Shalwar +3", feet="Assim. Charuqs +3"
		}
	

	
	--	***Clubs***
	
		sets.precast.WS['True Strike'] =
		{
			ammo="Floestone",
			head=gear.HHead_WSD, neck="Mirage Stole +2", lear="Telos Earring", rear="Ishvara Earring",
			body="Assim. Jubbah +3", hands="Jhakri Cuffs +2", lring="Shukuyu Ring", rring="Karieyh Ring +1",
			back=gear.BLUCape_WSD, waist="Prosilio Belt +1", legs="Luhlaza Shalwar +3", feet=gear.HBoots_WSD

		}

		sets.precast.WS['True Strike'].Low = sets.precast.WS['True Strike']
		
		sets.precast.WS['True Strike'].Mid = sets.precast.WS['True Strike'].Low
		
		sets.precast.WS['True Strike'].High = set_combine(sets.precast.WS['True Strike'].Mid,
		{
			ammo="Falcon Eye",
			head="Jhakri Coronal +2", lear={name="Mache Earring +1", bag="wardrobe2"}, rear={name="Mache Earring +1", bag="wardrobe3"},
			lring="Rufescent Ring",
			feet="Assim. Charuqs +3"
		})
		
		sets.precast.WS['Judgment'] = sets.precast.WS['Savage Blade']

		sets.precast.WS['Judgment'].Low = sets.precast.WS['Savage Blade'].Low
		
		sets.precast.WS['Judgment'].Mid = sets.precast.WS['Savage Blade'].Mid
		
		sets.precast.WS['Judgment'].High = sets.precast.WS['Savage Blade'].High

		sets.precast.WS['Black Halo'] = set_combine(sets.precast.WS['Savage Blade'],
		{
			feet="Carmine Greaves +1"
		})

		sets.precast.WS['Black Halo'].Low = sets.precast.WS['Black Halo']
		
		sets.precast.WS['Black Halo'].Mid = sets.precast.WS['Black Halo'].Low
		
		sets.precast.WS['Black Halo'].High = set_combine(sets.precast.WS['Black Halo'].Mid,
		{
			ammo="Falcon Eye",
			head="Jhakri Coronal +2", lear={name="Mache Earring +1", bag="wardrobe2"}, rear={name="Mache Earring +1", bag="wardrobe3"},
			feet="Assim. Charuqs +3"
		})

		sets.precast.WS['Realmrazer'] = sets.precast.WS['Requiescat']
		
		sets.precast.WS['Realmrazer'].Low = sets.precast.WS['Requiescat'].Low
		
		sets.precast.WS['Realmrazer'].Mid = sets.precast.WS['Requiescat'].Mid
		
		sets.precast.WS['Realmrazer'].High = sets.precast.WS['Requiescat'].High

		sets.precast.WS['Flash Nova'] = set_combine(sets.precast.WS['Sanguine Blade'],
		{
			head="Assim. Keffiyeh +3",
			rring={name="Shiva Ring +1", bag="wardrobe3"},
		})

	
	
	
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
			sub="Genmei Shield", ammo="Ginsen",
			head=gear.AHead_TP, neck="Mirage Stole +2", lear="Telos Earring", rear="Cessance Earring",
			body="Ayanmo Corazza +2", hands="Adhemar Wrist. +1", lring="Hetairoi Ring", rring="Epona's Ring",
			back=gear.BLUCape_STP, waist="Windbuffet Belt +1", legs="Samnuha Tights", feet="Carmine Greaves +1"
		}
		sets.engaged.AM3 =
		{
			sub="Genmei Shield", ammo="Ginsen",
			head=gear.AHead_TP, neck="Mirage Stole +2", lear="Telos Earring", rear="Dedition Earring",
			body="Adhemar Jacket +1", hands="Adhemar Wrist. +1", lring="Hetairoi Ring", rring="Epona's Ring",
			back=gear.BLUCape_STP, waist="Windbuffet Belt +1", legs="Samnuha Tights", feet="Carmine Greaves +1"
		}
		
		sets.engaged.Low = set_combine(sets.engaged,
		{
			head="Dampening Tam", rear="Cessance Earring",
			lring={name="Chirich Ring +1", bag="wardrobe2"},
		})

		sets.engaged.Mid = set_combine(sets.engaged.Low,
		{
			ammo="Falcon Eye",
			rear={name="Mache Earring +1", bag="wardrobe3"},
			rring={name="Chirich Ring +1", bag="wardrobe3"},
			legs="Adhemar Kecks +1"
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
			ammo="Ginsen",
			head=gear.AHead_TP, neck="Mirage Stole +2", lear="Eabani Earring", rear="Suppanomimi",
			body="Adhemar Jacket +1", hands="Adhemar Wrist. +1", lring="Hetairoi Ring", rring="Epona's Ring",
			back=gear.BLUCape_DW, waist="Reiki Yotai", legs="Carmine Cuisses +1", feet=gear.TFeet_TP
		}
		
		sets.engaged.DW2.AM3 =
		{
			ammo="Ginsen",
			head=gear.AHead_TP, neck="Mirage Stole +2", lear="Eabani Earring", rear="Suppanomimi",
			body="Adhemar Jacket +1", hands="Adhemar Wrist. +1", lring="Hetairoi Ring", rring="Epona's Ring",
			back=gear.BLUCape_DW, waist="Reiki Yotai", legs="Carmine Cuisses +1", feet=gear.TFeet_TP
		}
		
		
		-----------------------------------------------------------------------------------
		---	TP/h:79	(DW:42	STP:39		QA:0%	TA:16%	DA:5%)
		-----------------------------------------------------------
		sets.engaged.DW2.Low = set_combine(sets.engaged.DW2,
		{
			ammo="Falcon Eye",
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
			ammo="Ginsen",
			head=gear.AHead_TP, neck="Mirage Stole +2", lear="Eabani Earring", rear="Suppanomimi",
			body="Adhemar Jacket +1", hands="Adhemar Wrist. +1", lring="Hetairoi Ring", rring="Epona's Ring",
			back=gear.BLUCape_DW, waist="Reiki Yotai", legs="Carmine Cuisses +1", feet=gear.TFeet_TP
		}
		
		sets.engaged.DW3.AM3 =
		{
			ammo="Ginsen",
			head=gear.AHead_TP, neck="Mirage Stole +2", lear="Eabani Earring", rear="Suppanomimi",
			body="Adhemar Jacket +1", hands="Adhemar Wrist. +1", lring="Hetairoi Ring", rring="Epona's Ring",
			back=gear.BLUCape_DW, waist="Reiki Yotai", legs="Carmine Cuisses +1", feet=gear.TFeet_TP
		}
		
		
		-----------------------------------------------------------------------------------
		---	TP/h:79	(DW:42	STP:39		QA:0%	TA:16%	DA:5%)
		-----------------------------------------------------------
		sets.engaged.DW3.Low = set_combine(sets.engaged.DW3,
		{
			ammo="Falcon Eye",
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
			ammo="Ginsen",
			head=gear.AHead_TP, neck="Mirage Stole +2", lear="Eabani Earring", rear="Suppanomimi",
			body="Adhemar Jacket +1", hands="Adhemar Wrist. +1", lring="Hetairoi Ring", rring="Epona's Ring",
			back=gear.BLUCape_DW, waist="Reiki Yotai", legs="Carmine Cuisses +1", feet=gear.TFeet_TP
		}
		
		sets.engaged.DW4.AM3 =
		{
			ammo="Ginsen",
			head=gear.AHead_TP, neck="Mirage Stole +2", lear="Eabani Earring", rear="Suppanomimi",
			body="Adhemar Jacket +1", hands="Adhemar Wrist. +1", lring="Hetairoi Ring", rring="Epona's Ring",
			back=gear.BLUCape_DW, waist="Reiki Yotai", legs="Carmine Cuisses +1", feet=gear.TFeet_TP
		}
		
		-----------------------------------------------------------------------------------
		---	TP/h:79	(DW:42	STP:39		QA:0%	TA:16%	DA:5%)
		-----------------------------------------------------------
		sets.engaged.DW4.Low = set_combine(sets.engaged.DW4,
		{	
			ammo="Falcon Eye",
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
	-- Minimum Haste
	----------------------------------------------------------
	
	--15 DW = 52 DW needed		(DNC Sub)

	--25 DW = 42 DW needed		(NIN Sub or BLU Trait)

	--30 DW = 37  DW needed		(Tier 2 BLU Trait)
	
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
			ammo="Ginsen",
			head=gear.AHead_TP, neck="Mirage Stole +2", lear="Eabani Earring", rear="Suppanomimi",
			body="Adhemar Jacket +1", hands="Adhemar Wrist. +1", lring="Hetairoi Ring", rring="Epona's Ring",
			back=gear.BLUCape_DW, waist="Reiki Yotai", legs="Carmine Cuisses +1", feet=gear.TFeet_TP
		}
		
		sets.engaged.DW2.Min.AM3 =
		{
			ammo="Ginsen",
			head=gear.AHead_TP, neck="Mirage Stole +2", lear="Eabani Earring", rear="Suppanomimi",
			body="Adhemar Jacket +1", hands="Adhemar Wrist. +1", lring="Hetairoi Ring", rring="Epona's Ring",
			back=gear.BLUCape_DW, waist="Reiki Yotai", legs="Carmine Cuisses +1", feet=gear.TFeet_TP
		}
		-----------------------------------------------------------------------------------
		---	TP/h:79	(DW:42	STP:39		QA:0%	TA:16%	DA:5%)
		-----------------------------------------------------------
		sets.engaged.DW2.Low.Min = set_combine(sets.engaged.DW2.Min,
		{
			ammo="Falcon Eye",
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
			ammo="Ginsen",
			head=gear.AHead_TP, neck="Mirage Stole +2", lear="Eabani Earring", rear="Suppanomimi",
			body="Adhemar Jacket +1", hands="Adhemar Wrist. +1", lring="Hetairoi Ring", rring="Epona's Ring",
			back=gear.BLUCape_DW, waist="Reiki Yotai", legs="Carmine Cuisses +1", feet=gear.TFeet_TP
		}
		
		sets.engaged.DW3.Min.AM3 =
		{
			ammo="Ginsen",
			head=gear.AHead_TP, neck="Mirage Stole +2", lear="Eabani Earring", rear="Suppanomimi",
			body="Adhemar Jacket +1", hands="Adhemar Wrist. +1", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring="Epona's Ring",
			back=gear.BLUCape_DW, waist="Reiki Yotai", legs="Carmine Cuisses +1", feet=gear.TFeet_TP
		}
		
		-----------------------------------------------------------------------------------
		---	TP/h:79	(DW:42	STP:39		QA:0%	TA:16%	DA:5%)
		-----------------------------------------------------------
		sets.engaged.DW3.Low.Min = set_combine(sets.engaged.DW3.Min,
		{
			ammo="Falcon Eye",
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
			ammo="Ginsen",
			head=gear.AHead_TP, neck="Mirage Stole +2", lear="Eabani Earring", rear="Suppanomimi",
			body="Adhemar Jacket +1", hands="Adhemar Wrist. +1", lring="Hetairoi Ring", rring="Epona's Ring",
			back=gear.BLUCape_DW, waist="Reiki Yotai", legs="Carmine Cuisses +1", feet=gear.HBoots_TP
		}
		
		sets.engaged.DW4.Min.AM3 =
		{
			ammo="Ginsen",
			head=gear.AHead_TP, neck="Mirage Stole +2", lear="Eabani Earring", rear="Suppanomimi",
			body="Adhemar Jacket +1", hands="Adhemar Wrist. +1", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring="Epona's Ring",
			back=gear.BLUCape_DW, waist="Reiki Yotai", legs="Carmine Cuisses +1", feet=gear.HBoots_TP
		}
		
		-----------------------------------------------------------------------------------
		---	TP/h:79	(DW:37	STP:39		QA:0%	TA:16%	DA:5%)
		-----------------------------------------------------------
		sets.engaged.DW4.Low.Min = set_combine(sets.engaged.DW4.Min,
		{
			ammo="Falcon Eye",
			head="Dampening Tam",
		})

		-----------------------------------------------------------------------------------
		---	TP/h:79	(DW:37	STP:39		QA:0%	TA:16%	DA:5%)
		-----------------------------------------------------------
		sets.engaged.DW4.Mid.Min = set_combine(sets.engaged.DW4.Low.Min,
		{
			lear={name="Mache Earring +1", bag="wardrobe2"},
			hands="Luh. Bazubands +3", lring={name="Chirich Ring +1", bag="wardrobe2"},
			feet=gear.TFeet_TP
		})

		-----------------------------------------------------------------------------------
		---	TP/h:79	(DW:37	STP:39		QA:0%	TA:16%	DA:5%)
		-----------------------------------------------------------
		sets.engaged.DW4.High.Min = set_combine(sets.engaged.DW4.Mid.Min,
		{
			head="Carmine Mask +1",
			rring={name="Chirich Ring +1", bag="wardrobe3"}
		})
	
	
	
	----------------------------------------------------------
	-- Medium Haste
	----------------------------------------------------------
	
	--15 DW = 41 DW needed		(DNC Sub)

	--25 DW = 31 DW needed		(NIN Sub or BLU Trait)

	--30 DW = 26  DW needed		(Tier 2 BLU Trait)
	
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
			ammo="Ginsen",
			head=gear.AHead_TP, neck="Mirage Stole +2", lear="Eabani Earring", rear="Suppanomimi",
			body="Adhemar Jacket +1", hands="Adhemar Wrist. +1", lring="Hetairoi Ring", rring="Epona's Ring",
			back=gear.BLUCape_DW, waist="Reiki Yotai", legs="Carmine Cuisses +1", feet=gear.TFeet_TP
		}
		
		-----------------------------------------------------------------------------------
		---	TP/h:100	(DW:6	STP:50		QA:2%	TA:20%	DA:11%)
		-----------------------------------------------------------
		sets.engaged.DW2.Med.AM3 =
		{
			ammo="Ginsen",
			head=gear.AHead_TP, neck="Mirage Stole +2", lear="Eabani Earring", rear="Suppanomimi",
			body="Adhemar Jacket +1", hands="Adhemar Wrist. +1", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring="Epona's Ring",
			back=gear.BLUCape_DW, waist="Reiki Yotai", legs="Carmine Cuisses +1", feet=gear.TFeet_TP
		}

		-----------------------------------------------------------------------------------
		---	TP/h:79	(DW:42	STP:39		QA:0%	TA:16%	DA:5%)
		-----------------------------------------------------------
		sets.engaged.DW2.Low.Min = set_combine(sets.engaged.DW2.Min,
		{
			ammo="Falcon Eye",
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
		--					(DW3 + 30% Haste)
		----------------------------------------------------------

		--25 DW = 31 DW needed		(NIN Sub or BLU Trait)
		
		----------------------------------------------------------
	
		-----------------------------------------------------------------------------------
		---	TP/h:79	(DW:32	STP:39		QA:0%	TA:16%	DA:5%)
		-----------------------------------------------------------
		sets.engaged.DW3.Med =
		{
			ammo="Ginsen",
			head=gear.AHead_TP, neck="Mirage Stole +2", lear="Eabani Earring", rear="Suppanomimi",
			body="Adhemar Jacket +1", hands="Adhemar Wrist. +1", lring="Hetairoi Ring", rring="Epona's Ring",
			back=gear.BLUCape_DW, waist="Reiki Yotai", legs="Samnuha Tights", feet=gear.HBoots_TP
		}
		
		-----------------------------------------------------------------------------------
		---	TP/h:100	(DW:31	STP:50		QA:2%	TA:20%	DA:11%)
		-----------------------------------------------------------
		sets.engaged.DW3.Med.AM3 =
		{
			ammo="Ginsen",
			head=gear.AHead_TP, neck="Mirage Stole +2", lear="Eabani Earring", rear="Dedition Earring",
			body="Adhemar Jacket +1", hands="Adhemar Wrist. +1", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring="Epona's Ring",
			back=gear.BLUCape_DW, waist="Reiki Yotai", legs="Samnuha Tights", feet=gear.TFeet_TP
		}

		-----------------------------------------------------------------------------------
		---	TP/h:79	(DW:32	STP:40		QA:2%	TA:10%	DA:2%)
		-----------------------------------------------------------
		sets.engaged.DW3.Low.Med = set_combine(sets.engaged.DW3.Med,
		{
			head="Dampening Tam",
			lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"},
			legs="Adhemar Kecks +1"
		})

		-----------------------------------------------------------------------------------
		---	TP/h:78	(DW:31	STP:36		QA:2%	TA:8%	DA:3%)
		-----------------------------------------------------------
		sets.engaged.DW3.Mid.Med = set_combine(sets.engaged.DW3.Low.Med,
		{
			ammo="Falcon Eye",
			lear={name="Mache Earring +1", bag="wardrobe2"},
			hands="Luh. Bazubands +3",
			feet=gear.TFeet_TP
		})

		-----------------------------------------------------------------------------------
		---	TP/h:78	(DW:32	STP:36		QA:0%	TA:5%	DA:0%)
		-----------------------------------------------------------
		sets.engaged.DW3.High.Med = set_combine(sets.engaged.DW3.Mid.Med,
		{
			head="Carmine Mask +1", rear={name="Mache Earring +1", bag="wardrobe3"},
			legs="Carmine Cuisses +1"
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
			ammo="Ginsen",
			head=gear.AHead_TP, neck="Mirage Stole +2", lear="Eabani Earring", rear="Suppanomimi",
			body="Adhemar Jacket +1", hands="Adhemar Wrist. +1", lring="Hetairoi Ring", rring="Epona's Ring",
			back=gear.BLUCape_DW, waist="Windbuffet Belt +1", legs="Samnuha Tights", feet=gear.HBoots_TP
		}
		
		-----------------------------------------------------------------------------------
		---	TP/h:100	(DW:27	STP:50		QA:2%	TA:20%	DA:11%)
		-----------------------------------------------------------
		sets.engaged.DW4.Med.AM3 =
		{
			ammo="Ginsen",
			head=gear.AHead_TP, neck="Mirage Stole +2", lear="Eabani Earring", rear="Dedition Earring",
			body="Adhemar Jacket +1", hands="Adhemar Wrist. +1", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring="Epona's Ring",
			back=gear.BLUCape_DW, waist="Reiki Yotai", legs="Samnuha Tights", feet=gear.HBoots_TP
		}

		-----------------------------------------------------------------------------------
		---	TP/h:84	(DW:26	STP:47		QA:2%	TA:16%	DA:6%)
		-----------------------------------------------------------
		sets.engaged.DW4.Low.Med = set_combine(sets.engaged.DW4.Med,
		{
			ammo="Falcon Eye",
			head="Dampening Tam",
			lring={name="Chirich Ring +1", bag="wardrobe2"}
		})

		-----------------------------------------------------------------------------------
		---	TP/h:85	(DW:26	STP:48		QA:2%	TA:8%	DA:4%)I 
		-----------------------------------------------------------
		sets.engaged.DW4.Mid.Med = set_combine(sets.engaged.DW4.Low.Med,
		{
			lear={name="Mache Earring +1", bag="wardrobe2"}, rear={name="Mache Earring +1", bag="wardrobe3"},
			rring={name="Chirich Ring +1", bag="wardrobe3"},
			waist="Reiki Yotai", legs="Adhemar Kecks +1", feet=gear.TFeet_TP
		})

		-----------------------------------------------------------------------------------
		---	TP/h:78	(DW:26	STP:36		QA:0%	TA:3%	DA:0%)
		-----------------------------------------------------------
		sets.engaged.DW4.High.Med = set_combine(sets.engaged.DW4.Mid.Med,
		{
			head="Carmine Mask +1",
			body="Luhlaza Jubbah +3", hands="Luh. Bazubands +3",
			legs="Carmine Cuisses +1"
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
			ammo="Ginsen",
			head=gear.AHead_TP, neck="Mirage Stole +2", lear="Brutal Earring", rear="Suppanomimi",
			body="Adhemar Jacket +1", hands="Adhemar Wrist. +1", lring="Hetairoi Ring", rring="Epona's Ring",
			back=gear.BLUCape_DW, waist="Windbuffet Belt +1", legs="Samnuha Tights", feet=gear.HBoots_TP
		}
		
		-----------------------------------------------------------------------------------
		---		(DW:21	STP:52		QA:2%	TA:22%	DA:9%)
		-----------------------------------------------------------
		sets.engaged.DW2.Max.AM3 =
		{
			ammo="Ginsen",
			head=gear.AHead_TP, neck="Mirage Stole +2", lear="Telos Earring", rear="Suppanomimi",
			body="Adhemar Jacket +1", hands="Adhemar Wrist. +1", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring="Epona's Ring",
			back=gear.BLUCape_DW, waist="Windbuffet Belt +1", legs="Samnuha Tights", feet=gear.HBoots_TP
		}

		-----------------------------------------------------------------------------------
		---		(DW:21	STP:53		QA:4%	TA:19%	DA:7%)
		-----------------------------------------------------------
		sets.engaged.DW2.Low.Max = set_combine(sets.engaged.DW2.Max,
		{
			head="Dampening Tam", lear={name="Mache Earring +1", bag="wardrobe2"},
			lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe2"}, 
			legs="Adhemar Kecks +1"
		})

		-----------------------------------------------------------------------------------
		---		(DW:22	STP:54		QA:2%	TA:14%	DA:14%)
		-----------------------------------------------------------
		sets.engaged.DW2.Mid.Max = set_combine(sets.engaged.DW2.Low.Max,
		{
			ammo="Falcon Eye",
			rear={name="Mache Earring +1", bag="wardrobe3"},
			hands="Luh. Bazubands +3",
			legs="Carmine Cuisses +1"
		})

		-----------------------------------------------------------------------------------
		---		(DW:23	STP:46~50	QA:0%	TA:5%	DA:15%)
		-----------------------------------------------------------
		sets.engaged.DW2.High.Max = set_combine(sets.engaged.DW2.Mid.Max,
		{
			head="Carmine Mask +1",
			body="Luhlaza Jubbah +3", lring={name="Chirich Ring +1", bag="wardrobe3"},
			waist="Reiki Yotai", feet="Assim. Charuqs +3"
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
			ammo="Ginsen",
			head=gear.AHead_TP, neck="Mirage Stole +2", lear="Brutal Earring", rear="Suppanomimi",
			body="Adhemar Jacket +1", hands="Adhemar Wrist. +1", lring="Hetairoi Ring", rring="Epona's Ring",
			back=gear.BLUCape_STP, waist="Windbuffet Belt +1", legs="Samnuha Tights", feet=gear.HBoots_TP
		}
		
		-----------------------------------------------------------------------------------
		---		(DW:13	STP:70		QA:4%	TA:14%	DA:8%)
		-----------------------------------------------------------
		sets.engaged.DW3.Max.AM3 =
		{
			ammo="Ginsen",
			head="Dampening Tam", neck="Mirage Stole +2", lear="Telos Earring", rear="Dedition Earring",
			body="Adhemar Jacket +1", hands="Adhemar Wrist. +1", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring="Epona's Ring",
			back=gear.BLUCape_STP, waist="Reiki Yotai", legs="Samnuha Tights", feet="Carmine Greaves +1"
		}

		-----------------------------------------------------------------------------------
		---		(DW:11	STP:32		QA:5%	TA:24%	DA:8%)
		-----------------------------------------------------------
		sets.engaged.DW3.Low.Max = set_combine(sets.engaged.DW3.Max,
		{
			ammo="Falcon Eye",
			head="Dampening Tam", lear="Telos Earring", 
			lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"},
		})

		-----------------------------------------------------------------------------------
		---		(DW:12	STP:38		QA:3%	TA:22%	DA:10%)
		-----------------------------------------------------------
		sets.engaged.DW3.Mid.Max = set_combine(sets.engaged.DW3.Low.Max,
		{
			rear={name="Mache Earring +1", bag="wardrobe3"},
			hands="Luh. Bazubands +3",
			waist="Kentarch Belt +1", legs="Carmine Cuisses +1",
		})

		-----------------------------------------------------------------------------------
		---		(DW:13	STP:24		QA:0%	TA:0%	DA:11%)
		-----------------------------------------------------------
		sets.engaged.DW3.High.Max = set_combine(sets.engaged.DW3.Mid.Max,
		{
			head="Carmine Mask +1", lear={name="Mache Earring +1", bag="wardrobe2"},
			body="Luhlaza Jubbah +3",
			back=gear.BLUCape_DW, legs="Adhemar Kecks +1", feet="Assim. Charuqs +3"
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
			ammo="Ginsen",
			head=gear.AHead_TP, neck="Mirage Stole +2", lear="Brutal Earring", rear="Cessance Earring",
			body="Adhemar Jacket +1", hands="Adhemar Wrist. +1", lring="Hetairoi Ring", rring="Epona's Ring",
			back=gear.BLUCape_STP, waist="Windbuffet Belt +1", legs="Samnuha Tights", feet=gear.HBoots_TP
		}
		
		-----------------------------------------------------------------------------------
		---		(DW:6	STP:61		QA:6%	TA:16%	DA:11%)
		-----------------------------------------------------------
		sets.engaged.DW4.Max.AM3 =
		{
			ammo="Ginsen",
			head="Dampening Tam", neck="Mirage Stole +2", lear="Telos Earring", rear="Dedition Earring",
			body="Adhemar Jacket +1", hands="Adhemar Wrist. +1", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring="Epona's Ring",
			back=gear.BLUCape_STP, waist="Windbuffet Belt +1", legs="Samnuha Tights", feet="Carmine Greaves +1"
		}

		-----------------------------------------------------------------------------------
		---		(DW:6	STP:34		QA:5%	TA:24%	DA:10%)
		-----------------------------------------------------------
		sets.engaged.DW4.Low.Max = set_combine(sets.engaged.DW4.Max,
		{
			ammo="Falcon Eye",
			head="Dampening Tam", lear="Telos Earring", rear={name="Mache Earring +1", bag="wardrobe3"},
			lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"},
		})

		-----------------------------------------------------------------------------------
		---		(DW:6	STP:37~41	QA:3%	TA:17%	DA:10%)
		-----------------------------------------------------------
		sets.engaged.DW4.Mid.Max = set_combine(sets.engaged.DW4.Low.Max,
		{
			lear={name="Mache Earring +1", bag="wardrobe2"}, 
			hands="Luh. Bazubands +3",
			waist="Kentarch Belt +1", legs="Adhemar Kecks +1",
		})

		-----------------------------------------------------------------------------------
		---		(DW:6	STP:23~27	QA:0%	TA:0%	DA:15%)
		-----------------------------------------------------------
		sets.engaged.DW4.High.Max = set_combine(sets.engaged.DW4.Mid.Max,
		{
			head="Carmine Mask +1",
			body="Luhlaza Jubbah +3",
			legs="Carmine Cuisses +1", feet="Assim. Charuqs +3"
		})

		
		
		
		
	--------------------------------------
	-- Hybrid Sets
	--------------------------------------
		sets.engaged.Hybrid = 
		{-- DT: 19%		PDT: 30%	MDT: 18%
			ammo="Staunch Tathlum +1",
			head=gear.AHead_PDT, 
			hands="Assim. Bazu. +3", lring="Defending Ring", rring="Gelatinous Ring +1",
		}
		
		sets.engaged.Hybrid2 = 
		{-- DT: 31%		PDT: 42%	MDT: 30%
			ammo="Staunch Tathlum +1",
			head=gear.AHead_PDT, neck="Loricate Torque +1",
			body="Ayanmo Corazza +2", hands="Assim. Bazu. +3", lring="Defending Ring", rring="Gelatinous Ring +1",
		}
		
		
		----------------------------------------------------------
		-- Sword & Board
		----------------------------------------------------------	
	    	sets.engaged.DT 				= set_combine(sets.engaged, 		sets.engaged.Hybrid)
		sets.engaged.AM3.DT 				= set_combine(sets.engaged.AM3,		sets.engaged.Hybrid)
		sets.engaged.Low.DT 				= set_combine(sets.engaged.Low, 	sets.engaged.Hybrid)
		sets.engaged.Mid.DT 				= set_combine(sets.engaged.Mid, 	sets.engaged.Hybrid)
		sets.engaged.High.DT				= set_combine(sets.engaged.High, 	sets.engaged.Hybrid)
		
	
		sets.engaged.DTMAX 					= set_combine(sets.engaged, 		sets.engaged.Hybrid2,
		{
			neck="Mirage Stole +2"
		})
		sets.engaged.DTMAX.AM3 					= set_combine(sets.engaged.AM3,		sets.engaged.Hybrid2,
		{
			neck="Mirage Stole +2"
		})
		sets.engaged.Low.DTMAX 				= set_combine(sets.engaged.Low, 	sets.engaged.Hybrid2,
		{
			neck="Mirage Stole +2"
		})
		sets.engaged.Mid.DTMAX				= set_combine(sets.engaged.Mid, 	sets.engaged.Hybrid2,
		{
			neck="Mirage Stole +2"
		})
		sets.engaged.High.DTMAX				= set_combine(sets.engaged.High, 	sets.engaged.Hybrid2,
		{
			neck="Mirage Stole +2"
		})

		
	
		----------------------------------------------------------
		-- No Haste
		----------------------------------------------------------
		sets.engaged.DW2.DT 				= set_combine(sets.engaged.DW2, 	sets.engaged.Hybrid)
		sets.engaged.DW2.DT.AM3 			= set_combine(sets.engaged.DW2.AM3, 	sets.engaged.Hybrid)
		sets.engaged.DW2.Low.DT 			= set_combine(sets.engaged.DW2.Low, 	sets.engaged.Hybrid)
		sets.engaged.DW2.Mid.DT 			= set_combine(sets.engaged.DW2.Mid, 	sets.engaged.Hybrid)
		sets.engaged.DW2.High.DT 			= set_combine(sets.engaged.DW2.High, 	sets.engaged.Hybrid)

	
		sets.engaged.DW3.DT 				= set_combine(sets.engaged.DW3, 	sets.engaged.Hybrid)
		sets.engaged.DW3.DT.AM3 			= set_combine(sets.engaged.DW3.AM3, 	sets.engaged.Hybrid)
		sets.engaged.DW3.Low.DT 			= set_combine(sets.engaged.DW3.Low, 	sets.engaged.Hybrid)
		sets.engaged.DW3.Mid.DT 			= set_combine(sets.engaged.DW3.Mid, 	sets.engaged.Hybrid)
		sets.engaged.DW3.High.DT 			= set_combine(sets.engaged.DW3.High, 	sets.engaged.Hybrid)
		
	
		sets.engaged.DW4.DT 				= set_combine(sets.engaged.DW4, 	sets.engaged.Hybrid)
		sets.engaged.DW4.DT.AM3 			= set_combine(sets.engaged.DW4.AM3, 	sets.engaged.Hybrid)
		sets.engaged.DW4.Low.DT 			= set_combine(sets.engaged.DW4.Low, 	sets.engaged.Hybrid)
		sets.engaged.DW4.Mid.DT 			= set_combine(sets.engaged.DW4.Mid, 	sets.engaged.Hybrid)
		sets.engaged.DW4.High.DT 			= set_combine(sets.engaged.DW4.High, 	sets.engaged.Hybrid)
		
		
		
		sets.engaged.DW2.DTMAX 				= set_combine(sets.engaged.DW2, 	sets.engaged.Hybrid2)
		sets.engaged.DW2.DTMAX.AM3 			= set_combine(sets.engaged.DW2.AM3, 	sets.engaged.Hybrid2)
		sets.engaged.DW2.Low.DTMAX 			= set_combine(sets.engaged.DW2.Low, 	sets.engaged.Hybrid2)
		sets.engaged.DW2.Mid.DTMAX 			= set_combine(sets.engaged.DW2.Mid, 	sets.engaged.Hybrid2)
		sets.engaged.DW2.High.DTMAX			= set_combine(sets.engaged.DW2.High, 	sets.engaged.Hybrid2)

	
		sets.engaged.DW3.DTMAX 				= set_combine(sets.engaged.DW3, 	sets.engaged.Hybrid2)
		sets.engaged.DW3.DTMAX.AM3 			= set_combine(sets.engaged.DW3.AM3, 	sets.engaged.Hybrid2)
		sets.engaged.DW3.Low.DTMAX 			= set_combine(sets.engaged.DW3.Low, 	sets.engaged.Hybrid2)
		sets.engaged.DW3.Mid.DTMAX 			= set_combine(sets.engaged.DW3.Mid, 	sets.engaged.Hybrid2)
		sets.engaged.DW3.High.DTMAX			= set_combine(sets.engaged.DW3.High, 	sets.engaged.Hybrid2)
		
	
		sets.engaged.DW4.DTMAX 				= set_combine(sets.engaged.DW4, 	sets.engaged.Hybrid2)
		sets.engaged.DW4.DTMAX.AM3 			= set_combine(sets.engaged.DW4.AM3, 	sets.engaged.Hybrid2)
		sets.engaged.DW4.Low.DTMAX 			= set_combine(sets.engaged.DW4.Low, 	sets.engaged.Hybrid2)
		sets.engaged.DW4.Mid.DTMAX 			= set_combine(sets.engaged.DW4.Mid, 	sets.engaged.Hybrid2)
		sets.engaged.DW4.High.DTMAX			= set_combine(sets.engaged.DW4.High, 	sets.engaged.Hybrid2)
		
		
	
		----------------------------------------------------------
		-- Minimum Haste
		----------------------------------------------------------
		sets.engaged.DW2.DT.Min 			= set_combine(sets.engaged.DW2.Min,		sets.engaged.Hybrid)
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
		
		
		
		sets.engaged.DW2.DTMAX.Min 	 		= set_combine(sets.engaged.DW2.Min, 		sets.engaged.Hybrid2)
		sets.engaged.DW2.DTMAX.Min.AM3  	= set_combine(sets.engaged.DW2.Min.AM3, 	sets.engaged.Hybrid2)
		sets.engaged.DW2.Low.DTMAX.Min  	= set_combine(sets.engaged.DW2.Low.Min, 	sets.engaged.Hybrid2)
		sets.engaged.DW2.Mid.DTMAX.Min  	= set_combine(sets.engaged.DW2.Mid.Min, 	sets.engaged.Hybrid2)
		sets.engaged.DW2.High.DTMAX.Min		= set_combine(sets.engaged.DW2.High.Min, 	sets.engaged.Hybrid2)
		
	
		sets.engaged.DW3.DTMAX.Min 	 		= set_combine(sets.engaged.DW3.Min, 		sets.engaged.Hybrid2)
		sets.engaged.DW3.DTMAX.Min.AM3  	= set_combine(sets.engaged.DW3.Min.AM3, 	sets.engaged.Hybrid2)
		sets.engaged.DW3.Low.DTMAX.Min  	= set_combine(sets.engaged.DW3.Low.Min, 	sets.engaged.Hybrid2)
		sets.engaged.DW3.Mid.DTMAX.Min  	= set_combine(sets.engaged.DW3.Mid.Min, 	sets.engaged.Hybrid2)
		sets.engaged.DW3.High.DTMAX.Min 	= set_combine(sets.engaged.DW3.High.Min, 	sets.engaged.Hybrid2)
		
	
		sets.engaged.DW4.DTMAX.Min 	 		= set_combine(sets.engaged.DW4.Min, 		sets.engaged.Hybrid2,
		{
			feet=gear.TFeet_TP
		})
		sets.engaged.DW4.DTMAX.Min.AM3  	= set_combine(sets.engaged.DW4.Min.AM3, 	sets.engaged.Hybrid2,
		{
			feet=gear.TFeet_TP
		})
		sets.engaged.DW4.Low.DTMAX.Min  	= set_combine(sets.engaged.DW4.Low.Min, 	sets.engaged.Hybrid2,
		{
			feet=gear.TFeet_TP
		})
		sets.engaged.DW4.Mid.DTMAX.Min  	= set_combine(sets.engaged.DW4.Mid.Min, 	sets.engaged.Hybrid2)
		sets.engaged.DW4.High.DTMAX.Min 	= set_combine(sets.engaged.DW4.High.Min, 	sets.engaged.Hybrid2)
		
		
	
		----------------------------------------------------------
		-- Medium Haste
		----------------------------------------------------------
		sets.engaged.DW2.DT.Med 	 		= set_combine(sets.engaged.DW2.Med, 		sets.engaged.Hybrid)
		sets.engaged.DW2.DT.Med.AM3  		= set_combine(sets.engaged.DW2.Med.AM3, 	sets.engaged.Hybrid)
		sets.engaged.DW2.Low.DT.Med  		= set_combine(sets.engaged.DW2.Low.Med, 	sets.engaged.Hybrid)
		sets.engaged.DW2.Mid.DT.Med  		= set_combine(sets.engaged.DW2.Mid.Med, 	sets.engaged.Hybrid)
		sets.engaged.DW2.High.DT.Med 		= set_combine(sets.engaged.DW2.High.Med, 	sets.engaged.Hybrid)

	
		sets.engaged.DW3.DT.Med 	 		= set_combine(sets.engaged.DW3.Med, 		sets.engaged.Hybrid)
		sets.engaged.DW3.DT.Med.AM3  		= set_combine(sets.engaged.DW3.Med.AM3, 	sets.engaged.Hybrid)
		sets.engaged.DW3.Low.DT.Med  		= set_combine(sets.engaged.DW3.Low.Med, 	sets.engaged.Hybrid)
		sets.engaged.DW3.Mid.DT.Med  		= set_combine(sets.engaged.DW3.Mid.Med, 	sets.engaged.Hybrid)
		sets.engaged.DW3.High.DT.Min 		= set_combine(sets.engaged.DW3.High.Min, 	sets.engaged.Hybrid)

	
		sets.engaged.DW4.DT.Med 	 		= set_combine(sets.engaged.DW4.Med, 		sets.engaged.Hybrid)
		sets.engaged.DW4.DT.Med.AM3  		= set_combine(sets.engaged.DW4.Med.AM3, 	sets.engaged.Hybrid)
		sets.engaged.DW4.Low.DT.Med  		= set_combine(sets.engaged.DW4.Low.Med, 	sets.engaged.Hybrid)
		sets.engaged.DW4.Mid.DT.Med  		= set_combine(sets.engaged.DW4.Mid.Med, 	sets.engaged.Hybrid)
		sets.engaged.DW4.High.DT.Med 		= set_combine(sets.engaged.DW4.High.Med, 	sets.engaged.Hybrid)
		
		
		
		sets.engaged.DW2.DTMAX.Med 	 		= set_combine(sets.engaged.DW2.Med, 		sets.engaged.Hybrid2)
		sets.engaged.DW2.DTMAX.Med.AM3  	= set_combine(sets.engaged.DW2.Med.AM3, 	sets.engaged.Hybrid2)
		sets.engaged.DW2.Low.DTMAX.Med  	= set_combine(sets.engaged.DW2.Low.Med, 	sets.engaged.Hybrid2)
		sets.engaged.DW2.Mid.DTMAX.Med  	= set_combine(sets.engaged.DW2.Mid.Med, 	sets.engaged.Hybrid2)
		sets.engaged.DW2.High.DTMAX.Med 	= set_combine(sets.engaged.DW2.High.Med, 	sets.engaged.Hybrid2)

	
		sets.engaged.DW3.DTMAX.Med 	 		= set_combine(sets.engaged.DW3.Med, 		sets.engaged.Hybrid2)
		sets.engaged.DW3.DTMAX.Med.AM3  	= set_combine(sets.engaged.DW3.Med.AM3, 	sets.engaged.Hybrid2,
		{
			rear="Suppanomimi",
			feet=gear.HBoots_TP
		})
		sets.engaged.DW3.Low.DTMAX.Med  	= set_combine(sets.engaged.DW3.Low.Med, 	sets.engaged.Hybrid2)
		sets.engaged.DW3.Mid.DTMAX.Med  	= set_combine(sets.engaged.DW3.Mid.Med, 	sets.engaged.Hybrid2,
		{
			head="Carmine Mask +1", lear="Eabani Earring",
			feet="Aya. Gambieras +2"
		})
		sets.engaged.DW3.High.DTMAX.Med 	= set_combine(sets.engaged.DW3.High.Min, 	sets.engaged.Hybrid2,
		{
			head="Carmine Mask +1", lear="Eabani Earring",
			feet="Aya. Gambieras +2"
		})

	
		sets.engaged.DW4.DTMAX.Med 	 		= set_combine(sets.engaged.DW4.Med, 		sets.engaged.Hybrid2,
		{
			legs="Carmine Cuisses +1"
		})
		sets.engaged.DW4.DTMAX.Med.AM3  	= set_combine(sets.engaged.DW4.Med.AM3, 	sets.engaged.Hybrid2,
		{
			legs="Carmine Cuisses +1"
		})
		sets.engaged.DW4.Low.DTMAX.Med  	= set_combine(sets.engaged.DW4.Low.Med, 	sets.engaged.Hybrid2,
		{
			legs="Carmine Cuisses +1"
		})
		sets.engaged.DW4.Mid.DTMAX.Med  	= set_combine(sets.engaged.DW4.Mid.Med, 	sets.engaged.Hybrid2,
		{
			rear="Suppanomimi",
			legs="Carmine Cuisses +1"
		})
		sets.engaged.DW4.High.DTMAX.Med 	= set_combine(sets.engaged.DW4.High.Med, 	sets.engaged.Hybrid2,
		{
			head="Carmine Mask +1", lear="Eabani Earring", rear="Suppanomimi",
			waist="Reiki Yotai", legs="Adhemar Kecks +1", feet="Aya. Gambieras +2"
		})
		
	
	
		----------------------------------------------------------
		-- Maximum Haste
		----------------------------------------------------------		
		sets.engaged.DW2.DT.Max 	 		= set_combine(sets.engaged.DW2.Max, 		sets.engaged.Hybrid)
		sets.engaged.DW2.DT.Max.AM3  		= set_combine(sets.engaged.DW2.Max.AM3, 	sets.engaged.Hybrid)
		sets.engaged.DW2.Low.DT.Max  		= set_combine(sets.engaged.DW2.Low.Max, 	sets.engaged.Hybrid)
		sets.engaged.DW2.Mid.DT.Max  		= set_combine(sets.engaged.DW2.Mid.Max, 	sets.engaged.Hybrid)
		sets.engaged.DW2.High.DT.Max 		= set_combine(sets.engaged.DW2.High.Max, 	sets.engaged.Hybrid)
		
	
		sets.engaged.DW3.DT.Max 	 		= set_combine(sets.engaged.DW3.Max, 		sets.engaged.Hybrid)
		sets.engaged.DW3.DT.Max.AM3  		= set_combine(sets.engaged.DW3.Max.AM3, 	sets.engaged.Hybrid)
		sets.engaged.DW3.Low.DT.Max  		= set_combine(sets.engaged.DW3.Low.Max, 	sets.engaged.Hybrid)
		sets.engaged.DW3.Mid.DT.Max  		= set_combine(sets.engaged.DW3.Mid.Max, 	sets.engaged.Hybrid)
		sets.engaged.DW3.High.DT.Max 		= set_combine(sets.engaged.DW3.High.Max, 	sets.engaged.Hybrid)

	
		sets.engaged.DW4.DT.Max 	 		= set_combine(sets.engaged.DW4.Max, 		sets.engaged.Hybrid)
		sets.engaged.DW4.DT.Max.AM3  		= set_combine(sets.engaged.DW4.Max.AM3, 	sets.engaged.Hybrid)
		sets.engaged.DW4.Low.DT.Max  		= set_combine(sets.engaged.DW4.Low.Max, 	sets.engaged.Hybrid)
		sets.engaged.DW4.Mid.DT.Max  		= set_combine(sets.engaged.DW4.Mid.Max, 	sets.engaged.Hybrid)
		sets.engaged.DW4.High.DT.Max 		= set_combine(sets.engaged.DW4.High.Max, 	sets.engaged.Hybrid)
		
		
		
		sets.engaged.DW2.DTMAX.Max 	 		= set_combine(sets.engaged.DW2.Max, 		sets.engaged.Hybrid2,
		{
			legs="Carmine Cuisses +1"
		})
		sets.engaged.DW2.DTMAX.Max.AM3  	= set_combine(sets.engaged.DW2.Max.AM3, 	sets.engaged.Hybrid2,
		{
			legs="Carmine Cuisses +1"
		})
		sets.engaged.DW2.Low.DTMAX.Max  	= set_combine(sets.engaged.DW2.Low.Max, 	sets.engaged.Hybrid2,
		{
			legs="Carmine Cuisses +1"
		})
		sets.engaged.DW2.Mid.DTMAX.Max  	= set_combine(sets.engaged.DW2.Mid.Max, 	sets.engaged.Hybrid2,
		{
			lear="Eabani Earring"
		})
		sets.engaged.DW2.High.DTMAX.Max 	= set_combine(sets.engaged.DW2.High.Max, 	sets.engaged.Hybrid2,
		{
			lear="Eabani Earring"
		})
		
	
		sets.engaged.DW3.DTMAX.Max 	 		= set_combine(sets.engaged.DW3.Max, 		sets.engaged.Hybrid2,
		{
			rear="Cessance Earring",
			back=gear.BLUCape_DW
		})
		sets.engaged.DW3.DTMAX.Max.AM3  	= set_combine(sets.engaged.DW3.Max.AM3, 	sets.engaged.Hybrid2,
		{
			rear="Eabani Earring"
		})
		sets.engaged.DW3.Low.DTMAX.Max  	= set_combine(sets.engaged.DW3.Low.Max, 	sets.engaged.Hybrid2,
		{
			rear="Cessance Earring",
			back=gear.BLUCape_DW
		})
		sets.engaged.DW3.Mid.DTMAX.Max  	= set_combine(sets.engaged.DW3.Mid.Max, 	sets.engaged.Hybrid2,
		{
			back=gear.BLUCape_DW, legs="Adhemar Kecks +1"
		})
		sets.engaged.DW3.High.DTMAX.Max 	= set_combine(sets.engaged.DW3.High.Max, 	sets.engaged.Hybrid2)

	
		sets.engaged.DW4.DTMAX.Max 	 		= set_combine(sets.engaged.DW4.Max, 		sets.engaged.Hybrid2,
		{
			legs="Carmine Cuisses +1"
		})
		sets.engaged.DW4.DTMAX.Max.AM3  	= set_combine(sets.engaged.DW4.Max.AM3, 	sets.engaged.Hybrid2,
		{
			waist="Reiki Yotai"
		})
		sets.engaged.DW4.Low.DTMAX.Max  	= set_combine(sets.engaged.DW4.Low.Max, 	sets.engaged.Hybrid2,
		{
			legs="Carmine Cuisses +1"
		})
		sets.engaged.DW4.Mid.DTMAX.Max  	= set_combine(sets.engaged.DW4.Mid.Max, 	sets.engaged.Hybrid2,
		{
			legs="Carmine Cuisses +1"
		})
		sets.engaged.DW4.High.DTMAX.Max 	= set_combine(sets.engaged.DW4.High.Max, 	sets.engaged.Hybrid2)
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

-- Run after the general precast() is done.


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
	
	if (spell.skill =='Elemental Magic' or spellMap == 'Magical' or spellMap == 'DarkBlue' or spellMap == 'LightBlue' or spellMap == 'Breath')
			and ((spell.element == world.day_element and spell.element == world.weather_element) 
				or (spell.element == world.weather_element and get_weather_intensity() == 2)) then
		equip { waist="Hachirin-no-Obi" }
	end
	
	if spell.action_type == 'Magic' then
		apply_ability_bonuses(spell, action, spellMap, eventArgs)
	end
	
	if state.TreasureMode.value ~= 'None' and spell.action_type == 'Magic' and spell.target.type == 'MONSTER' then
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
	
	-- If we gain or lose any haste buffs, adjust which gear set we target.
	if S{'haste','march','embrava','haste samba', 'mighty guard', 'geo-haste', 'indi-haste', 'slow', 'indi-slow', 'elegy',}:contains(buff:lower()) then
		determine_haste_group()
		handle_equipping_gear(player.status)
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
end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
	equip(sets[state.MainWeaponSet.current])
	equip(sets[state.SubWeaponSet.current])
end

function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet,
		{
			body="Jhakri Robe +2",
			waist="Fucho-no-Obi",
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
	
	determine_haste_group()
	update_active_abilities()
	update_combat_form()
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
		
	add_to_chat(060, msg)

	eventArgs.handled = true
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

-- Determines Dual Wield level for Combat Form
function update_combat_form()
    if determine_DW() == 35  then
		state.CombatForm:set('DW5')
		--add_to_chat(8, '-------------Dual Wield Level 4 Detected--------------')
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
	set_macro_page(1, 5)
	
	send_command('lua l azuresets')
	
	send_command('wait 3; input /lockstyleset ' .. lockstyleset)
end
