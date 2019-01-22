local make_type = require "eaw-abstraction-layer.types.type"
local metatables = require "eaw-abstraction-layer.core.metatables"
local callback_method = metatables.callback_method
local callback_return_method = metatables.callback_return_method

-- @usage
-- game_object {
--     name = "Type_Name",
--     owner = faction_object
-- }
local function game_object(tab)

    local obj = setmetatable({
        __eaw_type = "game_object"
    }, {
        __tostring = function(_)
            return tab.name
        end;
    })

    obj.Get_Owner = callback_return_method("Get_Owner")
    function obj.Get_Owner.return_value()
        return tab.owner
    end

    obj.Change_Owner = callback_method("Change_Owner")
    function obj.Change_Owner.callback(owner)
        tab.owner = owner
    end

    local type = make_type(tab.name)

    obj.Get_Type = callback_return_method("Get_Type")
    function obj.Get_Type.return_value()
        return type
    end

    return obj
end

return game_object