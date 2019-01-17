local eaw = require "eaw-abstraction-layer"
local game_object = eaw.types.game_object
local faction = eaw.types.faction
local make_type = eaw.types.type
local spawn = require "eaw-abstraction-layer.functions.spawn" ()

test["Given defined Spawn_Unit.callback() -> when calling Spawn_Unit() inside sandbox -> Spawn_Unit.callback() should be called"] = function()
    local called_spawn_unit = false
    function eaw.environment.Spawn_Unit.callback()
        called_spawn_unit = true
    end

    eaw.run(function()
        Spawn_Unit(make_type("DummyType"), game_object { name = "DummyPlanet" }, faction { name = "DummyFaction" })
    end)

    test.is_true(called_spawn_unit)
end

test["When calling Spawn_Unit() -> should return table containing game object"] = function()
    local spawned = spawn.Spawn_Unit(make_type("DummyType"), game_object { name = "DummyPlanet" }, faction { name = "DummyFaction" })

    local actual = spawned[1]
    test.is_table(actual)
end

test["When calling Spawn_Unit() -> should spawn at given location"] = function()
    local target_location = game_object { name = "DummyPlanet" }
    local spawned = spawn.Spawn_Unit(make_type("DummyType"), target_location, faction { name = "DummyFaction" })

    local actual = spawned[1].Get_Planet_Location()
    local expected = target_location
    test.equal(expected, actual)
end

