angular.module('shouldiorderapizzacomApp')
  .service 'AnswerService',
    class AnswerService
      constructor: (
        @$http
      ) ->

      url: '//floating-refuge-4183.herokuapp.com/shouldi'

      getAnswer: ->
        @$http.get(@url)
