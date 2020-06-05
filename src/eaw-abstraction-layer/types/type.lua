local metatables = require "eaw-abstraction-layer.core.metatables"
local method = metatables.method

local function type(name)
    local obj = setmetatable({
        __eaw_type = "type"
    }, {
        __tostring = function(t)
            return t.Get_Name()
        end
    })

    obj.Get_Name = method("Get_Name")
    function obj.Get_Name.return_value()
        return string.upper(name)
    end

    obj.Get_Combat_Rating = method("Get_Combat_Rating")
    function obj.Get_Combat_Rating.return_value()
        return tab.combat_rating or 1
    end

    obj.Is_Hero = method("Is_Hero")
    function obj.Is_Hero.return_value()
        return tab.hero or false
    end;

    return obj
end

return type