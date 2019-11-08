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
	state.OffenseMode:options('Normal','Refresh')
	state.CastingMode:options('Normal','Resistant','Potency')
	state.IdleMode:options('Normal','DT')
	state.PhysicalDefenseMode:options('Master','Pet')

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

		sets.precast.JA['Bolster'] = { body="Bagua Tunic +3" }

		sets.precast.JA['Full Circle'] =
		{
			head="Azimuth Hood +1",
			hands="Bagua Mitaines +3"
		}
		
		sets.precast.JA['Life Cycle'] = 
		{ 
			body="Geomancy Tunic +2",
			back=gear.GEOCape_Luopan
		}
		
		sets.precast.JA['Radial Arcana'] = { feet="Bagua Sandals +3" }
		
	
	-------------------
	-- Precast Magic --
	------------------- 
		sets.precast.FC =
		{--Fast Cast 82
			main="Sucellus", sub="Chanter's Shield", ammo="Sapience Orb",
			head="Amalric Coif +1", neck="Orunmila's Torque", lear="Loquac. Earring", rear="Malignance Earring",
			body="Shango Robe", hands=gear.ENH_Gloves, lring="Kishar Ring", rring="Weather. Ring +1",
			back="Lifestream Cape", waist="Witful Belt", legs="Geo. Pants +1", feet="Amalric Nails +1"
		}

		sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC,
		{--Fast Cast 75 / -8% Enhancing Magic Cast Time
			waist="Siegel Sash"
		})
		
		sets.precast.FC.Geomancy =
		{--Fast Cast 83
			main="Sucellus", sub="Chanter's Shield", range="Dunna",
			head="Amalric Coif +1", neck="Orunmila's Torque", lear="Loquac. Earring", rear="Malignance Earring",
			body="Shango Robe", hands=gear.ENH_Gloves, lring="Kishar Ring", rring="Weather. Ring +1",
			back="Lifestream Cape", waist="Witful Belt", legs="Geo. Pants +1", feet="Amalric Nails +1"
		}

		sets.precast.FC.Stoneskin = sets.precast.FC['Enhancing Magic']
		
		sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC,
		{
			hands="Bagua Mitaines +3"
		})

		sets.precast.FC.Impact = set_combine(sets.precast.FC['Elemental Magic'],
		{--Fast Cast 64
			head=empty,
			body="Twilight Cloak"
		})

		sets.precast.FC.Cures = sets.precast.FC

		sets.precast.FC.Curaga = sets.precast.FC.Cures
		
		sets.precast.FC.Dispelga = set_combine(sets.precast.FC,
		{
			main="Daybreak"
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
			main="Gada", sub="Ammurapi Shield", ammo="Sapience Orb",
			head="Telchine Cap", neck="Orunmila's Torque", lear="Loquac. Earring", rear="Malignance Earring",
			body=gear.ENH_Body, hands=gear.ENH_Gloves, lring="Kishar Ring", rring="Weather. Ring +1",
			back="Fi Follet Cape +1", waist="Witful Belt", legs=gear.ENH_Legs, feet="Telchine Pigaches"
		}

		sets.midcast['Enhancing Magic'] =
		{
			main="Gada", sub="Ammurapi Shield", ammo="Pemphredo Tathlum",
			head="Befouled Crown", neck="Incanter's Torque", lear="Andoaa Earring", rear="Augment. Earring",
			body=gear.ENH_Body, hands=gear.ENH_Gloves, lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back="Fi Follet Cape +1", waist="Olympus Sash", legs=gear.ENH_Legs, feet="Telchine Pigaches"
		}
	
		sets.midcast.ConserveMP = 
		{
			main="Solstice", sub="Ammurapi Shield", ammo="Pemphredo Tathlum",
			head="Vanya Hood", neck="Incanter's Torque", lear="Gwati Earring", rear="Mendi. Earring",
			body="Amalric Doublet +1", hands=gear.ENH_Gloves, lring="Kishar Ring", rring="Weather. Ring +1",
			back="Fi Follet Cape +1", waist="Luminary Sash", legs="Lengo Pants", feet="Medium's Sabots"
		}

	--------------------------------------
	-- Healing Midcast sets
	--------------------------------------	
	
		--Cure Potency: 50%
		sets.midcast.Cures =
		{
			main="Daybreak", sub="Sors Shield", ammo="Esper Stone +1",
			head="Vanya Hood", neck="Lasaia Pendant", lear="Beatific Earring", rear="Novia Earring",
			body="Vanya Robe", hands="Vanya Cuffs", lring="Lebeche Ring", rring="Kuchekula Ring",
			back="Lifestream Cape", waist="Bishop's Sash", legs="Vanya Slops", feet="Vanya Clogs"
		}

		sets.midcast.Curaga = sets.midcast.Cures

		sets.midcast.StatusRemoval = sets.midcast.FC

		sets.midcast.Cursna = 
		{
			main="Gada", sub="Chanter's Shield", ammo="Sapience Orb",
			head="Vanya Hood", neck="Debilis Medallion", lear="Beatific Earring", rear="Healing Earring",
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

		sets.midcast.Regen = set_combine(sets.midcast.Duration,
		{
			main="Bolelabunga"
		})

		sets.midcast.Aquaveil = set_combine(sets.midcast.Duration,
		{
			main="Vadose Rod",
			head="Amalric Coif +1",
			waist="Emphatikos Rope", legs="Shedir Seraweels"
		})

		sets.midcast.Statless = sets.midcast.Duration

		sets.midcast.Storm = sets.midcast.Duration

		sets.midcast.Klimaform = sets.midcast.FC

		sets.midcast.Protection = sets.midcast.Duration
		
		sets.midcast.Geomancy = 
		{
			main="Idris", sub="Chanter's Shield", range="Dunna", ammo="",
			head="Azimuth Hood +1", neck="Incanter's Torque", lear="Gwati Earring", rear="Mendi. Earring",
			body="Bagua Tunic +3", hands="Geo. Mitaines +2", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back="Lifestream Cape", waist="Luminary Sash", legs="Lengo Pants", feet="Medium's Sabots"
		}
	
	--------------------------------------
	-- Offensive Midcast sets
	--------------------------------------   
	
	
	---Enfeebling
		sets.midcast.Macc =
		{
			main="Daybreak", sub="Ammurapi Shield", ammo="Pemphredo Tathlum",
			head="C. Palug Crown", neck="Bagua Charm +1", lear="Regal Earring", rear="Malignance Earring",
			body="Geomancy Tunic +2", hands="Geo. Mitaines +2", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back=gear.GEOCape_Nuke, waist="Luminary Sash", legs="Ea Slops +1", feet="Ea Pigaches +1"
		}
	
		sets.midcast['Enfeebling Magic'] = set_combine(sets.midcast.Macc,
		{
			head="Befouled Crown", neck="Incanter's Torque",
			lring="Kishar Ring", hands="Regal Cuffs",
			feet="Bagua Sandals +3"
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
			neck="Erra Pendant",
			waist="Fucho-no-Obi", legs="Azimuth Tights +1",
		})

		sets.midcast.Sap = set_combine(sets.midcast['Dark Magic'],
		{
			head="Pixie Hairpin +1", lear="Hirudinea Earring",
			lring="Archon Ring", rring="Evanescence Ring", 
			feet=gear.NukeCrackows
		})
		
		sets.midcast.Sap.Resistant = set_combine(sets.midcast.Sap,
		{
			head="Bagua Galero +3"
		})

		sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'],
		{
			neck="Orunmila's Torque",
			body="Shango Robe",
			back="Lifestream Cape", waist="Witful Belt"
		})
	
		sets.midcast.Stun.Resistant = sets.midcast.Macc

	-- Elemental Magic
		sets.midcast['Elemental Magic'] =
		{
			main="Daybreak", sub="Ammurapi Shield", ammo="Pemphredo Tathlum",
			head="C. Palug Crown", neck="Sanctity Necklace", lear="Regal Earring", rear="Malignance Earring",
			body="Amalric Doublet +1", hands="Amalric Gages +1", lring="Freke Ring", rring={name="Shiva Ring +1", bag="wardrobe3"},
			back=gear.GEOCape_Nuke, waist="Sacro Cord", legs="Amalric Slops +1", feet="Amalric Nails +1"
		}

		sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'],
		{
			head="Ea Hat +1", rear="Barkaro. Earring",
			body="Ea Houppe. +1", 
			waist="Sacro Cord", legs="Ea Slops +1", feet="Jhakri Pigaches +2"
		})

		sets.midcast['Elemental Magic'].Potency = sets.midcast['Elemental Magic']

		sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'],
		{
			head=empty,
			body="Twilight Cloak",
			rring="Archon Ring",
		})
	
		sets.magic_burst =
		{--MBD/II: 42/11
			main="Daybreak", sub="Ammurapi Shield", ammo="Pemphredo Tathlum",
			head="Ea Hat +1", neck="Mizu. Kubikazari", lear="Malignance Earring", rear="Regal Earring",
			body="Ea Houppe. +1", hands="Amalric Gages +1", lring="Freke Ring", rring="Mujin Band",
			back=gear.GEOCape_Nuke, waist="Sacro Cord", legs="Ea Slops +1", feet="Ea Pigaches +1"
		}

		sets.magic_burst.Resistant = set_combine(sets.magic_burst,
		{--MBD/II: 42/11
			hands="Regal Cuffs"
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
		{--Regen+3 | Refresh+9 | PDT/MDT: (21/9)
			main="Daybreak", sub="Genmei Shield", ammo="Staunch Tathlum +1",
			head="Befouled Crown", neck="Sanctity Necklace", lear="Dawn Earring", rear="Infused Earring",
			body="Amalric Doublet +1", hands="Bagua Mitaines +3", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back="Moonlight Cape", waist="Carrier's Sash", legs="Volte Brais", feet="Geo. Sandals +1"
		}

		sets.idle.DT = set_combine(sets.idle,
		{--Refresh+7 | PDT/MDT: (46/14)
			neck="Loricate Torque +1", lear="Genmei Earring", rear="Lugalbanda Earring",
			lring="Defending Ring", rring="Gelatinous Ring +1"
		})
		
		sets.idle.Luopan =
		{--Refresh+6 | PDT/MDT: (15/3)	[Luopan: Regen+24 | DT: -40% | Abs. Dmg. Tkn. +8%]
			main="Idris", sub="Genmei Shield", ammo="Staunch Tathlum +1",
			head="Azimuth Hood +1", neck="Bagua Charm +1", lear="Sanare Earring", rear="Lugalbanda Earring",
			body="Amalric Doublet +1", hands="Geo. Mitaines +2", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back=gear.GEOCape_Luopan, waist="Isa Belt", legs="Volte Brais", feet="Bagua Sandals +3"
		}	

		sets.idle.DT.Luopan =
		{--Refresh+2 | PDT/MDT: (15/3)	[Luopan: Regen+30 | DT: -48% | Abs. Dmg. Tkn. +8%]
			main="Idris", sub="Genmei Shield", ammo="Staunch Tathlum +1",
			head="Azimuth Hood +1", neck="Bagua Charm +1", lear="Sanare Earring", rear="Lugalbanda Earring",
			body=gear.Pet_Body, hands="Geo. Mitaines +2", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back=gear.GEOCape_Luopan, waist="Isa Belt", legs=gear.Pet_Legs, feet="Bagua Sandals +3"
		}

		sets.idle.Weak = sets.idle.DT	
	
		sets.idle.Town = set_combine(sets.idle, 
		{
			feet="Geo. Sandals +1"
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
	
		sets.defense.Master =
		{--PDT: 51 / MDT: 42
			main="Daybreak", sub="Genmei Shield", ammo="Staunch Tathlum +1",
			head="Ea Hat +1", neck="Loricate Torque +1",  lear="Genmei Earring", rear="Lugalbanda Earring",
			body="Bagua Tunic +3", hands="Volte Bracers", lring="Defending Ring", rring="Gelatinous Ring +1",
			back=gear.GEOCape_Nuke, waist="Carrier's Sash", legs="Volte Brais", feet="Azimuth Gaiters +1"
		}
		
		sets.defense.Pet =
		{--PDT: 51 / MDT: 42
			main="Idris", sub="Genmei Shield", ammo="Staunch Tathlum +1",
			head="Azimuth Hood +1", neck="Bagua Charm +1",  lear="Genmei Earring", rear="Lugalbanda Earring",
			body="Mallquis Saio +2", hands="Geo. Mitaines +2", lring="Defending Ring", rring="Gelatinous Ring +1",
			back=gear.GEOCape_Luopan, waist="Isa Belt", legs="Artsieq Hose", feet="Bagua Sandals +3"
		}

		sets.defense.MDT = 
		{--MDT: 46 / PDT: 31
			ammo="Staunch Tathlum +1",
			head="Ea Hat +1", neck="Warder's Charm +1", lear="Sanare Earring", rear="Lugalbanda Earring",
			body="Mallquis Saio +2", hands="Volte Bracers", lring="Defending Ring", rring="Shukuyu Ring",
			back=gear.GEOCape_Luopan, waist="Carrier's Sash", legs="Volte Brais", feet="Bagua Sandals +3"
		}

	--------------------------------------
	-- Special Sets
	--------------------------------------

		sets.Kiting = { feet="Geo. Sandals +1" }

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
			ammo="Floestone",
			head="Jhakri Coronal +2", neck="Fotia Gorget", lear="Telos Earring", rear="Moonshade Earring",
			body="Jhakri Robe +2", hands="Jhakri Cuffs +2", lring="Shukuyu Ring", rring="Epaminondas's Ring",
			back="Lifestream Cape", legs="Jhakri Slops +2", feet="Jhakri Pigaches +2"
		}

	
	--------------------------------------
	-- Melee sets
	--------------------------------------
	
		sets.engaged =
		{
			main="Idris", sub="Genmei Shield", ammo="Floestone",
			head="Bagua Galero +3", neck="Bagua Charm +1", lear={name="Mache Earring +1", bag="wardrobe2"},  rear={name="Mache Earring +1", bag="wardrobe3"},
			body="Bagua Tunic +3", hands="Bagua Mitaines +3", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"},
			back=gear.GEOCape_Luopan, waist="Witful Belt",  legs=gear.Pet_Legs, feet="Bagua Sandals +3"
		}
		
		sets.engaged.Refresh =
		{
			main="Idris", sub="Genmei Shield", ammo="Staunch Tathlum +1",
			head="Bagua Galero +3", neck="Bagua Charm +1", lear="Dawn Earring", rear="Infused Earring",
			body="Geomancy Tunic +2", hands="Geo. Mitaines +2", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back=gear.GEOCape_Luopan, waist="Isa Belt", legs="Volte Brais", feet="Bagua Sandals +3"
		}

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------



-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_post_midcast(spell, action, spellMap, eventArgs)
	if spellMap == 'Cures' and spell.target.type == 'SELF' then
        	equip { waist="Gishdubar Sash" }
	end
	
	if spellMap == 'Refresh' and spell.target.type == 'SELF' then
		equip
		{
			back="Grapevine Cape", waist="Gishdubar Sash", feet="Inspirited Boots"
		}
	end
	
	if spell.english:startswith('Indi') then
		if spell.target.type == 'SELF' then
			equip(
			{
				body="Amalric Doublet +1",
				legs="Bagua Pants +1", feet="Azimuth Gaiters +1"
			})
		elseif spell.target.type == 'PLAYER' or spell.target.type == 'NPC' then
			equip(
			{
				main="Solstice",
				body="Amalric Doublet +1",
				legs="Bagua Pants +1", feet="Azimuth Gaiters +1"
			})
		end
	end
	
	if spell.english:startswith('Geo') then
		if buffactive['Blaze of Glory'] then
			equip(
			{
				neck="Bagua Charm +1"
			})
		else
			equip(
			{
				neck="Bagua Charm +1"
			})
		end
	end

	if (spell.skill == 'Elemental Magic') and state.MagicBurst.value and (state.CastingMode.value == 'Normal' or state.CastingMode.value == 'Potency') then
		if spell.element ~= 'Dark' then
			equip(sets.magic_burst)
		elseif spell.english =='Impact' then
			equip(set_combine(sets.magic_burst,
			{
				head=empty,
				body="Twilight Cloak", lring="Archon Ring"
			}))
		end
	elseif (spell.skill == 'Elemental Magic') and state.MagicBurst.value and state.CastingMode.value == 'Resistant' then
		if spell.element ~= 'Dark' then
			equip(sets.magic_burst.Resistant)
		elseif spell.english =='Impact' then
			equip(set_combine(sets.magic_burst.Resistant,
			{
				head=empty,
				body="Twilight Cloak", lring="Archon Ring"
			}))
		end
	end
	
	if spell.skill == 'Elemental Magic' and state.SaveMP.value and spell.english ~= 'Impact' then
		equip{body="Seidr Cotehardie"}
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

function job_buff_change(buff, gain)
    if state.Buff[buff] ~= nil then
        handle_equipping_gear(player.status)
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
end


function job_pet_status_change(newStatus, oldStatus, eventArgs)
    if pet.isvalid and not midaction() and not pet_midaction() and (newStatus == 'Engaged' or oldStatus == 'Engaged') then
        handle_equipping_gear(player.status, newStatus)
    end
end


function job_pet_change(petparam, gain)
    classes.CustomIdleGroups:clear()
    if gain then
		if pet.name == 'Luopan' then
			classes.CustomIdleGroups:append('Luopan')
		end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
	
	if player.mpp < 51 and state.IdleMode.value ~= 'DT' and state.DefenseMode.value == 'None' then
        idleSet = set_combine(idleSet,
		{
			body="Jhakri Robe +2",
			waist="Fucho-no-Obi",
		})
    end

	return idleSet
end

-- Function to display the current relevant user state when doing an update.
function display_current_job_state(eventArgs)
	display_current_caster_state()
	eventArgs.handled = true
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function apply_job_change()
	set_macro_page(1, 6)
	
	send_command('wait 3; input /lockstyleset 15')
end