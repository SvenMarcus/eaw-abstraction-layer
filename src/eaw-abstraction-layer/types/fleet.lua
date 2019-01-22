local metatables = require "eaw-abstraction-layer.core.metatables"
local callback_method = metatables.callback_method
local callback_return_method = metatables.callback_return_method

function fleet()
    local obj = {
        __eaw_type = "fleet"
    }

    obj.Get_Contained_Object_Count = callback_return_method("Get_Contained_Object_Count")
    function obj.Get_Contained_Object_Count.return_value()
        return 1
    end

    obj.Contains_Hero = callback_return_method("Contains_Hero")
    function obj.Contains_Hero.return_value()
        return false
    end

    obj.Contains_Object_Type = callback_return_method("Contains_Object_Type")
    function obj.Contains_Object_Type.return_value(_)
        return true
    end

    return obj
end

return fleet