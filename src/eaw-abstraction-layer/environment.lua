local env = {}
local original_require = require

local function insert_into_env(env, tab)
    for func_name, func in pairs(tab) do
        env[func_name] = func
    end
end

local function make_eaw_environment()
    env = setmetatable({}, {__index = _G})

    insert_into_env(env, require "eaw-abstraction-layer.finders")
    insert_into_env(env, require "eaw-abstraction-layer.register_functions")
    insert_into_env(env, require "eaw-abstraction-layer.story")
    insert_into_env(env, require "eaw-abstraction-layer.utility_functions")
    insert_into_env(env, require "eaw-abstraction-layer.spawn")

    env.GlobalValue = require "eaw-abstraction-layer.global_value"

    return env
end

local function register_busted_matchers()
    require "eaw-abstraction-layer.busted_matchers"
end

local function init(mod_path)
    print("Initializing environment...")
    env = make_eaw_environment()


    local scripts = mod_path.."/Data/Scripts/"
    local script_folders = {
        scripts.."AI/",
        scripts.."Library/",
        scripts.."Story/",
        scripts.."GameObject/",
        scripts.."Evaluators/",
        scripts.."Miscellaneous/",
        scripts.."FreeStore/",
        scripts.."Interventions/"
    }

    for _, path in pairs(script_folders) do
        package.path = package.path..";"..path.."?.lua"
    end
end

local function create_g_backup()
    local _G_backup = {}

    for k, v in pairs(_G) do
        _G_backup[k] = v
    end

    return _G_backup
end

local function run(func, ...)
    local _G_backup = create_g_backup()

    env = make_eaw_environment()
    insert_into_env(_G, env)

    local runner = coroutine.wrap(function(...)
        func(...)
    end)

    runner(...)

    _G = _G_backup
end

return {
    register_busted_matchers = register_busted_matchers,
    init = init,
    run = run
}