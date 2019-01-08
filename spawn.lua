local metatables = require "metatables"
local callback_return_method = metatables.callback_return_method

return {
    Spawn_Unit = callback_return_method("Spawn_Unit"),
    SpawnList = callback_return_method("SpawnList")
}