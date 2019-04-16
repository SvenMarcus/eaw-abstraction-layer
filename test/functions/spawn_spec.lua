test(
    "When calling Spawn_Unit() -> should return table containing unit object",
    function()
        local actual = eaw.environment.Spawn_Unit(
            eaw.types.type("DummyType"),
            eaw.types.game_object{name = "DummyPlanet"},
            eaw.types.faction{name = "DummyFaction"}
        )

        assert.is_true(type(actual) == "table")
        assert.is.unit_object(actual[1])
    end
)

test(
    "When calling Spawn_Unit() -> type of returned unit should match requested type",
    function()
        local expected = eaw.types.type("Expected_Type")
        local spawned = eaw.environment.Spawn_Unit(
            expected,
            eaw.types.game_object{name = "DummyPlanet"},
            eaw.types.faction{name = "DummyFaction"}
        )

        local actual = spawned[1].Get_Type()
        assert.are.equal(string.upper("Expected_Type"), actual.Get_Name())
    end
)

test(
    "When calling Spawn_Unit() -> should spawn at given location",
    function()
        local expected = eaw.types.planet{name = "Expected_Location"}
        local spawned = eaw.environment.Spawn_Unit(
            eaw.types.type("DummyType"),
            expected,
            eaw.types.faction{name = "DummyFaction"}
        )

        local actual = spawned[1].Get_Planet_Location()
        assert.are.equal(expected, actual)
    end
)

test(
    "When calling Spawn_Unit() -> owner of returned unit should match requested owner",
    function()
        local expected = eaw.types.faction{name = "Expected_Owner"}
        local spawned = eaw.environment.Spawn_Unit(
            eaw.types.type("DummyType"),
            eaw.types.game_object{name = "DummyPlanet"},
            expected
        )

        local actual = spawned[1].Get_Owner()
        assert.are.equal(expected, actual)
    end
)

test(
    "When calling SpawnList with table, planet, nil, boolean, boolean -> should fail",
    function()
        assert.has.errors(function()
            -- eaw.environment.SpawnList({}, eaw.types.planet {name = "Coruscant"}, nil, true, true)
            eaw.run(function()
                SpawnList({}, FindPlanet("Bla"), nil, true, true)
            end)
        end)
    end
)
