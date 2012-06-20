# =require ./timer
# =require ./solar_system
# =require ./screen

class Gravity.Runner
  constructor: ->
    canvas = document.getElementById 'universe'
    @timer = new Gravity.Timer 60, canvas
    @startStopButton = document.getElementById 'start_stop'
    @planets = Gravity.solarSystem.activatePlanets ['Sun', 'Mercury', 'Venus', 'Earth', 'Mars', 'Jupiter'] #[solarSystem.sun, solarSystem.mercury, solarSystem.venus, solarSystem.earth, solarSystem.mars, solarSystem.jupiter, solarSystem.saturn, solarSystem.uranus, solarSystem.neptune, solarSystem.pluto]
    @screen = new Gravity.Screen canvas, @planets, Gravity.solarSystem.sun, Gravity.solarSystem.farthestPlanet().distanceToCenter()
    @dt = 24 * 60 * 60

  startStop: ->
    if @timer.running
      @timer.stop()
    else
      @timer.start()

  tick: ->
    for planet in @planets
      planet.calculateGravitationalPull otherPlanet, @dt for otherPlanet in @planets
    planet.move @dt for planet in @planets
    @screen.draw @planets

  render: ->
    @screen.draw @planets
    @timer.registerCallback @tick.bind(@)
    @startStopButton.onclick = @startStop.bind(@)

  @init: ->
    runner = new Gravity.Runner
    runner.render()
