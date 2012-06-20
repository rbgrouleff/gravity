class Gravity.Vector
  constructor: (@x, @y) ->

  mult: (v) ->
    if @constructor == v.constructor
      new Gravity.Vector(@x * v.x, @y * v.y)
    else
      new Gravity.Vector(@x * v, @y * v)

  div: (v) ->
    if @constructor == v.constructor
      new Gravity.Vector @x / v.x, @y / v.y
    else
      new Gravity.Vector @x / v, @y / v

  add: (v) ->
    new Gravity.Vector @x + v.x, @y + v.y

  sub: (v) ->
    new Gravity.Vector @x - v.x, @y - v.y

  sumOfSquares: ->
    @x*@x + @y*@y

  eq: (v) ->
    if v
      @x == v.x && @y == v.y
    else
      false

  toString: ->
    "(#{@x}, #{@y})"
