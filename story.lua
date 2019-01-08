local metatables = require "metatables"
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

    return obj
end

local Get_Story_Plot = callback_return_method("Get_Story_Plot")
function Get_Story_Plot.return_value()
    return plot()
end;


return {
    event = event,
    plot = plot,
    Get_Story_Plot = Get_Story_Plot,
    Story_Event = callback_method("Story_Event")
}