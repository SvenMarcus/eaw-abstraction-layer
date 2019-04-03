test(
    "When requiring a file inside run -> should not be in package.loaded after run",
    function()
        eaw.run(function() local stub = require "./test/core/file_stub" end)

        assert.is_nil(package.loaded["./test/core/file_stub"])
    end
)

test(
    "After initiating the environment with mod folder and running sandbox -> package path should be reset",
    function()
        local expected = tostring(package.path)

        eaw.init(".")
        eaw.run(function()
        end)

        assert.are.equal(expected, package.path)
    end
)

test(
    "When setting callback on function in initiated environment -> then running twice -> should only call callback once",
    function()
        local types = eaw.types
        local type = types.type
        local faction = types.faction
        local game_object = types.game_object
        local env = eaw.environment

        eaw.init("./examples/Mod")

        local spawn_unit_spy = spy.on(env, "Spawn_Unit")

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

        assert.spy(spawn_unit_spy).was.called(1)
    end
)

test(
    "After running sandbox -> global environment should not have any EaW specific functions",
    function()
        eaw.init()

        eaw.run(function() end)

        assert.is_nil(Find_First_Object)
        assert.is_nil(Find_All_Objects_Of_Type)
        assert.is_nil(Find_Nearest)
        assert.is_nil(FindPlanet)
        assert.is_nil(Find_Player)
        assert.is_nil(Find_Object_Type)
        assert.is_nil(Find_Hint)
        assert.is_nil(Find_Path)
        assert.is_nil(Register_Timer)
        assert.is_nil(Cancel_Timer)
        assert.is_nil(Register_Prox)
        assert.is_nil(Register_Attacked_Event)
        assert.is_nil(Cancel_Attacked_Event)
        assert.is_nil(Register_Death_Event)
        assert.is_nil(Spawn_Unit)
        assert.is_nil(SpawnList)
        assert.is_nil(Check_Story_Flag)
        assert.is_nil(Get_Story_Plot)
        assert.is_nil(Story_Event)
        assert.is_nil(Add_Planet_Highlight)
        assert.is_nil(BlockOnCommand)
        assert.is_nil(Create_Thread)
        assert.is_nil(EvaluatePerception)
        assert.is_nil(GetCurrentTime)
        assert.is_nil(Get_Game_Mode)
        assert.is_nil(Hide_Sub_Object)
        assert.is_nil(Sleep)
        assert.is_nil(Suspend_AI)
        assert.is_nil(TestValid)
        assert.is_nil(ScriptExit)
        assert.is_nil(GameRandom)
        assert.is_nil(DebugMessage)
    end
)