'use strict'

describe 'Controller: MainCtrl', ->

  # load the controller's module
  beforeEach module 'shouldiorderapizzaApp'

  MainCtrl = $log = null

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope, _$log_) ->
    $scope = $rootScope.$new()
    $log = _$log_

    spyOn($log, 'log')

    MainCtrl = $controller 'MainCtrl',
      $log: $log
      $scope: $scope

  describe 'chooseRandom', ->
    it 'should return a random member of an array', ->
      expect(MainCtrl.chooseRandom(['a', 'b'])).toMatch /a|b/

  describe 'lookForPizza', ->
    it 'should log to console', ->
      MainCtrl.lookForPizza()
      expect($log.log).toHaveBeenCalled()
