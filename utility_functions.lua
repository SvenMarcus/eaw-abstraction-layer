local metatables = require "metatables"
local callback_method = metatables.callback_method
local callback_return_method = metatables.callback_return_method

local TestValid = callback_return_method("TestValid")
function TestValid.return_value()
    return false
end

return {
    BlockOnCommand = callback_method("BlockOnCommand");
    Sleep = callback_method("Sleep");
    TestValid = TestValid,
    DebugMessage = function(...) print(...) end
}