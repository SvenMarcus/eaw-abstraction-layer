local function build_argument_tree(type_list, tree)
    for _, value in pairs(type_list) do
        if not tree[value] then
            tree[value] = {}
        end

        tree = tree[value]
    end

end

local function arguments(tab)
    local arg_root = {}
    for _, value in pairs(tab) do
        if type(value) == "string" and not arg_root[value] then
            arg_root[value] = {}
        elseif type(value) == "table" then
            build_argument_tree(value, arg_root)
        end
    end

    return arg_root
end

local function get_type(obj)
    if type(obj) == "table" and obj.__eaw_type then
        return obj.__eaw_type
    end

    return type(obj)
end

local function type_matches(expected, actual)
    return get_type(actual) == expected
end

local function check_arguments(t, ...)
    if not t.expected then
        return
    end

    local args = {...}
    local argument_tree = t.expected
    for index, arg in pairs(args) do
        if argument_tree[get_type(arg)] == nil then
            error(
                "Error in function "..t.func_name..
                " argument "..tostring(index)..". Unexpected argument of type "..get_type(arg)
            )
        end
        argument_tree = argument_tree[get_type(arg)]
    end
end

local basic_callback_metatable = {
    __call = function(t, ...)
        t.calls = t.calls + 1

        if t.expected then
            check_arguments(t, ...)
        end

        if not t.callback then
            return
        end

        t.callback(...)
    end;
}

local callback_return_metatable = {
    __call = function(t, ...)
        t.calls = t.calls + 1

        if t.expected then
            check_arguments(t, ...)
        end

        local return_value
        if t.return_value then
            return_value = t.return_value(...)
        elseif t.func_name then
            print("Warning! no return value for function "..t.func_name)
        end

        if t.callback then
            t.callback(...)
        end

        return return_value
    end;
}

local function callback_method(func_name)
    return setmetatable({func_name = func_name, calls = 0}, basic_callback_metatable)
end

local function callback_return_method(func_name)
    return setmetatable({func_name = func_name, calls = 0}, callback_return_metatable)
end

return {
    arguments = arguments,
    callback_method = callback_method,
    callback_return_method = callback_return_method
}