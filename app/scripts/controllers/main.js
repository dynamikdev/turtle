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
    $scope.history = [
    ];

    $scope.addLine = function (line) {
        console.log(line);
        $scope.lines.push(angular.copy(line));
    };
    $scope.move = function (deplacement) {
        //save precedente pos
        var x1 = Turtle.x;
        var y1 = Turtle.y;
        //deplacement
        Turtle.turn(deplacement.angle);
        Turtle.move(deplacement.distance);
        //pousse histo
        $scope.lines.push({'x1': x1, 'y1': y1, 'x2': Turtle.x, 'y2': Turtle.y});
        //mise a jour position et sens
        $scope.Angle = Turtle.angle;
        $scope.X = Turtle.x;
        $scope.Y = Turtle.y;
        //-------------
        $log.log(Turtle);
    };

};
