angular.module('shouldiorderapizzaApp')
  .controller 'MainCtrl', ($scope, $log) ->
    $scope.lookForPizza = ->
      $log.log('gimme pizza!')
