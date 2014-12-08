angular.module('shouldiorderapizzacomApp')
.service 'geolocation', [
  '$q'
  '$window'
(
  $q
  $window
) ->
  geolocation = {}

  geolocation.getCoords = ->
    deferred = $q.defer()
    $window.navigator.geolocation.getCurrentPosition (position) ->
      deferred.resolve(position.coords)
    , deferred.reject
    deferred.promise

  geolocation.getCurrentLocation = ->
    geolocation.getCoords().then (coords) ->
      new google.maps.LatLng(coords.latitude, coords.longitude)

  geolocation
]
