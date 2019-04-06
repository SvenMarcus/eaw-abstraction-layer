local eaw = require "eaw-abstraction-layer"
local configure_environment = require "./examples/configuration"
eaw.init("./examples/Mod")


local function test_eaw_module()
    configure_environment()

    eaw.run(function()
        require "eaw_module"
        my_eaw_function()
    end)

end

test_eaw_module()

