angular.module('shouldiorderapizzacomApp')
  .service 'googleMapsPlaces', [
    '$document'
  (
    $document
  ) ->
    requiredEl = angular.element('<div id="google-api-dummy-el"></div>')
    $document.find('body').eq(0).append(requiredEl)

    new google.maps.places.PlacesService(requiredEl[0])
  ]
