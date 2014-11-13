/*global angular,google*/
'use strict';

angular.module('pizzaApp')
.service('geolocation', ['$q', '$window', function($q, $window) {
  var geolocation = {};

  geolocation.getCurrentLocation = function() {
    var deferred = $q.defer();

    $window.navigator.geolocation.getCurrentPosition(function(position) {
      var latitude = position.coords.latitude;
      var longitude = position.coords.longitude;
      var latlng = new google.maps.LatLng(latitude, longitude);

      deferred.resolve(latlng);
    }, deferred.reject);

    return deferred.promise;
  };

  return geolocation;
}]);
