require "eaw-abstraction-layer.test_framework.custom_assertions"

test(
    "When calling assert.is.eaw_type with EaW Type -> should not fail",
    function() assert.is.eaw_type(eaw.types.type("Dummy")) end
)

test(
    "When calling assert.is_not.eaw_type with EaW Type -> should throw error",
    function()
        assert.has_errors(function() assert.is_not.eaw_type(eaw.types.type("Dummy")) end)
    end
)

test(
    "When calling assert.is.faction with Faction -> should not fail",
    function()
        assert.is.faction(eaw.types.faction{name = "Dummy"})
    end
)

test(
    "When calling assert.is_not.faction with Faction -> should throw error",
    function()
        assert.has_errors(function()
            assert.is_not.faction(eaw.types.faction{name = "Dummy"})
        end)
    end
)

test(
    "When calling assert.is.fleet with Fleet -> should not fail",
    function() assert.is.fleet(eaw.types.fleet()) end
)

test(
    "When calling assert.is_not.fleet with Fleet -> should throw error",
    function()
        assert.has_errors(function() assert.is_not.fleet(eaw.types.fleet()) end)
    end
)

test(
    "When calling assert.is.game_object with game_object -> should not fail",
    function()
        assert.is.game_object(eaw.types.game_object{name = "Dummy"})
    end
)

test(
    "When calling assert.is_not.game_object with game_object -> should throw error",
    function()
        assert.has_errors(function()
            assert.is_not.game_object(eaw.types.game_object{name = "Dummy"})
        end)
    end
)

test(
    "When calling assert.is.planet with planet -> should not fail",
    function() assert.is.planet(eaw.types.planet{name = "Dummy"}) end
)

test(
    "When calling assert.is_not.planet with planet -> should throw error",
    function()
        assert.has_errors(function()
            assert.is_not.planet(eaw.types.planet{name = "Dummy"})
        end)
    end
)

test(
    "When calling assert.is.unit_object with unit_object -> should not fail",
    function()
        assert.is.unit_object(eaw.types.unit_object{name = "Dummy"})
    end
)

test(
    "When calling assert.is_not.unit_object with unit_object -> should throw error",
    function()
        assert.has_errors(function()
            assert.is_not.unit_object(eaw.types.unit_object{name = "Dummy"})
        end)
    end
)

test(
    "When calling assert.is.plot with plot -> should not fail",
    function() assert.is.plot(eaw.types.story.plot()) end
)

test(
    "When calling assert.is_not.plot with plot -> should throw error",
    function()
        assert.has_errors(function() assert.is_not.plot(eaw.types.story.plot()) end)
    end
)

test(
    "When calling assert.is.event with event -> should not fail",
    function() assert.is.event(eaw.types.story.event()) end
)

test(
    "When calling assert.is_not.event with event -> should throw error",
    function()
        assert.has_errors(function() assert.is_not.event(eaw.types.story.event()) end)
    end
)

test(
    "When calling assert.is.task_force with task_force -> should not fail",
    function() assert.is.task_force(eaw.types.task_force()) end
)

test(
    "When calling assert.is_not.task_force with event -> should throw error",
    function()
        assert.has_errors(function() assert.is_not.task_force(eaw.types.task_force()) end)
    end
)
