local sandbox = require "eaw-abstraction-layer.core.sandbox"

local env = nil
local real_errors = false

local function insert_into_env(env, tab)
    for func_name, func in pairs(tab) do env[func_name] = func end
end

local make_finders = require "eaw-abstraction-layer.functions.finders"
local make_register_functions = require "eaw-abstraction-layer.functions.register_functions"
local make_story = require "eaw-abstraction-layer.functions.story"
local make_utilities = require "eaw-abstraction-layer.functions.utilities"
local make_spawn = require "eaw-abstraction-layer.functions.spawn"

local function make_eaw_environment()
    local env = {}

    insert_into_env(env, make_finders())
    insert_into_env(env, make_register_functions())
    insert_into_env(env, make_story())
    insert_into_env(env, make_utilities())
    insert_into_env(env, make_spawn())

    env.GlobalValue = require "eaw-abstraction-layer.global_value"
    return env
end

local function init(mod_path)
    env = make_eaw_environment()
    if mod_path then
        local scripts = mod_path .. "/Data/Scripts/"
        local script_folders = {
            scripts .. "AI/",
            scripts .. "Library/",
            scripts .. "Story/",
            scripts .. "GameObject/",
            scripts .. "Evaluators/",
            scripts .. "Miscellaneous/",
            scripts .. "FreeStore/",
            scripts .. "Interventions/"
        }

        for _, path in pairs(script_folders) do package.path = package.path .. ";" .. path .. "?.lua" end
    end
end

local function prepare_environment()
    if not env then env = make_eaw_environment() end

    package.loaded.PGAICommands = true
    package.loaded.PGBase = true
    package.loaded.PGBaseDefinitions = true
    package.loaded.PGCommands = true
    package.loaded.PGDebug = true
    package.loaded.PGEvents = true
    package.loaded.PGInterventions = true
    package.loaded.PGMoveUnits = true
    package.loaded.PGSpawnUnits = true
    package.loaded.PGStateMachine = true
    package.loaded.PGStoryMode = true
    package.loaded.PGTaskForce = true

    insert_into_env(_G, env)
end

local function reset_environment()
    for k, v in pairs(env) do _G[v] = nil end

    package.loaded.PGAICommands = nil
    package.loaded.PGBase = nil
    package.loaded.PGBaseDefinitions = nil
    package.loaded.PGCommands = nil
    package.loaded.PGDebug = nil
    package.loaded.PGEvents = nil
    package.loaded.PGInterventions = nil
    package.loaded.PGMoveUnits = nil
    package.loaded.PGSpawnUnits = nil
    package.loaded.PGStateMachine = nil
    package.loaded.PGStoryMode = nil
    package.loaded.PGTaskForce = nil

    env = make_eaw_environment()
end

local function run(func, ...)
    prepare_environment()
    local status, err = sandbox.run(func, ...)
    reset_environment()

    if status then
        return
    end

    if real_errors then
        real_errors = false
        error(err)
    end

    print(err)
end

local function use_real_errors(bool)
    real_errors = bool
end

return {
    init = init,
    run = run,
    use_real_errors = use_real_errors,
    current_environment = setmetatable(
        {},
        {
            __index = function(_, k)
                if not env then env = make_eaw_environment() end
                return env[k]
            end,
            __newindex = function(_, k, v) env[k] = v end
        }
    )
}
