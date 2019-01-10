local assert = require "luassert"

local function match_eaw_type(expected, actual)
    if type(expected) == "table" and expected.Get_Name then
        return expected.Get_Name() == actual.Get_Name()
    end

    return string.upper(expected) == actual.Get_Name()
end

local function eaw_type(state, args)
    local expected = args[1]
    return function(value)
        return match_eaw_type(expected, value)
    end;
end

local function match_faction(expected, actual)
    if type(expected) == "table" and expected.Get_Faction_Name then
        return expected.Get_Faction_Name() == actual.Get_Faction_Name()
    end

    return string.upper(expected) == actual.Get_Faction_Name()
end

local function faction(state, args)
    local expected = args[1]
    return function(value)
        return match_faction(expected, value)
    end;
end

local function game_object(state, args)
    local expected = args[1]
    return function(value)
        local matches = true
        if expected.Get_Type then
            local expected_eaw_type = expected.Get_Type()
            local expected_owner = expected.Get_Owner()

            matches = matches and match_eaw_type(expected_eaw_type, value.Get_Type())
            matches = matches and match_faction(expected_owner, value.Get_Owner())
            return matches
        end

        if expected.name then
            matches = matches and match_eaw_type(expected.name, value.Get_Type())
        end

        if expected.owner then
            matches = matches and match_faction(expected.owner, value.Get_Owner())
        end

        return matches
    end;
end

assert:register("matcher", "eaw_type", eaw_type)
assert:register("matcher", "faction", faction)
assert:register("matcher", "game_object", game_object)