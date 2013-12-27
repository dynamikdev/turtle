
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

app.directive 'turtleCommandPanel', () ->
  priority: 0
  templateUrl: 'scripts/turtle/templates/commandpanel.html'
  replace: false
  transclude: false
  restrict: 'E'
  scope: false
  controller: ($scope, $element, $attrs, $transclude, $rootScope, Turtle) ->
    $scope.move (deplacement)->
      #save precedente pos
      x1 = Turtle.x
      Turtle.write = deplacement.write
      y1 = Turtle.y
      #deplacement
      if parseInt(deplacement.angle?) != 0
        angle = Turtle.turn(deplacement.angle)
#        $rootScope.$broadcast("TurtleTurn",angle)
      if parseInt(deplacement.distance?) != 0
        move = Turtle.move(deplacement.distance)

app.directive 'turtleHistoryPanel', () ->
  priority: 0
  templateUrl: 'scripts/turtle/templates/historypanel.html'
  replace: false
  transclude: false
  restrict: 'E'
  scope: false
  controller: ($scope, $element, $attrs, $transclude, Turtle) ->
    $scope.history = Turtle.history



app.directive 'turtleRenderingPanel', ($log,Turtle) ->
  priority: 0
  templateUrl: 'scripts/turtle/templates/renderingpanel.html'
  replace: false
  transclude: false
  restrict: 'E'
  scope: false #{width : "@width", height : "@height"}
#  link : ($scope, $element, $attrs) ->
##    $log.log($scope.width,$scope.height)
#    Turtle.x = parseInt($scope.width) / 2
#    Turtle.y = parseInt($scope.height) / 2
#    $scope.$watch Turtle.x, -> $scope.X = Turtle.x
#    $scope.$watch Turtle.y, -> $scope.Y = Turtle.y
#    $scope.$watch Turtle.angle, -> $scope.Angle = Turtle.angle
#    $scope.$watch Turtle.write, -> $scope.write = Turtle.write

  controller: ($scope, $element, $attrs, $transclude) ->
    $scope.X = Turtle.x
    $scope.Y = Turtle.y
    $scope.Angle = Turtle.angle
    $scope.write = Turtle.write
    $scope.traces = Turtle.traces
#    $scope.X = Turtle.x
#    $scope.Y = Turtle.y
#    $scope.Angle = Turtle.angle
#    $scope.write = Turtle.write
