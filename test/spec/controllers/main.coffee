describe 'Controller: MainCtrl', ->
  MainCtrl = AnswerService = geolocation = $httpBackend = $scope = $timeout = null

  beforeEach module 'shouldiorderapizzacomApp'

  beforeEach inject (_$timeout_, _$httpBackend_, $controller, $q, $rootScope, _AnswerService_) ->
    $httpBackend = _$httpBackend_
    @$q = $q
    geolocation = {foo: 'bar'}
    $scope = $rootScope.$new()
    $timeout = _$timeout_
    AnswerService = _AnswerService_

    MainCtrl = $controller 'MainCtrl',
      $scope: $scope
      AnswerService: AnswerService
      geolocation: geolocation
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

  describe 'lookForPizza', ->
    beforeEach ->
      spyOn(MainCtrl, 'getNearbyPizza')

    describe 'user accepts geolocation request', ->
      fakeLocation = {latitude: 1, longitude: 2}
      beforeEach ->
        geolocation.getCurrentLocation = =>
          deferred = @$q.defer()
          deferred.resolve(fakeLocation)
          deferred.promise
        spyOn(geolocation, 'getCurrentLocation').and.callThrough()

      flow 'search for neaby pizza', (start) ->
        start
        .step 'loading flags should begin undefined', ->
          expect(MainCtrl.findUserPizza).toBeUndefined()
          expect(MainCtrl.promptGeoAllow).toBeUndefined()

        .step 'initiate a search', ->
          MainCtrl.lookForPizza()
          expect(geolocation.getCurrentLocation).toHaveBeenCalled()

        .step 'set teaser flag', ->
          expect(MainCtrl.findUserPizza).toBe(true)

        # .step 'encourage user to answer prompt', ->
        #   expect(MainCtrl.promptGeoAllow).toBe(true)

        .step 'user accepts request', ->
          $scope.$apply()
          expect(MainCtrl.promptGeoAllow).toBe(false)

        .step 'find neaby pizza', ->
          $scope.$apply()
          expect(MainCtrl.getNearbyPizza).toHaveBeenCalledWith(fakeLocation)

    describe 'user rejects geolocation request', ->
      beforeEach ->
        geolocation.getCurrentLocation = =>
          deferred = @$q.defer()
          deferred.reject({ code: 1, message: 'User denied Geolocation' })
          deferred.promise
        spyOn(geolocation, 'getCurrentLocation').and.callThrough()

      flow 'search for neaby pizza', (start) ->
        start
        .step 'loading flags should begin undefined', ->
          expect(MainCtrl.findUserPizza).toBeUndefined()
          expect(MainCtrl.promptGeoAllow).toBeUndefined()

        .step 'initiate a search', ->
          MainCtrl.lookForPizza()
          expect(geolocation.getCurrentLocation).toHaveBeenCalled()

        .step 'set teaser flag', ->
          expect(MainCtrl.findUserPizza).toBe(true)

        # .step 'encourage user to answer prompt', ->
        #   expect(MainCtrl.promptGeoAllow).toBe(true)

        .step 'user denies request', ->
          $scope.$apply()
          expect(MainCtrl.promptGeoAllow).toBe(false)

        .step 'set error flag', ->
          $scope.$apply()
          expect(MainCtrl.geolocationError).toBe(true)
