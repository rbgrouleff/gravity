Body = require './body'
Vector = require './vector'

module.exports =
  sun: new Body("Sun", 695000000, 1.989E+030, new Vector(0,0), new Vector(0,0))
  mercury: new Body("Mercury", 2440000, 3.33E+023, new Vector(0, 57900000000), new Vector(47900, 0))
  venus: new Body("Venus", 6050000, 4.869E+024, new Vector(0, 108000000000), new Vector(35000, 0))
  earth: new Body("Earth", 6378140, 5.976E+024, new Vector(0, 150000000000), new Vector(29800, 0))
  mars: new Body("Mars", 3397200, 6.421E+023, new Vector(0, 227940000000), new Vector(24100, 0))
  jupiter: new Body("Jupiter", 71492000, 1.9E+027, new Vector(0, 778330000000), new Vector(13100, 0))
  saturn: new Body("Saturn", 60268000, 5.688E+026, new Vector(0, 1429400000000), new Vector(9640, 0))
  uranus: new Body("Uranus", 25559000, 8.686E+025, new Vector(0, 2870990000000), new Vector(6810, 0))
  neptune: new Body("Neptune", 24746000, 1.024E+026, new Vector(0, 4504300000000), new Vector(5430, 0))
  pluto: new Body("Pluto", 1137000, 1.27E+022, new Vector(0, 5913520000000), new Vector(4740, 0))

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
