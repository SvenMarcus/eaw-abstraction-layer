local eaw = require "eaw-abstraction-layer"

test["When requiring a file inside run -> should not be in package.loaded after run"] = function()
    eaw.run(function()
        local stub = require "./test/file_stub"
    end)

    test.is_nil(package.loaded["./test/file_stub"])
end

test["When setting callback on function in initiated environment -> then running twice -> should only call callback once"] = function()
    local types = eaw.types
    local type = types.type
    local faction = types.faction
    local game_object = types.game_object
    local env = eaw.environment

    eaw.init("./examples/Mod")

    local times_called_spawn_unit = 0
    function env.Spawn_Unit.callback()
        times_called_spawn_unit = times_called_spawn_unit + 1
    end

    eaw.run(function()
        Spawn_Unit(type("DUMMY"), game_object {name = "DUMMY"}, faction {name = "DUMMY"})
    end)

    eaw.run(function()
        Spawn_Unit(type("DUMMY"), game_object {name = "DUMMY"}, faction {name = "DUMMY"})
    end)

    local expected = 1
    test.equal(expected, times_called_spawn_unit)
end
