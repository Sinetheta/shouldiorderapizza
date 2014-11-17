angular.module('shouldiorderapizzaApp')
  .controller 'MainCtrl',
    class MainCtrl
      constructor: (
        @$log
      ) ->

      chooseRandom: (array) ->
        array[Math.floor(Math.random() * array.length)]

      lookForPizza: ->
        @$log.log('gimme pizza!')
