local metatables = require "eaw-abstraction-layer.core.metatables"
local method = metatables.method
local vararg_method = metatables.vararg_method

local function utilities()

    --TODO: verify signature
    local Add_Planet_Highlight = method("Add_Planet_Highlight")
    Add_Planet_Highlight.expected = {
        {"planet", "string"}
    }

    --TODO: the first argument of BlockOnCommand is a method call, how can we check this?
    local BlockOnCommand = method("BlockOnCommand")
    BlockOnCommand.expected = {
        {"any"},
        {"any", "number"},
        {"any", "number", "function"}
    }

    --TODO: Create_Thread can take any amount of additional arguments, we need real vararg support to do that
    local Create_Thread = vararg_method("Create_Thread")

    local EvaluatePerception = method("EvaluatePerception")
    EvaluatePerception.expected = {
        {"string", "faction"},
        {"string", "faction", "any"}
    }

    function EvaluatePerception.return_value()
        return 1
    end

    local GetCurrentTime = method("Get_Current_Time")
    function GetCurrentTime.return_value()
        return 0
    end

    local Get_Game_Mode = method("Get_Game_Mode")
    function Get_Game_Mode.return_value()
        return "Galactic"
    end

    local Hide_Sub_Object = method("Hide_Sub_Object")
    Hide_Sub_Object.expected = {
        {"game_object", "number", "string"},
        {"unit_object", "number", "string"}
    }

    local Sleep = method("Sleep")
    Sleep.expected = {
        "number"
    }

    local Suspend_AI = method("Suspend_AI")
    Suspend_AI.expected = {
        "number"
    }

    local TestValid = method("TestValid")
    TestValid.expected = {
        {"game_object"},
        {"unit_object"},
        {"planet"},
        {"faction"},
        {"fleet"}
    }
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
            __call = method("Game_Random")
        }
        random_mt.__call.expected = {
            "number", "number"
        }

        function random_mt.__call.return_value(min, max)
            return min
        end

        local obj = setmetatable({}, random_mt)

        obj.GetFloat = method("GetFloat")
        function obj.GetFloat.return_value()
            return 0
        end

        return obj
    end

    return {
        Add_Planet_Highlight = Add_Planet_Highlight,
        BlockOnCommand = BlockOnCommand;
        Create_Thread = Create_Thread,
        EvaluatePerception = EvaluatePerception,
        GetCurrentTime = GetCurrentTime,
        Get_Game_Mode = Get_Game_Mode,
        Hide_Sub_Object = Hide_Sub_Object,
        Sleep = Sleep;
        Suspend_AI = Suspend_AI,
        TestValid = TestValid,
        ScriptExit = ScriptExit,
        GameRandom = GameRandom(),
        DebugMessage = function(...) print(string.format(...)) end
    }
end

return utilities