-------------------------------------------------------------------------------------------------------------------
-- General utility functions that can be used by any job files.
-- Outside the scope of what the main include file deals with.
-------------------------------------------------------------------------------------------------------------------

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
