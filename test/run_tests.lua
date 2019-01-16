local function scandir(directory)
    local i, t, popen = 0, {}, io.popen
    local pfile = popen('ls -a "'..directory..'"')
    for filename in pfile:lines() do
        i = i + 1
        t[i] = filename
    end
    pfile:close()
    return t
end

local function ends_with(str, ending)
    return ending == "" or str:sub(-#ending) == ending
end

local nargs = #arg

if nargs < 1 then
    print("Expected folder")
    os.exit(1)
end

local test_suites = {}

for _, v in pairs(scandir(arg[1])) do
    if ends_with(v, "_spec.lua") then
        local script = arg[1].."/"..string.gsub(v, ".lua", "")
        table.insert(test_suites, script)
    end
end

arg[1] = nil

test = require "u-test"

for _, script in pairs(test_suites) do
    require(script)
end

test.summary()