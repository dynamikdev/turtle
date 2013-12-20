
app = angular.module 'ngTurtle', []

app.factory "Turtle", ->
  class Turtle
    x: 400
    y: 400
    angle: -270
    write: true

    move: (distance) ->
      @x =  @x + (parseInt(distance, 10) * Math.cos(parseInt(@angle, 10) * Math.PI / 180))
      @y =  @y - (parseInt(distance, 10) * Math.sin(parseInt(@angle, 10) * Math.PI / 180));

    turn: (angle) ->
      @angle -= parseInt(angle)

    up: () ->
      @write = false

    down: () ->
      @write = true
  new Turtle