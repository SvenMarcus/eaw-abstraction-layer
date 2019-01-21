local faction = require "eaw-abstraction-layer.types.faction"
local game_object = require "eaw-abstraction-layer.types.game_object"
local metatables = require "eaw-abstraction-layer.core.metatables"
local callback_method = metatables.callback_method
local callback_return_method = metatables.callback_return_method

local function planet(tab)

    local obj = game_object(tab)

    obj.Remove_Planet_Highlight = callback_method("Remove_Planet_Highlight")

    obj.Get_Final_Blow_Player = callback_return_method("Get_Final_Blow_Player")
    function obj.Get_Final_Blow_Player.return_value()
        return faction { name = "DummyFaction" }
    end

    return obj
end

return planet