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
    $scope.write = Turtle.write;

    $scope.lines = [
    ];
    $scope.history = [];
    var updatingScope = function(){
        $scope.history = Turtle.history;
        $scope.Angle = Turtle.angle;
        $scope.X = Turtle.x;
        $scope.Y = Turtle.y;
        $scope.write = Turtle.write;
    }
    $scope.addLine = function (line) {
        console.log(line);
        $scope.lines.push(angular.copy(line));
    };

    $scope.move = function (deplacement) {
        //save precedente pos
        var x1 = Turtle.x;
        Turtle.write = deplacement.write;
        var y1 = Turtle.y;
        //deplacement
        if (!angular.isUndefined(deplacement.angle) && deplacement.angle != "" && parseInt(deplacement.angle,10) != 0){
            Turtle.turn(deplacement.angle);
        }
        if (!angular.isUndefined(deplacement.distance) && deplacement.distance != "" && parseInt(deplacement.distance) != 0){
            var move = Turtle.move(deplacement.distance);
            if (move.write){
                $scope.lines.push({'x1': move.x1, 'y1': move.y1, 'x2': move.x, 'y2': move.y});
            }
        }
        //pousse histo

        //mise a jour position et sens
        updatingScope();
//        $scope.$apply();
        //-------------
        $log.log(Turtle);
    };

};
