# Empire at War Abstraction Layer

- [Empire at War Abstraction Layer](#empire-at-war-abstraction-layer)
  - [About](#about)
  - [Installation](#installation)
    - [Installation on Windows](#installation-on-windows)
  - [Usage](#usage)
    - [Project setup](#project-setup)
    - [Running tests](#running-tests)
  - [Currently available EaW functions and types](#currently-available-eaw-functions-and-types)
    - [Functions](#functions)
    - [Types](#types)
  - [Configuration](#configuration)
  - [Writing tests](#writing-tests)
  - [Contributing](#contributing)


## About

The Empire at War Abstraction Layer aims to be a drop in replacement for Empire at War's Lua functions, so Lua modules can be executed without launching the game itself. This not only saves time, but also helps with debugging, since the abstraction layer provides additional functioniality to configure the behavior of EaW's functions. The end goal is to provide a set of functions that can be used together in a unit testing framework. The library ships with `u-test`  (https://github.com/IUdalov/u-test). Lua's most popular testing framework `busted` is unfortunately not compatible at the the current time due to bugs with their handling of global variables, which are essential in EaW modding.


## Installation

Either clone this repository or get it on luarocks using:

```
luarocks install eaw-abstraction-layer
```

This will install the necessary Lua files, an executable called `eaw_test_runner` to run your unit tests  as well as `penlight`, a powerful set of libraries that allows easy handling of files and directories.

### Installation on Windows

If you are on Windows it can be tricky to get `luarocks` to run. I recommend installing the Windows Subsystem for Linux (WSL) with Ubuntu:
https://docs.microsoft.com/en-us/windows/wsl/install-win10

Using this you will gain access to a Linux system with all its repositories. Setting up a Lua development environment here is much easier. To get up and running type the following commands in your Linux terminal:

```bash
sudo apt install luajit
sudo apt install luarocks
luarocks install eaw-abstraction-layer
```

From the terminal you can access your Windows drive through the `mnt` folder:

```bash
cd /mnt/c/Program Files (x86)/...
```

## Usage

### Project setup

`eaw_test_runner` provides a function to create a test project for you.

```bash
eaw_test_runner --project-setup
```

This will launch a setup routine that asks you for the target location of your test project and the location of your mod.

It will the generate all the necessary folders for you (including all folders in your test project path that don't exist yet) and a file called `config.lua`  in your test project root folder that contains your mod path.



Of course you can also set up a similar folder structure manually.



### Running tests

`eaw_test_runner` can locate and run all tests in a folder. Only files ending with "_spec.lua" count as test files. Run it in the terminal using:

```bash
eaw_test_runner <path>
```

This command will run a script that provides your test scripts with a few global variables for easier usage.

| Variable | Description                                                                                                                            |
| -------- | -------------------------------------------------------------------------------------------------------------------------------------- |
| eaw      | The EaW Abstraction Layer. This will run also run the `eaw.init()` function with the mod path from your `config.lua` file, if present. |
| test     | The public API of `u-test`                                                                                                             |



To use the library manually, set the path to your mod folder, `require()` a file and choose an entry function.

```lua
local eaw = require "eaw-abstraction-layer"

eaw.init("./examples/Mod")

local function test_eaw_module()
    eaw.run(function()
        require "eaw_module"
        my_eaw_function()
    end)

end

test_eaw_module()
```

If your code uses EaW's built-in global functions you will need to configure them as explained in the following sections.



## Currently available EaW functions and types

### Functions

All of the following functions can be accessed via the EaW environment:

```lua
local env = eaw.environment
local the_function = env.the_function_name
```



| Function                             | Default return value                                                                                               |
| ------------------------------------ | ------------------------------------------------------------------------------------------------------------------ |
| Find_First_Object_Of_Type(type_name) | A `game_object` with requested type                                                                                |
| Find_All_Objects_Of_Type             | A `table` with a single `game_object` with requested type                                                          |
| Find_Player                          | A `faction` object with requested name                                                                             |
| Find_Object_Type                     | A `type` with requested name                                                                                       |
| FindPlanet                           | A `planet` object with requested name                                                                              |
| FindPlanet.Get_All_Planets           | A `table` with a single `planet`                                                                                   |
| Find_Nearest                         | A `game_object` with requested type                                                                                |
| Find_Hint                            | A `game_object` with requested type                                                                                |
| Get_Story_Plot                       | A `plot` object                                                                                                    |
| Get_Game_Mode                        | String `"Galactic"`                                                                                                |
| Register_Timer                       | -                                                                                                                  |
| Cancel_Timer                         | -                                                                                                                  |
| Register_Death_Event                 | -                                                                                                                  |
| Register_Attacked_Event              | -                                                                                                                  |
| Cancel_Attacked_Event                | -                                                                                                                  |
| Register_Prox                        | -                                                                                                                  |
| Spawn_Unit                           | A `table` with a `game_object` of requested type                                                                   |
| SpawnList                            | A `table` of multiple `game_objects` of requested types                                                            |
| Story_Event                          | -                                                                                                                  |
| TestValid                            | Boolean `true`                                                                                                     |
| ScriptExit                           | Unlike all other replacement functions ScriptExit is an actual Lua function and cannot receive a callback function |
| Add_Planet_Highlight                 | -                                                                                                                  |
| Hide_Sub_Object                      | -                                                                                                                  |
| Game_Random                          | The first of the two provided input arguments                                                                      |
| Game_Random.GetFloat                 | `number` 0                                                                                                         |
| BlockOnCommand                       | -                                                                                                                  |
| DebugMessage                         | Will print the message using `print(string.format(...))`                                                           |

### Types

**faction**

Usage

```lua
local faction = eaw.types.faction

local player = faction {
    name = "Empire",
    is_human = true
}
```



| Method           | Default return value                                         |
| ---------------- | ------------------------------------------------------------ |
| Get_Faction_Name | Value of field `name`                                        |
| Is_Human         | Value of field `is_human` or `false` if field is not present |
| Make_Ally        | -                                                            |
| Get_Tech_Level   | `number` 1                                                   |



**type**

Usage

```lua
local type = eaw.types.type
local my_type = type("My_Type")
```

| Method   | Default return value      |
| -------- | ------------------------- |
| Get_Name | String with provided name |

**fleet**

Usage

```lua
local fleet = eaw.types.fleet
local my_fleet = fleet()
```

| Method                     | Default return value |
| -------------------------- | -------------------- |
| Get_Contained_Object_Count | `number` 1           |
| Contains_Hero              | Boolean `false`      |
| Contains_Object_Type       | Boolean `true`       |

**game_object**

Usage

```lua
local game_object = eaw.types.game_object
local faction = eaw.types.faction
local my_game_object = game_object {
    name = "type_name",
    owner = faction {
        name = "Empire"
    }
}
```

| Method       | Default return value               |
| ------------ | ---------------------------------- |
| Change_Owner | -                                  |
| Get_Owner    | Value of field `owner`             |
| Get_Type     | A `type` with name of field `name` |



**planet**

Inherits from game_object

Usage

```lua
local planet = eaw.types.planet
local faction = eaw.types.faction
local my_planet = planet {
    name = "planet_name",
    owner = faction {
        name = "Empire"
    }
}
```

| Method                  | Default return value |
| ----------------------- | -------------------- |
| Remove_Planet_Highlight | -                    |
| Get_Final_Blow_Player   | A `faction` object   |



**unit_object**

Inherits from game_object

Usage

```lua
local unit_object = eaw.types.unit_object
local faction = eaw.types.faction
local my_unit = unit_object {
    name = "type_name",
    owner = faction {
        name = "Empire"
    }
}
```

| Method                       | Default return value |
| ---------------------------- | -------------------- |
| Move_To                      | -                    |
| Attack_Move                  | -                    |
| Attack_Target                | -                    |
| Guard_Target                 | -                    |
| Make_Invulnerable            | -                    |
| Teleport                     | -                    |
| Teleport_And_Face            | -                    |
| Turn_To_Face                 | -                    |
| Activate_Ability             | -                    |
| Despawn                      | -                    |
| Enable_Behavior              | -                    |
| Hide                         | -                    |
| In_End_Cinematic             | -                    |
| Lock_Current_Orders          | -                    |
| Override_Max_Speed           | -                    |
| Play_Animation               | -                    |
| Prevent_AI_Usage             | -                    |
| Prevent_Opportunity_Fire     | -                    |
| Reset_Ability_Counter        | -                    |
| Set_Single_Ability_Autofire  | -                    |
| Stop                         | -                    |
| Suspend_Locomotor            | -                    |
| Event_Object_In_Range        | -                    |
| Cancel_Event_Object_In_Range | -                    |
| Are_Engines_Online           | Boolean `true`       |
| Get_Hull                     | Number `1`           |
| Get_Shield                   | Number `1`           |
| Get_Parent_Object            | A `game_object`      |
| Has_Ability                  | Booean `true`        |
| Is_Ability_Active            | Boolean `false`      |
| Is_Under_Effects_Of_Ability  | Boolean `false`      |
| Get_Planet_Location          | A `game_object`      |
| Get_Position                 | -                    |

**plot**

Usage

```lua
local plot = eaw.types.story.plot
local my_plot = plot()
```

| Method    | Default return value |
| --------- | -------------------- |
| Get_Event | An `event`           |
| Activate  | -                    |
| Suspend   | -                    |
| Reset     | -                    |

**event**

Usage

```lua
local event = eaw.types.story.event
local my_event = event()
```

| Method               | Default return value |
| -------------------- | -------------------- |
| Set_Event_Parameter  | -                    |
| Set_Reward_Parameter | -                    |



## Configuration

All functions and types are implemented as callable tables that can be configured to use a callback function when they're being called or to return a specified value.

If, for example, you want to configure `FindPlanet` to return a certain game object and print a message when being called you can do so like this:

```lua
local eaw = require "eaw-abstraction-layer"
local env = eaw.environment
local planet = eaw.types.planet
local faction = eaw.types.faction

function env.FindPlanet.return_value(planet_name)
    return planet {
        name = planet_name,
        owner = faction {
            name = "Empire",
            is_human = true
        }
    }
end

function env.FindPlanet.callback(planet_name)
    print("FindPlanet was called with "..planet_name)
end
```

Since `return_value()` is a function instead of a simple field it allows you to apply more complex logic to a return value.

Functions that are expected to return something will throw a warning if you don't provide a `return_value()` function. However, they will not crash the script. The return value is determined before the `callback()` function is called.
Most functions provide a default return value instead of returning nil.

## Writing tests

The following section describes unit testing with the `u-test` testing framework. Tests can simply be defined using the `test` table as shown below:

```lua
test.test_suite_name.test_name = function()
    local eaw = require "eaw-abstraction-layer"
    local type = eaw.types.type
    local game_object = eaw.types.game_object
    local faction = eaw.types.faction

    local called_spawn_unit = false
    function eaw.environment.Spawn_Unit.callback()
        called_spawn_unit = true
    end

    eaw.run(function()
        Spawn_Unit(type("DummyType"), game_object { name = "DummyPlanet" }, faction { name = "DummyFaction" })
    end)

    test.is_true(called_spawn_unit)
end
```

Due to a problem with the current sandboxing technique for the EaW environment, tests calling `eaw.run()` must be defined within a test suite other than the root test suite. Read more about testing with `u-test` on their github site: https://github.com/IUdalov/u-test

## Contributing

It's actually really easy to contribute to this project, you don't have to be a Lua expert.
In `metatables.lua` are the only two possible candidates for function definitions: `callback_method(func_name)` which is for functions that don't return a value and `callback_return_method(func_name)` that is used for functions that do return something.
When you create a reference for a new EaW function either place it in a fitting existing file or create a new one in `eaw-abstraction-layer/functions`.
A function reference could look like this:

```lua
local metatables = require "eaw-abstraction-layer.core.metatables"
local callback_method = metatables.callback_method
local callback_return_method = metatables.callback_return_method

local my_custom_function_creator()
    local My_New_EaW_Function_Reference = callback_return_method("My_New_EaW_Function_Reference")
    function My_New_EaW_Function_Reference.return_value()
        local something = 0
        return something
    end

    return { My_New_EaW_Function_Reference = My_New_EaW_Function_Reference }
end

return my_custom_function_creator
```

Use the field `return_value()` to implement a default return value for that function. To the end user this is more useful than no default return value, because they won't have to define return values for every function this way. Make sure that your new function references are wrapped in a creator function as shown above. The creator function should be the files' return value.
Finally, if you have created a new file, all you need to is add it to the `make_eaw_environment()` function in `environment.lua` like this:

```lua
insert_into_env(env, require "eaw-abstraction-layer.functions.my_file_name" ())
```
