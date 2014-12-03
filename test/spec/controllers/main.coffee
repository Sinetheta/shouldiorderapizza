describe 'Controller: MainCtrl', ->
  MainCtrl = AnswerService = $httpBackend = $scope = $timeout = null

  beforeEach module 'shouldiorderapizzacomApp'

  beforeEach inject (_$timeout_, _$httpBackend_, $controller, $rootScope, _AnswerService_) ->
    $httpBackend = _$httpBackend_
    $scope = $rootScope.$new()
    $timeout = _$timeout_
    AnswerService = _AnswerService_

    MainCtrl = $controller 'MainCtrl',
      $scope: $scope
      AnswerService: AnswerService
      geolocation: {}
      pizzaPlaces: {}

  describe 'chooseRandom', ->
    it 'should return a random member of an array', ->
      expect(MainCtrl.chooseRandom(['a', 'b'])).toMatch /a|b/


  describe 'API responds fast enough', ->
    realAnswer = {"text": "Yep","explanation": "Because"}

    beforeEach ->
      spyOn(AnswerService, 'getAnswer').and.callThrough()
      $httpBackend.expectGET(AnswerService.url)
      .respond(200, realAnswer)

    flow 'Should I order a pizza?', (start) ->
      start
      .step 'loading flag should begin undefined', ->
        expect(MainCtrl.hasUserAsked).toBeUndefined()

      .step 'request an answer', ->
        MainCtrl.fetchAnswer()
        expect(AnswerService.getAnswer).toHaveBeenCalled()

      .step 'user asks for answer', ->
        MainCtrl.shouldi()
        expect(MainCtrl.hasUserAsked).toBe(true)

      .step 'resolve the request', ->
        $httpBackend.flush()
        expect(MainCtrl.answer).toEqual(realAnswer)


  describe 'API fails to respond in time', ->
    beforeEach ->
        spyOn(AnswerService, 'getAnswer').and.callThrough()
        $httpBackend.expectGET(AnswerService.url)
        .respond(500)

    flow 'Should I order a pizza?', (start) ->
      fakeAnswer = {"text": "Yep","explanation": "Because"}

      start
      .step 'loading flag should begin undefined', ->
        expect(MainCtrl.hasUserAsked).toBeUndefined()

      .step 'request an answer', ->
        MainCtrl.fetchAnswer()
        expect(AnswerService.getAnswer).toHaveBeenCalled()

      .step 'user asks for answer', ->
        MainCtrl.shouldi()
        expect(MainCtrl.hasUserAsked).toBe(true)

      .step 'reach the wait time limit', ->
        $timeout.flush()
        expect(MainCtrl.answer).toEqual(MainCtrl.fakeAnswer)
