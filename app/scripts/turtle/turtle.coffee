
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
  controller: ($scope) ->
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

app.factory "turtleInterpreter" , ($log,Turtle) ->
  class TurtleInterpreter
    sendCommand: (command) ->
      patternMove = ///
      ^(move)+ #move command
      \s+ # with a space
      \-?\ # may be a negative number
      d+$ # the value
      ///
      patternTurn = ///
      ^(turn)+ # the turn command
      \s+ # with a space
      \-? # may be a negative number
      \d+$ # the value
      ///
      patternValue =///
        \+?
        \d+$
      ///

      if command.match patternMove
        value = command.match /\ +\d+$/
        $log.log value
        Turtle.move(value[0])
      if command.match patternTurn
        value = command.match /\ +\d+$/
        $log.log value
        Turtle.turn(value[0])

app.directive 'turtleCodeCommandPanel', (Turtle,turtleInterpreter) ->
  templateUrl: 'scripts/turtle/templates/codecommandpanel.html'
  restrict: 'E'
#  require: 'ngModel'
  controller: ($scope,$log,turtleInterpreter,Turtle)->
    ti = new turtleInterpreter()
    $scope.patternCode = /^(move|turn)+\ +\-?\d+$/
    $scope.addCode = (code,write)->
      $log.log code
      ti.sendCommand  code

#INTEGER_REGEXP = /^\-?\d+$/
#app.directive "validCommand", ($log)->
#  direct=
#    restrict: 'A'
#    link: (scope, elm, attrs)->
#        if INTEGER_REGEXP.test elm.val()
#          $log.log "la valeur est correcte"
#        else
#          $log.log "la valeur est incorrecte"

app.directive 'turtleHistoryPanel', () ->
  templateUrl: 'scripts/turtle/templates/historypanel.html'
  restrict: 'E'

app.directive 'turtleRenderingPanel', () ->
  templateUrl: 'scripts/turtle/templates/renderingpanel.html'
  restrict: 'E'
