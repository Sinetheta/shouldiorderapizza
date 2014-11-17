angular.module('mockAnswerService', [])
.service 'MockAnswerService', ($q) ->

  MockAnswerService = jasmine.createSpyObj('MockAnswerService', ['getAnswer'])

  MockAnswerService.fakeAnswer = {}
  MockAnswerService.fakeResponse = $q.defer()
  MockAnswerService.resolveRequest = ->
    MockAnswerService.fakeResponse.resolve({data: MockAnswerService.fakeAnswer})

  MockAnswerService.getAnswer.and.returnValue(MockAnswerService.fakeResponse.promise)

  MockAnswerService
