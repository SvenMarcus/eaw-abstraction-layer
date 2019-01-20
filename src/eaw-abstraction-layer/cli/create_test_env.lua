local dir = require "pl.dir"
local file = require "pl.file"

local function starts_with(str, start)
    return str:sub(1, #start) == start
 end

 local function ends_with(str, ending)
    return ending == "" or str:sub(-#ending) == ending
 end

 function trim(s)
    return s:match'^()%s*$' and '' or s:match'^%s*(.*%S)'
 end

local mod_path = ""

io.write("Please enter a path to the location where you would like to create the test project including the test project's name (the project folder will be created if it does not exist)\n")
local project_path = trim(io.read())

io.write("Please enter your mod path (you can still change it later in config.lua)\n")
mod_path = trim(io.read()) or mod_path

if not starts_with(mod_path, "\"") then
    mod_path = "\""..mod_path
end

if not ends_with(mod_path, "\"") then
    mod_path = mod_path.."\""
end

local config_str = "modpath = "..mod_path

dir.makepath(project_path.."/".."AI/")
dir.makepath(project_path.."/".."Evaluators/")
dir.makepath(project_path.."/".."FreeStore/")
dir.makepath(project_path.."/".."GameObject/")
dir.makepath(project_path.."/".."Interventions/")
dir.makepath(project_path.."/".."Library/")
dir.makepath(project_path.."/".."Miscellaneous/")
dir.makepath(project_path.."/".."Story/")
file.write(project_path.."/".."config.lua", config_str)

print("Successfully created test project!")