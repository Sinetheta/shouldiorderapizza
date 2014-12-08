angular.module('shouldiorderapizzacomApp')
  .controller 'MainCtrl', [
    'AnswerService'
    'geolocation'
    'pizzaPlaces'
    '$q'
    '$timeout'
    class MainCtrl
      constructor: (
        @AnswerService
        @geolocation
        @pizzaPlaces
        @$q
        @$timeout
      ) ->

      init: =>
        @fetchAnswer()
        @byline = @chooseRandom(@bylines)

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
        @getAnswer = @AnswerService.getAnswer()
        .success (answer) =>
          @answer = answer
        .error =>
          @answer = @fakeAnswer

      fakeAnswer:
        text: 'Yes'
        explanation: 'Each moment you\'re not with pizza is a moment you\'re without pizza. Get on your phone or whatever and sort it out. Go.'

      buttonWaitTime: 3000

      shouldi: =>
        @hasUserAsked = true
        if @answer? then return
        panick = @$timeout(@getAnswer.cancel, @buttonWaitTime)
        @getAnswer.then(panick.cancel)

      showAnswer: =>
        @hasUserAsked and @answer?

      showFindButton: =>
        @hasUserAsked and @answer? and not @findUserPizza

      lookForPizza: =>
        @findUserPizza = true
        @promptGeoAllow = true
        @geolocation.getCurrentLocation()
        .then (location) =>
          @promptGeoAllow = false
          @getNearbyPizza(location)
        , =>
          @promptGeoAllow = false
          @geolocationError = true

      getNearbyPizza: (location) =>
        @pizzaPlaces.getNearbyPizza(location)
        .then (places) =>
          topResults = places.slice(0, 3)
          getDetails = topResults.map(@pizzaPlaces.getPlaceDetails)
          @$q.all(getDetails)
        .then (details) =>
          @pizzaPlaces = details
  ]
