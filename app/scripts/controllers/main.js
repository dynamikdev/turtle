'use strict';
//angular.factory()

//    .factory('turtle',function(){
//        var turtle;
//        turtle = new Turtle();
//        return turtle;
//
//    });
var MainCtrl = function ($scope, $log, Turtle) {



    $scope.X = Turtle.x;
    $scope.Y = Turtle.y;
    $scope.Angle = Turtle.angle;

    $scope.lines = [
    ];
    $scope.history = [];
    var updatingScope = function(){
        $scope.history = Turtle.history;
        $log.log($scope.history);
        $scope.Angle = Turtle.angle;
        $scope.X = Turtle.x;
        $scope.Y = Turtle.y;
    }
    $scope.addLine = function (line) {
        console.log(line);
        $scope.lines.push(angular.copy(line));
    };
    $scope.move = function (deplacement) {
        //save precedente pos
        var x1 = Turtle.x;
        var y1 = Turtle.y;
        //deplacement
        if (!angular.isUndefined(deplacement.angle) && deplacement.angle != "" && parseInt(deplacement.angle,10) != 0){
            Turtle.turn(deplacement.angle);
        }
        if (!angular.isUndefined(deplacement.distance) && deplacement.distance != "" && parseInt(deplacement.distance) != 0){
            Turtle.move(deplacement.distance);
        }
        //pousse histo
        $scope.lines.push({'x1': x1, 'y1': y1, 'x2': Turtle.x, 'y2': Turtle.y});
        //mise a jour position et sens
        updatingScope();
//        $scope.$apply();
        //-------------
        $log.log(Turtle);
    };

};
