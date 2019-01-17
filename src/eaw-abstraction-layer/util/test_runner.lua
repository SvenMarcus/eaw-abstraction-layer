local dir = require "pl.dir"

local function ends_with(str, ending)
    return ending == "" or str:sub(-#ending) == ending
end

local current_dir = arg[1]
arg[1] = nil

local test_suites = {}

for root, dirs, files in dir.walk(current_dir) do
    for i, f in ipairs(files) do
        if ends_with(f, "_spec.lua") then
            local script = root.."/"..string.gsub(f, ".lua", "")
            table.insert(test_suites, script)
        end
    end
end

-- Important! require u-test related scripts after getting test files and resetting arg because of arg weirdness
test = require "eaw-abstraction-layer.util.u-test"
require "eaw-abstraction-layer.util.custom_assertions"

for _, suite in pairs(test_suites) do
    require(suite)
end

test.summary()