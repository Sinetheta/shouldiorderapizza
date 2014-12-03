angular.module('shouldiorderapizzacomApp')
.factory 'pizzaPlaces', [
  '$q'
  'googleMapsPlaces'
(
  $q
  googleMapsPlaces
) ->

  new class pizzaPlaces
    getNearbyPizza: (latlng) =>
      deferred = $q.defer()
      request =
        location: latlng
        radius: 5000
        keyword: 'pizza'
        opennow: true
        types: ['meal_delivery']
      googleMapsPlaces.nearbySearch request, (places) ->
        deferred.resolve(places)
      deferred.promise

    getPlaceDetails: (place) =>
      deferred = $q.defer()
      #jshint camelcase: false
      googleMapsPlaces.getDetails
        placeId: place.place_id
      , (details) ->
        deferred.resolve(details)
      deferred.promise
]
