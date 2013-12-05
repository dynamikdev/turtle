'use strict';
angular.module('turtleApp', ['ngRoute'])
    .config(function ($routeProvider) {
        $routeProvider
            .when('/', {
                templateUrl: 'views/main.html',
                controller: 'MainCtrl'
            })
            .otherwise({
                redirectTo: '/'
            });
    })
    .factory('turtle', function () {
        var Turtle;
        Turtle = (function () {
            function Turtle() {
            }

            Turtle.prototype.x = 200;
            Turtle.prototype.y = 200;
            Turtle.prototype.angle = -90;
            Turtle.prototype.move = function (distance) {
                this.x = distance * Math.cos(this.angle);
                this.y = distance * Math.sin(this.angle);
                return this;
            };
            Turtle.prototype.turn = function (angle) {
                this.angle = angle;
                return this;
            };
        })();
        return Turtle;
    });
