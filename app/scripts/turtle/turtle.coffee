
app = angular.module 'ngTurtle', ['ui.bootstrap.buttons']

app.service "Turtle",
  class Turtle
    x: 400
    y: 400
    angle: -270
    write: true
    history: [];
    move: (distance) ->
      @history.push "move "+distance
      x1 = @x
      y1 = @y
      @x =  @x + (parseInt(distance, 10) * Math.cos(parseInt(@angle, 10) * Math.PI / 180))
      @y =  @y - (parseInt(distance, 10) * Math.sin(parseInt(@angle, 10) * Math.PI / 180));
      {x1,y1,@x,@y,@write}
    turn: (angle) ->
      @history.push "turn "+angle
      @angle -= parseInt(angle)

    up: () ->
      @history.push "up"
      @write = false

    down: () ->
      @history.push "up"
      @write = true

app.directive 'turtleCommandPanel', () ->
  priority: 0
  templateUrl: 'scripts/turtle/templates/commandpanel.html'
  replace: false
  transclude: false
  restrict: 'E'
  scope: false
  controller: ($scope, $element, $attrs, $transclude, $rootScope, Turtle) ->
#    $scope.X = Turtle.x
#    $scope.Y = Turtle.y
#    $scope.Angle = Turtle.angle
#    $scope.write = Turtle.write
#    updatingScope = ->
#      $scope.history = Turtle.history
#      $scope.Angle = Turtle.angle
#      $scope.X = Turtle.x
#      $scope.Y = Turtle.y
#      $scope.write = Turtle.write

    $scope.move (deplacement)->
      #save precedente pos
      x1 = Turtle.x
      Turtle.write = deplacement.write
      y1 = Turtle.y
      #deplacement
      if parseInt(deplacement.angle?) != 0
        angle = Turtle.turn(deplacement.angle)
        $rootScope.$broadcast("TurtleTurn",angle)
      if parseInt(deplacement.distance?) != 0
        move = Turtle.move(deplacement.distance)
        $rootScope.$broadcast("TurtleMove",move)
#      updatingScope();
#  compile: (tElement, tAttrs, transclude) ->
#  pre: (scope, iElement, iAttrs, controller) ->
#  post: (scope, iElement, iAttrs, controller) ->
#  link: (scope, iElement, iAttrs) ->

app.directive 'turtleHistoryPanel', () ->
  priority: 0
  templateUrl: 'scripts/turtle/templates/historypanel.html'
  replace: false
  transclude: false
  restrict: 'E'
  scope: {}
  controller: ($scope, $element, $attrs, $transclude, Turtle) ->
    $scope.history = Turtle.history
#  compile: (tElement, tAttrs, transclude) ->
#  pre: (scope, iElement, iAttrs, controller) ->
#  post: (scope, iElement, iAttrs, controller) ->
#  link: (scope, iElement, iAttrs) ->



app.directive 'turtleRenderingPanel', () ->
  priority: 0
  templateUrl: 'scripts/turtle/templates/renderingpanel.html'
  replace: false
  transclude: false
  restrict: 'E'
  scope: {}
  controller: ($scope, $element, $attrs, $transclude, $rootScope,Turtle,$log) ->
    $scope.X = Turtle.x;
    $scope.Y = Turtle.y;
    $scope.Angle = Turtle.angle;
    $scope.write = Turtle.write;
    $scope.$on("TurtleTurn" , (event, angle)->
      $scope.Angle = angle;
      $log.log event
      $log.log angle
    )
    $scope.$on("TurtleMove" , (event, move)->
      $log.log event
      $log.log move
      $scope.X = move.x;
      $scope.Y = move.y;
      if move.write
        $scope.lines.push {'x1': move.x1, 'y1': move.y1, 'x2': move.x, 'y2': move.y}
    )
