Timer = require './timer'
Screen = require './screen'
Vector = require './vector'

solarSystem = require './solar_system'

module.exports = class Runner
  constructor: ->
    canvas = document.getElementById 'universe'
    @timer = new Timer 60, canvas
    @startStopButton = document.getElementById 'start_stop'
    @planets = solarSystem.activatePlanets ['Sun', 'Mercury', 'Venus', 'Earth', 'Mars', 'Jupiter'] #[solarSystem.sun, solarSystem.mercury, solarSystem.venus, solarSystem.earth, solarSystem.mars, solarSystem.jupiter, solarSystem.saturn, solarSystem.uranus, solarSystem.neptune, solarSystem.pluto]
    @screen = new Screen canvas, @planets, solarSystem.sun, solarSystem.farthestPlanet().distanceToCenter()
    @dt = 24 * 60 * 60

  startStop: =>
    if @timer.running
      @timer.stop()
    else
      @timer.start()

  tick: =>
    for planet in @planets
      planet.calculateGravitationalPull otherPlanet, @dt for otherPlanet in @planets
    planet.move @dt for planet in @planets
    @screen.draw @planets

  render: ->
    @screen.draw @planets
    @timer.registerCallback @tick
    @startStopButton.onclick = @startStop

  @init: ->
    runner = new Runner
    runner.render()
