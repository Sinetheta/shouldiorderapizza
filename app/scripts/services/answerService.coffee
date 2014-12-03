angular.module('shouldiorderapizzacomApp')
  .service 'AnswerService', [
    '$http'
    '$q'

    class AnswerService
      constructor: (
        @$http
        @$q
      ) ->

      url: '//floating-refuge-4183.herokuapp.com/shouldi'

      getAnswer: =>
        canceler = @$q.defer()
        promise = @$http.get(@url, {timeout: canceler.promise})
        promise.cancel = canceler.resolve
        promise
  ]
