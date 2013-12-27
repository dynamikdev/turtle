
app = angular.module 'ngTurtle', ['ui.bootstrap.buttons']

app.service "Turtle",
  class Turtle
    x: 400
    y: 400
    angle: -270
    write: true
    history: []
    traces : []
    move: (distance) ->
      @history.push "move "+distance
      x1 = @x
      y1 = @y
      @x =  @x + (parseInt(distance, 10) * Math.cos(parseInt(@angle, 10) * Math.PI / 180))
      @y =  @y - (parseInt(distance, 10) * Math.sin(parseInt(@angle, 10) * Math.PI / 180));
      mv = {"x1":x1,"y1":y1,"x2":@x,"y2":@y,"write":@write}
      @traces.push mv
      mv
    turn: (angle) ->
      @history.push "turn "+angle
      @angle -= parseInt(angle)

    up: () ->
      @history.push "up"
      @write = false

    down: () ->
      @history.push "up"
      @write = true

app.directive 'turtleCommandPanel', (Turtle) ->
  templateUrl: 'scripts/turtle/templates/commandpanel.html'
  restrict: 'E'
  controller: ($scope, $element, $attrs, $transclude) ->
    $scope.move  = (deplacement)->
      #save precedente pos
      x1 = Turtle.x
      Turtle.write = deplacement.write
      y1 = Turtle.y
      #deplacement
      if parseInt(deplacement.angle?) != 0
        angle = Turtle.turn(deplacement.angle)
      if parseInt(deplacement.distance?) != 0
        move = Turtle.move(deplacement.distance)

app.directive 'turtleHistoryPanel', () ->
  templateUrl: 'scripts/turtle/templates/historypanel.html'
  restrict: 'E'

app.directive 'turtleRenderingPanel', () ->
  templateUrl: 'scripts/turtle/templates/renderingpanel.html'
  restrict: 'E'
