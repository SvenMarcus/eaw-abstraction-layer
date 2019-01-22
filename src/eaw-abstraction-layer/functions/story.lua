local story_types = require "eaw-abstraction-layer.types.story"
local metatables = require "eaw-abstraction-layer.core.metatables"
local callback_method = metatables.callback_method
local callback_return_method = metatables.callback_return_method


local function story()
    local Check_Story_Flag = callback_return_method("Check_Story_Flag")
    function Check_Story_Flag.return_value()
        return false
    end

    local Get_Story_Plot = callback_return_method("Get_Story_Plot")
    function Get_Story_Plot.return_value()
        return story_types.plot()
    end;

    local Story_Event = callback_method("Story_Event")

    return {
        Check_Story_Flag = Check_Story_Flag,
        Get_Story_Plot = Get_Story_Plot,
        Story_Event = Story_Event
    }
end

return story