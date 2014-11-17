describe 'Controller: MainCtrl', ->
  MainCtrl = MockAnswerService = $scope = null

  beforeEach module 'shouldiorderapizzacomApp'
  beforeEach module 'mockAnswerService'

  beforeEach inject ($controller, $rootScope, _MockAnswerService_) ->
    $scope = $rootScope.$new()
    MockAnswerService = _MockAnswerService_

    MainCtrl = $controller 'MainCtrl',
      $scope: $scope
      AnswerService: MockAnswerService

  describe 'chooseRandom', ->
    it 'should return a random member of an array', ->
      expect(MainCtrl.chooseRandom(['a', 'b'])).toMatch /a|b/

  flow "fetchAnswer", (start) ->
    start
    .step 'loading flag should begin undefined', ->
      expect(MainCtrl.fetchingAnswer).toBeUndefined()

    .step 'request an answer', ->
      MainCtrl.fetchAnswer()
      expect(MainCtrl.fetchingAnswer).toBe true
      expect(MockAnswerService.getAnswer).toHaveBeenCalled()

    .step 'resolve the request', ->
      MockAnswerService.resolveRequest()
      $scope.$apply()
      expect(MainCtrl.fetchingAnswer).toBe false
      expect(MainCtrl.answer).toBe MockAnswerService.fakeAnswer
