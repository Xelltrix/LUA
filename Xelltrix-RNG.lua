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
	state.Buff.Barrage = buffactive.Barrage or false
	state.Buff.Camouflage = buffactive.Camouflage or false
	state.Buff['Unlimited Shot'] = buffactive['Unlimited Shot'] or false
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	state.OffenseMode:options('Normal', 'Low', 'Mid', 'High')
	state.RangedMode:options('Normal', 'Acc')
	state.WeaponskillMode:options('Normal', 'Low', 'Mid', 'High')

	apply_job_change()
end

-- Set up all gear sets.
function init_gear_sets()
	--------------------------------------
	-- Precast sets
	--------------------------------------

	-- Precast sets to enhance JAs
	sets.precast.JA['Bounty Shot'] = { hands="Amini Glove. +1" }
	
	sets.precast.JA['Shadowbind'] = { hands="Orion Bracers +1" }


	-- Fast cast sets for spells

		sets.precast.FC =
		{
			head="Carmine Mask +1", neck="Orunmila's Torque", lear="Etiolation Earring", rear="Loquac. Earring",
			body=gear.TBody_Phalanx, hands="Leyline Gloves", lring="Kishar Ring", rring="Weather. Ring +1",
			back="Moonlight Cape", waist="Flume Belt +1", legs="Carmine Cuisses +1", feet="Carmine Greaves +1"
		}
		
		sets.precast.FC.Utsusemi = set_combine(sets.precast.FC,
		{
			neck="Magoraga Beads",
			body="Passion Jacket"
		})

	-- Ranged sets (snapshot)

	sets.precast.RA =
	{
		head="Amini Gapette +1",
		body="Amini Caban +1", hands="Carmine Fin. Ga. +1",
		back="Belenus's Cape", waist="Impulse Belt", legs="Adhemar Kecks +1", feet="Adhemar Gamashes +1"
	}


	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS =
	{
		head="Lilitu Headpiece", neck="Fotia Gorget", lear="Neritic Earring", rear="Moonshade Earring",
		body="Herculean Vest", hands="Meg. Gloves +2", lring="Regal Ring", rring="Epaminondas's Ring",
		back="Belenus's Cape", waist="Fotia Belt", legs="Herculean Trousers", gear.HBoots_WSD
	}
	
	sets.precast.WS["Mistral Axe"] =
	{
		head="Lilitu Headpiece", neck="Fotia Gorget", lear="Neritic Earring", rear="Moonshade Earring",
		body="Meghanada Cuirie +1", hands="Meg. Gloves +2", lring="Regal Ring", rring="Ilabrat Ring",
		back="Belenus's Cape", waist="Fotia Belt", legs="Herculean Trousers", feet="Meg. Jam. +1"
	}

	sets.precast.WS["Jishnu's Radiance"] = set_combine(sets.precast.WS,
	{
		head=gear.AHead_TP, lear="Sherida Earring",
		body="Abnoba Kaftan", lring="Begrudging Ring", rring="Ilabrat Ring",
		legs="Herculean Trousers", feet="Thereoid Greaves"
	})

	sets.precast.WS['Apex Arrow'] = sets.precast.WS

	sets.precast.WS['Refulgent Arrow'] = set_combine(sets.precast.WS,
	{
		body="Amini Caban +1", lring="Regal Ring", rring="Ilabrat Ring",
		legs="Samnuha Tights"
	})
	
	sets.precast.WS['Last Stand'] = sets.precast.WS

	sets.precast.WS['Trueflight'] = set_combine(sets.precast.WS,
	{
		head=gear.HHead_MAB, neck="Sanctity Necklace", lear="Friomisi Earring", rear="Crematio Earring",
		body="Carm. Sc. Mail +1", hands="Carmine Fin. Ga. +1", lring="Dingir Ring", rring={name="Shiva Ring +1", bag="wardrobe3"},
		back="Belenus's Cape", waist="Orpheus's Sash", legs="Gyve Trousers", feet="Adhemar Gamashes +1"
	})


	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.


	--------------------------------------
	-- Midcast sets
	--------------------------------------

	sets.midcast.FC =
	{
		head="Herculean Helm", neck="Orunmila's Torque", lear="Etiolation Earring", rear="Loquac. Earring",
		body=gear.TBody_Phalanx, hands="Leyline Gloves", lring="Evanescence Ring", rring="Weather. Ring +1",
	}

	-- Specific spells
	sets.midcast.Utsusemi = sets.midcast.FC

	-- Ranged sets

	sets.midcast.RA =
	{
		head="Arcadian Beret +1", neck="Iskur Gorget", lear="Telos Earring", rear="Enervating Earring",
		body="Amini Caban +1", hands="Amini Glove. +1", lring="Dingir Ring", rring="Ilabrat Ring",
		back="Belenus's Cape", waist="Yemaya Belt", legs="Malignance Tights", feet="Malignance Boots"
	}
	
	sets.buff['Barrage'] = 
	{
		hands="Orion Bracers +1"
	}

	--------------------------------------
	-- Idle/resting/defense/etc sets
	--------------------------------------

		-- Sets to return to when not performing an action.

		-- Idle sets
		sets.idle =
		{
			ranged="Fomalhaut", ammo="Chrono Bullet",
			head="Malignance Chapeau", neck="Warder's Charm +1", lear="Etiolation Earring", "Sanare Earring",
			body="Malignance Tabard", hands="Malignance Gloves", lring="Defending Ring", rring="Gelatinous Ring +1",
			back="Moonlight Cape", waist="Engraved Belt", legs="Malignance Tights",  feet="Jute Boots +1"
			
		}

		sets.idle.Town = set_combine(sets.idle,
		{
			feet="Jute Boots +1"
		})
		
		sets.idle.Adoulin = set_combine(sets.idle,
		{
			body="Councilor's Garb"
		})

		-- Defense sets
		sets.defense.PDT = sets.idle

		sets.defense.MDT = sets.idle

		sets.Kiting = { feet="Jute Boots +1" }
	
		sets.buff.Doom = 
		{
			neck="Nicander's Necklace",
			lring={name="Eshmun's Ring", bag="wardrobe2"}, rring={name="Eshmun's Ring", bag="wardrobe3"},
			waist="Gishdubar Sash"
		}


	--------------------------------------
	-- Melee sets
	--------------------------------------
	------------------------------------------------
	----------------------------------------------------------
	--	*************************************************** --
	----------------------------------------------------------
	-- Single-Wield 
	----------------------------------------------------------	
		
		sets.engaged =
		{
			head=gear.AHead_TP, neck="Iskur Gorget", lear="Sherida Earring", rear="Brutal Earring",
			body="Adhemar Jacket +1", hands="Adhemar Wrist. +1", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring="Epona's Ring",
			back="Belenus's Cape", waist="Windbuffet Belt +1", legs="Samnuha Tights", feet=gear.HBoots_TP
		}

		sets.engaged.Low =
		{
			head=gear.AHead_TP, neck="Iskur Gorget", lear="Sherida Earring", rear="Brutal Earring",
			body="Adhemar Jacket +1", hands="Adhemar Wrist. +1", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring="Epona's Ring",
			back="Belenus's Cape", waist="Windbuffet Belt +1", legs="Samnuha Tights", feet=gear.HBoots_TP
		}
		
		sets.engaged.Mid =
		{
			head=gear.AHead_TP, neck="Iskur Gorget", lear="Sherida Earring", rear="Brutal Earring",
			body="Adhemar Jacket +1", hands="Adhemar Wrist. +1", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring="Epona's Ring",
			back="Belenus's Cape", waist="Windbuffet Belt +1", legs="Samnuha Tights", feet=gear.HBoots_TP
		}
		
		sets.engaged.High =
		{
			head=gear.AHead_TP, neck="Iskur Gorget", lear="Sherida Earring", rear="Brutal Earring",
			body="Adhemar Jacket +1", hands="Adhemar Wrist. +1", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring="Epona's Ring",
			back="Belenus's Cape", waist="Windbuffet Belt +1", legs="Samnuha Tights", feet=gear.HBoots_TP
		}

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
	if spell.action_type == 'Ranged Attack' then
		state.CombatWeapon:set(player.equipment.range)
	end

	if spell.action_type == 'Ranged Attack' or
	  (spell.type == 'WeaponSkill' and (spell.skill == 'Marksmanship' or spell.skill == 'Archery')) then
		check_ammo(spell, action, spellMap, eventArgs)
	end

	if state.DefenseMode.value ~= 'None' and spell.type == 'WeaponSkill' then
		-- Don't gearswap for weaponskills when Defense is active.
		eventArgs.handled = true
	end
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
	if spell.action_type == 'Ranged Attack' and state.Buff.Barrage then
		equip(sets.buff.Barrage)
		eventArgs.handled = true
	end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------
function job_buff_change(buff,gain)
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


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)

end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Check for proper ammo when shooting or weaponskilling
function check_ammo(spell, action, spellMap, eventArgs)
	-- Filter ammo checks depending on Unlimited Shot
	if state.Buff['Unlimited Shot'] then
		if player.equipment.ammo ~= U_Shot_Ammo[player.equipment.range] then
			if player.inventory[U_Shot_Ammo[player.equipment.range]] or player.wardrobe[U_Shot_Ammo[player.equipment.range]] then
				add_to_chat(122,"Unlimited Shot active. Using custom ammo.")
				equip({ammo=U_Shot_Ammo[player.equipment.range]})
			elseif player.inventory[DefaultAmmo[player.equipment.range]] or player.wardrobe[DefaultAmmo[player.equipment.range]] then
				add_to_chat(122,"Unlimited Shot active but no custom ammo available. Using default ammo.")
				equip({ammo=DefaultAmmo[player.equipment.range]})
			else
				add_to_chat(122,"Unlimited Shot active but unable to find any custom or default ammo.")
			end
		end
	else
		if player.equipment.ammo == U_Shot_Ammo[player.equipment.range] and player.equipment.ammo ~= DefaultAmmo[player.equipment.range] then
			if DefaultAmmo[player.equipment.range] then
				if player.inventory[DefaultAmmo[player.equipment.range]] then
					add_to_chat(122,"Unlimited Shot not active. Using Default Ammo")
					equip({ammo=DefaultAmmo[player.equipment.range]})
				else
					add_to_chat(122,"Default ammo unavailable.  Removing Unlimited Shot ammo.")
					equip({ammo=empty})
				end
			else
				add_to_chat(122,"Unable to determine default ammo for current weapon.  Removing Unlimited Shot ammo.")
				equip({ammo=empty})
			end
		elseif player.equipment.ammo == 'empty' then
			if DefaultAmmo[player.equipment.range] then
				if player.inventory[DefaultAmmo[player.equipment.range]] then
					add_to_chat(122,"Using Default Ammo")
					equip({ammo=DefaultAmmo[player.equipment.range]})
				else
					add_to_chat(122,"Default ammo unavailable.  Leaving empty.")
				end
			else
				add_to_chat(122,"Unable to determine default ammo for current weapon.  Leaving empty.")
			end
		elseif player.inventory[player.equipment.ammo].count < 15 then
			add_to_chat(122,"Ammo '"..player.inventory[player.equipment.ammo].shortname.."' running low ("..player.inventory[player.equipment.ammo].count..")")
		end
	end
end


function determine_haste_group()
--[[
				buffactive[1]	= Weakness
				buffactive[13]	= Slow
				buffactive[33]	= Haste
				buffactive[194]	= Elegy
				buffactive[214]	= March
				buffactive[228]	= Embrava
				buffactive[265] = Flurry
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
			classes.CustomMeleeGroups:append('Max')								-- 43.75% Magical Haste
			--add_to_chat(8, '*********Maximum Haste Set***********')
		elseif buffactive[33] or buffactive.march == 2 or buffactive[580] or buffactive[228] then
			classes.CustomMeleeGroups:append('Med')								-- 30% Magical Haste
			--add_to_chat(8, '*********Medium Haste Set***********')
		elseif buffactive[214] or buffactive[604] then
			classes.CustomMeleeGroups:append('Min')								-- 15% Magical Haste
			--add_to_chat(8, '*********Minimum Haste Set***********')
		else
			classes.CustomMeleeGroups:append('')								-- No Magical Haste
			--add_to_chat(8, '********* No Haste Set ***********')
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
		--add_to_chat(8, '------------- No Dual Wield Detected   --------------')
    end
end


-- Select default macro book on initial load or subjob change.
function apply_job_change()
	set_macro_page(1, 10)
end