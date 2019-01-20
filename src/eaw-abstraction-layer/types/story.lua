local metatables = require "eaw-abstraction-layer.core.metatables"
local callback_method = metatables.callback_method
local callback_return_method = metatables.callback_return_method

local function event()
    local obj = {}

    obj.Set_Event_Parameter = callback_method("Set_Event_Parameter")
    obj.Set_Reward_Parameter = callback_method("Set_Reward_Parameter")

    return obj
end

local function plot()
    local obj = {}
    obj.Get_Event = callback_return_method("Get_Event")
    function obj.Get_Event.return_value()
        return event()
    end

    obj.Activate = callback_method("Activate")
    obj.Suspend = callback_method("Suspend")
    obj.Reset = callback_method("Reset")

    return obj
end

return {
    plot = plot,
    event =event
}