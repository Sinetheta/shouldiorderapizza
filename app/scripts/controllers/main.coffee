angular.module('shouldiorderapizzacomApp')
  .controller 'MainCtrl', [
    'AnswerService'
    'browser'
    'geolocation'
    'pizzaPlaces'
    '$analytics'
    '$interval'
    '$q'
    '$timeout'
    class MainCtrl
      constructor: (
        @AnswerService
        @browser
        @geolocation
        @pizzaPlaces
        @$analytics
        @$interval
        @$q
        @$timeout
      ) ->

      init: =>
        @fetchAnswer()
        @byline = @chooseRandom(@bylines)

      bylines: [
        'The Age-old Question.',
        'The Guidance You Need.',
        'Let Us Help You.',
        'The Eighteen Dollar Question.',
        'The Internet Can Help.'
      ]

      chooseRandom: (array) ->
        array[Math.floor(Math.random() * array.length)]

      ask: (answerTarget) =>
        @hasUserAsked = true
        target = $(answerTarget)
        @waitForVisible(target).then ->
          $.scrollTo(target) unless target.isScrolledIntoView()

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

      showGeoPrompt: =>
        @browser() is 'chrome' and @promptGeoAllow and !@geolocationError

      isLookingForPizza: =>
        @findUserPizza and !@pizzaJoints? and !@geolocationError

      lookForPizza: =>
        @findUserPizza = true
        prompt = @$timeout =>
          @promptGeoAllow = true
        , 3000
        @geolocation.getCurrentLocation()
        .then (location) =>
          @$timeout.cancel(prompt)
          @promptGeoAllow = false
          @getNearbyPizza(location)
        , (error) =>
          @promptGeoAllow = false
          @geolocationError = true
          @$analytics.eventTrack 'error',
            category: 'geolocation'
            label: error.message
            value: error.code

      getNearbyPizza: (location) =>
        @pizzaJoints = @pizzaPlaces.getNearbyPizza(location)

      fetchDetails: (pizzaJoint) =>
        pizzaJoint.details = true
        @pizzaPlaces.getPlaceDetails(pizzaJoint)
        @$analytics.eventTrack 'click',
          category: 'details'
          label: pizzaJoint.name

      roundRating: (rating) ->
        halfCount = Math.round(rating * 2)
        "half-filled-stars-#{halfCount}"

      waitForVisible: (target) =>
        deferred = @$q.defer()
        stop = @$interval =>
          if target.is(':visible')
            deferred.resolve()
            @$interval.cancel(stop)
        , 10
        deferred.promise
  ]
