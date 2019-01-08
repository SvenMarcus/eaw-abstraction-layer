require("sub_module")

function my_eaw_function()
    local all_planets = FindPlanet.Get_All_Planets()

    for _, planet in pairs(all_planets) do
        local owner = planet.Get_Owner()

        if not owner.Is_Human() then
            my_table.sub.change_owner_and_spawn_stuff(planet)
            ScriptExit()
        end

    end

    DebugMessage("Reached end of function")
end