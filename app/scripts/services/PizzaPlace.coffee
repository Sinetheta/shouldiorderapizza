angular.module('shouldiorderapizzacomApp')
.factory 'PizzaPlace', [ ->

  class PizzaPlace
    constructor: (options) ->
      angular.extend(this, options)
      @rating ?= 0
]
