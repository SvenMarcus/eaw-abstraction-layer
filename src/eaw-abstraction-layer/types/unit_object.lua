local game_object = require "eaw-abstraction-layer.types.game_object"
local faction = require "eaw-abstraction-layer.types.faction"
local metatables = require "eaw-abstraction-layer.core.metatables"
local callback_method = metatables.callback_method
local callback_return_method = metatables.callback_return_method


local function unit_object(tab)

    local obj = game_object(tab)

	obj.Activate_Ability = callback_method("Activate_Ability")
	obj.Change_Owner = callback_method("Change_Owner")
	obj.Cinematic_Hyperspace_In = callback_method("Cinematic_Hyperspace_In")
	obj.Despawn = callback_method("Despawn")
	obj.Enable_Behavior = callback_method("Enable_Behavior")
	obj.Face_Immediate = callback_method("Face_Immediate")
	obj.Hide = callback_method("Hide")
	obj.In_End_Cinematic = callback_method("In_End_Cinematic")
	obj.Lock_Current_Orders = callback_method("Lock_Current_Orders")
	obj.Override_Max_Speed = callback_method("Override_Max_Speed")
	obj.Play_Animation = callback_method("Play_Animation")
	obj.Prevent_AI_Usage = callback_method("Prevent_AI_Usage")
	obj.Prevent_Opportunity_Fire = callback_method("Prevent_Opportunity_Fire")
	obj.Reset_Ability_Counter = callback_method("Reset_Ability_Counter")
	obj.Set_Single_Ability_Autofire = callback_method("Set_Single_Ability_Autofire")
	obj.Stop = callback_method("Stop")
	obj.Suspend_Locomotor = callback_method("Suspend_Locomotor")
	obj.Take_Damage = callback_method("Take_Damage")
    obj.Attack_Move = callback_method("Attack_Move")
    obj.Attack_Target = callback_method("Attack_Target")
    obj.Guard_Target = callback_method("Guard_Target")
    obj.Make_Invulnerable = callback_method("Make_Invulnerable")
    obj.Move_To = callback_method("Move_To")
    obj.Teleport = callback_method("Teleport")
    obj.Teleport_And_Face = callback_method("Teleport_And_Face")
    obj.Turn_To_Face = callback_method("Turn_To_Face")

	obj.Event_Object_In_Range = callback_method("Event_Object_In_Range")
	obj.Cancel_Event_Object_In_Range = callback_method("Cancel_Event_Object_In_Range")

	obj.Are_Engines_Online = callback_return_method("Are_Engines_Online")
	function obj.Are_Engines_Online.return_value()
		return true
	end

	obj.Get_Hull = callback_return_method("Get_Hull")
	function obj.Get_Hull.return_value()
		return 1.0
	end

	obj.Get_Parent_Object = callback_return_method("Get_Parent_Object")
	function obj.Get_Parent_Object.return_value()
		return game_object {
			name = "DummyObject",
			owner = faction {
                name = "DummyFaction",
                is_human = false
            }
		}
	end

	obj.Get_Shield = callback_return_method("Get_Shield")
	function obj.Get_Shield.return_value()
		return 1.0
	end

	obj.Has_Ability = callback_return_method("Has_Ability")
	function obj.Has_Ability.return_value()
		return true
	end

	obj.Is_Ability_Active = callback_return_method("Is_Ability_Active")
	function obj.Is_Ability_Active.return_value()
		return false
	end

	obj.Is_Under_Effects_Of_Ability = callback_return_method("Is_Under_Effects_Of_Ability")
	function obj.Is_Under_Effects_Of_Ability.return_value()
		return false
	end

	obj.Get_Planet_Location = callback_return_method("Get_Planet_Location")
	function obj.Get_Planet_Location.return_value()
        return game_object {
            name = "DummyPlanet",
            owner = faction {
                name = "DummyFaction",
                is_human = false
            }
        }
	end

	obj.Get_Position = callback_return_method("Get_Position")

    return obj
end

return unit_object