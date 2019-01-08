local game_object = require "eaw-abstraction-layer.game_object"
local faction = require "eaw-abstraction-layer.faction"
local make_type = require "eaw-abstraction-layer.type"
local spawn = require "eaw-abstraction-layer.spawn"

describe("When spawning", function()
    it("should return table containing game object", function()
        local spawned = spawn.Spawn_Unit(make_type("DummyType"), game_object { name = "DummyPlanet" }, faction { name = "DummyFaction" })

        local actual = spawned[1]
        assert.is_table(actual)
    end)

    it("should spawn at given location", function()
        local target_location = game_object { name = "DummyPlanet" }
        local spawned = spawn.Spawn_Unit(make_type("DummyType"), target_location, faction { name = "DummyFaction" })

        local actual = spawned[1].Get_Planet_Location()
        local expected = target_location
        assert.equals(expected, actual)
    end)
end)