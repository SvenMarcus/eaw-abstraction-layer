local metatables = require "eaw-abstraction-layer.metatables"
local callback_return_method = metatables.callback_return_method
local game_object = require "eaw-abstraction-layer.game_object"
local faction = require "eaw-abstraction-layer.faction"
local make_type = require "eaw-abstraction-layer.type"

local function dummy_faction()
    return faction {name = "Dummy_Faction", is_human = false}
end

local function dummy_game_object()
    return game_object {name = "Dummy_Object", owner = dummy_faction()}
end

local Find_First_Object = callback_return_method("Find_First_Object")
function Find_First_Object.return_value(type_name)
    return game_object { name = type_name, owner = dummy_faction() }
end

local Find_All_Objects_Of_Type = callback_return_method("Find_All_Objects_Of_Type")
function Find_All_Objects_Of_Type.return_value()
    return { dummy_game_object() }
end

local Find_Nearest = callback_return_method("Find_Nearest")
function Find_Nearest.return_value(type_name)
    return game_object { name = type_name, owner = dummy_faction() }
end

local FindPlanet = callback_return_method("FindPlanet")
function FindPlanet.return_value(planet_name)
    return game_object { name = planet_name, owner = dummy_faction() }
end

FindPlanet.Get_All_Planets = callback_return_method("Get_All_Planets")
function FindPlanet.Get_All_Planets.return_value()
    return { dummy_game_object() }
end

local Find_Player = callback_return_method("Find_Player")
function Find_Player.return_value(name)
    return faction {name = name, is_human = false}
end

local Find_Object_Type = callback_return_method("Find_Object_Type")
function Find_Object_Type.return_value(name)
    local type = make_type(name)
    return type
end


return {
    Find_First_Object = Find_First_Object,
    Find_All_Objects_Of_Type = Find_All_Objects_Of_Type,
    Find_Nearest = Find_Nearest,
    FindPlanet = FindPlanet,
    Find_Player = Find_Player,
    Find_Object_Type = Find_Object_Type
}


