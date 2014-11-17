angular.module('shouldiorderapizzaApp')
  .controller 'MainCtrl',
    class MainCtrl
      constructor: (
        @$log
      ) ->

      bylines: [
        'The Age-old Question',
        'The Everlasting Struggle',
        'The Unknowable.',
        'The Eighteen Dollar Question.',
        'The Internet Can Help.'
      ]

      chooseRandom: (array) ->
        array[Math.floor(Math.random() * array.length)]

      lookForPizza: ->
        @$log.log('gimme pizza!')
