local metatables = require "eaw-abstraction-layer.core.metatables"
local callback_method = metatables.callback_method
local callback_return_method = metatables.callback_return_method

local function utilities()
    local Add_Planet_Highlight = callback_method("Add_Planet_Highlight")

    local Hide_Sub_Object = callback_method("Hide_Sub_Object")

    local SuspendAI = callback_method("SuspendAI")

    local Get_Game_Mode = callback_return_method("Get_Game_Mode")
    function Get_Game_Mode.return_value()
        return "Galactic"
    end

    local TestValid = callback_return_method("TestValid")
    function TestValid.return_value()
        return false
    end

    local function ScriptExit()
        print("Script exited by ScriptExit() call")
        coroutine.yield()
    end

    -- GameRandom is a special case. It can be called as a function or as an object with the method GetFloat()
    local function GameRandom()
        local random_mt = {
            __call = callback_return_method("Game_Random")
        }

        function random_mt.__call.return_value(min, max)
            return min
        end

        local obj = setmetatable({}, random_mt)

        obj.GetFloat = callback_return_method("GetFloat")
        function obj.GetFloat.return_value()
            return 0
        end

        return obj
    end

    return {
        BlockOnCommand = callback_method("BlockOnCommand");
        Sleep = callback_method("Sleep");
        TestValid = TestValid,
        Get_Game_Mode = Get_Game_Mode,
        ScriptExit = ScriptExit,
        GameRandom = GameRandom(),
        DebugMessage = function(...) print(string.format(...)) end
    }
end

return utilities