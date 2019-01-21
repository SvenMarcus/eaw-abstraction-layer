local metatables = require "eaw-abstraction-layer.core.metatables"
local callback_method = metatables.callback_method
local callback_return_method = metatables.callback_return_method

local function faction(tab)
    local obj = setmetatable({}, {
        __tostring = function(_)
            return tab.name
        end
    })

    obj.Get_Faction_Name = callback_return_method("Get_Faction_Name")
    function obj.Get_Faction_Name.return_value()
        return string.upper(tab.name)
    end

    obj.Is_Human = callback_return_method("Is_Human")
    function obj.Is_Human.return_value()
        return tab.is_human or false
    end

    obj.Get_Tech_Level = callback_return_method("Get_Tech_Level")
    function obj.Get_Tech_Level.return_value()
        return 1
    end

    obj.Make_Ally = callback_method("Make_Ally")

    return obj
end

return faction

