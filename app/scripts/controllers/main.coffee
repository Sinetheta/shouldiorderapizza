'use strict'

###*
 # @ngdoc function
 # @name shouldiorderapizzaApp.controller:MainCtrl
 # @description
 # # MainCtrl
 # Controller of the shouldiorderapizzaApp
###
angular.module('shouldiorderapizzaApp')
  .controller 'MainCtrl', ($scope) ->
    $scope.awesomeThings = [
      'HTML5 Boilerplate'
      'AngularJS'
      'Karma'
    ]
