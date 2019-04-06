test(
    "When calling Register_Timer with valid arguments -> should not throw error",
    function()
        eaw.environment.Register_Timer(function() end, 2)
        eaw.environment.Register_Timer(function() end, 0, {})
    end
)

test(
    "When calling Register_Timer with invalid arguments -> should throw error",
    function()
        assert.has.errors(function() eaw.environment.Register_Timer(function() end) end)
        assert.has.errors(function() eaw.environment.Register_Timer(function() end, {}) end)
        assert.has.errors(function() eaw.environment.Register_Timer("", 0) end)
    end
)

test(
    "When calling Cancel_Timer with valid arguments -> should not throw error",
    function() eaw.environment.Cancel_Timer(function() end) end
)

test(
    "When calling Cancel_Timer with invalid arguments -> should throw error",
    function()
        assert.has.errors(function() eaw.environment.Cancel_Timer("") end)
    end
)

test(
    "When calling Register_Prox with valid arguments -> should not throw error",
    function()
        eaw.environment.Register_Prox(eaw.types.game_object{name = ""}, function() end, 0)
        eaw.environment.Register_Prox(eaw.types.unit_object{name = ""}, function() end, 0)
        eaw.environment.Register_Prox(
            eaw.types.game_object{name = ""},
            function() end,
            0,
            eaw.types.faction{name = ""}
        )
        eaw.environment.Register_Prox(
            eaw.types.unit_object{name = ""},
            function() end,
            0,
            eaw.types.faction{name = ""}
        )
    end
)

test(
    "When calling Register_Prox with invalid arguments -> should throw error",
    function()
        assert.has.errors(function()
            eaw.environment.Register_Prox(eaw.types.planet, function() end, 0)
        end)

        assert.has.errors(function()
            eaw.environment.Register_Prox(eaw.types.game_object{name = ""}, "", 0)
        end)

        assert.has.errors(function()
            eaw.environment.Register_Prox(eaw.types.game_object{name = ""}, function() end, "")
        end)

        assert.has.errors(function()
            eaw.environment.Register_Prox(eaw.types.game_object{name = ""}, function() end, 0, "")
        end)
    end
)

test(
    "When calling Register_Attacked_Event with valid arguments -> should not throw error",
    function()
        eaw.environment.Register_Attacked_Event(eaw.types.game_object{name = ""}, function() end)
        eaw.environment.Register_Attacked_Event(eaw.types.unit_object{name = ""}, function() end)
    end
)

test(
    "When calling Register_Attacked_Event with invalid arguments -> should throw error",
    function()
        assert.has.errors(function()
            eaw.environment.Register_Attacked_Event("", function() end)
        end)

        assert.has.errors(function()
            eaw.environment.Register_Attacked_Event(eaw.types.game_object{name = ""}, 0)
        end)
    end
)

test(
    "When calling Cancel_Attacked_Event with valid arguments -> should not throw error",
    function()
        eaw.environment.Cancel_Attacked_Event(eaw.types.game_object{name = ""})
        eaw.environment.Cancel_Attacked_Event(eaw.types.unit_object{name = ""})
    end
)

test(
    "When calling Cancel_Attacked_Event with invalid arguments -> should throw error",
    function()
        assert.has.errors(function() eaw.environment.Cancel_Attacked_Event(0) end)
    end
)

test(
    "When calling Register_Death_Event with valid arguments -> should not throw error",
    function()
        eaw.environment.Register_Death_Event(eaw.types.game_object{name = ""}, function() end)
        eaw.environment.Register_Death_Event(eaw.types.unit_object{name = ""}, function() end)
    end
)

test(
    "When calling Register_Death_Event with invalid arguments -> should throw error",
    function()
        assert.has.errors(function()
            eaw.environment.Register_Death_Event(0, function() end)
        end)

        assert.has.errors(function()
            eaw.environment.Register_Death_Event(eaw.types.game_object{name = ""}, {})
        end)
    end
)
