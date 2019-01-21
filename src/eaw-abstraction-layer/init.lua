local environment = require "eaw-abstraction-layer.core.environment"

local types = {
    faction = require "eaw-abstraction-layer.types.faction",
    fleet = require "eaw-abstraction-layer.types.fleet",
    game_object = require "eaw-abstraction-layer.types.game_object",
    global_value = require "eaw-abstraction-layer.global_value",
    planet = require "eaw-abstraction-layer.planet",
    story = require "eaw-abstraction-layer.types.story",
    type = require "eaw-abstraction-layer.types.type",
    unit_object = require "eaw-abstraction-layer.types.unit_object"
}

return {
    environment = environment.current_environment,
    types = types,
    init = environment.init,
    run = environment.run
}
