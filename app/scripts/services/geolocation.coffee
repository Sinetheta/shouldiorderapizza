angular.module('shouldiorderapizzacomApp')
.service 'geolocation', [
  '$q'
  '$window'
(
  $q
  $window
) ->
  geolocation = {}

  geolocation.getCurrentLocation = ->
    deferred = $q.defer()
    $window.navigator.geolocation.getCurrentPosition (position) ->
      latitude = position.coords.latitude
      longitude = position.coords.longitude
      latlng = new google.maps.LatLng(latitude, longitude)
      deferred.resolve(latlng)
    , deferred.reject
    deferred.promise

  geolocation
]
