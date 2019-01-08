local eaw_env = require "eaw-abstraction-layer.environment"
local configure_environment = require "./examples/configuration"

eaw_env.init("./examples/Mod")

local function test_eaw_module()
    configure_environment()

    eaw_env.run(function()
        require "eaw_module"
        my_eaw_function()
    end)

end

test_eaw_module()