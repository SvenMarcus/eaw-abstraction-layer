my_table = {}
my_table.sub = {}

function my_table.sub.change_owner_and_spawn_stuff(planet)
    planet.Change_Owner(Find_Player("Empire"))
    Spawn_Unit(Find_Object_Type("Star_Destroyer"), planet, Find_Player("Empire"))
end