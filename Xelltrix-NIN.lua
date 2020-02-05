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
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'DT')

    gear.MovementFeet = {name="Danzo Sune-ate"}
    gear.DayFeet = "Danzo Sune-ate"
    gear.NightFeet = "Hachiya Kyahan"

    select_movement_feet()
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
    sets.precast.JA['Futae'] = { feet="Hattori Tekko +1" }

    -- Waltz set (chr and vit)
	sets.precast.Waltz =
	{
		body="Passion Jacket",
		feet="Rawhide Boots"
	}

	
	-------------------
	-- Precast Magic --
	------------------- 
	sets.precast.FC =
	{
		ammo="Sapience Orb",
		head=gear.HHead_MAB, neck="Orunmila's Torque", lear="Etiolation Earring", rear="Loquac. Earring",
		body=gear.TBody_Phalanx, hands="Leyline Gloves", lring="Kishar Ring", rring="Weather. Ring +1",
		back="Moonlight Cape", waist="Witful Belt", legs="Rawhide Trousers", feet=gear.TFeet_Phalanx
	}

	sets.precast.Utsusemi = set_combine(sets.precast.FC,
	{
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
    -- Midcast sets
    --------------------------------------

	sets.midcast.FC = sets.precast.FC

    sets.midcast.ElementalNinjutsu =
	{
		ammo="Pemphredo Tathlum",
		head=gear.HHead_MAB, neck="Sanctity Necklace", lear="Friomisi Earring", rear="Crematio Earring",
		body="Gyve Doublet", hands="Hattori Tekko +1", lring="Dingir Ring", rring={name="Shiva Ring +1", bag="wardrobe3"},
		back="Andartia's Mantle", waist="Orpheus's Sash", legs="Gyve Trousers", feet="Herculean Boots"
	}

    sets.midcast.NinjutsuDebuff =
	{
        ammo="Pemphredo Tathlum",
		head=gear.HHead_MAB, neck="Sanctity Necklace", lear="Digni. Earring", rear="Gwati Earring",
        body="Samnuha Coat", hands="Leyline Gloves", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
        back="Andartia's Mantle", waist="Orpheus's Sash", legs="Gyve Trousers", feet="Herculean Boots"
	}

    sets.midcast.NinjutsuBuff =
	{
		ammo="Sapience Orb",
		head=gear.HHead_MAB, neck="Orunmila's Torque", lear="Etiolation Earring", rear="Loquac. Earring",
		body="Samnuha Coat", hands="Mochizuki Tekko +1", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
		back="Andartia's Mantle", waist="Flume Belt +1", legs="Rawhide Trousers", feet="Hattori Kyahan +1"
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
		head="Dampening Tam", neck="Sanctity Necklace", lear="Dawn Earring", rear="Infused Earring",
		body="Hiza. Haramaki +1", hands="Floral Gauntlets", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"},
		back="Moonlight Cape", waist="Flume Belt +1", legs="Herculean Trousers", feet="Herculean Boots"
	}

	sets.idle.DT = set_combine (sets.idle,
	{
		head=gear.AHead_PDT, neck="Loricate Torque +1",
		body="Emet Harness +1", lring="Defending Ring", rring="Gelatinous Ring +1",
	})

	sets.idle.Town = set_combine(sets.idle,
	{
		feet="Danzo Sune-Ate"
	})

	sets.idle.Adoulin = set_combine(sets.idle,
	{
		body="Councilor's Garb"
	})
	
	sets.idle.Weak = sets.idle.MDT


	------------------------------------------------------------------------------------------------
	--------------------------------------- Defense Sets -------------------------------------------
	------------------------------------------------------------------------------------------------
	
	sets.defense.PDT = sets.idle.DT

	sets.defense.MDT = set_combine(sets.defense.PDT,
	{
		lear="Etiolation Earring", rear="Odnowa Earring +1",
		waist="Carrier's Sash"
	})
	
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
			ammo="Seeth. Bomblet +1",
			head=gear.AHead_TP, neck="Fotia Gorget", lear="Brutal Earring", rear="Moonshade Earring",
			body="Adhemar Jacket +1", hands="Adhemar Wrist. +1", lring="Gere Ring", rring="Epona's Ring",
			back="Andartia's Mantle", waist="Fotia Belt", legs="Samnuha Tights", feet=gear.HBoots_TP
		}

		sets.precast.WS.Low = set_combine(sets.precast.WS,
		{
			lear="Telos Earring"
		})
		
		sets.precast.WS.Mid = set_combine(sets.precast.WS,
		{
			head="Dampening Tam",
			legs="Adhemar Kecks +1"
		})
		
		sets.precast.WS.High = set_combine(sets.precast.WS,
		{
			lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"}
		})

		sets.precast.WS['Blade: Hi'] = set_combine(sets.precast.WS,
		{
			ammo="Yetshila +1",
			head=gear.HHead_WSD, lear="Ishvara Earring",
			body="Abnoba Kaftan", hands="Herculean Gloves", rring="Begrudging Ring",
			legs="Adhemar Kecks +1", feet=gear.HBoots_WSD
		})

		sets.precast.WS['Blade: Hi'].Low = set_combine(sets.precast.WS['Blade: Hi'],
		{
			lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"}
		})
		
		sets.precast.WS['Blade: Hi'].Mid = set_combine(sets.precast.WS['Blade: Hi'].Low,
		{
			head="Dampening Tam",
			hands="Adhemar Wrist. +1"
		})
		
		sets.precast.WS['Blade: Hi'].High = set_combine(sets.precast.WS['Blade: Hi'].Mid,
		{
			ammo="Seeth. Bomblet +1",
			feet=gear.HBoots_TP
		})

		sets.precast.WS['Blade: Jin'] = set_combine(sets.precast.WS,
		{
			ammo="Yetshila +1",
			lring="Begrudging Ring",
			feet=gear.HBoots_Crit
		})

		sets.precast.WS['Blade: Jin'].Low = set_combine(sets.precast.WS['Blade: Jin'],
		{
			head="Dampening Tam", lear="Telos Earring"
		})
		
		sets.precast.WS['Blade: Jin'].Mid = set_combine(sets.precast.WS['Blade: Jin'].Low,
		{
			feet=gear.HBoots_TP
		})
		
		sets.precast.WS['Blade: Jin'].High = set_combine(sets.precast.WS['Blade: Jin'].Mid,
		{
			lear={name="Mache Earring +1", bag="wardrobe2"}, rear={name="Mache Earring +1", bag="wardrobe3"},
			lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"},
			legs="Adhemar Kecks +1"
		})

		sets.precast.WS['Blade: Kamu'] = set_combine(sets.precast.WS,
		{
			body="Hiza. Haramaki +1",
			lring="Regal Ring", rring="Epaminondas's Ring",
			feet="Hiza. Sune-Ate +1"
		})

		sets.precast.WS['Blade: Kamu'].Acc = set_combine(sets.precast.WS['Blade: Kamu'],
		{
			head="Dampening Tam",
			lring={name="Chirich Ring +1", bag="wardrobe2"},
			legs="Adhemar Kecks +1"
		})

		sets.precast.WS['Blade: Yu'] = set_combine(sets.precast.WS,
		{
			ammo="Pemphredo Tathlum",
			head=gear.HHead_MAB, lear="Friomisi Earring", rear="Crematio Earring",
			body="Gyve Doublet", hands="Leyline Gloves", lring="Dingir Ring", rring={name="Shiva Ring +1", bag="wardrobe3"},
			back="Andartia's Mantle", legs="Gyve Trousers", feet="Herculean Boots"
		})

		sets.precast.WS['Blade: Ei'] = sets.precast.WS['Blade: Yu']

		sets.precast.WS['Blade: Teki'] = sets.precast.WS['Blade: Yu']

		sets.precast.WS['Evisceration'] = sets.precast.WS['Blade: Hi']

		sets.precast.WS['Evisceration'].Acc = sets.precast.WS['Blade: Hi'].Acc

		sets.precast.WS['Gust Slash'] = sets.precast.WS['Blade: Yu']

		sets.precast.WS['Cyclone'] = sets.precast.WS['Blade: Yu']

		sets.precast.WS['Aeolian Edge'] = sets.precast.WS['Blade: Yu']

    --------------------------------------
    -- Engaged sets
    --------------------------------------

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- Normal melee group
    sets.engaged =
	{
		ammo="Happo Shuriken",
		head="Hattori Zukin +1", neck="Combatant's Torque", lear="Eabani Earring", rear="Suppanomimi",
		body="Adhemar Jacket +1", hands="Floral Gauntlets", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring="Epona's Ring",
		back="Andartia's Mantle", waist="Reiki Yotai", legs="Samnuha Tights", feet="Hiza. Sune-Ate +1"
	}

	sets.engaged.LowAcc = set_combine(sets.engaged,
	{
		neck="Combatant's Torque", lear="Telos Earring",
		lring={name="Chirich Ring +1", bag="wardrobe2"}
	})

	sets.engaged.MidAcc = set_combine(sets.engaged.LowAcc,
	{
		rear="Cessance Earring",
		legs="Adhemar Kecks +1"
	})

	sets.engaged.HighAcc = set_combine(sets.engaged.MidAcc,
	{
		head="Dampening Tam", lear={name="Mache Earring +1", bag="wardrobe2"}, rear={name="Mache Earring +1", bag="wardrobe3"},
		rring={name="Chirich Ring +1", bag="wardrobe3"}
	})

	sets.engaged.HighHaste =
	{
		ammo="Happo Shuriken",
		head=gear.AHead_TP, neck="Combatant's Torque", lear="Eabani Earring", rear="Suppanomimi",
		body="Adhemar Jacket +1", hands="Adhemar Wrist. +1", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring="Epona's Ring",
		back="Andartia's Mantle", waist="Reiki Yotai", legs="Samnuha Tights", feet="Herculean Boots"
	}

	sets.engaged.HighHaste.LowAcc = set_combine(sets.engaged.HighHaste,
	{
		head="Dampening Tam", neck="Combatant's Torque",
		lring={name="Chirich Ring +1", bag="wardrobe2"}
	})

	sets.engaged.HighHaste.MidAcc = set_combine(sets.engaged.HighHaste.LowAcc,
	{
		lear="Telos Earring",
		legs="Adhemar Kecks +1"
	})

	sets.engaged.HighHaste.HighAcc = set_combine(sets.engaged.HighHaste.MidAcc,
	{
		lear={name="Mache Earring +1", bag="wardrobe2"}, rear={name="Mache Earring +1", bag="wardrobe3"},
		hands="Floral Gauntlets",
	})

	sets.engaged.MaxHaste =
	{
		ammo="Happo Shuriken",
		head=gear.AHead_TP, neck="Combatant's Torque", lear="Telos Earring", rear="Cessance Earring",
		body="Herculean Vest", hands="Adhemar Wrist. +1", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring="Epona's Ring",
		back="Andartia's Mantle", waist="Windbuffet Belt +1", legs="Samnuha Tights", feet="Herculean Boots"
	}

	sets.engaged.MaxHaste.LowAcc = set_combine(sets.engaged.MaxHaste,
	{
		head="Dampening Tam", neck="Combatant's Torque",
		lring={name="Chirich Ring +1", bag="wardrobe2"}
	})

	sets.engaged.MaxHaste.MidAcc = set_combine(sets.engaged.MaxHaste.LowAcc,
	{
		hands="Hizamaru Kote +1", legs="Adhemar Kecks +1"
	})

	sets.engaged.MaxHaste.HighAcc = set_combine(sets.engaged.MaxHaste.MidAcc,
	{
		lear={name="Mache Earring +1", bag="wardrobe2"}, rear={name="Mache Earring +1", bag="wardrobe3"},
		waist="Kentarch Belt +1"
	})

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Run after the general midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.



-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.


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

function job_status_change(new_status, old_status)
    if new_status == 'Idle' then
        select_movement_feet()
    end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Get custom spell maps
function job_get_spell_map(spell, default_spell_map)
    if spell.skill == "Ninjutsu" then
        if not default_spell_map then
            if spell.target.type == 'SELF' then
                return 'NinjutsuBuff'
            else
                return 'NinjutsuDebuff'
            end
        end
    end
end


-- Called by the default 'update' self-command.
function job_update(cmdParams, eventArgs)
    select_movement_feet()
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

function select_movement_feet()
    if world.time >= 17*60 or world.time < 7*60 then
        gear.MovementFeet.name = gear.NightFeet
    else
        gear.MovementFeet.name = gear.DayFeet
    end
end


-- Select default macro book on initial load or subjob change.
function apply_job_change()
    set_macro_page(1, 19)
end