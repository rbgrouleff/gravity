module.exports = class Body
  @G: 6.6742e-11

  # radius, mass - float
  # position, velocity - Vector
  constructor: (@name, @radius, @mass, @position, @velocity) ->
  
  exertPullOn: (otherBody, dt) ->
    # Gravitational pull on itself does not make sense (here at least...)
    return if otherBody is @
    radius = otherBody.position.sub(@position)
    otherBody.updateVelocity radius, @mass, dt

  updateVelocity: (r, mass, dt) ->
    sumOfSquares = r.sumOfSquares()
    hypot = Math.sqrt sumOfSquares
    acceleration = -Body.G * mass/sumOfSquares
    @velocity = @velocity.add r.div(hypot).mult(acceleration * dt)

  calculateGravitationalPull: (otherBody, dt) ->
    unless otherBody is @
      radius = @position.sub otherBody.position
      radiusSquared = radius.sumOfSquares()
      hyp = Math.sqrt radiusSquared
      acceleration = -Body.G * otherBody.mass/radiusSquared
      @velocity = @velocity.add radius.div(hyp).mult(acceleration * dt)

  move: (dt) ->
    @oldPosition = @position
    @position = @position.add @velocity.mult(dt)

  distanceToCenter: ->
    Math.sqrt @position.sumOfSquares()
