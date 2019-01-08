describe("busted tests", function()
    local eaw_env = require "eaw-abstraction-layer.environment"
    local spawn = require "eaw-abstraction-layer.spawn"
    local configure_environment = require "./examples/configuration"

    configure_environment()

    it("should work", function()
        configure_environment()

        local spawn_spy = spy.on(spawn, "Spawn_Unit")

        eaw_env.init("./examples/Mod")

        eaw_env.run(function()
            require "eaw_module"
            my_eaw_function()
        end)

        assert.spy(spawn_spy).was.called()
    end)
end)