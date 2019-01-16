local eal = require "eaw-abstraction-layer"
local environment = eal.environment
local faction = eal.types.faction
local game_object = eal.types.game_object

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
    },

    kuat = game_object {
        name = "Kuat",
        owner = players["REBEL"]
    }
}

local function configure_environment()

    function environment.Find_Player.return_value(faction_name)
        return players[string.upper(faction_name)]
    end

    function environment.Find_Object_Type.callback(faction_name)
        print("\nFind_Object_Type was called with "..faction_name)
    end

    function planets.coruscant.Change_Owner.callback(new_owner)
        print("\nChanged owner of Coruscant to "..new_owner.Get_Faction_Name())
    end

    function planets.hoth.Change_Owner.callback(new_owner)
        print("\nChanged owner of Hoth to "..new_owner.Get_Faction_Name())
    end

    function planets.kuat.Change_Owner.callback(new_owner)
        print("\nChanged owner of Kuat to "..new_owner.Get_Faction_Name())
    end

    function environment.FindPlanet.Get_All_Planets.return_value()
        return {
            planets.coruscant,
            planets.hoth,
            planets.kuat
        }
    end

    function environment.Spawn_Unit.callback(obj_type, location, owner)
        print("\nSpawned "..obj_type.Get_Name().." on "..location.Get_Type().Get_Name().." for "..owner.Get_Faction_Name())
    end

end

return configure_environment