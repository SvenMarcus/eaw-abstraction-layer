local game_object = require "eaw-abstraction-layer.types.game_object"
local faction = require "eaw-abstraction-layer.types.faction"
local planet = require "eaw-abstraction-layer.types.planet"
local make_type = require "eaw-abstraction-layer.types.type"
local metatables = require "eaw-abstraction-layer.core.metatables"
local callback_return_method = metatables.callback_return_method
local arguments = metatables.arguments

local function dummy_faction()
    return faction {name = "Dummy_Faction", is_human = false}
end

local function dummy_game_object()
    return game_object {name = "Dummy_Object", owner = dummy_faction()}
end

local function dummy_planet()
    return planet { name = "Dummy_Planet", owner = dummy_faction() }
end

local function finders()
    local Find_First_Object = callback_return_method("Find_First_Object")
    Find_First_Object.expected = arguments { "string" }
    function Find_First_Object.return_value(type_name)
        return game_object { name = type_name, owner = dummy_faction() }
    end

    local Find_All_Objects_Of_Type = callback_return_method("Find_All_Objects_Of_Type")
    Find_All_Objects_Of_Type.expected = arguments { "string" }
    function Find_All_Objects_Of_Type.return_value(type_name)
        return { game_object { name = type_name, owner = dummy_faction() } }
    end

    local Find_Nearest = callback_return_method("Find_Nearest")
    Find_Nearest.expected = arguments {
        {"game_object", "faction", "boolean"},
        {"unit_object", "faction", "boolean"},
        {"game_object", "string", "faction", "boolean"},
        {"unit_object", "string", "faction", "boolean"},
        {"task_force", "faction", "boolean"},
        {"task_force", "string", "faction", "boolean"}
    }
    function Find_Nearest.return_value()
        return dummy_game_object()
    end

    local FindPlanet = callback_return_method("FindPlanet")
    FindPlanet.expected = arguments { "string" }
    function FindPlanet.return_value(planet_name)
        return planet { name = planet_name, owner = dummy_faction() }
    end

    FindPlanet.Get_All_Planets = callback_return_method("Get_All_Planets")
    function FindPlanet.Get_All_Planets.return_value()
        return { dummy_planet() }
    end

    local Find_Player = callback_return_method("Find_Player")
    Find_Player.expected = arguments { "string" }
    function Find_Player.return_value(name)
        return faction {name = name, is_human = false}
    end

    local Find_Object_Type = callback_return_method("Find_Object_Type")
    Find_Object_Type.expected = arguments { "string" }
    function Find_Object_Type.return_value(name)
        local type = make_type(name)
        return type
    end

    local Find_Hint = callback_return_method("Find_Hint")
    Find_Hint.expected = arguments { "string", "string" }
    function Find_Hint.return_value(name, hint)
        return game_object { name = name, owner = dummy_faction() }
    end

    local Find_Path = callback_return_method("Find_Path")
    function Find_Path.return_value()
        return { dummy_game_object() }
    end


    return {
        Find_First_Object = Find_First_Object,
        Find_All_Objects_Of_Type = Find_All_Objects_Of_Type,
        Find_Nearest = Find_Nearest,
        FindPlanet = FindPlanet,
        Find_Player = Find_Player,
        Find_Object_Type = Find_Object_Type,
        Find_Hint = Find_Hint
    }
end

return finders