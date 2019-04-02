local game_object = require "eaw-abstraction-layer.types.game_object"
local faction = require "eaw-abstraction-layer.types.faction"
local planet = require "eaw-abstraction-layer.types.planet"
local metatables = require "eaw-abstraction-layer.core.metatables"
local method = metatables.method


local function unit_object(tab)

	local obj = game_object(tab)
	obj.__eaw_type = "unit_object"

	obj.Activate_Ability = method("Activate_Ability")
	obj.Activate_Ability.expected = {
		{"string", "boolean"},
		{"string", "game_object"},
		{"string", "unit_object"}
	}

	obj.Change_Owner = method("Change_Owner")
	obj.Change_Owner.expected = {
		"faction"
	}

	obj.Cinematic_Hyperspace_In = method("Cinematic_Hyperspace_In")
	obj.Cinematic_Hyperspace_In.expected = {
		"number"
	}

	obj.Despawn = method("Despawn")

	obj.Enable_Behavior = method("Enable_Behavior")
	obj.Enable_Behavior.expected = {
		"number", "boolean"
	}

	obj.Face_Immediate = method("Face_Immediate")
	obj.Face_Immediate.expected = {
		{"game_object"},
		{"unit_object"}
	}

	obj.Hide = method("Hide")
	obj.Hide.expected = {
		"boolean"
	}

	obj.In_End_Cinematic = method("In_End_Cinematic")
	obj.In_End_Cinematic.expected = {
		"boolean"
	}

	obj.Lock_Current_Orders = method("Lock_Current_Orders")

	obj.Override_Max_Speed = method("Override_Max_Speed")
	obj.Override_Max_Speed.expected = {
		"number"
	}

	obj.Play_Animation = method("Play_Animation")
	obj.Play_Animation.expected = {
		"string", "boolean", "number"
	}

	obj.Prevent_AI_Usage = method("Prevent_AI_Usage")
	obj.Prevent_AI_Usage.expected = {
		"boolean"
	}

	obj.Prevent_Opportunity_Fire = method("Prevent_Opportunity_Fire")
	obj.Prevent_Opportunity_Fire.expected = {
		"boolean"
	}

	obj.Reset_Ability_Counter = method("Reset_Ability_Counter")

	obj.Set_Single_Ability_Autofire = method("Set_Single_Ability_Autofire")
	obj.Set_Single_Ability_Autofire.expected = {
		"string", "boolean"
	}

	obj.Stop = method("Stop")

	obj.Suspend_Locomotor = method("Suspend_Locomotor")
	obj.Suspend_Locomotor.expected = {
		"boolean"
	}

	obj.Take_Damage = method("Take_Damage")
	obj.Take_Damage.expected = {
		"number"
	}

	obj.Attack_Move = method("Attack_Move")
	obj.Attack_Move.expected = {
		{"game_object"},
		{"unit_object"}
	}

	obj.Attack_Target = method("Attack_Target")
	obj.Attack_Target.expected = {
		{"game_object"},
		{"unit_object"}
	}

	obj.Guard_Target = method("Guard_Target")
	obj.Guard_Target.expected = {
		{"game_object"},
		{"unit_object"}
	}

	obj.Make_Invulnerable = method("Make_Invulnerable")
	obj.Make_Invulnerable.expected = {
		"boolean"
	}

	obj.Move_To = method("Move_To")
	obj.Move_To.expected = {
		{"game_object"},
		{"unit_object"}
	}

	obj.Teleport = method("Teleport")
	obj.Teleport.expected = {
		{"game_object"},
		{"unit_object"}
	}

	obj.Teleport_And_Face = method("Teleport_And_Face")
	obj.Teleport_And_Face.expected = {
		{"game_object"},
		{"unit_object"}
	}

	obj.Turn_To_Face = method("Turn_To_Face")
	obj.Turn_To_Face.expected = {
		{"game_object"},
		{"unit_object"}
	}

	obj.Event_Object_In_Range = method("Event_Object_In_Range")
	obj.Event_Object_In_Range.expected = {
		{"function", "number"},
		{"function", "number", "faction"}
	}

	obj.Cancel_Event_Object_In_Range = method("Cancel_Event_Object_In_Range")
	obj.Cancel_Event_Object_In_Range.expected = {
		"function"
	}

	obj.Are_Engines_Online = method("Are_Engines_Online")
	function obj.Are_Engines_Online.return_value()
		return true
	end

	obj.Get_Hull = method("Get_Hull")
	function obj.Get_Hull.return_value()
		return 1.0
	end

	obj.Get_Parent_Object = method("Get_Parent_Object")
	function obj.Get_Parent_Object.return_value()
		return game_object {
			name = "DummyObject",
			owner = faction {
                name = "DummyFaction",
                is_human = false
            }
		}
	end

	obj.Get_Shield = method("Get_Shield")
	function obj.Get_Shield.return_value()
		return 1.0
	end

	obj.Has_Ability = method("Has_Ability")
	obj.Has_Ability.expected = {
		"string"
	}

	function obj.Has_Ability.return_value()
		return true
	end

	obj.Is_Ability_Active = method("Is_Ability_Active")
	obj.Is_Ability_Active.expected = {
		"string"
	}

	function obj.Is_Ability_Active.return_value()
		return false
	end

	obj.Is_Under_Effects_Of_Ability = method("Is_Under_Effects_Of_Ability")
	obj.Is_Under_Effects_Of_Ability.expected = {
		"string"
	}

	function obj.Is_Under_Effects_Of_Ability.return_value()
		return false
	end

	obj.Get_Planet_Location = method("Get_Planet_Location")
	function obj.Get_Planet_Location.return_value()
        return planet {
            name = "DummyPlanet",
            owner = faction {
                name = "DummyFaction",
                is_human = false
            }
        }
	end

	obj.Get_Position = method("Get_Position")

    return obj
end

return unit_object