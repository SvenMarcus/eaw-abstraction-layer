local metatables = require "eaw-abstraction-layer.core.metatables"
local callback_method = metatables.callback_method
local callback_return_method = metatables.callback_return_method

local function utilities()
    local TestValid = callback_return_method("TestValid")
    function TestValid.return_value()
        return false
    end

    local Get_Game_Mode = callback_return_method("Get_Game_Mode")
    function Get_Game_Mode.return_value()
        return "Galactic"
    end

    local function ScriptExit()
        print("Script exited by ScriptExit() call")
        coroutine.yield()
    end

    return {
        BlockOnCommand = callback_method("BlockOnCommand");
        Sleep = callback_method("Sleep");
        TestValid = TestValid,
        Get_Game_Mode = Get_Game_Mode,
        ScriptExit = ScriptExit,
        DebugMessage = function(...) print(...) end
    }
end

return utilities