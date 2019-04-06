context(
    "Function argument checking",
    function()

        local metatables = require "eaw-abstraction-layer.core.metatables"
        local method = metatables.method

        local game_object = require "eaw-abstraction-layer.types.game_object"
        local faction = require "eaw-abstraction-layer.types.faction"

        test(
            "Given method expecting number -> when receiving string -> should throw error",
            function()
                local sut = method("sut")
                sut.expected = {"number"}

                assert.has.errors(function() sut("") end)
            end
        )

        test(
            "Given method expecting number -> when receiving number -> should not throw error",
            function()
                local sut = method("sut")
                sut.expected = {"number"}

                sut(0)
            end
        )

        test(
            "Given method expecting string -> when receiving number -> should throw error",
            function()
                local sut = method("sut")
                sut.expected = {"string"}

                assert.has.errors(function() sut(0) end)
            end
        )

        test(
            "Given method expecting (number, number) -> when receiving (number, string) -> should throw error",
            function()
                local sut = method("sut")
                sut.expected = {"number", "number"}

                assert.has.errors(function() sut(0, "") end)
            end
        )

        test(
            "Given method expecting number or string -> when receiving number -> should not throw error",
            function()
                local sut = method("sut")
                sut.expected = {{"number"}, {"string"}}

                sut(0)
            end
        )

        test(
            "Given method expecting number or string -> when receiving boolean -> should throw error",
            function()
                local sut = method("sut")
                sut.expected = {{"number"}, {"string"}}

                assert.has.errors(function() sut(true) end)
            end
        )

        test(
            "Given method expecting number or string -> when receiving table -> should throw error",
            function()
                local sut = method("sut")
                sut.expected = {{"number"}, {"string"}}

                assert.has.errors(function() sut({}) end)
            end
        )

        test(
            "Given method expecting number or string -> when receiving string -> should not throw error",
            function()
                local sut = method("sut")
                sut.expected = {{"number"}, {"string"}}

                sut("")
            end
        )

        test(
            "Given method expecting number, string or boolean -> when receiving boolean -> should not throw error",
            function()
                local sut = method("sut")
                sut.expected = {{"number"}, {"string"}, {"boolean"}}

                sut(true)
            end
        )

        test(
            "Given method expecting (number, table) or string -> when receiving (number, string) -> should throw error",
            function()
                local sut = method("sut")
                sut.expected = {{"number", "table"}, {"string"}}

                assert.has.errors(function() sut(0, "") end)
            end
        )

        test(
            "Given method expecting number -> when receiving nothing -> should throw error",
            function()
                local sut = method("sut")

                sut.expected = {"number"}

                assert.has.errors(function() sut() end)
            end
        )

        test(
            "Given method expecting nothing -> when receiving nothing -> should not throw error",
            function()
                local sut = method("sut")

                sut.expected = {}

                sut()
            end
        )

        test(
            "Given method without defining expected args -> when receiving nothing -> should not throw error",
            function()
                local sut = method("sut")

                sut()
            end
        )

        test(
            "Given method expecting (number, number) -> when receiving number -> should throw error",
            function()
                local sut = method("sut")
                sut.expected = {"number", "number"}

                assert.has.errors(function() sut(0) end)
            end
        )

        test(
            "Given method expecting (number, table) or string -> when receiving number -> should throw error",
            function()
                local sut = method("sut")
                sut.expected = {{"number", "table"}, {"string"},}

                assert.has.errors(function() sut(0) end)
            end
        )

        test(
            "Given method expecting string or (number, table) -> when receiving (number, table) -> should not throw error",
            function()
                local sut = method("sut")
                sut.expected = {{"string"}, {"number", "table"}}

                sut(0, {})
            end
        )

        test(
            "Given method expecting game_object -> when receiving game_object -> should not throw error",
            function()
                local sut = method("sut")
                sut.expected = {"game_object"}

                sut({__eaw_type = "game_object"})
            end
        )

        test(
            "Given method expecting game_object -> when receiving faction -> should throw error",
            function()
                local sut = method("sut")
                sut.expected = {"game_object"}

                assert.has.errors(function() sut({__eaw_type = "faction"}) end)
            end
        )
        test(
            "Given method expecting game_object or faction -> when receiving game_object -> should not throw error",
            function()
                local sut = method("sut")
                sut.expected = {{"game_object"}, {"faction"}}

                sut({__eaw_type = "game_object"})
            end
        )

        test(
            "Given method expecting 'any' argument type -> when receiving number -> should not throw error",
            function()
                local sut = method("sut")
                sut.expected = {"any"}

                sut(0)
            end
        )

        test(
            "Given method expecting number or 'any' argument type -> when receiving table -> should not throw error",
            function()
                local sut = method("sut")
                sut.expected = {{"number"}, {"any"}}

                sut({})
            end
        )
    end
)
