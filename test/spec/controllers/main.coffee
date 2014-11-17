describe 'Controller: MainCtrl', ->
  MainCtrl = $scope = null

  beforeEach module 'shouldiorderapizzacomApp'

  beforeEach inject ($controller, $rootScope) ->
    $scope = $rootScope.$new()

    MainCtrl = $controller 'MainCtrl',
      $scope: $scope

  describe 'chooseRandom', ->
    it 'should return a random member of an array', ->
      expect(MainCtrl.chooseRandom(['a', 'b'])).toMatch /a|b/

