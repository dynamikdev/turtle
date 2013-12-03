'use strict';

angular.module('turtleApp',[])
    .factory('turtle',function(){
        var turtle;
        turtle = new Turtle();
        return turtle;

    })
  .controller('MainCtrl', function ($scope,$log,$turtle) {

    $scope.X = 400;
    $scope.Y = 400;
    $scope.Angle = 90 - 360;

    $scope.lines=[
    ];
    $scope.history=[
    ];

        $scope.addLine = function(line){

        console.log(line);
        $scope.lines.push(angular.copy(line));
      };
    $scope.move = function(deplacement){
        $scope.Angle =$scope.Angle - parseInt(deplacement.angle);
        var x2 = $scope.X+(parseInt(deplacement.distance) * Math.cos(parseInt($scope.Angle)*Math.PI/180));
        var y2 = $scope.Y-(parseInt(deplacement.distance) * Math.sin(parseInt($scope.Angle)*Math.PI/180));
        $scope.lines.push({'x1':$scope.X ,'y1':$scope.Y,'x2':x2,'y2':y2});
        $scope.X = x2;
        $scope.Y=y2;

        $log.log($scope);
      };

  });
