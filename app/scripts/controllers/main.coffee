angular.module('shouldiorderapizzaApp')
  .controller 'MainCtrl',
    class MainCtrl
      constructor: (
        @$log
      ) ->

      lookForPizza: ->
        @$log.log('gimme pizza!')
