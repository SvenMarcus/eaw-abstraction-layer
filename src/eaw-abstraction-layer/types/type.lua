local metatables = require "eaw-abstraction-layer.core.metatables"
local callback_return_method = metatables.callback_return_method

local function type(name)
    local obj = setmetatable({
        __eaw_type = "type"
    }, {
        __tostring = function(t)
            return t.Get_Name()
        end
    })

    obj.Get_Name = callback_return_method("Get_Name")
    function obj.Get_Name.return_value()
        return string.upper(name)
    end;

    return obj
end

return type