requestAnimationFrame = window.requestAnimationFrame || window.mozRequestAnimationFrame ||
                        window.webkitRequestAnimationFrame || window.msRequestAnimationFrame

class Gravity.Timer
  constructor: (@fps, @canvas, @debug = false) ->
    @callbacks = []
    @msPrFrame = Math.ceil(1000/@fps)
    @ms = 0
    @ticksDuringLastSecond = 0
    if debug
      @registerCallback @fpsCounter.bind(@)

  tick: (timestamp) ->
    delta = timestamp - @lastTickTime
    if delta > @msPrFrame
      @lastTickTime = timestamp
      callback(delta) for callback in @callbacks
    requestAnimationFrame @tick.bind(@), @canvas if @running

  start: ->
    return if @running
    @running = true
    @lastTickTime = Date.now()
    requestAnimationFrame @tick.bind(@), @canvas

  stop: ->
    @running = false

  registerCallback: (callback) ->
    @callbacks.push callback

  fpsCounter: (delta) ->
    if @ms + delta > 1000
      console.log "FPS: #{@ticksDuringLastSecond}"
      @ms = @ticksDuringLastSecond = 0
    else
      @ms += delta
      @ticksDuringLastSecond += 1
