describe 'AnswerService', ->

  # load the service's module
  beforeEach module 'shouldiorderapizzacomApp'

  # instantiate service
  AnswerService = $httpBackend = $scope = null
  beforeEach inject (_AnswerService_, _$httpBackend_, $rootScope) ->
    AnswerService = _AnswerService_
    $httpBackend = _$httpBackend_
    $scope = $rootScope.$new()

  describe 'getAnswer', ->
    beforeEach ->
      $httpBackend.when('GET', AnswerService.url)
      .respond({"text": "Yep","explanation": "Because"})

    it 'should request an answer', ->
      AnswerService.getAnswer()
      $httpBackend.flush()

    it 'can be cancelled', (done) ->
      getAnswer = AnswerService.getAnswer()
      getAnswer.error(done)
      getAnswer.cancel()
      $scope.$apply()
