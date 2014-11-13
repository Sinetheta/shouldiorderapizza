/*global angular,google*/
'use strict';

angular.module('pizzaApp')
.service('googleMapsPlaces', ['$document', function($document) {
  var requiredEl = angular.element('<div id="google-api-dummy-el"></div>');
  $document.find('body').eq(0).append(requiredEl);

  return new google.maps.places.PlacesService($('#google-api-dummy-el')[0]);
}]);
