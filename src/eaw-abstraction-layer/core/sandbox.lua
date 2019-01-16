local table_lookup = {}

local function deep_restore(tab, backup)
    table_lookup[tab] = true
    for k, v in pairs(tab) do
        if not backup[k] then
            tab[k] = nil
        elseif type(v) == "table" and not table_lookup[v] then
            deep_restore(v, backup[k])
        elseif not type(v) == "table" then
            tab[k] = backup[k]
        end
    end
end

local function clone_helper(tab)
    local clone = {}
    table_lookup[tab] = true
    for k, v in pairs(tab) do
        if type(v) == "table" and not table_lookup[v] then
            clone[k] = clone_helper(v)
        else
            clone[k] = v
        end
    end

    return clone
end

local function deep_clone(tab)
    local env_clone = clone_helper(tab)
    table_lookup = {}
    return env_clone
end


local function run(func)
    local g_clone = deep_clone(_G)

    coroutine.wrap(func)()

    deep_restore(_G, g_clone)
    table_lookup = {}
end

return {
    run = run
}