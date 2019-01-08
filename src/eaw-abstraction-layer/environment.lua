local env = {}

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

local function run(func, ...)
    env = make_eaw_environment()
    for k, v in pairs(env) do
        _G[k] = v
    end

    local runner = coroutine.wrap(function(...)
        func(...)
    end)

    runner(...)

    for k, v in pairs(env) do
        _G[k] = nil
    end
end

return {
    init = init,
    run = run
}