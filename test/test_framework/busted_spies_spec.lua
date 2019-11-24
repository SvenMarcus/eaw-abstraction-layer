setup("Setup", function()
   eaw.init() 
end)

test(
    "Busted spies are getting called",
    function()
        local find_planet_spy = spy.on(eaw.environment, "FindPlanet")

        eaw.environment.FindPlanet("Test")

        assert.spy(find_planet_spy).was.called()
    end
)

test(
    "Busted spies are getting called inside eaw environment",
    function()
        local find_planet_spy = spy.on(eaw.environment, "FindPlanet")
        eaw.run(
            function()
                FindPlanet("Test")
            end
        )
        assert.spy(find_planet_spy).was.called()
    end
)
