local eaw_env = require "environment"
local finders = require "finders"
local faction = require "faction"
local game_object = require "game_object"
local spawn = require "spawn"

local players = {
    ["EMPIRE"] = faction {
        name = "Empire",
        is_human = true
    },

    ["REBEL"] = faction {
        name = "Rebel",
        is_human = false
    }
}

local planets = {
    coruscant = game_object {
        name = "Coruscant",
        owner = players["EMPIRE"]
    },

    hoth = game_object {
        name = "Hoth",
        owner = players["REBEL"]
    }
}

local function configure_environment()

    function finders.Find_Player.return_value(faction_name)
        return players[string.upper(faction_name)]
    end

    function finders.Find_Object_Type.callback(faction_name)
        print("\nFind_Object_Type was called with "..faction_name)
    end

    function planets.coruscant.Change_Owner.callback(new_owner)
        print("\nChanged owner of Coruscant to "..new_owner.Get_Faction_Name())
    end

    function planets.hoth.Change_Owner.callback(new_owner)
        print("\nChanged owner of Hoth to "..new_owner.Get_Faction_Name())
    end

    function finders.FindPlanet.Get_All_Planets.return_value()
        return {
            planets.coruscant,
            planets.hoth
        }
    end

    function spawn.Spawn_Unit.callback(obj_type, location, owner)
        print("\nSpawned "..obj_type.Get_Name().." on "..location.Get_Type().Get_Name().." for "..owner.Get_Faction_Name())
    end

end


eaw_env.init("./examples/Mod")

local function test_eaw_module()
    configure_environment()

    
    eaw_env.run(function()
        require "eaw_module"
        my_eaw_function()
    end)

end

test_eaw_module()