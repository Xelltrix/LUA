-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------
 
-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
 
    -- Load and initialize the include file.
    include('Mote-Include.lua')
end
 
-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------
 
-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	state.OffenseMode:options('Normal', 'Low', 'Mid', 'High')
	state.HybridMode:options('Normal', 'DT', 'DTMAX')
	state.WeaponskillMode:options('Normal', 'Low', 'Mid', 'High')
	state.CastingMode:options('Normal', 'Resistant')
	state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
    state.IdleMode:options('Normal', 'DT')
    	
    apply_job_change()
end
 
 function user_unload()
	send_command('unbind ^`')
	send_command('unbind !`')
	send_command('unbind ^=')
	send_command('unbind !-')
	send_command('unbind ^,')
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
		sets.precast.JA['Blood Weapon'] =
		{
		}
		sets.precast.JA['Arcane Circle'] =
		{
		}
		sets.precast.JA['Last Resort'] =
		{
		}
		sets.precast.JA['Souleater'] =
		{
		}
		sets.precast.JA['Weapon Bash'] =
		{
		}
		sets.precast.JA['Dark Seal'] =
		{
		}
		sets.precast.JA['Diabolic Eye'] =
		{
		}
		sets.precast.JA['Nether Void'] =
		{
		}
		
		
	-------------------
	-- Precast Magic --
	------------------- 
	
	
    sets.precast.FC = 
	{
		ammo="Sapience Orb",
		head="Carmine Mask +1", neck="Orunmila's Torque", lear="Loquac. Earring", rear="Malignance Earring",
		body="Odyss. Chestplate", hands="Leyline Gloves", lring="Kishar Ring", rring="Weather. Ring +1",
		back="Moonlight Cape", waist="Flume Belt +1", legs="Carmine Cuisses +1", feet="Carmine Greaves +1"
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
		sets.midcast.FC = sets.precast.FC

    
    --------------------------------------
	-- Buffing Midcast sets
	--------------------------------------		
	
		sets.midcast.Endark = {}

		sets.midcast['Endark II'] = sets.midcast.Endark

		sets.midcast['Dread Spikes'] = {}
	
	--------------------------------------
	-- Offensive Midcast sets
	--------------------------------------    
	
	---Enfeebling Magic
		sets.midcast.Macc =	
		{
			ammo="Pemphredo Tathlum",
			head="Carmine Mask +1", neck="Erra Pendant", lear="Digni. Earring", rear="Malignance Earring",
			body="Flamma Korazin +2", hands="Leyline Gloves", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back="Ankou's Mantle", waist="Orpheus's Sash", legs="Flamma Dirs +2", feet="Flam. Gambieras +2"
		}
	
		sets.midcast['Enfeebling Magic'] = set_combine(sets.midcast.Macc,
		{
			neck="Incanter's Torque",
			lring="Kishar Ring"
		})

	---Dark Magic
		sets.midcast.Stun = set_combine(sets.midcast.Macc,
		{
			body="Carm. Sc. Mail +1", lring="Kishar Ring", rring="Weather. Ring +1",
			feet="Carmine Greaves +1"
		})
		
		sets.midcast.Absorb = set_combine(sets.midcast.Macc,
		{
			back="Ankou's Mantle"
		})
	  
		sets.midcast.Sap = set_combine(sets.midcast.Macc,
		{
			head="Pixie Hairpin +1",
			body="Carm. Sc. Mail +1",  lring="Archon Ring", rring="Evanescence Ring",
			back="Ankou's Mantle", 
		})

	---Elemental Magic
    sets.midcast['Elemental Magic'] = 
	{
		ammo="Pemphredo Tathlum", 
		head="Flamma Zucchetto +2", neck="Sanctity Necklace", lear="Friomisi Earring", rear="Malignance Earring",
		body="Flamma Korazin +2", hands="Carmine Fin. Ga. +1", lring={name="Shiva Ring +1", bag="wardrobe2"}, rring={name="Shiva Ring +1", bag="wardrobe3"},
		back="Ankou's Mantle", waist="Orpheus's Sash", legs="Flamma Dirs +2", feet="Flam. Gambieras +2"
	}


	--------------------------------------
	-- Suppoort Job Midcast sets
	--------------------------------------

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
			ammo="Staunch Tathlum +1",
			neck="Sanctity Necklace", lear="Dawn Earring", rear="Infused Earring",
			body="Lugra Cloak +1", hands="Sulev. Gauntlets +2", lring={name="Stikini Ring +1", bag="wardrobe2"}, rring={name="Stikini Ring +1", bag="wardrobe3"},
			back="Moonlight Cape", waist="Flume Belt +1", legs="Carmine Cuisses +1", feet="Sulev. Leggings +2"
		}

		sets.idle.DT =
		{
			ammo="Staunch Tathlum +1",
			neck="Loricate Torque +1", lear="Dawn Earring", rear="Infused Earring",
			body="Lugra Cloak +1", hands="Sulev. Gauntlets +2", lring="Defending Ring", rring="Moonlight Ring",
			back="Moonlight Cape", waist="Flume Belt +1", legs="Carmine Cuisses +1", feet="Sulev. Leggings +2"
		}

		sets.idle.Town = set_combine(sets.idle,
		{
			legs="Carmine Cuisses +1"
		})
		
		sets.idle.Adoulin = set_combine(sets.idle,
		{
			head="Flam. Zucchetto +2",
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
		{
			ammo="Staunch Tathlum +1",
			head="Sulevia's Mask +2", neck="Loricate Torque +1", lear="Etiolation Earring", rear="Odnowa Earring +1",
			body="Sulevia's Plate. +1", hands="Sulev. Gauntlets +2", lring="Defending Ring", rring="Moonlight Ring",
			back="Moonlight Cape", waist="Flume Belt +1", legs="Sulev. Cuisses +2", feet="Sulev. Leggings +2"
		}

		sets.defense.MDT = 
		{
			ammo="Staunch Tathlum +1",
			head="Sulevia's Mask +2", neck="Loricate Torque +1", lear="Etiolation Earring", rear="Odnowa Earring +1",
			body="Sulevia's Plate. +1", hands="Sulev. Gauntlets +2", lring="Defending Ring", rring="Moonlight Ring",
			back="Moonlight Cape", waist="Flume Belt +1", legs="Sulev. Cuisses +2", feet="Sulev. Leggings +2"
		}

	--------------------------------------
	-- Special Sets
	--------------------------------------

		sets.Kiting =
		{
			legs="Carmine Cuisses +1"
		}
		
		sets.TreasureHunter =
		{
			hands="Volte Bracers",
			waist="Chaac Belt", legs="Volte Hose"
		}

	---Buffs
		sets.buff.Doom = 
		{
			neck="Nicander's Necklace",
			lring={name="Eshmun's Ring", bag="wardrobe2"}, rring={name="Eshmun's Ring", bag="wardrobe3"},
			waist="Gishdubar Sash"
		}
		
		
		sets.buff['Souleater'] = 
		{
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
		ammo="Knobkierrie",
		head="Odyssean Helm", neck="Fotia Gorget", lear="Ishvara Earring", rear="Moonshade Earring",
		body="Flamma Korazin +2", hands="Odyssean Gauntlets", lring="Regal Ring", rring="Epaminondas's Ring",
		back="Ankou's Mantle", waist="Fotia Belt", legs="Sulev. Cuisses +2", feet="Sulev. Leggings +2"
	}
	
	sets.precast.WS.Low = sets.precast.WS
	
	sets.precast.WS.Mid = sets.precast.WS
	
	sets.precast.WS.High = sets.precast.WS
 

	--------------------------------------
	-- Melee sets
	--------------------------------------
	
	sets.engaged =
	{
		ammo="Ginsen",
		head="Flam. Zucchetto +2", neck="Asperity Necklace", lear="Telos Earring", rear="Cessance Earring",
		body="Valorous Mail", hands="Flam. Manopolas +2", lring="Niqmaddu Ring", rring="Regal Ring",
		back="Ankou's Mantle", waist="Ioskeha Belt", legs="Odyssean Cuisses", feet="Odyssean Greaves"
	}

	--------------------------------------
	-- Hybrid Sets
	--------------------------------------
		sets.engaged.Hybrid = 
		{
			ammo="Staunch Tathlum +1",
			neck="Loricate Torque +1",
			lring="Defending Ring",
		}
		
		sets.engaged.Hybrid2 = 
		{
			ammo="Staunch Tathlum +1",
			neck="Loricate Torque +1",
			lring="Defending Ring",
			legs="Sulev. Cuisses +2", feet="Sulev. Leggings +2"
		}

 
end

-------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff,gain)
-- If we gain or lose any flurry buffs, adjust gear.
	if state.Buff[buff] ~= nil then
        if not midaction() then
            handle_equipping_gear(player.status)
        end
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
	
	if buff == "sleep" then
		if gain then
			equip({head="Frenzy Sallet"})
		else
			handle_equipping_gear(player.status)
		end
	end

	if S{'last resort','haste','march','embrava','haste samba', 'mighty guard', 'geo-haste', 'indi-haste', 'slow', 'indi-slow', 'elegy'}:contains(buff:lower()) then
		determine_haste_group()
		handle_equipping_gear(player.status)
	end
	
end

function job_status_change(new_status, old_status)
	if new_status == 'Engaged' then
		determine_haste_group()
	end
end


function job_update(cmdParams, eventArgs)
    determine_haste_group()
	handle_equipping_gear(player.status)
end

--Adjusts gear based on the level of magical haste received.
function determine_haste_group()
--[[
				buffactive[1]	= Weakness
				buffactive[13]	= Slow
				buffactive[33]	= Haste
				buffactive[51]	= Last Resort
				buffactive[194]	= Elegy
				buffactive[214]	= March
				buffactive[228]	= Embrava
				buffactive[370]	= Haste Samba
				buffactive[580]	= Geo-Haste
				buffactive[604]	= Mighty Guard							]]
	
	classes.CustomMeleeGroups:clear()

	if buffactive[1] or buffactive[13] or buffactive[194] then
		classes.CustomMeleeGroups:append('')						-- Slow Status Effect
		add_to_chat(8, '*********Slowed Status Effect Set***********')
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


 
-- Select default macro book on initial load or subjob change.
function apply_job_change()
    set_macro_page(1, 8)
	
	send_command('wait 3; input /lockstyleset 8')
end