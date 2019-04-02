local make_type = require "eaw-abstraction-layer.types.type"
local metatables = require "eaw-abstraction-layer.core.metatables"
local method = metatables.method

-- @usage
-- game_object {
--     name = "Type_Name",
--     owner = faction_object
-- }
local function game_object(tab)

    local obj = { __eaw_type = "game_object" }

    obj.Get_Owner = method("Get_Owner")
    function obj.Get_Owner.return_value()
        return tab.owner
    end

    obj.Change_Owner = method("Change_Owner")
    obj.Change_Owner.expected = {
        "faction"
    }
    function obj.Change_Owner.callback(owner)
        tab.owner = owner
    end

    local type = make_type(tab.name)

    obj.Get_Type = method("Get_Type")
    function obj.Get_Type.return_value()
        return type
    end

    return obj
end

return game_object