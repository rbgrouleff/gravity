# =require ./body
# =require ./vector

Gravity.solarSystem =
  sun: new Gravity.Body("Sun", 695000000, 1.989e+030, new Gravity.Vector(0,0), new Gravity.Vector(0,0))
  mercury: new Gravity.Body("Mercury", 2440000, 3.33e+023, new Gravity.Vector(0, 57900000000), new Gravity.Vector(47900, 0))
  venus: new Gravity.Body("Venus", 6050000, 4.869e+024, new Gravity.Vector(0, 108000000000), new Gravity.Vector(35000, 0))
  earth: new Gravity.Body("Earth", 6378140, 5.976e+024, new Gravity.Vector(0, 150000000000), new Gravity.Vector(29800, 0))
  mars: new Gravity.Body("Mars", 3397200, 6.421e+023, new Gravity.Vector(0, 227940000000), new Gravity.Vector(24100, 0))
  jupiter: new Gravity.Body("Jupiter", 71492000, 1.9e+027, new Gravity.Vector(0, 778330000000), new Gravity.Vector(13100, 0))
  saturn: new Gravity.Body("Saturn", 60268000, 5.688e+026, new Gravity.Vector(0, 1429400000000), new Gravity.Vector(9640, 0))
  uranus: new Gravity.Body("Uranus", 25559000, 8.686e+025, new Gravity.Vector(0, 2870990000000), new Gravity.Vector(6810, 0))
  neptune: new Gravity.Body("Neptune", 24746000, 1.024e+026, new Gravity.Vector(0, 4504300000000), new Gravity.Vector(5430, 0))
  pluto: new Gravity.Body("Pluto", 1137000, 1.27e+022, new Gravity.Vector(0, 5913520000000), new Gravity.Vector(4740, 0))

  activatePlanets: (list) ->
    @activatedPlanets = list
    @activePlanets()

  activePlanets: ->
    (planet for name, planet of @ when @activatedPlanets.indexOf(planet.name) > -1)

  farthestPlanet: ->
    @max @activePlanets(), (planet) ->
      Math.sqrt planet.position.sumOfSquares()

  max: (list, max) ->
    maxTemp = list[0]
    for planet in list
      maxTemp = planet if max(maxTemp) < max(planet)
    maxTemp
