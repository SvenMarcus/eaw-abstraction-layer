local metatables = require "eaw-abstraction-layer.core.metatables"
local callback_method = metatables.callback_method
local callback_return_method = metatables.callback_return_method
local arguments = metatables.arguments

test["When calling table based on callback_method -> should call table.callback() with arguments"] = function()
    local sut = callback_method("sut")

    local called, actual
    function sut.callback(arg)
        called = true
        actual = arg
    end

    sut("test")

    local expected = "test"
    test.is_true(called)
    test.equal(expected, actual)
end

test["When calling table based on callback_return_method -> should call table.callback() with arguments"] = function()
    local sut = callback_return_method("sut")

    local called, actual
    function sut.callback(arg)
        called = true
        actual = arg
    end

    sut("test")

    local expected = "test"
    test.is_true(called)
    test.equal(expected, actual)
end

test["When calling table based on callback_return_method with return_value() function -> should return value from return_value() function"] = function()
    local sut = callback_return_method("sut")
    function sut.return_value()
        return "value"
    end

    local actual = sut()

    local expected = "value"
    test.equal(expected, actual)
end

test["When calling callback_method that defines expected args with wrong argument type -> should throw error containing argument type"] = function()
    local sut = callback_method("sut")
    sut.expected = arguments { "string" }

    test.error_raised(function()
        sut(true)
    end, "boolean")
end

test["When calling callback_return_method that defines expected args with wrong argument type -> should throw error containing wrong argument type"] = function()
    local sut = callback_return_method("sut")
    sut.expected = arguments { "string" }

    test.error_raised(function()
        sut(true)
    end, "boolean")
end

test["When calling callback_method with two defined args with wrong second argument -> should throw error containing wrong argument"] = function()
    local sut = callback_return_method("sut")
    sut.expected = arguments { "string", "string" }

    test.error_raised(function()
        sut("str", true)
    end, "boolean")
end

test["When calling callback_method expecting one of two combinations of two arguments with wrong arguments -> should throw error containing wrong argument"] = function()
    local sut = callback_return_method("sut")
    sut.expected = arguments {
        { "string", "table" },
        { "string", "number" }
    }

    test.error_raised(function()
        sut("str", eaw.types.type("test"))
    end, "type")
end