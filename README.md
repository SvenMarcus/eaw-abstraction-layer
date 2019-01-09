# Empire at War Abstraction Layer

- [Empire at War Abstraction Layer](#empire-at-war-abstraction-layer)
  - [About](#about)
  - [Installation](#installation)
  - [Usage](#usage)
  - [Currently available EaW functions and types](#currently-available-eaw-functions-and-types)
    - [Functions](#functions)
    - [Types](#types)
  - [Configuration](#configuration)
  - [Contributing](#contributing)

## About

The Empire at War Abstraction Layer aims to be a drop in replacement for Empire at War's Lua functions, so Lua modules can be executed without launching the game itself. This not only saves time, but also helps with debugging, since the abstraction layer provides additional functioniality to configure the behavior of EaW's functions. The end goal is to provide a set of functions that can be used together in a unit testing framework like `busted`.

## Installation

Either clone this repository or get it on luarocks using:

```
luarocks install eaw-abstraction-layer
```

## Usage

As of now, the library needs to be used on files that don't have any connection to the base PG Lua files. That means you can neither `require()` a PG Lua file directly nor a file that `require`s a PG Lua file (and so on...) . You will need to organize your code into decoupled modules with minimal dependencies to achieve that.

To use the library set the path to your mod folder, `require()` a file and choose an entry function.

```lua
local eaw_env = require "environment"

eaw_env.init("./examples/Mod")

local function test_eaw_module()
    eaw_env.run(function()
        require "eaw_module"
        my_eaw_function()
    end)

end

test_eaw_module()
```

If your code uses EaW's built-in global functions you will need to configure them as explained in the following sections.

## Currently available EaW functions and types

### Functions

- Find_First_Object_Of_Type

- Find_All_Objects_Of_Type

- Find_Player

- Find_Object_Type

- FindPlanet

- FindPlanet.Get_All_Planets

- Find_Nearest

- Get_Story_Plot

- Get_Game_Mode

- Register_Timer

- Register_Death_Event

- Register_Attacked_Event

- Register_Prox

- Spawn_Unit

- Story_Event

- Sleep

- TestValid

- ScriptExit

  - Unlike all other replacement functions ScriptExit is an actual Lua function and cannot receive a callback function

### Types

- faction:

  - Available functions:

  - Get_Faction_Name

  - Is_Human

- type

  - Available functions:

  - Get_Name

- game_object

  - Available functions:

  - Change_Owner

  - Despawn

  - Get_Owner

  - Get_Type

- unit_object (inherits from game object):

  - Available functions:

  - Move_To

  - Attack_Move

  - Attack_Target

  - Guard_Target

  - Make_Invulnerable

  - Teleport

  - Teleport_And_Face

  - Turn_To_Face

  - Get_Planet_Location

  - Get_Position

- plot:

  - Available functions:

  - Get_Event

- event:

  - Available functions:

  - Set_Event_Parameter

  - Set_Reward_Parameter

## Configuration

All functions and types are implemented as callable tables that can be configured to use a callback function when they're being called or to return a specified value.

If, for example, you want to configure `FindPlanet` to return a certain game object and print a message when being called you can do so like this:

```lua
local finders = require "finders"
local game_object = require "game_object"
local faction = require "faction"

function finders.FindPlanet.return_value(planet_name)
    return game_object {
        name = planet_name,
        owner = faction {
            name = "Empire",
            is_human = true
        }
    }
end

function finders.FindPlanet.callback(planet_name)
    print("FindPlanet was called with "..planet_name)
end
```

Since `return_value()` is a function instead of a simple field it allows you to apply more complex logic to a return value.

Functions that are expected to return something will throw a warning if you don't provide a `return_value()` function. However, they will not crash the script. The return value is determined before the `callback()` function is called.
Most functions provide a default return value instead of returning nil.


## Contributing

It's actually really easy to contribute to this project, you don't have to be a Lua expert.
In `metatables.lua` are the only two possible candidates for function definitions: `callback_method(func_name)` which is for functions that don't return a value and `callback_return_method(func_name)` that is used for functions that do return something.
When you create a reference for a new EaW function either place it in a fitting existing file or create a new one.
A function reference could look like this:

```lua
local metatables = require "eaw-abstraction-layer.metatables"
local callback_method = metatables.callback_method
local callback_return_method = metatables.callback_return_method

local My_New_EaW_Function_Reference = callback_return_method("My_New_EaW_Function_Reference")
function My_New_EaW_Function_Reference.return_value()
    local something = 0
    return something
end

return My_New_EaW_Function_Reference
```

Use the field `return_value()` to implement a default return value for that function. To the end user this is more useful than no default return value, because they won't have to define return values for every function this way.