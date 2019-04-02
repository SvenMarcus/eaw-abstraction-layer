local metatables = require "eaw-abstraction-layer.core.metatables"
local method = metatables.method

test["When calling table based on method -> should call table.callback() with arguments"] = function()
    local sut = method("sut")
    sut.expected = {"string"}

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

test["When calling table based on method with return_value() function -> should return value from return_value() function"] = function()
    local sut = method("sut")
    function sut.return_value() return "value" end

    local actual = sut()

    local expected = "value"
    test.equal(expected, actual)
end
