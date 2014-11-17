angular.module('shouldiorderapizzacomApp')
  .controller 'MainCtrl', [
    'AnswerService'
    class MainCtrl
      constructor: (
        @AnswerService
      ) ->

      init: =>
        @fetchAnswer()

      bylines: [
        'The Age-old Question',
        'The Everlasting Struggle',
        'The Unknowable.',
        'The Eighteen Dollar Question.',
        'The Internet Can Help.'
      ]

      chooseRandom: (array) ->
        array[Math.floor(Math.random() * array.length)]

      fetchAnswer: =>
        @fetchingAnswer = true
        @AnswerService.getAnswer().then (response) =>
          @answer = response.data
          @fetchingAnswer = false
  ]
