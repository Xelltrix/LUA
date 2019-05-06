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
    state.Buff['Climactic Flourish'] = buffactive['climactic flourish'] or false

    state.MainStep = M{['description']='Main Step', 'Box Step', 'Quickstep', 'Feather Step', 'Stutter Step'}
    state.AltStep = M{['description']='Alt Step', 'Quickstep', 'Feather Step', 'Stutter Step', 'Box Step'}
    state.UseAltStep = M(false, 'Use Alt Step')
    state.SelectStepTarget = M(false, 'Select Step Target')
    state.IgnoreTargetting = M(false, 'Ignore Targetting')

    state.CurrentStep = M{['description']='Current Step', 'Main', 'Alt'}

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
    state.PhysicalDefenseMode:options('PDT')
    state.IdleMode:options('Normal', 'DT')

    -- Additional local binds
    send_command('bind ^= gs c cycle mainstep')
    send_command('bind != gs c cycle altstep')
    send_command('bind ^- gs c toggle selectsteptarget')
    send_command('bind !- gs c toggle usealtstep')
    send_command('bind ^` input /ja "Chocobo Jig" <me>')
    send_command('bind !` input /ja "Chocobo Jig II" <me>')

    select_default_macro_book()
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
    send_command('unbind ^=')
    send_command('unbind !=')
    send_command('unbind ^-')
    send_command('unbind !-')
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

	sets.precast.JA['No Foot Rise'] =
	{
		body="Horos Casaque +1"
	}

    sets.precast.JA['Trance'] =
	{
		head="Horos Tiara +1"
	}

	    sets.precast.Waltz =
	{
        ammo="Yamarang",
		head="Horos Tiara +1", lear="Roundel Earring",
        body="Maxixi Casaque +1",
        back="Toetapper Mantle", waist="Fotia Belt", feet="Maxixi Shoes +1"
	}


    sets.precast.Samba =
	{
		head="Maxixi Tiara +1",
		back="Senuna's Mantle"
	}

    sets.precast.Jig =
	{
		legs="Horos Tights +1", feet="Maxixi Shoes +1"
	}

    sets.precast.Step =
	{
		ammo="Yamarang",
		head="Meghanada Visor +2", neck="Combatant's Torque", lear={name="Mache Earring +1", bag="wardrobe2"}, rear={name="Mache Earring +1", bag="wardrobe3"},
		body="Meg. Cuirie +2", hands="Meg. Gloves +2", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"},
		back="Toetapper Mantle", waist="Kentarch Belt +1", legs="Adhemar Kecks +1", feet="Meg. Jam. +2"
	}

    sets.precast.Flourish1 = {}
    sets.precast.Flourish1['Violent Flourish'] =
	{
		ammo="Pemphredo Tathlum",
		head="Meghanada Visor +2", neck="Sanctity Necklace", lear="Digni. Earring",ear2="Gwati Earring",
        body="Horos Casaque +1", hands="Leyline Gloves", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
        back="Toetapper Mantle", waist="Eschan Stone", legs="Meg. Chausses +2", feet="Herculean Boots"
	}
    sets.precast.Flourish1['Desperate Flourish'] =
	{
		ammo="Falcon Eye",
		head="Meghanada Visor +2", neck="Combatant's Torque", lear={name="Mache Earring +1", bag="wardrobe2"}, rear={name="Mache Earring +1", bag="wardrobe3"},
		body="Meg. Cuirie +2", hands="Meg. Gloves +2", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"},
		back="Toetapper Mantle", waist="Eschan Stone", legs="Meg. Chausses +2", feet="Meg. Jam. +2"
	}

    sets.precast.Flourish2 = {}
    sets.precast.Flourish2['Reverse Flourish'] =
	{
		hands="Macu. Bangles +1",
		back="Toetapper Mantle"
	}

    sets.precast.Flourish3 = {}
    sets.precast.Flourish3['Climactic Flourish'] =
	{
		head="Maculele Tiara +1"
	}
	
	
	-------------------
	-- Precast Magic --
	------------------- 

    sets.precast.FC =
	{
		ammo="Sapience Orb",
		head=gear.HHead_MAB, neck="Orunmila's Torque", lear="Etiolation Earring", rear="Loquac. Earring",
		body="Samnuha Coat", hands="Leyline Gloves", lring="Prolix Ring", rring="Rahab Ring",
		back="Moonbeam Cape", waist="Flume Belt +1", legs="Rawhide Trousers", feet=gear.HBoots_TP
	}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC,
	{
		neck="Magoraga Beads",
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
	-- Base Midcast sets
	--------------------------------------	
	
	sets.midcast.Utsusemi = sets.precast.FC

	
	
	
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
		body="Meg. Cuirie +2", hands="Meg. Gloves +2", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"},
		back="Moonbeam Cape", waist="Flume Belt +1", legs="Mummu Kecks +2", feet=gear.HBoots_TP
	}

	sets.idle.DT = set_combine (sets.idle,
	{
		head="Meghanada Visor +2", neck="Loricate Torque +1",
		body="Meg. Cuirie +2", lring="Defending Ring", rring="Moonbeam Ring",
	})

	sets.idle.Town = set_combine(sets.idle,
	{
		feet="Tandava Crackows"
	})
	
	sets.idle.AdoulinCity = set_combine(sets.idle,
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
	
	-- Defense sets

		sets.defense.PDT =  set_combine(sets.idle.DT,
		{
			lear="Etiolation Earring", rear="Odnowa Earring +1"
		})

		sets.defense.MDT = sets.defense.PDT

	
	--------------------------------------
	-- Special Sets
	--------------------------------------
	
		sets.Kiting =
		{
			feet="Tandava Crackows"
		}
	
	---Buffs
		sets.buff['Climactic Flourish'] =
		{
			head="Maculele Tiara +1"
		}
		
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
			ammo="Yamarang",
			head=gear.HHead_WSD, neck="Fotia Gorget", lear="Sherida Earring", rear="Moonshade Earring",
			body="Adhemar Jacket +1", hands="Meg. Gloves +2", lring="Regal Ring", rring="Epona's Ring",
			back="Senuna's Mantle", waist="Fotia Belt", legs="Samnuha Tights", feet=gear.HBoots_WSD
		}

		sets.precast.WS.Low = set_combine(sets.precast.WS,
		{
			feet="Meg. Jam. +2"
		})
		
		sets.precast.WS.Mid = set_combine(sets.precast.WS.Low,
		{
			lear={name="Mache Earring +1", bag="wardrobe2"}, rear={name="Mache Earring +1", bag="wardrobe3"}
		})
		
		sets.precast.WS.High = set_combine(sets.precast.WS.Mid,
		{
			head="Dampening Tam",
			body="Meg. Cuirie +2", rring={name="Chirich Ring +1", bag="wardrobe3"},
			legs="Adhemar Kecks +1"
		})
		
		sets.precast.WS.CF = set_combine(sets.precast.WS,
		{
			head="Maculele Tiara +1",
		})

	
	---Exenterator
		sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS,
		{
			rear="Brutal Earring",
			feet=gear.HBoots_TP
		})

		sets.precast.WS['Exenterator'].Low = set_combine(sets.precast.WS['Exenterator'],
		{
			lear={name="Mache Earring +1", bag="wardrobe2"}, rear={name="Mache Earring +1", bag="wardrobe3"}
		})
		
		sets.precast.WS['Exenterator'].Mid = set_combine(sets.precast.WS['Exenterator'].Low,
		{
			head="Dampening Tam"
		})

		sets.precast.WS['Exenterator'].High = set_combine(sets.precast.WS['Exenterator'].Mid,
		{
			body="Meg. Cuirie +2", hands="Meg. Gloves +2", lring={name="Chirich Ring +1", bag="wardrobe2"}, rring={name="Chirich Ring +1", bag="wardrobe3"},
			legs="Adhemar Kecks +1"
		})

		sets.precast.WS['Exenterator'].CF = set_combine(sets.precast.WS['Exenterator'],
		{
			head="Maculele Tiara +1",
		})

	---Evisceration	
		sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS,
		{
			head="Adhemar Bonnet +1",
			hands="Adhemar Wrist. +1", lring="Begrudging Ring",
			feet=gear.HBoots_Crit
		})

		sets.precast.WS['Evisceration'].Low = set_combine(sets.precast.WS['Evisceration'],
		{
			head="Dampening Tam"
		})
		
		sets.precast.WS['Evisceration'].Mid = set_combine(sets.precast.WS['Evisceration'].Low,
		{
			lear={name="Mache Earring +1", bag="wardrobe2"}, rear={name="Mache Earring +1", bag="wardrobe3"}
		})
		
		sets.precast.WS['Evisceration'].High = set_combine(sets.precast.WS['Evisceration'].Mid,
		{
			body="Meg. Cuirie +2", hands="Meg. Gloves +2", rring={name="Chirich Ring +1", bag="wardrobe3"},
			legs="Adhemar Kecks +1"
		})
		
		sets.precast.WS['Evisceration'].CF = set_combine(sets.precast.WS['Evisceration'],
		{
			head="Maculele Tiara +1",
			body="Abnoba Kaftan"
		})

	---Dancing Edge
		sets.precast.WS['Dancing Edge'] = set_combine(sets.precast.WS,
		{
			ammo="Falcon Eye",
			head="Adhemar Bonnet +1",
			hands="Adhemar Wrist. +1", feet=gear.HBoots_TP
		})

		sets.precast.WS['Dancing Edge'].Low = set_combine(sets.precast.WS['Dancing Edge'],
		{
			head="Dampening Tam",
		})
		
		sets.precast.WS['Dancing Edge'].Mid = set_combine(sets.precast.WS['Dancing Edge'].Low,
		{
			lear={name="Mache Earring +1", bag="wardrobe2"}, rear={name="Mache Earring +1", bag="wardrobe3"}
		})
		
		sets.precast.WS['Dancing Edge'].High = set_combine(sets.precast.WS['Dancing Edge'].Mid,
		{
			body="Meg. Cuirie +2", hands="Meg. Gloves +2", rring={name="Chirich Ring +1", bag="wardrobe3"},
			legs="Adhemar Kecks +1"
		})
		
		sets.precast.WS['Dancing Edge'].CF = set_combine(sets.precast.WS['Dancing Edge'],
		{
			head="Maculele Tiara +1",
			body="Abnoba Kaftan"
		})
		
	---Rudra's Storm
		sets.precast.WS['Rudra\'s Storm'] = set_combine(sets.precast.WS,
		{
			head="Lilitu Headpiece", neck="Caro Necklace", lear="Ishvara Earring",
			body="Herculean Vest", rring={name="Chirich Ring +1", bag="wardrobe3"},
			waist="Grunfeld Rope", legs="Herculean Trousers", feet=gear.HBoots_WSD
		})

		sets.precast.WS['Rudra\'s Storm'].Low = sets.precast.WS["Rudra's Storm"]
		
		sets.precast.WS['Rudra\'s Storm'].Mid = sets.precast.WS["Rudra's Storm"]
		
		sets.precast.WS['Rudra\'s Storm'].High = sets.precast.WS["Rudra's Storm"]

		sets.precast.WS['Rudra\'s Storm'].CF = set_combine(sets.precast.WS["Rudra's Storm"],
		{
			head="Maculele Tiara +1",
			body="Abnoba Kaftan", feet=gear.HBoots_Crit
		})

	---Pyrrhic Kleos
		sets.precast.WS['Pyrrhic Kleos'] = set_combine(sets.precast.WS,
		{
			ammo="Floestone",
			head="Adhemar Bonnet +1", rear="Brutal Earring",
			hands="Adhemar Wrist. +1", feet=gear.HBoots_TP
		})

		sets.precast.WS['Pyrrhic Kleos'].Low = set_combine(sets.precast.WS['Pyrrhic Kleos'],
		{
			lear={name="Mache Earring +1", bag="wardrobe2"}, rear={name="Mache Earring +1", bag="wardrobe3"}
		})
		
		sets.precast.WS['Pyrrhic Kleos'].Mid = set_combine(sets.precast.WS['Pyrrhic Kleos'].Low,
		{
			head="Dampening Tam",
			legs="Meg. Chausses +2"
		})
		
		sets.precast.WS['Pyrrhic Kleos'].High = set_combine(sets.precast.WS['Pyrrhic Kleos'].Mid,
		{
			body="Meg. Cuirie +2", hands="Meg. Gloves +2", rring={name="Chirich Ring +1", bag="wardrobe3"},
			legs="Adhemar Kecks +1"
		})
		
		sets.precast.WS['Pyrrhic Kleos'].CF = set_combine(sets.precast.WS['Pyrrhic Kleos'],
		{
			head="Maculele Tiara +1",
			body="Abnoba Kaftan"
		})
		
	---Aeolian Edge
		sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS,
		{
			ammo="Pemphredo Tathlum",
			head=gear.HHead_MAB, lear="Friomisi Earring",
			body="Samnuha Coat", hands="Leyline Gloves", lring="Regal Ring", rring={name="Shiva Ring +1", bag="wardrobe3"},
			back="Senuna's Mantle", legs="Herculean Trousers", feet=gear.HBoots_WSD
		})


	sets.precast.WS['Cyclone'] = sets.precast.WS['Aeolian Edge']

	sets.precast.WS['Gust Slash'] = sets.precast.WS['Aeolian Edge']

	
	--------------------------------------
	-- Melee sets
	--------------------------------------

	
	----------------------------------------------------------
	--					(DW4 + No Haste)
	----------------------------------------------------------

	--30 DW = 44 DW needed		
	
	----------------------------------------------------------	
	
		sets.engaged =
		{
			ammo="Yamarang",
			head="Adhemar Bonnet +1", neck="Combatant's Torque", lear="Eabani Earring", rear="Suppanomimi",
			body="Adhemar Jacket +1", hands="Adhemar Wrist. +1", lring="Hetairoi Ring", rring="Epona's Ring",
			back="Toetapper Mantle", waist="Reiki Yotai", legs="Samnuha Tights", feet=gear.TFeet_TP
		}

		sets.engaged.Low = set_combine(sets.engaged,
		{
			head="Dampening Tam", neck="Combatant's Torque",
			lring={name="Chirich Ring +1", bag="wardrobe2"}
		})

		sets.engaged.Mid = set_combine(sets.engaged.Low,
		{
			rring="Regal Ring",
			legs="Adhemar Kecks +1"
		})

		sets.engaged.High = set_combine(sets.engaged.Mid,
		{
			lear={name="Mache Earring +1", bag="wardrobe2"}, rear={name="Mache Earring +1", bag="wardrobe3"},
			waist="Kentarch Belt +1", feet=gear.HBoots_TP
		})
	
	
	
	----------------------------------------------------------
	--					(DW4 + 15% Haste)
	----------------------------------------------------------

	--30 DW = 37 DW needed		
	
	----------------------------------------------------------	
	
		sets.engaged.Min =
		{
			ammo="Yamarang",
			head="Adhemar Bonnet +1", neck="Anu Torque", lear="Eabani Earring", rear="Suppanomimi",
			body="Adhemar Jacket +1", hands="Adhemar Wrist. +1", lring="Hetairoi Ring", rring="Epona's Ring",
			back="Toetapper Mantle", waist="Reiki Yotai", legs="Samnuha Tights", feet=gear.TFeet_TP
		}

		sets.engaged.Low.Min = set_combine(sets.engaged.Min,
		{
			head="Dampening Tam", neck="Combatant's Torque",
			lring={name="Chirich Ring +1", bag="wardrobe2"}
		})

		sets.engaged.Mid.Min = set_combine(sets.engaged.Low.Min,
		{
			rring="Regal Ring",
			legs="Adhemar Kecks +1"
		})

		sets.engaged.High.Min = set_combine(sets.engaged.Mid.Min,
		{
			lear="Telos Earring",
			waist="Kentarch Belt +1", feet=gear.HBoots_TP
		})

	
	----------------------------------------------------------
	--					(DW4 + 30% Haste)
	----------------------------------------------------------

	--30 DW = 26 DW needed		
	
	----------------------------------------------------------	
	
		sets.engaged.Med =
		{
			ammo="Yamarang",
			head="Adhemar Bonnet +1", neck="Anu Torque", lear="Eabani Earring", rear="Suppanomimi",
			body="Adhemar Jacket +1", hands="Adhemar Wrist. +1", lring="Hetairoi Ring", rring="Epona's Ring",
			back="Senuna's Mantle", waist="Reiki Yotai", legs="Samnuha Tights", feet=gear.TFeet_TP
		}

		sets.engaged.Low.Med = set_combine(sets.engaged.Med,
		{
			head="Dampening Tam", neck="Combatant's Torque",
			lring={name="Chirich Ring +1", bag="wardrobe2"}
		})

		sets.engaged.Mid.Med = set_combine(sets.engaged.Low.Med,
		{
			rring="Regal Ring",
			legs="Meg. Chausses +2"
		})

		sets.engaged.High.Med = set_combine(sets.engaged.Mid.Med,
		{
			lear="Telos Earring",
			waist="Kentarch Belt +1", feet=gear.HBoots_TP
		})

	
	
	----------------------------------------------------------
	--					(DW4 + Max Haste)
	----------------------------------------------------------

	--30 DW = 6 DW needed
	
	----------------------------------------------------------
	
		sets.engaged.Max =
		{
			ammo="Yamarang",
			head="Adhemar Bonnet +1", neck="Anu Torque", lear="Sherida Earring", rear="Telos Earring",
			body="Adhemar Jacket +1", hands="Adhemar Wrist. +1", lring="Petrov Ring", rring="Epona's Ring",
			back="Senuna's Mantle", waist="Windbuffet Belt +1", legs="Samnuha Tights", feet=gear.HBoots_TP
		}

		sets.engaged.Low.Max = set_combine(sets.engaged.Max,
		{
			head="Dampening Tam", neck="Combatant's Torque",
			lring={name="Chirich Ring +1", bag="wardrobe2"} 
		})

		sets.engaged.Mid.Max = set_combine(sets.engaged.Low.Max,
		{
			hands="Meg. Gloves +2",
			legs="Meg. Chausses +2"
		})

		sets.engaged.High.Max = set_combine(sets.engaged.Mid.Max,
		{
			rring="Regal Ring",
			waist="Kentarch Belt +1",
		})


end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
----------------------------------
---------------------------------------------------------------------------------


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff,gain)
    -- If we gain or lose any haste buffs, adjust which gear set we target.
    if S{'haste','march','embrava','haste samba', 'mighty guard'}:contains(buff:lower()) then
		determine_haste_group()
		handle_equipping_gear(player.status)
    elseif buff == 'Climactic Flourish' then
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


function job_status_change(new_status, old_status)
    if new_status == 'Engaged' then
        determine_haste_group()
    end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the default 'update' self-command.
function job_update(cmdParams, eventArgs)
    determine_haste_group()
end

function get_custom_wsmode(spell, spellMap, defaut_wsmode)
	local wsmode

	if state.Buff['Climactic Flourish'] then
		wsmode = 'CF'
	end

	return wsmode
end

function customize_melee_set(meleeSet)
    if state.DefenseMode.value ~= 'None' then
        if state.Buff['Climactic Flourish'] then
            meleeSet = set_combine(meleeSet, sets.buff['Climactic Flourish'])
        end
    end

    return meleeSet
end

-- Handle auto-targetting based on local setup.
function job_auto_change_target(spell, action, spellMap, eventArgs)
    if spell.type == 'Step' then
        if state.IgnoreTargetting.value == true then
            state.IgnoreTargetting:reset()
            eventArgs.handled = true
        end

        eventArgs.SelectNPCTargets = state.SelectStepTarget.value
    end
end


-- Function to display the current relevant user state when doing an update.
-- Set eventArgs.handled to true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
    local msg = 'Melee'

    if state.CombatForm.has_value then
        msg = msg .. ' (' .. state.CombatForm.value .. ')'
    end

    msg = msg .. ': '

    msg = msg .. state.OffenseMode.value
    if state.HybridMode.value ~= 'Normal' then
        msg = msg .. '/' .. state.HybridMode.value
    end
    msg = msg .. ', WS: ' .. state.WeaponskillMode.value

    if state.DefenseMode.value ~= 'None' then
        msg = msg .. ', ' .. 'Defense: ' .. state.DefenseMode.value .. ' (' .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ')'
    end

    if state.Kiting.value then
        msg = msg .. ', Kiting'
    end

    msg = msg .. ', ['..state.MainStep.current

    if state.UseAltStep.value == true then
        msg = msg .. '/'..state.AltStep.current
    end

    msg = msg .. ']'

    if state.SelectStepTarget.value == true then
        steps = steps..' (Targetted)'
    end

    add_to_chat(122, msg)

    eventArgs.handled = true
end


-------------------------------------------------------------------------------------------------------------------
-- User self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called for custom player commands.
function job_self_command(cmdParams, eventArgs)
    if cmdParams[1] == 'step' then
        if cmdParams[2] == 't' then
            state.IgnoreTargetting:set()
        end

        local doStep = ''
        if state.UseAltStep.value == true then
            doStep = state[state.CurrentStep.current..'Step'].current
            state.CurrentStep:cycle()
        else
            doStep = state.MainStep.current
        end

        send_command('@input /ja "'..doStep..'" <t>')
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
				buffactive[189] = Haste Samba
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
			(buffactive[33] and (buffactive[580] or buffactive.embrava)) or (buffactive.march == 2 and buffactive[604])
			or (buffactive[189] and (buffactive[33] or buffactive.march == 2 or buffactive[228] or buffactive[580]))) then
			classes.CustomMeleeGroups:append('Max')							-- 43.75% Magical Haste
			--add_to_chat(8, '*********Maximum Haste Set***********')
		elseif buffactive[33] or buffactive.march == 2 or buffactive[580] or buffactive[228] then
			classes.CustomMeleeGroups:append('Med')							-- 30% Magical Haste
			--add_to_chat(8, '*********Medium Haste Set***********')
		elseif buffactive[214] or buffactive[604] or buffactive[189] then
			classes.CustomMeleeGroups:append('Min')							-- 15% Magical Haste
			--add_to_chat(8, '*********Minimum Haste Set***********')
		else
			classes.CustomMeleeGroups:append('')							-- No Magical Haste
			--add_to_chat(8, '*********No Haste Set***********')
		end
	end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    set_macro_page(1, 16)
end
