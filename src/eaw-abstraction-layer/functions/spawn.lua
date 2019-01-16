local unit_object = require "eaw-abstraction-layer.types.unit_object"
local metatables = require "eaw-abstraction-layer.core.metatables"
local callback_return_method = metatables.callback_return_method

local function spawn()
    local Spawn_Unit = callback_return_method("Spawn_Unit")
    function Spawn_Unit.return_value(obj_type, location, owner)
        local unit = unit_object {
            name = obj_type.Get_Name(),
            owner = owner
        }

        function unit.Get_Planet_Location.return_value()
            return location
        end

        return { unit }
    end

    return {
        Spawn_Unit = Spawn_Unit,
        SpawnList = callback_return_method("SpawnList")
    }
end

return spawn