local function get_type(arg)
    if type(arg) == "table" and arg.__eaw_type then
        return arg.__eaw_type
    end

    return type(arg)
end

local function is_type_mismatch(arg, expected)
    return get_type(arg) ~= expected
end

local function get_expected_type_from_table(candidates, arg_index, arg)
    local expected_arg
    for expected_index = 1, #candidates do
        expected_arg = candidates[expected_index][arg_index]

        if type(arg) == expected_arg then
            return expected_arg
        end
    end
end

local function get_expected_type(candidate, arg_index, arg)
        local expected_arg = candidate[arg_index]

        if type(candidate[1]) == "table" then
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

local function get_argument_candidates(method, args)
    if not expects_input(method) then
        return {}
    end

    if type(method.expected[1]) ~= "table" then
        if #args == #method.expected then
            return method.expected
        end
    end

    local candidates = {}
    for i=1, #method.expected do
        if #method.expected[i] == #args then
            table.insert(candidates, method.expected[i])
        end
    end

    return candidates
end

local function validate_arguments(method, ...)
    local args = {...}
    local candidates = get_argument_candidates(method, args)

    if expects_input(method) and #candidates == 0 then
        error("No matching signature for given argument count")
    end

    local arg
    for arg_index =1, #args do
        arg = args[arg_index]
        validate_argument_type(candidates, arg_index, arg)
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
    callback_return_method = callback_method
}
