# =require ./vector

class Gravity.Screen
  constructor: (canvas, bodies, @center, @maxDistance) ->
    @height = canvas.height = canvas.clientHeight
    @width = canvas.width = canvas.clientWidth
    @canvasCenter = new Gravity.Vector Math.floor(@width/2), Math.floor(@height/2)
    @ctx = canvas.getContext '2d'
    @prerenderedBodies = {}

    @prerenderBody body for body in bodies

  draw: (bodies) ->
    @ctx.clearRect 0, 0, @width, @height
    @ctx.save()
    @ctx.translate @canvasCenter.x, @canvasCenter.y
    for body in bodies
      @renderBody body
    @ctx.restore()

  renderBody: (body) ->
    bodyRadius = @radiusInPixels body.radius
    translatedPosition = @positionInPixels body.position.sub(@center.position)
    translatedPosition = new Gravity.Vector(Math.floor(translatedPosition.x), Math.floor(translatedPosition.y))
    @ctx.drawImage @prerenderedBodies[body.name], Math.floor(translatedPosition.x) - bodyRadius, Math.floor(translatedPosition.y) - bodyRadius

  prerenderBody: (body) ->
    bodyRadius = @radiusInPixels body.radius
    bodyCanvas = document.createElement 'canvas'
    bodyCanvas.width = bodyCanvas.height = bodyRadius*2
    bodyCtx = bodyCanvas.getContext '2d'
    bodyCtx.fillStyle = "rgb(255, 255, 255)"
    bodyCtx.beginPath()
    bodyCtx.arc bodyRadius, bodyRadius, bodyRadius, 0, 2*Math.PI
    bodyCtx.fill()
    @prerenderedBodies[body.name] = bodyCanvas

  scale: ->
    Math.ceil @maxDistance/(@height/2 - 10)

  positionInPixels: (position) ->
    position.div @scale() if position

  radiusInPixels: (radius) ->
    Math.ceil(Math.log(radius)) - 13
