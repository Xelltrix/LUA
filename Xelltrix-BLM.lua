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
	state.CastingMode:options('Normal','Resistant','Occult')
	state.IdleMode:options('Normal','DT','DeathMode')
	state.MagicalDefenseMode:options('EVA', 'MDT')

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
	-- Precast Magic --
	------------------- 
		sets.precast.FC =
		{--Fast Cast 74
			ammo="Sapience Orb",
			head="Amalric Coif +1", neck="Orunmila's Torque", lear="Malignance Earring", rear="Loquac. Earring",
			body="Shango Robe", hands=gear.ENH_Gloves, lring="Kishar Ring", rring="Weather. Ring +1",
			back=gear.BLMCape_FC, waist="Witful Belt", legs="Volte Brais", feet="Amalric Nails +1"
		}

		sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC)

		sets.precast.FC.Stoneskin = sets.precast.FC['Enhancing Magic']


		sets.precast.FC.Impact = set_combine(sets.precast.FC,
		{--Fast Cast 55
			head=empty,
			body="Twilight Cloak",
			waist="Embla Sash"
		})

		sets.precast.FC.Death = set_combine(sets.precast.FC,
		{--Fast Cast 72
			ammo="Sapience Orb",
			hands=gear.ENH_Gloves, rring="Mephitas's Ring +1",
		})

		sets.precast.FC.Cures = set_combine(sets.precast.FC,
		{--Fast Cast 72 / -5% Cure Cast Time
			lear="Mendi. Earring"
		})

		sets.precast.FC.Curaga = sets.precast.FC.Cures
		
		sets.precast.FC.Dispelga = set_combine(sets.precast.FC,
		{
			main="Daybreak", sub="Chanter's Shield"
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
			head="Befouled Crown", neck="Incanter's Torque", lear="Andoaa Earring", rear="Mimir Earring",
			body=gear.ENH_Body, hands=gear.ENH_Gloves, lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back="Fi Follet Cape +1", waist="Olympus Sash", legs=gear.ENH_Legs, feet="Telchine Pigaches"
		}
	
		sets.midcast.ConserveMP = 
		{
			main="Gada", sub="Ammurapi Shield", ammo="Pemphredo Tathlum",
			head="Vanya Hood", neck="Incanter's Torque", lear="Mendi. Earring", rear="Gwati Earring",
			body="Amalric Doublet +1", hands=gear.ENH_Gloves, lring="Kishar Ring", rring="Weather. Ring +1",
			back="Fi Follet Cape +1", waist="Luminary Sash", legs="Lengo Pants", feet="Medium's Sabots"
		}

	--------------------------------------
	-- Healing Midcast sets
	--------------------------------------	
	
		sets.midcast.Cures =
		{--Cure Potency: 49%
			ammo="Esper Stone +1",
			head="Vanya Hood", neck="Incanter's Torque", lear="Beatific Earring", rear="Mendi. Earring",
			body="Vanya Robe", hands=gear.ENH_Gloves, lring="Lebeche Ring", rring="Menelaus's Ring",
			back="Oretan. Cape +1", waist="Bishop's Sash", legs="Vanya Slops", feet="Medium's Sabots"
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
			main="Daybreak", sub="Ammurapi Shield", ammo="Pemphredo Tathlum",
			head="C. Palug Crown", neck="Erra Pendant", lear="Malignance Earring", rear="Barkaro. Earring",
			body="Ea Houppe. +1", hands="Regal Cuffs", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back="Taranus's Cape", waist="Luminary Sash", legs="Ea Slops +1", feet="Ea Pigaches +1"
		}
	
		sets.midcast['Enfeebling Magic'] = set_combine(sets.midcast.Macc,
		{
			neck="Incanter's Torque",
			lring="Kishar Ring"
		})
	
		sets.midcast['Enfeebling Magic'].Resistant = sets.midcast.Macc
		
		sets.midcast.Dispelga = set_combine(sets.midcast['Enfeebling Magic'].Resistant,
		{
			main="Daybreak", sub="Ammurapi Shield"
		})

		sets.midcast.ElementalDebuffs = sets.midcast.Macc

	
	---Dark Magic
		sets.midcast['Dark Magic'] = set_combine(sets.midcast.Macc,
		{
			lear="Mani Earring",
			body="Shango Robe",
			waist="Fucho-no-Obi"
		})

		sets.midcast.Sap = set_combine(sets.midcast['Dark Magic'],
		{
			main="Rubicundity", sub="Ammurapi Shield",
			head="Pixie Hairpin +1", rear="Hirudinea Earring",
			lring="Archon Ring", rring="Evanescence Ring", 
			feet=gear.NukeCrackows
		})

		sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'],
		{
			neck="Orunmila's Torque",
			body="Shango Robe", lring="Kishar Ring",
			back=gear.BLMCape_FC, waist="Witful Belt", legs="Volte Brais", feet="Volte Gaiters"
		})
	
		sets.midcast.Stun.Resistant = sets.midcast.Macc

	-- Elemental Magic
		sets.midcast['Elemental Magic'] =
		{
			main="Lathi", sub="Niobid Strap", ammo="Pemphredo Tathlum",
			head="C. Palug Crown", neck="Sanctity Necklace", lear="Malignance Earring", rear="Regal Earring",
			body="Amalric Doublet +1", hands="Amalric Gages +1", lring="Freke Ring", rring={name="Shiva Ring +1", bag="wardrobe3"},
			back=gear.BLMCape_Nuke, waist="Sacro Cord", legs="Amalric Slops +1", feet="Amalric Nails +1"
		}

		sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'],
		{
			head="Ea Hat +1", rear="Barkaro. Earring",
			body="Ea Houppe. +1", 
			waist="Sacro Cord", legs="Ea Slops +1", feet="Jhakri Pigaches +2"
		})

		sets.midcast['Elemental Magic'].Occult = set_combine(sets.midcast['Elemental Magic'],
		{
			head="Mall. Chapeau +2",
			lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"},
			waist="Oneiros Rope", legs="Perdition Slops"
		})
		
		---Darkness
		sets.midcast.Darkness = set_combine(sets.midcast['Elemental Magic'],
		{
			head="Pixie Hairpin +1",
			rring="Archon Ring"
		})
		
		sets.midcast.Darkness.Resistant = set_combine(sets.midcast['Elemental Magic'].Resistant,
		{
			rring="Archon Ring"
		})

		sets.midcast.Comet = set_combine(sets.midcast['Elemental Magic'],
		{
			head="Pixie Hairpin +1",
			rring="Archon Ring",
		})

		sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'],
		{
			head=empty,
			body="Twilight Cloak", rring="Archon Ring",
		})
		
		sets.midcast.Impact.Occult = set_combine(sets.midcast.Impact,
		{
			lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"},
			waist="Oneiros Rope", legs="Perdition Slops"
		})
		

		sets.midcast.Death =
		{
			main="Lathi", sub="Niobid Strap", ammo="Psilomene",
			head="Pixie Hairpin +1", neck="Sanctity Necklace", lear="Malignance Earring", rear="Barkaro. Earring",
			body="Amalric Doublet +1", hands="Amalric Gages +1", lring="Archon Ring", rring="Mephitas's Ring +1",
			back=gear.BLMCape_Nuke, waist="Sacro Cord", legs="Amalric Slops +1", feet="Amalric Nails +1"
		}

		sets.midcast.Death.Resistant = set_combine(sets.midcast.Death,
		{
			ammo="Pemphredo Tathlum",
			head="Ea Hat +1",
			body="Ea Houppe. +1",
			legs="Ea Slops +1"
		})
		
		---Brightness
		sets.midcast.Brightness = set_combine(sets.midcast['Elemental Magic'],
		{
			rring="Weather. Ring +1"
		})
		
		sets.midcast.Brightness.Resistant = set_combine(sets.midcast['Elemental Magic'].Resistant,
		{
			rring="Weather. Ring +1"
		})
	
		sets.magic_burst =
		{--MBD/II: 44/40
			main="Lathi", sub="Niobid Strap", ammo="Pemphredo Tathlum",
			head="Ea Hat +1", neck="Mizu. Kubikazari", lear="Malignance Earring", rear="Regal Earring",
			body="Ea Houppe. +1", hands="Ea Cuffs +1", lring="Freke Ring", rring="Mujin Band",
			back=gear.BLMCape_Nuke, waist="Sacro Cord", legs="Ea Slops +1", feet="Amalric Nails +1"
		}

		sets.magic_burst.Resistant = set_combine(sets.magic_burst,
		{--MBD/II: 44/34
			hands="Ea Cuffs +1",
			feet="Ea Pigaches +1"
		})
	
	
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
		{--Regen+3 | Refresh+8~9 | PDT/MDT: (13/15)
			main="Lathi", sub="Khonsu", ammo="Staunch Tathlum +1",
			head="Befouled Crown", neck="Sanctity Necklace", lear="Dawn Earring", rear="Infused Earring",
			body="Amalric Doublet +1", hands="Raetic Bangles +1", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back="Moonlight Cape", waist="Carrier's Sash", legs="Volte Brais", feet="Volte Gaiters"
		}

		sets.idle.DT = set_combine(sets.idle,
		{--Regen+0 | Refresh+6~7 | PDT/MDT: (38/40)
			neck="Loricate Torque +1",  lear="Genmei Earring", rrear="Lugalbanda Earring",
			lring="Defending Ring", rring="Gelatinous Ring +1"
		})

		sets.idle.DeathMode =
		{--Regen+1 | Refresh+4~5 | PDT/MDT: (5/8)
			main="Lathi", sub="Khonsu", ammo="Psilomene",
			head="Befouled Crown", neck="Sanctity Necklace", lear="Etiolation Earring", rear="Loquac. Earring",
			body="Amalric Doublet +1", hands="Regal Cuffs", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back="Fi Follet Cape +1", waist="Fucho-no-Obi", legs="Volte Brais", feet="Amalric Nails +1"
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
			body="Mallquis Saio +2", hands="Raetic Bangles +1", lring="Defending Ring", rring="Gelatinous Ring +1",
			back="Moonlight Cape", waist="Carrier's Sash", legs="Artsieq Hose", feet="Hippo. Socks +1"
		}

		sets.defense.MDT = 
		{--MDT: 46 / PDT: 31
			main="Lathi", sub="Khonsu", ammo="Staunch Tathlum +1",
			head="Vanya Hood", neck="Loricate Torque +1", lear="Etiolation Earring", rear="Odnowa Earring +1",
			body="Mallquis Saio +2", hands="Raetic Bangles +1", lring="Defending Ring", rring="Shukuyu Ring",
			back="Moonlight Cape", waist="Carrier's Sash", legs="Vanya Slops", feet="Volte Gaiters"
		}
		
		sets.defense.MEVA =
		{--MDT: 46 / PDT: 31
			main="Lathi", sub="Khonsu", ammo="Staunch Tathlum +1",
			head="Ea Hat +1", neck="Warder's Charm +1", lear="Eabani Earring", rear="Lugalbanda Earring",
			body="Ea Houppe. +1", hands="Raetic Bangles +1", lring="Defending Ring", rring="Shukuyu Ring",
			back="Moonlight Cape", waist="Carrier's Sash", legs="Ea Slops +1", feet="Volte Gaiters"
		}

	--------------------------------------
	-- Special Sets
	--------------------------------------

		sets.Kiting = { feet="Crier's Gaiters" }

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
			head="Jhakri Coronal +2", neck="Fotia Gorget", lear="Telos Earring", rear="Moonshade Earring",
			body="Jhakri Robe +2", hands="Jhakri Cuffs +2", lring="Shukuyu Ring", rring="Epaminondas's Ring",
			back=gear.BLMCape_Nuke, legs="Jhakri Slops +2", feet="Jhakri Pigaches +2"
		}

		sets.precast.WS['Myrkr'] =
		{
			ammo="Psilomene",
			head="Amalric Coif +1", neck="Sanctity Necklace", lear="Etiolation Earring", rear="Moonshade Earring",
			body="Amalric Doublet +1", hands="Regal Cuffs", lring="Lebeche Ring", rring="Mephitas's Ring +1",
			back="Fi Follet Cape +1", waist="Luminary Sash", legs="Amalric Slops +1", feet="Amalric Nails +1"
		}
	
	--------------------------------------
	-- Melee sets
	--------------------------------------
	
		sets.engaged =
		{
			main="Lathi", sub="Khonsu",
			head="Jhakri Coronal +2", neck="Combatant's Torque", lear={name="Mache Earring +1", bag="wardrobe2"}, rear={name="Mache Earring +1", bag="wardrobe3"},
			body="Jhakri Robe +2", hands="Volte Bracers", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"},
			back=gear.BLMCape_Nuke, waist="Witful Belt", legs="Volte Brais", feet="Jhakri Pigaches +2"
		}
	
		sets.engaged.Refresh =
		{
			main="Lathi", sub="Khonsu", ammo="Staunch Tathlum +1",
			head="Befouled Crown", neck="Sanctity Necklace", lear="Dawn Earring", rear="Infused Earring",
			body="Jhakri Robe +2", hands="Amalric Gages +1", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back="Moonlight Cape", waist="Carrier's Sash", legs="Volte Brais", feet="Amalric Nails +1"
		}

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------



-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_post_midcast(spell, action, spellMap, eventArgs)
	if spellMap == 'Cures' or spellMap == 'Curagas' then
		if spell.target.type =='SELF' then 
			equip { waist="Gishdubar Sash"}
		end
	end
	
	if spellMap == 'Refresh' and spell.target.type == 'SELF' then
		equip
		{
			back="Grapevine Cape", waist="Gishdubar Sash", feet="Inspirited Boots"
		}
	end

	if (spell.skill == 'Elemental Magic' or spell.english == 'Death') and state.MagicBurst.value and (state.CastingMode.value ~= 'Resistant') then
		if spell.element ~= 'Dark' and spell.element ~= 'Light' then
			equip(sets.magic_burst)
		elseif spell.english == 'Comet' or spell.english == 'Noctohelix' then
			equip(set_combine(sets.magic_burst,
			{
				head="Pixie Hairpin +1", rear="Static Earring",
				lring="Archon Ring"
			}))
		elseif spell.english =='Impact' then
			equip(set_combine(sets.magic_burst,
			{
				head=empty, rear="Static Earring",
				body="Twilight Cloak", lring="Archon Ring",
				feet="Ea Pigaches +1"
			}))
		elseif spell.english =='Death' then
			equip(set_combine(sets.midcast.Death,
			{
				neck="Mizu. Kubikazari", lear="Static Earring",
				body="Ea Houppe. +1",
				legs="Ea Slops +1", feet="Ea Pigaches +1"
			}))
		elseif spell.english == 'Luminoxhelix' then
			equip(set_combine(sets.magic_burst,
			{
				lring="Mujin Band", rring="Weather. Ring +1",
				feet="Ea Pigaches +1"
			}))
		end
	elseif (spell.skill == 'Elemental Magic' or spell.english == 'Death') and state.MagicBurst.value and state.CastingMode.value == 'Resistant' then
		if spell.element ~= 'Dark' and spell.element ~= 'Light' then
			equip(sets.magic_burst.Resistant)
		elseif spell.english == 'Comet' or spell.english == 'Noctohelix' then
			equip(set_combine(sets.magic_burst.Resistant,
			{
				lring="Archon Ring"
			}))
		elseif spell.english =='Impact' then
			equip(set_combine(sets.magic_burst.Resistant,
			{
				head=empty, rear="Static Earring",
				body="Twilight Cloak",
				feet="Ea Pigaches +1"
			}))
		elseif spell.english =='Death' then
			equip(set_combine(sets.midcast.Death.Resistant,
			{
				neck="Mizu. Kubikazari",
				hands="Regal Cuffs", rring="Mujin Band",
				feet="Ea Pigaches +1"
			}))
		elseif spell.english == 'Luminoxhelix' then
			equip(set_combine(sets.magic_burst.Resistant,
			{
				lring="Mujin Band", rring="Weather. Ring +1",
			}))
		end
	end
	
	if spell.skill == 'Elemental Magic' and state.SaveMP.value and spell.english ~= 'Death' and spell.english ~= 'Impact' then
		equip{body="Spae. Coat +1"}
	end

	if spell.skill == 'Elemental Magic' and (spell.element ~= world.day_element and spell.element ~= world.weather_element) then
		if spell.target.distance < (15 - spell.target.model_size) then
			equip { waist="Orpheus's Sash" }
		end
	elseif spell.skill == 'Elemental Magic' and (spell.element == world.day_element and spell.element == world.weather_element)
			or (spell.element == world.weather_element and get_weather_intensity() == 2 and world.day_element ~= elements.strong_to[spell.element]) then
		if spellMap ~= 'Helix' then
			equip { waist="Hachirin-no-Obi" }
		elseif spell.target.distance < (15 - spell.target.model_size) then
			equip { waist="Orpheus's Sash" }
		end
	elseif spell.skill == 'Elemental Magic' and (spell.element == world.day_element or (spell.element == world.weather_element and get_weather_intensity() == 1)
		or (spell.element == world.weather_element and get_weather_intensity() == 2 and world.day_element == elements.strong_to[spell.element])) then
		if spell.target.distance < (7 - spell.target.model_size) then	
			equip { waist="Orpheus's Sash" }
		elseif spellMap ~= 'Helix' then
			equip { waist="Hachirin-no-Obi" }
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
	if state.Buff['Mana Wall'] then
		if state.IdleMode.value == 'Normal' then
			idleSet = set_combine(sets.idle, sets.buff['Mana Wall'])
		elseif state.IdleMode.value == 'PDT' then
			idleSet = set_combine(sets.idle.PDT, sets.buff['Mana Wall'])
		elseif state.IdleMode.value == 'MDT' then
			idleSet = set_combine(sets.idle.MDT, sets.buff['Mana Wall'])
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