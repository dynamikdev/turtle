
app = angular.module 'ngTurtle', []

app.factory "Turtle", ->
  class Turtle
    x: 200
    y: 200
    angle: -90

    move: (distance) ->
      @x =   distance * Math.cos(@angle)
      @y =   distance * Math.sin(@angle)

    turn: (angle) ->
      @angle = angle