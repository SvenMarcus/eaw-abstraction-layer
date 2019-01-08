local metatables = require "eaw-abstraction-layer.metatables"
local callback_method = metatables.callback_method

return {
    Register_Timer = callback_method("Register_Timer");
    Register_Prox = callback_method("Register_Prox");
    Register_Attacked_Event = callback_method("Register_Attacked_Event");
    Register_Death_Event = callback_method("Register_Death_Event");
}