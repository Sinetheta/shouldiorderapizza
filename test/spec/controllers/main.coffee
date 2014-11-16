'use strict'

describe 'Controller: MainCtrl', ->

  # load the controller's module
  beforeEach module 'shouldiorderapizzaApp'

  $log = $scope = null

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope, _$log_) ->
    $scope = $rootScope.$new()
    $log = _$log_

    spyOn($log, 'log')

    MainCtrl = $controller 'MainCtrl',
      $log: $log
      $scope: $scope

  describe 'lookForPizza', ->
    it 'should log to console', ->
      $scope.lookForPizza()
      expect($log.log).toHaveBeenCalled()
