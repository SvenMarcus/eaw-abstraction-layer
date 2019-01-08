local game_object = require "game_object"
local metatables = require "metatables"
local callback_method = metatables.callback_method
local callback_return_method = metatables.callback_return_method


local function unit_object(tab)

    local obj = game_object(tab)

    obj.Move_To = callback_method("Move_To")
    obj.Attack_Move = callback_method("Attack_Move")
    obj.Attack_Target = callback_method("Attack_Target")
    obj.Guard_Target = callback_method("Guard_Target")
    obj.Make_Invulnerable = callback_method("Make_Invulnerable")
    obj.Teleport = callback_method("Teleport")
    obj.Teleport_And_Face = callback_method("Teleport_And_Face")
    obj.Turn_To_Face = callback_method("Turn_To_Face")

    return obj
end