angular.module('shouldiorderapizzacomApp')
  .controller 'MainCtrl',
    class MainCtrl
      constructor: (
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

