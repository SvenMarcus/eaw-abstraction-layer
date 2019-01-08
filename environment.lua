local env = {}

local function insert_into_env(env, tab)
    for func_name, func in pairs(tab) do
        env[func_name] = func
    end
end

local function make_eaw_environment()
    local env = setmetatable({}, {__index = _G})

    insert_into_env(env, require "finders")
    insert_into_env(env, require "register_functions")
    insert_into_env(env, require "story")
    insert_into_env(env, require "utility_functions")
    insert_into_env(env, require "spawn")

    env.GlobalValue = require "global_value"

    return env
end

local function init(mod_path)
    print("Initializing environment...")
    env = make_eaw_environment()
    _g_env_backup = make_eaw_environment()


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
        print(k)
        _G[k] = v
    end

    func(...)

    for k, v in pairs(env) do
        _G[k] = nil
    end
end

return {
    init = init,
    -- import = import,
    -- restore_environment = restore_environment,
    run = run
}