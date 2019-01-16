local metatables = require "eaw-abstraction-layer.core.metatables"
local callback_method = metatables.callback_method

local function register_functions()
    return {
        Register_Timer = callback_method("Register_Timer");
        Register_Prox = callback_method("Register_Prox");
        Register_Attacked_Event = callback_method("Register_Attacked_Event");
        Register_Death_Event = callback_method("Register_Death_Event");
    }
end

return register_functions