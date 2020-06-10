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
	customize_idle_set()
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	state.OffenseMode:options('Refresh','Normal')
	state.CastingMode:options('Normal','Potency','Resistant','Occult')
	state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('EVA','MDT')
	state.IdleMode:options('Normal','DT')

	apply_job_change()
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
	
		sets.precast.JA['Manafont'] =
		{
			body="Arch. Coat +3"
		}
	
	-------------------
	-- Precast Magic --
	------------------- 
		sets.precast.FC =
		{--Fast Cast 82
			main=gear.Grioavolr_Enf, sub="Khonsu", ammo="Sapience Orb",
			head="Amalric Coif +1", neck="Orunmila's Torque", lear="Malignance Earring", rear="Loquac. Earring",
			body=gear.FCJubbah, hands=gear.FCHands, lring="Lebeche Ring", rring="Weather. Ring +1",
			back=gear.BLMCape_FC, waist="Witful Belt", legs="Psycloth Lappas", feet=gear.FCCrackows
		}

		sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC)


		sets.precast.FC.Death = set_combine(sets.precast.FC,
		{--Fast Cast 79
			lear="Etiolation Earring",
			lear="Kishar Ring",
			feet="Amalric Nails +1"
		})

		sets.precast.FC.Cures = sets.precast.FC

		sets.precast.FC.Curagas = sets.precast.FC.Cures
		
		sets.precast.FC.Dispelga = set_combine(sets.precast.FC,
		{
			main="Daybreak", sub="Ammurapi Shield"
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
		sets.midcast.FC = sets.precast.FC


		sets.midcast.Duration =
		{ --1.5 x 1.16 Duration Bonus
			main="Gada", sub="Ammurapi Shield", ammo="Pemphredo Tathlum",
			head=gear.ENH_Head, neck="Orunmila's Torque", lear="Malignance Earring", rear="Loquac. Earring",
			body=gear.ENH_Body, hands=gear.ENH_Gloves, lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back="Fi Follet Cape +1", waist="Embla Sash", legs=gear.ENH_Legs, feet="Telchine Pigaches"
		}

		sets.midcast['Enhancing Magic'] =
		{
			main="Gada", sub="Ammurapi Shield", ammo="Pemphredo Tathlum",
			head=gear.ENH_Head, neck="Incanter's Torque", lear="Andoaa Earring", rear="Mimir Earring",
			body=gear.ENH_Body, hands=gear.ENH_Gloves, lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back="Fi Follet Cape +1", waist="Olympus Sash", legs=gear.ENH_Legs, feet="Telchine Pigaches"
		}
	
		sets.midcast.ConserveMP = 
		{
			main="Gada", sub="Ammurapi Shield", ammo="Pemphredo Tathlum",
			head="Vanya Hood", neck="Incanter's Torque", lear="Mendi. Earring", rear="Gwati Earring",
			body="Amalric Doublet +1", hands=gear.FCHands, lring="Kishar Ring", rring="Weather. Ring +1",
			back="Fi Follet Cape +1", waist="Luminary Sash", legs="Lengo Pants", feet="Medium's Sabots"
		}

	--------------------------------------
	-- Healing Midcast sets
	--------------------------------------	
	
		sets.midcast.Cures =
		{--Cure Potency: 52% Healing Skill +172
			main="Raetic Rod +1", sub="Sors Shield", ammo="Esper Stone +1",
			head="Vanya Hood", neck="Incanter's Torque", lear="Meili Earring", rear="Beatific Earring",
			body="Vanya Robe", hands="Vanya Cuffs", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring="Menelaus's Ring",
			back="Oretan. Cape +1", waist="Bishop's Sash", legs="Vanya Slops", feet="Vanya Clogs"
		}
		
		sets.midcast.CuresLocked =
		{--Cure Potency: 49%
			ammo="Esper Stone +1",
			head="Vanya Hood", neck="Incanter's Torque", lear="Meili Earring",rear="Mendi. Earring",
			body="Vanya Robe", hands=gear.ENH_Gloves, lring="Lebeche Ring", rring="Menelaus's Ring",
			back="Oretan. Cape +1", waist="Bishop's Sash", legs="Vanya Slops", feet="Medium's Sabots"
		}
		
		sets.midcast.CuresWeather =
		{
			rear="Mendi. Earring",
			lring="Lebeche Ring", rring="Menelaus's Ring",
			back="Twilight Cape", waist="Hachirin-no-Obi"
		}
		
		sets.midcast.Curaga = sets.midcast.Cures


		sets.midcast.Cursna =
		{
			main="Gada", sub="Chanter's Shield", ammo="Sapience Orb",
			head="Vanya Hood", neck="Debilis Medallion", lear="Beatific Earring", rear="Meili Earring",
			body="Vanya Robe", hands="Hieros Mittens", lring="Haoma's Ring", rring="Menelaus's Ring",
			back="Oretan. Cape +1", waist="Bishop's Sash", legs="Vanya Slops", feet="Vanya Clogs"
		}
		
		sets.midcast.Raise = sets.midcast.ConserveMP
	
	--------------------------------------
	-- Buffing Midcast sets
	--------------------------------------	
	
		sets.midcast.Stoneskin = set_combine(sets.midcast.Duration,
		{
			neck="Stone Gorget", rear="Earthcry Earring",
			waist="Siegel Sash", legs="Shedir Seraweels"
		})

		sets.midcast.Refresh = set_combine(sets.midcast.Duration,
		{
			head="Amalric Coif +1",
		})

		sets.midcast.Regen = sets.midcast.Duration

		sets.midcast.Aquaveil = set_combine(sets.midcast.Duration,
		{
			main="Vadose Rod",
			head="Amalric Coif +1", hands="Regal Cuffs",
			waist="Emphatikos Rope", legs="Shedir Seraweels"
		})

		sets.midcast.Statless = sets.midcast.Duration

		sets.midcast.Storm = sets.midcast.Duration

		sets.midcast.Klimaform = sets.midcast.FC

		sets.midcast.Protection = sets.midcast.Duration
	
	--------------------------------------
	-- Offensive Midcast sets
	--------------------------------------   
	
	
	---Enfeebling
		sets.midcast.Macc =
		{
			main="Raetic Staff +1", sub="Khonsu", ammo="Pemphredo Tathlum",
			head="Spae. Petasos +3", neck="Src. Stole +2", lear="Malignance Earring", rear="Regal Earring",
			body="Spaekona's Coat +2", hands="Spae. Gloves +3", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring="Metamor. Ring +1",
			back="Taranus's Cape", waist="Luminary Sash", legs="Spae. Tonban +3", feet="Spae. Sabots +3"
		}
	
		sets.midcast['Enfeebling Magic'] = set_combine(sets.midcast.Macc,
		{
			main="Daybreak", sub="Ammurapi Shield",
			head="Befouled Crown", lear="Vor Earring",
			hands="Regal Cuffs", lring="Kishar Ring",
			legs="Psycloth Lappas", feet="Medium's Sabots"
		})
	
		sets.midcast['Enfeebling Magic'].Resistant = sets.midcast.Macc
		
		sets.midcast.Dispelga = set_combine(sets.midcast['Enfeebling Magic'].Resistant,
		{
			main="Daybreak", sub="Ammurapi Shield"
		})

		sets.midcast.ElementalDebuff = set_combine(sets.midcast.Macc,
		{
			head="Arch. Petasos +3", neck="Incanter's Torque",
			body="Arch. Coat +3", hands="Arch. Gloves +3", rring={name="Stikini Ring +1", bag="wardrobe3"},
			feet="Arch. Sabots +3"
		})

	
	---Dark Magic
		sets.midcast['Dark Magic'] = set_combine(sets.midcast.Macc,
		{
			main="Rubicundity", sub="Ammurapi Shield",
			neck="Erra Pendant", rear="Mani Earring",
			body="Shango Robe", rring={name="Stikini Ring +1", bag="wardrobe3"},
			feet="Wicce Sabots +1"
		})

		sets.midcast.Sap = set_combine(sets.midcast['Dark Magic'],
		{
			head="Pixie Hairpin +1", lear="Hirudinea Earring",
			hands="Arch. Gloves +3", lring="Archon Ring", rring="Evanescence Ring", 
			legs="Spae. Tonban +3", waist="Fucho-no-Obi", feet=gear.SapCrackows
		})

		sets.midcast.Sap.Resistant = set_combine(sets.midcast.Sap,
		{
			head="Spae. Petasos +3",
			body="Spaekona's Coat +2"
		})

		sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'],
		{
			head="Amalric Coif +1", ammo="Sapience Orb",
			neck="Orunmila's Torque",
			body="Shango Robe", lring="Kishar Ring", rring="Weather. Ring +1",
			back=gear.BLMCape_FC, waist="Witful Belt", legs="Volte Brais", feet="Volte Gaiters"
		})
	
		sets.midcast.Stun.Resistant = sets.midcast.Macc

	-- Elemental Magic
		sets.midcast['Elemental Magic'] =
		{
			main="Lathi", sub="Enki Strap", ammo="Pemphredo Tathlum",
			head="Arch. Petasos +3", neck="Src. Stole +2", lear="Malignance Earring", rear="Regal Earring",
			body="Amalric Doublet +1", hands="Amalric Gages +1", lring="Freke Ring", rring="Metamor. Ring +1",
			back=gear.BLMCape_Nuke, waist="Sacro Cord", legs="Arch. Tonban +3", feet="Arch. Sabots +3"
		}
		
		sets.midcast['Elemental Magic'].Potency =
		{
			main="Lathi", sub="Enki Strap", ammo="Pemphredo Tathlum",
			head="Arch. Petasos +3", neck="Saevus Pendant +1", lear="Malignance Earring", rear="Regal Earring",
			body="Amalric Doublet +1", hands="Amalric Gages +1", lring="Freke Ring", rring="Metamor. Ring +1",
			back=gear.BLMCape_Nuke, waist="Sacro Cord", legs="Amalric Slops +1", feet="Amalric Nails +1"
		}

		sets.midcast['Elemental Magic'].Resistant =
		{
			main="Raetic Staff +1", sub="Enki Strap", ammo="Pemphredo Tathlum",
			head="Arch. Petasos +3", neck="Src. Stole +2", lear="Malignance Earring", rear="Regal Earring",
			body="Arch. Coat +3", hands="Arch. Gloves +3", lring="Freke Ring", rring="Metamor. Ring +1",
			back=gear.BLMCape_Nuke, waist="Sacro Cord", legs="Spae. Tonban +3", feet="Arch. Sabots +3"
		}

		sets.midcast.MDMG = set_combine(sets.midcast['Elemental Magic'],
		{
			main="Raetic Staff +1", sub="Niobid Strap",
			head="Spae. Petasos +3",
		})
		
		sets.midcast.MDMG = set_combine(sets.midcast['Elemental Magic'].Potency,
		{
			main="Raetic Staff +1", sub="Niobid Strap",
			head="Spae. Petasos +3", neck="Saevus Pendant +1", rear="Friomisi Earring",
			rring="Shiva Ring +1"
		})
		
		sets.midcast.Brightness = sets.midcast.MDMG
		
		sets.midcast.MDMG.Resistant = sets.midcast['Elemental Magic'].Resistant
		
		--		Death Formula:	(MP×3 + Magic Damage)×(MAB/MDB)×(Affinity)×(Day/Weather)
		sets.midcast.Death =
		{
			main="Lathi", sub="Khonsu", ammo="Hasty Pinion +1",
			head="Pixie Hairpin +1", neck="Orunmila's Torque", lear="Malignance Earring", rear="Barkaro. Earring",
			body=gear.FCJubbah, hands="Amalric Gages +1", lring="Archon Ring", rring="Weather. Ring +1",
			back=gear.BLMCape_FC, waist="Witful Belt", legs="Volte Brais", feet="Amalric Nails +1"
		}
		
		sets.midcast.Death.Potency =
		{
			main="Lathi", sub="Niobid Strap", ammo="Psilomene",
			head="Pixie Hairpin +1", neck="Saevus Pendant +1", lear="Malignance Earring", rear="Barkaro. Earring",
			body="Amalric Doublet +1", hands="Amalric Gages +1", lring="Archon Ring", rring="Mephitas's Ring +1",
			back=gear.BLMCape_FC, waist="Sacro Cord", legs="Amalric Slops +1", feet="Amalric Nails +1"
		}

		sets.midcast.Death.Resistant = 
		{
			main="Lathi", sub="Khonsu", ammo="Hasty Pinion +1",
			head="Arch. Petasos +3", 
		}
	
		sets.magic_burst =
		{--MBD/II: 44/40
			main="Lathi", sub="Enki Strap", ammo="Pemphredo Tathlum",
			head="Ea Hat +1", neck="Src. Stole +2", lear="Malignance Earring", rear="Regal Earring",
			body="Ea Houppe. +1", hands="Amalric Gages +1", lring="Freke Ring", rring="Mujin Band",
			back=gear.BLMCape_Nuke, waist="Sacro Cord", legs="Ea Slops +1", feet="Amalric Nails +1"
		}

		sets.magic_burst.Resistant =
		{--MBD/II: 44/37
			main="Lathi", sub="Khonsu", ammo="Pemphredo Tathlum",
			head="Ea Hat +1", neck="Src. Stole +2", lear="Malignance Earring", rear="Regal Earring",
			body="Ea Houppe. +1", hands="Spae. Gloves +3", lring="Freke Ring", rring="Metamor. Ring +1",
			back=gear.BLMCape_Nuke, waist="Sacro Cord", legs="Ea Slops +1", feet="Ea Pigaches +1"
		}
	
	
	--------------------------------------
	-- Miscellaneous Midcast sets
	--------------------------------------  
	
		sets.midcast.Teleport = sets.midcast.ConserveMP
		
		sets.midcast.Utsusemi = sets.midcast.FC
	
	
	
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
		{--Regen+4 | Refresh+9 | PDT/MDT: (15/15)
			main="Lathi", sub="Khonsu", ammo="Staunch Tathlum +1",
			head="Befouled Crown", neck="Sanctity Necklace", lear="Dawn Earring", rear="Infused Earring",
			body="Amalric Doublet +1", hands="Volte Bracers", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back="Moonlight Cape", waist="Carrier's Sash", legs="Volte Brais", feet="Volte Gaiters"
		}

		sets.idle.DT = set_combine(sets.idle,
		{--Regen+1 | Refresh+6 | PDT/MDT: (40/30)
			neck="Loricate Torque +1",  lear="Genmei Earring", rrear="Lugalbanda Earring",
			lring="Defending Ring", rring="Gelatinous Ring +1"
		})

		sets.idle.DeathMode =
		{--Regen+1 | Refresh+4~5 | PDT/MDT: (5/8)
			main="Lathi", sub="Khonsu", ammo="Psilomene",
			head="Befouled Crown", neck="Sanctity Necklace", lear="Etiolation Earring", rear="Loquac. Earring",
			body="Amalric Doublet +1", hands="Regal Cuffs", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back=gear.BLMCape_FC, waist="Fucho-no-Obi", legs="Volte Brais", feet="Amalric Nails +1"
		}

		sets.idle.Weak = sets.idle.DT	
	
		sets.idle.Town = set_combine(sets.idle, 
		{
			feet="Crier's Gaiters"
		})

		sets.idle.Adoulin = set_combine(sets.idle,
		{
			body="Councilor's Garb"
		})
		
	
	
	------------------------------------------------------------------------------------------------
	--------------------------------------- Defense Sets -------------------------------------------
	------------------------------------------------------------------------------------------------
	
	
	--------------------------------------
	-- Defensive Sets
	--------------------------------------
	
		sets.defense.PDT =
		{--PDT: 51 / MDT: 42
			sub="Khonsu", ammo="Staunch Tathlum +1",
			head="Ea Hat +1", neck="Loricate Torque +1",  lear="Genmei Earring", rear="Lugalbanda Earring",
			body="Mallquis Saio +2", hands="Volte Bracers", lring="Defending Ring", rring="Gelatinous Ring +1",
			back="Moonlight Cape", waist="Carrier's Sash", legs="Artsieq Hose", feet="Hippo. Socks +1"
		}

		sets.defense.MDT = 
		{--MDT: 46 / PDT: 31
			main="Lathi", sub="Khonsu", ammo="Staunch Tathlum +1",
			head="Vanya Hood", neck="Loricate Torque +1", lear="Etiolation Earring", rear="Odnowa Earring +1",
			body="Mallquis Saio +2", hands="Raetic Bangles +1", lring="Defending Ring", rring="Shadow Ring",
			back="Moonlight Cape", waist="Carrier's Sash", legs="Vanya Slops", feet="Volte Gaiters"
		}
		
		sets.defense.EVA =
		{--MDT: 46 / PDT: 31
			main="Lathi", sub="Khonsu", ammo="Staunch Tathlum +1",
			head="Ea Hat +1", neck="Warder's Charm +1", lear="Eabani Earring", rear="Lugalbanda Earring",
			body="Ea Houppe. +1", hands="Raetic Bangles +1", lring="Defending Ring", rring="Purity Ring",
			back="Moonlight Cape", waist="Carrier's Sash", legs="Ea Slops +1", feet="Volte Gaiters"
		}

	--------------------------------------
	-- Special Sets
	--------------------------------------

		sets.Kiting = { feet="Crier's Gaiters" }
		
		sets.Occult =
		{
			ammo="Seraphic Ampulla",
			head="Mall. Chapeau +2", neck="Combatant's Torque", lear="Telos Earring", rear="Dedition Earring",
			body=gear.FCJubbah, hands=gear.FCHands, lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"},
			back=gear.BLMCape_FC, waist="Oneiros Rope", legs="Perdition Slops", feet=gear.FCCrackows
		}
		

		sets.buff['Mana Wall'] =
		{
			back=gear.BLMCape_Nuke, feet="Wicce Sabots +1"
		}

		sets.buff.Doom = 
		{
			neck="Nicander's Necklace",
			lring={name="Eshmun's Ring", bag="wardrobe2"}, rring={name="Eshmun's Ring", bag="wardrobe3"},
			waist="Gishdubar Sash"
		}
		
		sets.TreasureHunter =
		{
			hands="Volte Bracers",
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
	-- Weaponskill Sets
	-------------------------
	
		sets.precast.WS =
		{
			ammo="Hasty Pinion +1",
			head="Jhakri Coronal +2", neck="Fotia Gorget", lear="Telos Earring", rear="Moonshade Earring",
			body="Jhakri Robe +2", hands="Jhakri Cuffs +2", lring="Shukuyu Ring", rring="Epaminondas's Ring",
			back=gear.BLMCape_Nuke, legs="Jhakri Slops +2", feet="Jhakri Pigaches +2"
		}
		
		sets.precast.WS['Rock Crusher'] = 
		{
			ammo="Pemphredo Tathlum",
			head="Arch. Petasos +3", neck="Src. Stole +2", lear="Malignance Earring", rear="Regal Earring",
			body="Amalric Doublet +1", hands="Amalric Gages +1", lring="Freke Ring", rring="Epaminondas's Ring",
			back=gear.BLMCape_Nuke, waist="Orpheus's Sash", legs="Amalric Slops +1", feet="Amalric Nails +1"
		}
		
		sets.precast.WS['Earth Crusher'] = sets.precast.WS['Rock Crusher']
		
		sets.precast.WS['Starburst'] = set_combine(sets.precast.WS['Rock Crusher'],
		{
			lring="Weather. Ring +1"
		})
		
		sets.precast.WS['Sunburst'] = sets.precast.WS['Starburst']
		
		sets.precast.WS['Vidohunir'] = set_combine(sets.precast.WS['Rock Crusher'],
		{
			head="Pixie Hairpin +1",
			lring="Archon Ring"
		})
		
		sets.precast.WS['Cataclysm'] = sets.precast.WS['Vidohunir']

		sets.precast.WS['Myrkr'] =
		{
			ammo="Psilomene",
			head="Amalric Coif +1", neck="Sanctity Necklace", lear="Etiolation Earring", rear="Moonshade Earring",
			body="Amalric Doublet +1", hands="Spae. Gloves +3", lring="Mephitas's Ring +1", rring="Metamor. Ring +1",
			back=gear.BLMCape_FC, waist="Luminary Sash", legs="Amalric Slops +1", feet="Amalric Nails +1"
		}
	
	--------------------------------------
	-- Melee sets
	--------------------------------------
	
		sets.engaged =
		{
			main="Lathi", sub="Khonsu", ammo="Hasty Pinion +1",
			head="Arch. Petasos +3", neck="Combatant's Torque", lear="Telos Earring", rear={name="Mache Earring +1", bag="wardrobe3"},
			body="Arch. Coat +3", hands="Arch. Gloves +3", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"},
			back=gear.BLMCape_Nuke, waist="Witful Belt", legs="Arch. Tonban +3", feet="Arch. Sabots +3"
		}
	
		sets.engaged.Refresh =
		{
			main="Lathi", sub="Khonsu", ammo="Staunch Tathlum +1",
			head="Befouled Crown", neck="Sanctity Necklace", lear="Dawn Earring", rear="Infused Earring",
			body="Amalric Doublet +1", hands="Volte Bracers", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back="Moonlight Cape", waist="Carrier's Sash", legs="Volte Brais", feet="Volte Gaiters"
		}

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
function job_post_precast(spell, action, spellMap, eventArgs)
	
	
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
	
	if spell.english == 'Impact' then
		equip
		{
			head=empty,
			body="Twilight Cloak" 
		}
	end
	
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_post_midcast(spell, action, spellMap, eventArgs)
	if spellMap == 'Cures' or spellMap == 'Curagas' then
		if state.WeaponLock.value == true then
			equip(sets.midcast.CuresLocked)
		else
			if spell.element == world.day_element or spell.element == world.weather_element then
				equip(sets.midcast.CuresWeather)
			end
		end
	
		if spell.target.type =='SELF' then 
			equip 
			{ 
				hands=gear.ENH_Gloves,
				waist="Gishdubar Sash"
			}
		end
	end
	
	if spellMap == 'Refresh' and spell.target.type == 'SELF' then
		equip
		{
			back="Grapevine Cape", waist="Gishdubar Sash", feet="Inspirited Boots"
		}
	end

	if (spell.skill == 'Elemental Magic' or spellMap == 'Darkness' or spellMap == 'Brightness') and spellMap ~= 'ElementalDebuff' then
		
		if state.MagicBurst.value then
			if state.CastingMode.value == 'Resistant' then
				equip(sets.magic_burst.Resistant)
			else
				equip(sets.magic_burst)
			end
		else
			if state.CastingMode.value == 'Occult' and (spell.skill == 'Elemental Magic' or spell.english == 'Death')  then
				equip(sets.Occult)
			end
		end	
		
		if state.SaveMP.value and spell.skill == 'Elemental Magic' and (spell.english ~= 'Impact' and spell.english ~= 'Death') then
			if not (buffactive['Manawell'] or buffactive['Manafont']) then
				equip
				{
					body="Spaekona's Coat +2"
				}
				if state.MagicBurst.value then
					equip
					{
						hands="Ea Cuffs +1",
						feet="Ea Pigaches +1"
					}
				end
			end
		end
		
		if spellMap == 'Darkness' then
			equip { rring="Archon Ring" }
			
			if state.CastingMode.value == 'Normal' or state.CastingMode == 'Potency' then
				equip { head="Pixie Hairpin +1" }
			end
				
			if state.MagicBurst.value then
				equip 
				{
					hands="Arch. Gloves +3", lring="Mujin Band",
					feet="Arch. Sabots +3"
				}
			end
		elseif spellMap == 'Brightness' then
			equip
			{
				main="Daybreak", sub="Ammurapi Shield",
				rring="Weather. Ring +1"
			}
			
			if state.MagicBurst.value then
				equip { lring="Mujin Band" }
			end
		end
		
		if spell.english == 'Impact' then
			equip
			{
				head=empty,
				body="Twilight Cloak", hands="Arch. Gloves +3"
			}
		elseif spell.english == 'Death' then
			equip
			{
				back=gear.BLMCape_FC
			}
		end


		if (spell.element ~= world.day_element and spell.element ~= world.weather_element) then
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
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------



-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
	if state.Buff['Mana Wall'] and state.DefenseMode.value == 'None' then
		if state.IdleMode.value == 'Normal' then
			idleSet = set_combine(sets.idle, sets.buff['Mana Wall'])
		elseif state.IdleMode.value == 'DT' then
			idleSet = set_combine(sets.idle.DT, sets.buff['Mana Wall'])
		end
	end
	
	if player.mpp < 51 then
        	idleSet = set_combine(idleSet,
		{
			body="Jhakri Robe +2",
			waist="Fucho-no-Obi",
		})
    end

	return idleSet
end

function customize_defense_set(defenseSet)
    if buffactive['Mana Wall'] then
        defenseSet = set_combine(defenseSet, sets.buff['Mana Wall'])
    end
	
    return defenseSet
end

function job_update(cmdParams, eventArgs)
	update_wall()

	if gain then
		equip(sets.buff.Doom)
		disable('neck','lring','rring','waist')
	else
		enable('neck','lring','rring','waist')
		handle_equipping_gear(player.status)
	end
end

-- Function to display the current relevant user state when doing an update.
function display_current_job_state(eventArgs)
	display_current_caster_state()
	eventArgs.handled = true
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
function update_wall()
	state.Buff['Mana Wall'] = buffactive['Mana Wall'] or false
end

-- Select default macro book on initial load or subjob change.
function apply_job_change()
	set_macro_page(1, 4)
	
	send_command('wait 3; input /lockstyleset 4')
end