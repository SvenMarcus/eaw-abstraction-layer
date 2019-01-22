local make_type = require "eaw-abstraction-layer.types.unit_object"
local metatables = require "eaw-abstraction-layer.core.metatables"
local callback_method = metatables.callback_method
local callback_return_method = metatables.callback_return_method

-- @usage
-- task_force {
--	units = {unit_object}
-- }
local function task_force(tab)

    local obj = {}
   
    obj.Attack_Move = callback_method("Attack_Move")
    obj.Move_To = callback_method("Move_To")
    obj.Attack_Target = callback_method("Attack_Target")
    obj.Set_As_Goal_System_Removable = callback_method("Set_As_Goal_System_Removable")
    obj.Activate_Ability = callback_method("Activate_Ability")
    obj.Set_Plan_Result = callback_method("Set_Plan_Result")
    obj.Produce_Force = callback_method("Produce_Force")
    obj.Test_Target_Contrast = callback_method("Test_Target_Contrast")
    obj.Build_All = callback_method("Build_All")
    obj.Release_Unit = callback_method("Release_Unit")
    obj.Fire_Orbital_Bombardment = callback_method("Fire_Orbital_Bombardment")
    obj.Set_Targeting_Priorities = callback_method("Set_Targeting_Priorities")
    obj.Guard_Target = callback_method("Guard_Target")
    obj.Collect_All_Free_Units = callback_method("Collect_All_Free_Units")
    obj.Release_Forces = callback_method("Release_Forces")
    obj.Fire_Special_Weapon = callback_method("Fire_Special_Weapon")
    obj.Bombing_Run = callback_method("Bombing_Run")
    obj.Explore_Area = callback_method("Explore_Area")
    obj.Raid = callback_method("Raid")
    obj.Test_Target_Contrast = callback_method("Test_Target_Contrast")
    obj.Build = callback_method("Build")
    obj.Enable_Attack_Positioning = callback_method("Enable_Attack_Positioning")
    obj.Follow_Target = callback_method("Follow_Target")
    obj.Prepare_Ambush = callback_method("Prepare_Ambush")
    obj.Withdraw_Units = callback_method("Withdraw_Units")
    obj.Block_Goal_Proposal = callback_method("Block_Goal_Proposal")
    obj.Land_Units = callback_method("Land_Units")
    obj.Launch_Units = callback_method("Launch_Units")
    obj.Form_Units = callback_method("Form_Units")
    obj.Invade = callback_method("Invade")
    obj.Reinforce = callback_method("Reinforce")

    obj.Get_Unit_Table = callback_return_method("Get_Unit_Table")
    function obj.Get_Unit_Table.return_value()
        return obj.units
    end

    obj.Get_Goal_Type_Name = callback_return_method("Get_Goal_Type_Name")
    function obj.Get_Goal_Type_Name.return_value()
        return "Goal_Type_Name"
    end

    obj.Get_Force_Count = callback_return_method("Get_Force_Count")
    function obj.Get_Force_Count.return_value()
        --might need alternate table counter here
        return #obj.units
    end

    obj.Get_Self_Threat_Max = callback_return_method("Get_Self_Threat_Max")
    function obj.Get_Self_Threat_Max.return_value()
        --Hard to test what this actually *does*, needs some debug print in-game
        return 0
    end

    obj.Can_Garrison = callback_return_method("Can_Garrison")
    function obj.Can_Garrison.return_value()
        return false
    end

    obj.Get_Reserved_Build_Pads = callback_return_method("Get_Reserved_Build_Pads")
    function obj.Get_Reserved_Build_Pads.return_value()
        return obj.units
    end

    obj.Get_Stage = callback_return_method("Get_Stage")
    function obj.Get_Stage.return_value()
        return game_object {
            name = "DummyPlanet",
            owner = faction {
                name = "DummyFaction",
                is_human = false
            }
        }
    end

    obj.Get_Distance = callback_return_method("Get_Distance")
    function obj.Get_Distance.return_value()
        return 0
    end

    obj.Is_Raid_Capable = callback_return_method("Is_Raid_Capable")
    function obj.Is_Raid_Capable.return_value()
        return false
    end

    obj.Are_All_Units_On_Free_Store = callback_return_method("Are_All_Units_On_Free_Store")
    function obj.Are_All_Units_On_Free_Store.return_value()
        return false
    end

    return obj
end

return task_force