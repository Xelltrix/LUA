-------------------------------------------------------------------------------------------------------------------
-- General utility functions that can be used by any job files.
-- Outside the scope of what the main include file deals with.
-------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------
-- Buff utility functions.
-------------------------------------------------------------------------------------------------------------------

local cancel_spells_to_check = S{'Sneak', 'Stoneskin', 'Spectral Jig', 'Trance', 'Monomi: Ichi', 'Utsusemi: Ichi'}
local cancel_types_to_check = S{'Waltz', 'Samba'}

-- Function to cancel buffs if they'd conflict with using the spell you're attempting.
-- Requirement: Must have Cancel addon installed and loaded for this to work.
function cancel_conflicting_buffs(spell, action, spellMap, eventArgs)
    if cancel_spells_to_check:contains(spell.english) or cancel_types_to_check:contains(spell.type) then
        if spell.action_type == 'Ability' then
            local abil_recasts = windower.ffxi.get_ability_recasts()
            if abil_recasts[spell.recast_id] > 0 then
                add_to_chat(123,'Abort: Ability waiting on recast.')
                eventArgs.cancel = true
                return
            end
        elseif spell.action_type == 'Magic' then
            local spell_recasts = windower.ffxi.get_spell_recasts()
            if spell_recasts[spell.recast_id] > 0 then
                add_to_chat(123,'Abort: Spell waiting on recast.')
                eventArgs.cancel = true
                return
            end
        end
        
        if spell.english == 'Spectral Jig' and buffactive.sneak then
            cast_delay(0.2)
            send_command('cancel sneak')
        elseif spell.english == 'Sneak' and spell.target.type == 'SELF' and buffactive.sneak then
            send_command('cancel sneak')
        elseif spell.english == ('Stoneskin') then
            send_command('@wait 1.0;cancel stoneskin')
        elseif spell.english:startswith('Monomi') then
            send_command('@wait 1.7;cancel sneak')
        elseif spell.english == 'Utsusemi: Ichi' then
            send_command('@wait 1.7;cancel copy image,copy image (2)')
        elseif (spell.english == 'Trance' or spell.type=='Waltz') and buffactive['saber dance'] then
            cast_delay(0.2)
            send_command('cancel saber dance')
        elseif spell.type=='Samba' and buffactive['fan dance'] then
            cast_delay(0.2)
            send_command('cancel fan dance')
        end
    end
end


-- Some mythics have special durations for level 1 and 2 aftermaths
local special_aftermath_mythics = S{'Tizona', 'Kenkonken', 'Murgleis', 'Yagrush', 'Carnwenhan', 'Nirvana', 'Tupsimati', 'Idris'}

-- Call from job_precast() to setup aftermath information for custom timers.
function custom_aftermath_timers_precast(spell)
    if spell.type == 'WeaponSkill' then
        info.aftermath = {}
        
        local relic_ws = data.weaponskills.relic[player.equipment.main] or data.weaponskills.relic[player.equipment.range]
        local mythic_ws = data.weaponskills.mythic[player.equipment.main] or data.weaponskills.mythic[player.equipment.range]
        local empy_ws = data.weaponskills.empyrean[player.equipment.main] or data.weaponskills.empyrean[player.equipment.range]
        
        if not relic_ws and not mythic_ws and not empy_ws then
            return
        end

        info.aftermath.weaponskill = spell.english
        info.aftermath.duration = 0
        
        info.aftermath.level = math.floor(player.tp / 1000)
        if info.aftermath.level == 0 then
            info.aftermath.level = 1
        end
        
        if spell.english == relic_ws then
            info.aftermath.duration = math.floor(0.2 * player.tp)
            if info.aftermath.duration < 20 then
                info.aftermath.duration = 20
            end
        elseif spell.english == empy_ws then
            -- nothing can overwrite lvl 3
            if buffactive['Aftermath: Lv.3'] then
                return
            end
            -- only lvl 3 can overwrite lvl 2
            if info.aftermath.level ~= 3 and buffactive['Aftermath: Lv.2'] then
                return
            end
            
            -- duration is based on aftermath level
            info.aftermath.duration = 30 * info.aftermath.level
        elseif spell.english == mythic_ws then
            -- nothing can overwrite lvl 3
            if buffactive['Aftermath: Lv.3'] then
                return
            end
            -- only lvl 3 can overwrite lvl 2
            if info.aftermath.level ~= 3 and buffactive['Aftermath: Lv.2'] then
                return
            end

            -- Assume mythic is lvl 80 or higher, for duration
                        
            if info.aftermath.level == 1 then
                info.aftermath.duration = (special_aftermath_mythics:contains(player.equipment.main) and 270) or 90
            elseif info.aftermath.level == 2 then
                info.aftermath.duration = (special_aftermath_mythics:contains(player.equipment.main) and 270) or 120
            else
                info.aftermath.duration = 180
            end
        end
    end
end


-- Call from job_aftercast() to create the custom aftermath timer.
function custom_aftermath_timers_aftercast(spell)
    if not spell.interrupted and spell.type == 'WeaponSkill' and
       info.aftermath and info.aftermath.weaponskill == spell.english and info.aftermath.duration > 0 then

        local aftermath_name = 'Aftermath: Lv.'..tostring(info.aftermath.level)
        send_command('timers d "Aftermath: Lv.1"')
        send_command('timers d "Aftermath: Lv.2"')
        send_command('timers d "Aftermath: Lv.3"')
        send_command('timers c "'..aftermath_name..'" '..tostring(info.aftermath.duration)..' down abilities/00027.png')

        info.aftermath = {}
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Environment utility functions.
-------------------------------------------------------------------------------------------------------------------

-- Function to get the current weather intensity: 0 for none, 1 for single weather, 2 for double weather.
function get_weather_intensity()
    return gearswap.res.weather[world.weather_id].intensity
end


-- Call these function with a list of equipment slots to check ('head', 'neck', 'body', etc)
-- Returns true if any of the specified slots are currently encumbered.
-- Returns false if all specified slots are unencumbered.
function is_encumbered(...)
    local check_list = {...}
    -- Compensate for people passing a table instead of a series of strings.
    if type(check_list[1]) == 'table' then
        check_list = check_list[1]
    end
    local check_set = S(check_list)
    
    for slot_id,slot_name in pairs(gearswap.default_slot_map) do
        if check_set:contains(slot_name) then
            if gearswap.encumbrance_table[slot_id] then
                return true
            end
        end
    end
    
    return false
end


-------------------------------------------------------------------------------------------------------------------
-- Function to easily change to a given macro set or book.  Book value is optional.
-------------------------------------------------------------------------------------------------------------------

function set_macro_page(set,book)
    if not tonumber(set) then
        add_to_chat(123,'Error setting macro page: Set is not a valid number ('..tostring(set)..').')
        return
    end
    if set < 1 or set > 10 then
        add_to_chat(123,'Error setting macro page: Macro set ('..tostring(set)..') must be between 1 and 10.')
        return
    end

    if book then
        if not tonumber(book) then
            add_to_chat(123,'Error setting macro page: book is not a valid number ('..tostring(book)..').')
            return
        end
        if book < 1 or book > 20 then
            add_to_chat(123,'Error setting macro page: Macro book ('..tostring(book)..') must be between 1 and 20.')
            return
        end
        send_command('@input /macro book '..tostring(book)..';wait .1;input /macro set '..tostring(set))
    else
        send_command('@input /macro set '..tostring(set))
    end
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions for including local user files.
-------------------------------------------------------------------------------------------------------------------

-- Attempt to load user gear files in place of default gear sets.
-- Return true if one exists and was loaded.
function load_sidecar(job)
    if not job then return false end
    
    -- filename format example for user-local files: whm_gear.lua, or playername_whm_gear.lua
    local filenames = {player.name..'_'..job..'_gear.lua', job..'_gear.lua',
        'gear/'..player.name..'_'..job..'_gear.lua', 'gear/'..job..'_gear.lua',
        'gear/'..player.name..'_'..job..'.lua', 'gear/'..job..'.lua'}
    return optional_include(filenames)
end

-- Attempt to include user-globals.  Return true if it exists and was loaded.
function load_user_globals()
    local filenames = {player.name..'-globals.lua', 'user-globals.lua'}
    return optional_include(filenames)
end

-- Optional version of include().  If file does not exist, does not
-- attempt to load, and does not throw an error.
-- filenames takes an array of possible file names to include and checks
-- each one.
function optional_include(filenames)
    for _,v in pairs(filenames) do
        local path = gearswap.pathsearch({v})
        if path then
            include(v)
            return true
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions for vars or other data manipulation.
-------------------------------------------------------------------------------------------------------------------

-- Attempt to locate a specified name within the current alliance.
function find_player_in_alliance(name)
    for party_index,ally_party in ipairs(alliance) do
        for player_index,_player in ipairs(ally_party) do
            if _player.name == name then
                return _player
            end
        end
    end
end


-- buff_set is a set of buffs in a library table (any of S{}, T{} or L{}).
-- This function checks if any of those buffs are present on the player.
function has_any_buff_of(buff_set)
    return buff_set:any(
        -- Returns true if any buff from buff set that is sent to this function returns true:
        function (b) return buffactive[b] end
    )
end


-- Invert a table such that the keys are values and the values are keys.
-- Use this to look up the index value of a given entry.
function invert_table(t)
    if t == nil then error('Attempting to invert table, received nil.', 2) end
    
    local i={}
    for k,v in pairs(t) do 
        i[v] = k
    end
    return i
end


-- Gets sub-tables based on baseSet from the string str that may be in dot form
-- (eg: baseSet=sets, str='precast.FC', this returns the table sets.precast.FC).
function get_expanded_set(baseSet, str)
    local cur = baseSet
    for i in str:gmatch("[^.]+") do
        if cur then
            cur = cur[i]
        end
    end
    
    return cur
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions data and event tracking.
-------------------------------------------------------------------------------------------------------------------

-- This is a function that can be attached to a registered event for 'time change'.
-- It will send a call to the update() function if the time period changes.
-- It will also call job_time_change when any of the specific time class values have changed.
-- To activate this in your job lua, add this line to your user_setup function:
-- windower.register_event('time change', time_change)
--
-- Variables it sets: classes.Daytime, and classes.DuskToDawn.  They are set to true
-- if their respective descriptors are true, or false otherwise.
function time_change(new_time, old_time)
    local was_daytime = classes.Daytime
    local was_dusktime = classes.DuskToDawn
    
    if new_time >= 6*60 and new_time < 18*60 then
        classes.Daytime = true
    else
        classes.Daytime = false
    end

    if new_time >= 17*60 or new_time < 7*60 then
        classes.DuskToDawn = true
    else
        classes.DuskToDawn = false
    end
    
    if was_daytime ~= classes.Daytime or was_dusktime ~= classes.DuskToDawn then
        if job_time_change then
            job_time_change(new_time, old_time)
        end

        handle_update({'auto'})
    end
end


