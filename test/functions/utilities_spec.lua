test(
    "When calling GameRandom with number, number -> should return first number",
    function()
        local actual = eaw.environment.GameRandom(2, 7)

        local expected = 2
        assert.are.equal(expected, actual)
    end
)

test(
    "When calling GameRandom.GetFloat() -> should return 0",
    function()
        local actual = eaw.environment.GameRandom.GetFloat()

        local expected = 0
        assert.are.equal(expected, actual)
    end
)

test(
    "When calling BlockOnCommand with valid arguments -> should not fail",
    function()
        local obj = eaw.types.unit_object {name = "Dummy"}
        eaw.environment.BlockOnCommand(obj.Despawn())
        eaw.environment.BlockOnCommand(obj.Despawn(), 5)
        eaw.environment.BlockOnCommand(
            obj.Despawn(),
            5,
            function()
            end
        )
    end
)

test(
    "When calling Add_Planet_Highlight with valid arguments -> should not fail",
    function()
        local p = eaw.types.planet {name = "Dummy"}
        eaw.environment.Add_Planet_Highlight(p, "highlight")
    end
)

test(
    "When calling Add_Planet_Highlight with invalid arguments -> should fail",
    function()
        assert.has.errors(
            function()
                eaw.environment.Add_Planet_Highlight("", "highlight")
            end
        )

        assert.has.errors(
            function()
                local p = eaw.types.planet {name = "Dummy"}
                eaw.environment.Add_Planet_Highlight(p, 0)
            end
        )
    end
)

test(
    "When calling EvaluatePerception with valid arguments -> should return 1",
    function()
        local actual = eaw.environment.EvaluatePerception("Perception", eaw.types.faction {name = "Dummy"})

        local expected = 1
        assert.are.equal(expected, actual)

        actual =
            eaw.environment.EvaluatePerception(
            "Perception",
            eaw.types.faction {name = "Dummy"},
            eaw.types.game_object {name = "Dumy"}
        )

        assert.are.equal(expected, actual)
    end
)

test(
    "When calling EvaluatePerception with invalid arguments -> should throw error",
    function()
        assert.has.errors(
            function()
                eaw.environment.EvaluatePerception(0, eaw.types.faction {name = "Dummy"})
            end
        )

        assert.has.errors(
            function()
                eaw.environment.EvaluatePerception("Perception", 0)
            end
        )
    end
)

test(
    "When calling Assemble_Fleet with valid arguments -> should not throw error",
    function()
        eaw.environment.Assemble_Fleet({})
    end
)

test(
    "When calling Assemble_Fleet with valid arguments -> should return fleet",
    function()
        local actual = eaw.environment.Assemble_Fleet({})
        assert.is.fleet(actual)
    end
)

test(
    "When calling Assemble_Fleet with invalid arguments -> should throw error",
    function()
        assert.has.errors(function()
            eaw.environment.Assemble_Fleet(0)
        end)
    end
)