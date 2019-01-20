local basic_callback_metatable = {
    __call = function(t, ...)
        t.calls = t.calls + 1

        if not t.callback then
            return
        end

        t.callback(...)
    end;
}

local callback_return_metatable = {
    __call = function(t, ...)
        t.calls = t.calls + 1

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
    callback_method = callback_method,
    callback_return_method = callback_return_method
}