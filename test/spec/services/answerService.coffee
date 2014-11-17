describe 'AnswerService', ->

  # load the service's module
  beforeEach module 'shouldiorderapizzacomApp'

  # instantiate service
  AnswerService = $httpBackend = {}
  beforeEach inject (_AnswerService_, _$httpBackend_) ->
    AnswerService = _AnswerService_
    $httpBackend = _$httpBackend_

  describe 'getAnswer', ->
    beforeEach ->
      console.log 'before'
      $httpBackend.when('GET', AnswerService.url)
      .respond({"text": "Yep","explanation": "Because"})

    it 'should request an answer', ->
      console.log 'it'
      $httpBackend.expectGET(AnswerService.url)
      AnswerService.getAnswer()
      $httpBackend.flush()
