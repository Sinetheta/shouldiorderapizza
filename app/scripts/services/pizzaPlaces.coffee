angular.module('shouldiorderapizzacomApp')
.factory 'pizzaPlaces', [
  '$rootScope'
  '$q'
  'googleMapsPlaces'
  'PizzaPlace'
(
  $rootScope
  $q
  googleMapsPlaces
  PizzaPlace
) ->

  new class pizzaPlaces
    getNearbyPizza: (latlng) =>
      pizzaPlaces = []
      deferred = $q.defer()
      pizzaPlaces.$promise = deferred.promise
      request =
        location: latlng
        radius: 5000
        keyword: 'pizza'
        opennow: true
        types: ['meal_delivery']
      googleMapsPlaces.nearbySearch request, (places) ->

        replaceContents pizzaPlaces, places.map (place) ->
          new PizzaPlace(place)
        deferred.resolve(places)
        $rootScope.$apply()
      pizzaPlaces

    getPlaceDetails: (place) =>
      #jshint camelcase: false
      googleMapsPlaces.getDetails
        placeId: place.place_id
      , (details) ->
        angular.extend(place, details)
        $rootScope.$apply()
]

replaceContents = (array, newContents) ->
  Array.prototype.splice.apply(array, [0, array.length].concat(newContents))
