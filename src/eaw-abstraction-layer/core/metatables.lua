local function build_argument_tree(type_list, tree)
    for _, value in pairs(type_list) do
        if not tree[value] then tree[value] = {} end

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

-- local my_func = method("my_func")
-- my_func.expected = arguments {
--     "string", "function", optional "boolean"
-- }

-- my_func.expected = arguments {
--     { "string", "function", optional "boolean" },
--     { "game_object", "function", optional "booean" }
-- }

local function optional(type_name)
    local tab = {__optional = true}
    tab[type_name] = true
    return tab
end


local function is_type_mismatch(arg, expected)
    return type(arg) ~= expected
end

local function get_expected_type_from_table(t, arg_index, arg)
    local expected_arg
    for expected_index = 1, #t do
        expected_arg = t[expected_index][arg_index]

        if type(arg) == expected_arg then
            return expected_arg
        end
    end
end

local function get_expected_type(candidate, arg_index, arg)
        local expected_arg = candidate[arg_index]

        if type(candidate[arg_index]) == "table" then
            expected_arg = get_expected_type_from_table(candidate, arg_index, arg)
        end

        return expected_arg
end

local function validate_argument_type(method, arg_index, arg)
    local expected_arg = get_expected_type(method, arg_index, arg)

    if is_type_mismatch(arg, expected_arg) then
        error("Wrong input type")
    end
end

local function expects_input(method)
    return method.expected and #method.expected ~= 0
end

local function validate_number_of_arguments(method, args)
    if expects_input(method) then
        if type(method.expected[1]) ~= "table" then
            if #args ~= #method.expected then
                error()
            end
            return method.expected
        end

        for i=1, #method.expected do
            if #method.expected[i] == #args then
                return method.expected
            end
        end

        error()
    end
end

local function validate_arguments(method, ...)
    local args = {...}
    local candidate = validate_number_of_arguments(method, args)

    local arg
    for arg_index =1, #args do
        arg = args[arg_index]
        validate_argument_type(candidate, arg_index, arg)
    end
end

local function basic_callback_metatable()
    return {
        __call = function(t, ...)
            t.calls = t.calls + 1

            validate_arguments(t, ...)

            if not t.callback then return end

            t.callback(...)
        end,
    }
end


local function callback_return_metatable()
    return {
        __call = function(t, ...)
            t.calls = t.calls + 1

            if t.expected then
                validate_arguments(t, ...)
            end

            local return_value
            if t.return_value then
                return_value = t.return_value(...)
            elseif t.func_name then
                print("Warning! no return value for function " .. t.func_name)
            end

            if t.callback then t.callback(...) end

            return return_value
        end,
    }
end


local function callback_method(func_name)
    return setmetatable(
        {func_name = func_name, calls = 0},
        basic_callback_metatable()
    )
end

local function callback_return_method(func_name)
    return setmetatable(
        {func_name = func_name, calls = 0},
        callback_return_metatable()
    )
end

return {
    arguments = arguments,
    optional = optional,
    callback_method = callback_method,
    callback_return_method = callback_return_method
}
