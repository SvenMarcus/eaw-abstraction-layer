local eaw = require "eaw-abstraction-layer"
local assert = require "luassert"
local spy = require "luassert.spy"

test["When requiring a file inside run -> should not be in package.loaded after run"] = function()
    eaw.run(function() local stub = require "./test/core/file_stub" end)

    test.is_nil(package.loaded["./test/core/file_stub"])
end

test["When setting callback on function in initiated environment -> then running twice -> should only call callback once"] = function()
    local types = eaw.types
    local type = types.type
    local faction = types.faction
    local game_object = types.game_object
    local env = eaw.environment

    eaw.init("./examples/Mod")

    local times_called_spawn_unit = 0
    function env.Spawn_Unit.callback() times_called_spawn_unit = times_called_spawn_unit + 1 end

    eaw.run(function()
        Spawn_Unit(
            type("DUMMY"),
            game_object{name = "DUMMY"},
            faction{name = "DUMMY"}
        )
    end)

    eaw.run(function()
        Spawn_Unit(
            type("DUMMY"),
            game_object{name = "DUMMY"},
            faction{name = "DUMMY"}
        )
    end)

    local expected = 1
    test.equal(expected, times_called_spawn_unit)
end


test["After running sandbox -> global environment should not have any EaW specific functions"] = function()
    eaw.init()

    eaw.run(function()
    end)

    test.is_nil(Find_First_Object)
    test.is_nil(Find_All_Objects_Of_Type)
    test.is_nil(Find_Nearest)
    test.is_nil(FindPlanet)
    test.is_nil(Find_Player)
    test.is_nil(Find_Object_Type)
    test.is_nil(Find_Hint)
    test.is_nil(Find_Path)
    test.is_nil(Register_Timer)
    test.is_nil(Cancel_Timer)
    test.is_nil(Register_Prox)
    test.is_nil(Register_Attacked_Event)
    test.is_nil(Cancel_Attacked_Event)
    test.is_nil(Register_Death_Event)
    test.is_nil(Spawn_Unit)
    test.is_nil(SpawnList)
    test.is_nil(Check_Story_Flag)
    test.is_nil(Get_Story_Plot)
    test.is_nil(Story_Event)
    test.is_nil(Add_Planet_Highlight)
    test.is_nil(BlockOnCommand)
    test.is_nil(Create_Thread)
    test.is_nil(EvaluatePerception)
    test.is_nil(GetCurrentTime)
    test.is_nil(Get_Game_Mode)
    test.is_nil(Hide_Sub_Object)
    test.is_nil(Sleep)
    test.is_nil(Suspend_AI)
    test.is_nil(TestValid)
    test.is_nil(ScriptExit)
    test.is_nil(GameRandom)
    test.is_nil(DebugMessage)
end