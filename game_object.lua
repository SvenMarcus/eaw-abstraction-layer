local make_type = require "type"
local metatables = require "metatables"
local callback_method = metatables.callback_method
local callback_return_method = metatables.callback_return_method


local function game_object(tab)

    local obj = setmetatable({}, {
        __tostring = function(_)
            return tab.name
        end;
    })

    obj.Despawn = callback_method("Despawn")

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