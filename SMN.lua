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
    state.Buff["Avatar's Favor"] = buffactive["Avatar's Favor"] or false
    state.Buff["Astral Conduit"] = buffactive["Astral Conduit"] or false

	spirits = S{"LightSpirit", "DarkSpirit", "FireSpirit", "EarthSpirit", "WaterSpirit", "AirSpirit", "IceSpirit", "ThunderSpirit"}
    avatars = S{"Carbuncle", "Fenrir", "Diabolos", "Ifrit", "Titan", "Leviathan", "Garuda", "Shiva", "Ramuh", "Odin", "Alexander", "Cait Sith", "Atomos"}

	blood_pacts = {}

	blood_pacts.bp_Buffs =
	S{
		'Shining Ruby','Glittering Ruby','Healing Ruby','Healing Ruby II','Soothing Ruby','Pacifying Ruby',
		'Frost Armor','Crystal Blessing',
		'Hastega','Fleet Wind','Hastega II','Aerial Armor','Whispering Wind',
		'Earthen Armor','Earthen Ward',
		'Rolling Thunder','Lightning Armor',
		'Soothing Current','Spring Water',
		'Crimson Howl','Inferno Howl',
		'Ecliptic Growl','Ecliptic Howl','Heavenward Howl',
		'Noctoshield','Dream Shroud',
		"Altana's Favor",'Raise II','Mewing Lullaby','Reraise II'
	}

	blood_pacts.bp_Debuffs =
	S{
		'Sleepga','Diamond Storm',
		'Shock Squall',
		'Slowga','Tidal Roar',
		'Eerie Eye',
		'Lunar Cry','Lunar Roar',
		'Ultimate Terror','Pavor Nocturnus'
	}

	blood_pacts.bp_Physical =
	S{
		'Poison Nails',
		'Axe Kick','Double Slap','Rush',
		'Claw','Predator Claws',
		'Rock Throw','Rock Buster','Megalith Throw','Mountain Buster','Crag Throw',
		'Shock Strike','Chaotic Strike','Volt Strike',
		'Barracude Dive','Tail Whip','Spinning Dive',
		'Punch','Double Punch',
		'Regal Scratch','Regal Gash',
		'Moonlit Charge','Crescent Fang','Eclipse Bite',
		'Camisado','Blindside'
	}

	blood_pacts.bp_Magical =
	S{
		'Searing Light','Meteorite','Holy Mist',
		'Diamond Dust','Blizard II','Blizzard IV',
		'Aerial Blast','Aero II','Aero IV',
		'Earthen Fury','Stone II','Stone IV',
		'Judgment Bolt','Thunder II','Thunderspark','Thunder IV',
		'Tidal Wave','Water II','Water IV',
		'Inferno','Fire II','Fire IV','Conflag Strike',
		'Level ? Holy',
		'Howling Moon','Lunar Bay',
		'Ruinous Omen','Somnolence','Nightmare','Nether Blast','Night Terror'
	}

	blood_pacts.bp_Merit =
	S{
		'Meteor Strike','Heavenly Strike','Wind Blade','Geocrush','Thunderstorm','Grand Fall',
		'Impact'
	}

	blood_pacts.bp_Hybrid =
	S{
		'Burning Strike','Flaming Crush'
	}

	lockstyleset = 7
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Avatar')
    state.IdleMode:options('Normal', 'DT', 'DPS', 'Favor', 'Movement')
	state.PhysicalDefenseMode:options('PDT', 'MDT')

    select_default_macro_book()
	
	set_lockstyle()
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
		sets.precast.JA['Elemental Siphon'] =
		{
			main="Espiritus", sub="Vox Grip", ammo="Esper Stone +1",
			head="Baayami Hat", neck="Incanter's Torque", lear="Andoaa Earring", rear="Smn. Earring",
			body="Baayami Robe", hands="Baayami Cuffs", lring="Stikini Ring", rring="Evoker's Ring",
			back="Conveyance Cape", waist="Lucidity Sash", legs="Baayami Slops",feet="Beck. Pigaches +1"
		}

		sets.precast.JA['Mana Cede'] =
		{
			hands="Beck. Bracers +1"
		}
		
	
    -------------------
	--  Blood Pacts  --
	------------------- 
		sets.precast.BloodPactWard =
		{
			main="Espiritus", sub="Vox Grip", ammo="Sancus Sachet",
			head="Beckoner's Horn +1", neck="Incanter's Torque", lear="Andoaa Earring", rear="Smn. Earring",
			body="Con. Doublet +3", hands="Baayami Cuffs", lring="Stikini Ring", rring="Evoker's Ring",
			back="Conveyance Cape", waist="Lucidity Sash", legs="Baayami Slops", feet="Baayami Sabots"
		}

		sets.precast.BloodPactRage = sets.precast.BloodPactWard


    -------------------
	-- Precast Magic --
	------------------- 
		--Fast Cast: 63%
		sets.precast.FC =
		{
			head="Amalric Coif +1", neck="Orunmila's Torque", lear="Etiolation Earring", rear="Loquac. Earring",
			body="Inyanga Jubbah +2", hands="Telchine Gloves", lring="Kishar Ring", rring="Prolix Ring",
			back="Swith Cape +1", waist="Witful Belt", legs="Lengo Pants", feet="Amalric Nails +1"
		}
		
		--Fast Cast: 60%
		sets.precast.FC['Summoning Magic'] = set_combine(sets.precast.FC,
		{
			body="Baayami Robe"
		})

		--Fast Cast: 68%
		sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC,
		{
			waist="Siegel Sash"
		})

		--Fast Cast: 62%
		sets.precast.FC['Enfeebling Magic'] = set_combine(sets.precast.FC,
		{
			waist="Channeler's Stone"
		})

		--Fast Cast: 62%
		sets.precast.FC['Elemental Magic'] = sets.precast.FC['Enfeebling Magic']

		--Fast Cast: 83%
		sets.precast.FC.Stoneskin = set_combine(sets.precast.FC,
		{
			head="Umuthi Hat",
			hands="Carapacho Cuffs",
			waist="Siegel Sash"
		})

		--Fast Cast: 62%
		sets.precast.FC['Healing Magic'] = sets.precast.FC['Enfeebling Magic']

		--Fast Cast: 62%
		sets.precast.FC.StatusRemoval = sets.precast.FC['Enfeebling Magic']

		--Fast Cast: 72%
		sets.precast.FC.Cures = set_combine(sets.precast.FC,
		{
			rear="Mendi. Earring",
			waist="Channeler's Stone", feet="Vanya Clogs"
		})

		--Fast Cast: 72%
		sets.precast.FC.Curaga = sets.precast.FC.Cures

		--Fast Cast: 63%
		sets.precast.FC.Teleport = sets.precast.FC

		--Fast Cast: 63%
		sets.precast.FC.Reraise = sets.precast.FC

		--Fast Cast: 63%
		sets.precast.FC.Raise = sets.precast.FC

		--Fast Cast: 63%
		sets.precast.FC.Statless = sets.precast.FC

		--Fast Cast: 49%
		sets.precast.FC.Impact = set_combine(sets.precast.FC,
		{
			head=empty,
			body="Twilight Cloak",
			waist="Channeler's Stone"
		})

	
	

----------------------------------------------------------------------------
--------------------									--------------------
------------							 						------------
--------					Midcast Gear Sets						--------
------------							 						------------
--------------------									--------------------
----------------------------------------------------------------------------
    -------------------
	--  Blood Pacts  --
	------------------- 

		sets.midcast.Pet.bp_Buffs =
		{
			main="Espiritus", sub="Vox Grip", ammo="Esper Stone +1",
			head="Baayami Hat", neck="Incanter's Torque", lear="Andoaa Earring", rear="Smn. Earring",
			body="Baayami Robe", hands="Baayami Cuffs", lring="Stikini Ring", rring="Evoker's Ring",
			back="Conveyance Cape", waist="Lucidity Sash", legs="Baayami Slops", feet="Baayami Sabots"
		}

		sets.midcast.Pet.bp_Debuffs =
		{
			main="Espiritus", sub="Vox Grip", ammo="Sancus Sachet",
			head="Baayami Hat", neck="Adad Amulet", lear="Enmerkar Earring", rear="Lugalbanda Earring",
			body="Con. Doublet +3", hands="Lamassu Mitts +1", lring="Stikini Ring", rring="Evoker's Ring",
			back="Campestres's Cape", waist="Regal Belt", legs="Baayami Slops",feet="Baayami Sabots"
		}

		sets.midcast.Pet.bp_Physical =
		{
			main="Gridarvor", sub="Elan Strap", ammo="Sancus Sachet",
			head="Apogee Crown", neck="Shulmanu Collar", lear="Gelos Earring", rear="Lugalbanda Earring",
			body="Con. Doublet +3", hands="Merlinic Dastanas", lring="Varar Ring", rring="Varar Ring",
			back="Campestres's Cape", waist="Regal Belt", legs="Apogee Slacks", feet="Apogee Pumps"
		}

		sets.midcast.Pet.bp_Magical =
		{
			main=gear.Grioavolr_Pet, sub="Elan Strap", ammo="Sancus Sachet",
			head=gear.PetHood, neck="Adad Amulet", lear="Gelos Earring", rear="Lugalbanda Earring",
			body="Con. Doublet +3", hands="Merlinic Dastanas", lring="Varar Ring", rring="Varar Ring",
			back="Campestres's Cape", waist="Regal Belt", legs="Helios Spats", feet=gear.PetCrackows
		}

		sets.midcast.Pet.bp_Merit =
		{
			main=gear.Grioavolr_Pet, sub="Elan Strap", ammo="Sancus Sachet",
			head=gear.PetHood, neck="Adad Amulet", lear="Gelos Earring", rear="Lugalbanda Earring",
			body="Con. Doublet +3", hands="Merlinic Dastanas", lring="Varar Ring", rring="Varar Ring",
			back="Campestres's Cape", waist="Regal Belt", legs="Enticer's Pants", feet=gear.PetCrackows
		}

		sets.midcast.Pet.bp_Hybrid =
		{
			main=gear.Grioavolr_Pet, sub="Elan Strap", ammo="Sancus Sachet",
			head=gear.PetHood, neck="Adad Amulet", lear="Gelos Earring", rear="Lugalbanda Earring",
			body="Con. Doublet +3", hands="Merlinic Dastanas", lring="Varar Ring", rring="Varar Ring",
			back="Campestres's Cape", waist="Regal Belt", legs="Helios Spats", feet=gear.PetCrackows
		}


	--------------------------------------
	-- Base Midcast sets
	--------------------------------------

		sets.midcast.FC = sets.precast.FC
		
		sets.midcast.FC['Summoning Magic'] = sets.precast.FC['Summoning Magic']

		sets.midcast.ConserveMP = set_combine(sets.midcast.FC,
		{
			neck="Incanter's Torque", lear="Gwati Earring", rear="Mendi. Earring",
			body="Amalric Doublet +1",
			back="Fi Follet Cape +1", waist="Luminary Sash", legs="Lengo Pants", feet=gear.PetCrackows
		})

	
	--------------------------------------
	-- Healing Midcast sets
	--------------------------------------	

		sets.midcast.Cures =
		{
			main="Gada", sub="Genmei Shield",
			head="Vanya Hood", neck="Lasaia Pendant", lear="Gwati Earring", rear="Mendi. Earring",
			body="Merlinic Jubbah", hands="Telchine Gloves", lring="Lebeche Ring", rring="Vocane Ring",
			back="Solemnity Cape", waist="Gishdubar Sash", legs="Merlinic Shalwar", feet="Vanya Clogs"
		}
		sets.midcast.Curaga = sets.midcast.Cures

		sets.midcast.StatusRemoval = sets.midcast.FC

		sets.midcast.Cursna = set_combine(sets.precast.FC,
		{
			neck="Debilis Medallion",
			hands="Hieros Mittens", lring="Haoma's Ring", rring="Menelaus's Ring",
			back="Oretan. Cape +1", feet="Vanya Clogs"
		})

		sets.midcast['Healing Magic'] = sets.precast.FC['Healing Magic']

	
	--------------------------------------
	-- Buffing Midcast sets
	--------------------------------------
	
		sets.midcast.Duration =
		{
			main="Gada", sub="Ammurapi Shield",
			head="Telchine Cap", neck="Orunmila's Torque", lear="Etiolation Earring", rear="Loquac. Earring",
			body="Telchine Chas.", hands="Telchine Gloves", lring="Stikini Ring", rring="Stikini Ring",
			back="Swith Cape +1", waist="Luminary Sash", legs="Telchine Braconi", feet="Telchine Pigaches"
		}

		sets.midcast.Stoneskin =
		{
			main="Gada", sub="Ammurapi Shield",
			head="Telchine Cap", neck="Stone Gorget", lear="Andoaa Earring", rear="Earthcry Earring",
			body="Telchine Chas.", hands="Telchine Gloves", lring="Evanescence Ring", rring="Prolix Ring",
			back="Fi Follet Cape +1", waist="Olympus Sash", legs="Shedir Seraweels", feet="Telchine Pigaches"
		}

		sets.midcast.Aquaveil = set_combine(sets.midcast.Duration,
		{
			main="Vadose Rod",
			head="Amalric Coif +1", waist="Emphatikos Rope", legs="Shedir Seraweels"
		})

		sets.midcast['Enhancing Magic'] =
		{
			main="Gada", sub="Ammurapi Shield",
			head="Befouled Crown", neck="Incanter's Torque", lear="Andoaa Earring", rear="Augment. Earring",
			body="Telchine Chas.", hands="Inyan. Dastanas +2", lring="Stikini Ring", rring="Stikini Ring",
			back="Fi Follet Cape +1", waist="Olympus Sash", legs="Telchine Braconi", feet="Telchine Pigaches"
		}

		sets.midcast.BarElement = set_combine(sets.midcast['Enhancing Magic'],
		{
			legs="Shedir Seraweels"
		})

		sets.midcast.BarStatus = sets.midcast.BarElement

		sets.midcast.Regen =
		{
			main="Gada", sub="Ammurapi Shield",
			head="Inyanga Tiara +2", neck="Orunmila's Torque", lear="Gwati Earring", rear="Mendi. Earring",
			body="Telchine Chas.", hands="Telchine Gloves", lring="Lebeche Ring", rring="Prolix Ring",
			back="Swith Cape +1", waist="Luminary Sash", legs="Telchine Braconi", feet="Telchine Pigaches"
		}

		sets.midcast.Refresh =
		{
			main="Gada", sub="Ammurapi Shield",
			head="Amalric Coif +1", neck="Orunmila's Torque", lear="Gwati Earring", rear="Mendi. Earring",
			body="Telchine Chas.", hands="Telchine Gloves", lring="Lebeche Ring", rring="Prolix Ring",
			back="Grapevine Cape", waist="Gishdubar Sash", legs="Telchine Braconi", feet="Inspirited Boots"
		}

		sets.midcast.Statless = sets.midcast.Duration

		sets.midcast.Storm = sets.midcast.Duration

		sets.midcast.Protectra = set_combine(sets.midcast.Duration,
		{
			lring="Sheltered Ring"
		})

		sets.midcast.Protect = sets.midcast.Protectra

		sets.midcast.Shellra = sets.midcast.Protectra

		sets.midcast.Shell = sets.midcast.Protectra

	
	--------------------------------------
	-- Offensive Midcast sets
	--------------------------------------  
	
	---Enfeebling Magic
		sets.midcast.Macc =
		{
			main="Gada", sub="Ammurapi Shield",
			head="Befouled Crown", neck="Incanter's Torque", lear="Digni. Earring", rear="Gwati Earring",
			body="Vanya Robe", hands="Inyan. Dastanas +2", lring="Stikini Ring", rring="Stikini Ring",
			back="Swith Cape +1", waist="Luminary Sash", legs="Merlinic Shalwar", feet="Medium's Sabots"
		}

		sets.midcast['Dark Magic'] = set_combine(sets.midcast.Macc,
		{
			head="Pixie Hairpin +1",
			body="Shango Robe", lring="Archon Ring", rring="Stikini Ring",
			waist="Fucho-no-Obi", legs="Merlinic Shalwar", feet=gear.NukeCrackows
		})


		sets.midcast.Sap = set_combine(sets.midcast['Dark Magic'],
		{
			lring="Evanescence Ring", rring="Archon Ring"
		})

		sets.midcast['Elemental Magic'] =
		{
			main=gear.Grioavolr_Enf, sub="Niobid Strap", ammo="Pemphredo Tathlum",
			head=gear.NukeHood, neck="Mizu. Kubikazari", lear="Friomisi Earring", rear="Novio Earring",
			body="Amalric Doublet +1", hands="Amalric Gages +1", lring="Locus Ring", rring="Mujin Band",
			back="Swith Cape +1", waist="Eschan Stone", legs="Amalric Slops +1", feet="Amalric Nails +1"
		}

		sets.midcast['Elemental Magic'].Impact = set_combine(sets.midcast['Elemental Magic'],
		{
			head=empty, neck="Sanctity Necklace",
			body="Twilight Cloak", lring="Acumen Ring", rring="Archon Ring", 
		})
		
	
	--------------------------------------
	-- Miscellaneous Midcast sets
	--------------------------------------  
	
		sets.midcast.Teleport = sets.midcast.ConserveMP

		sets.midcast.Raise = sets.midcast.ConserveMP

		sets.midcast.Reraise = sets.midcast.ConserveMP
		
		sets.midcast.Utsusemi = sets.midcast.FastRecast

		
		
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
		main="Gridarvor", sub="Irenic Strap +1", ammo="Staunch Tathlum",
		head="Beckoner's Horn +1", neck="Sanctity Necklace", lear="Dawn Earring", rear="Infused Earring",
		body="Apogee Dalmatica", hands="Asteria Mitts +1", lring="Sheltered Ring", rring="Paguroidea Ring",
        back="Solemnity Cape", waist="Fucho-no-Obi", legs="Assid. Pants +1", feet="Baayami Sabots"
	}

	sets.idle.DT = set_combine(sets.idle,
	{
		neck="Loricate Torque +1", lear="Etiolation Earring",
        lring="Defending Ring", rring="Vocane Ring",
	})
	
	sets.idle.DPS = set_combine(sets.idle)
	
	sets.idle.Favor = set_combine(sets.idle)
	
	sets.idle.Movement = set_combine(sets.idle,
    {
        feet="Crier's Gaiters"
    })

	sets.idle.Town = set_combine(sets.idle,
	{
		feet="Crier's Gaiters"
	})
	
	sets.idle.AdoulinCity = set_combine(sets.idle,
	{
		body="Councilor's Garb"
	})

	sets.idle.Weak = sets.idle.DT

	------------------------------------------------------------------------------------------------
	----------------------------------------- Avatar Sets ------------------------------------------
	------------------------------------------------------------------------------------------------
		sets.idle.Avatar =
		{
			main="Gridarvor", sub="Vox Grip", ammo="Sancus Sachet",
			head="Beckoner's Horn +1", neck="Shulmanu Collar", lear="Enmerkar Earring", rear="Evans Earring",
			body="Apogee Dalmatica", hands="Asteria Mitts +1", lring="Varar Ring", rring="Evoker's Ring",
			back="Campestres's Cape", waist="Lucidity Sash", legs="Assid. Pants +1", feet="Baayami Sabots"
		}
		
		sets.idle.DT.Avatar =
		{
			main="Gridarvor", sub="Irenic Strap +1", ammo="Sancus Sachet",
			head="Beckoner's Horn +1", neck="Shulmanu Collar", lear="Enmerkar Earring", rear="Handler's Earring +1",
			body="Apogee Dalmatica", hands="Asteria Mitts +1", lring="Stikini Ring", rring="Evoker's Ring",
			back="Campestres's Cape", waist="Isa Belt", legs="Enticer's Pants", feet="Apogee Pumps"
		}
		
		sets.idle.DPS.Avatar =
		{
			main="Gridarvor", sub="Vox Grip", ammo="Sancus Sachet",
			head="Beckoner's Horn +1", neck="Shulmanu Collar", lear="Enmerkar Earring", rear="Evans Earring",
			body="Apogee Dalmatica", hands="Regimen Mittens", lring="Varar Ring", rring="Evoker's Ring",
			back="Campestres's Cape", waist="Klouskap Sash", legs="Enticer's Pants", feet="Apogee Pumps"
		}

		sets.idle.Movement.Avatar = set_combine(sets.idle.Avatar,
		{
			feet="Crier's Gaiters"
		})
		
		sets.idle.Favor.Avatar =
		{
			main="Gridarvor",sub="Vox Grip", ammo="Sancus Sachet",
			head="Beckoner's Horn +1", neck="Incanter's Torque", lear="Enmerkar Earring", rear="Handler's Earring +1",
			body="Apogee Dalmatica", hands="Baayami Cuffs", lring="Stikini Ring", rring="Evoker's Ring",
			back="Campestres's Cape", waist="Lucidity Sash", legs="Baayami Slops", feet="Apogee Pumps"
		}

		sets.idle.Spirit =
		{
			main="Espiritus",sub="Vox Grip", ammo="Sancus Sachet",
			head="Beckoner's Horn +1", neck="Adad Amulet", lear="Andoaa Earring", rear="Smn. Earring",
			body="Apogee Dalmatica", hands="Baayami Cuffs", ring1="Stikini Ring", ring2="Evoker's Ring",
			back="Campestres's Cape", waist="Lucidity Sash", legs="Assid. Pants +1", feet="Baayami Sabots"
		}
		
		sets.Kiting =
		{
			feet="Crier's Gaiters"
		}

	
	
	------------------------------------------------------------------------------------------------
	--------------------------------------- Defense Sets -------------------------------------------
	------------------------------------------------------------------------------------------------

	--------------------------------------
	-- Defensive Sets
	-------------------------------------
		-- PDT: -44% 	MDT: -42%
		sets.defense.PDT = set_combine(sets.idle.DT,
		{
			head="Inyanga Tiara +2",
			body="Merlinic Jubbah", hands="Inyan. Dastanas +2",
			legs="Inyanga Shalwar +2",
		})

		-- MDT:-57%		PDT: -29%
		sets.defense.MDT = set_combine(sets.defense.PDT,
		{
			sub="Irenic Strap +1",
			lear="Static Earring",
			body="Inyanga Jubbah +2",
			legs="Inyanga Shalwar +2", feet="Inyan. Crackows +2"
		})
		
	
	--------------------------------------
	-- Special Sets
	--------------------------------------
    
		sets.Kiting =
		{
			feet="Crier's Gaiters"
		}

		sets.perp = {}

		sets.perp.Alexander = sets.midcast.Pet.Debuffs

		sets.perp.Odin = sets.midcast.Pet.Debuffs

		sets.perp.Carbuncle =
		{
			ear1="Enmerkar Earring", ear2="Handler's Earring +1",
			hands="Asteria Mitts +1"
		}

		sets.perp.CaitSith =
		{
			ear1="Enmerkar Earring", ear2="Handler's Earring +1",
			hands="Lamassu Mitts +1"
		}
		
		sets.buff.Doom = 
		{
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
			ammo="Floestone",
			head="Tali'ah Turban +1", neck="Fotia Gorget", lear="Telos Earring", rear="Moonshade Earring",
			body="Tali'ah Manteel +1", hands="Tali'ah Gages +1", lring="Rufescent Ring", rring="Shukuyu Ring",
			back="Swith Cape +1", waist="Fotia Belt", legs="Tali'ah Sera. +1", feet="Tali'ah Crackows +1"
		}
		
		sets.precast.WS['Retribution'] = set_combine(sets.precast.WS,
		{
			body="Inyanga Jubbah +2", hands="Inyan. Dastanas +2", rring="Shukuyu Ring",
			legs="Tali'ah Sera. +1", feet="Baayami Sabots"
		})
		
		sets.precast.WS['Garland of Bliss'] = set_combine(sets.precast.WS,
		{
			head=gear.NukeHood, lear="Friomisi Earring",
			body="Amalric Doublet +1", hands="Amalric Gages +1", lring="Shiva Ring +1", rring="Shiva Ring +1",
			back="Swith Cape +1", legs="Amalric Slops +1", feet="Amalric Nails +1"
		})
	 
		sets.precast.WS['Shattersoul'] = set_combine(sets.precast.WS,
		{
			lring="Shiva Ring +1", rring="Shiva Ring +1",
			back="Grapevine Cape"
		})
		
		sets.precast.WS['Myrkr'] = set_combine(sets.precast.JA['Astral Conduit'],
		{
			neck="Fotia Gorget", rear="Moonshade Earring",
			waist="Fotia Belt"
		})
	
	--------------------------------------
	-- Melee sets
	--------------------------------------

		sets.engaged =
		{
			main="Gridarvor",sub="Elan Strap", ammo="Sancus Sachet",
			head="Beckoner's Horn +1", neck="Combatant's Torque", lear="Telos Earring",rear="Evans Earring",
			body="Tali'ah Manteel +1", hands="Tali'ah Gages +1", lring="Cacoethic Ring +1", rring="Varar Ring",
			back="Campestres's Cape", waist="Klouskap Sash", legs="Tali'ah Sera. +1", feet="Apogee Pumps"
		}
		
		sets.engaged.Avatar =
		{
			main="Gridarvor",sub="Elan Strap", ammo="Sancus Sachet",
			head="Beckoner's Horn +1", neck="Shulmanu Collar", lear="Enmerkar Earring", rear="Evans Earring",
			body="Apogee Dalmatica", hands="Regimen Mittens", lring="Varar Ring", rring="Varar Ring",
			back="Campestres's Cape", waist="Klouskap Sash", legs="Enticer's Pants", feet="Apogee Pumps"
		}

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if state.Buff['Astral Conduit'] and pet_midaction() then
        eventArgs.handled = true
    end
end

function job_midcast(spell, action, spellMap, eventArgs)
    if state.Buff['Astral Conduit'] and pet_midaction() then
        eventArgs.handled = true
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if state.Buff[buff] ~= nil then
        handle_equipping_gear(player.status)
    elseif storms:contains(buff) then
        handle_equipping_gear(player.status)
    end
end

-- Called when the player's pet's status changes.
-- This is also called after pet_change after a pet is released.  Check for pet validity.
function job_pet_status_change(newStatus, oldStatus, eventArgs)
    if pet.isvalid and not midaction() and not pet_midaction() and (newStatus == 'Engaged' or oldStatus == 'Engaged') then
        handle_equipping_gear(player.status, newStatus)
    end
end


function job_get_spell_map(spell, default_spell_map)
    if (spell.type == 'BloodPactRage' or spell.type == 'BloodPactWard') then
        for category,spell_list in pairs(blood_pacts) do
            if spell_list:contains(spell.english) then
                return category
            end
        end
    end
end


-- Called when a player gains or loses a pet.
-- pet == pet structure
-- gain == true if the pet was gained, false if it was lost.
function job_pet_change(petparam, gain)
    classes.CustomIdleGroups:clear()
    if gain then
        if avatars:contains(pet.name)  then
            classes.CustomIdleGroups:append('Avatar')
        elseif spirits:contains(pet.name) then
            classes.CustomIdleGroups:append('Spirit')
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function pet_midcast(spell)
	if (spell.type == 'BloodPactRage' or spell.type == 'BloodPactWard') then
		if bp_Buffs:contains(spell.name) then
			equip(sets.midcast.Pet.Buffs)
		elseif bp_Debuffs:contains(spell.name) then
			equip(sets.midcast.Pet.Debuffs)
		elseif bp_Physical:contains(spell.name) then
			equip(sets.midcast.Pet.Physical)
		elseif bp_Magical:contains(spell.name) then
			equip(sets.midcast.Pet.Magical)
		elseif bp_Hybrid:contains(spell.name) then
			equip(sets.midcast.Pet.Hybrid)
		end
	end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if pet.isvalid then
        if sets.perp[pet.name] then
            idleSet = set_combine(idleSet, sets.perp[pet.name])
        end
		if pet.name == 'Cait Sith' then
			idleSet = set_combine(idleSet, sets.perp.CaitSith)
		end
    end

    return idleSet
end

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    classes.CustomIdleGroups:clear()
    if pet.isvalid then
        if avatars:contains(pet.name) then
            classes.CustomIdleGroups:append('Avatar')
        elseif spirits:contains(pet.name) then
            classes.CustomIdleGroups:append('Spirit')
        end
    end
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)

end


-------------------------------------------------------------------------------------------------------------------
-- User self-commands.
-------------------------------------------------------------------------------------------------------------------



-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book(reset)
    if reset == 'reset' then
        -- lost pet, or tried to use pact when pet is gone
    end

    -- Default macro set/book
    set_macro_page(1, 7)
end

function set_lockstyle()
    send_command('wait 60; input /lockstyleset ' .. lockstyleset)
end