local test = require "eaw-abstraction-layer.util.u-test"

local function wrong_type_message(expected_type, actual)
    local msg = type(actual)
    if actual.Get_Type then
        msg = actual.Get_Type()
    end

    return "Expected '"..expected_type.."'. Got: "..tostring(msg)
end

local function matches_eaw_type(expected, actual)
    local msg

    if type(actual) ~= "table" or not actual.Get_Name then
        return false, wrong_type_message("type", actual)
    end

    msg = "Type does not match:\n"
    local actual_msg = msg.."Actual: "..actual.Get_Name()

    if type(expected) == "table" and expected.Get_Name then
        msg = msg.."Expected: "..expected.Get_Name()..actual_msg
        return expected.Get_Name() == actual.Get_Name(), msg
    end

    msg = msg.."Expected: "..string.upper(expected)..actual_msg
    return string.upper(expected) == actual.Get_Name(), msg
end

local function matches_faction(expected, actual)
    if type(actual) ~= "table" or not actual.Get_Faction_Name then
        local got = type(actual)
        if actual.Get_Type then
            got = actual.Get_Type()
        end
        return false, "Expected EaW type. Got: "..got
    end

    if type(expected) == "table" and expected.Get_Faction_Name then
        return expected.Get_Faction_Name() == actual.Get_Faction_Name()
    end

    return string.upper(expected) == actual.Get_Faction_Name()
end

local function matches_game_object(expected, actual)
    local matches = true
    local base_msg, msg = "Game object does not match:\n", ""
    if expected.Get_Type then
        local expected_eaw_type = expected.Get_Type()
        local expected_owner = expected.Get_Owner()

        matches, msg = matches_eaw_type(expected_eaw_type, actual.Get_Type())
        if not matches then
            return matches, base_msg..msg
        end

        matches, msg = matches_faction(expected_owner, actual.Get_Owner())
        if not matches then
            return matches, base_msg..msg
        end
    end

    if expected.name then
        matches, msg = matches_eaw_type(expected.name, actual.Get_Type())
        if not matches then
            return matches, base_msg..msg
        end
    end

    if expected.owner then
        matches, msg = matches_faction(expected.owner, actual.Get_Owner())
        if not matches then
            return matches, base_msg..msg
        end
    end

    return false, "Not enough data for comparison"
end

test.register_assert("is_eaw_type", matches_eaw_type)
test.register_assert("is_faction", matches_faction)
test.register_assert("is_game_object", matches_game_object)