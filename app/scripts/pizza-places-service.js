/*global angular*/
'use strict';

angular.module('pizzaApp')
.service('pizzaPlaces', ['$q', 'googleMapsPlaces', function($q, googleMapsPlaces) {
  var pizzaPlaces = {};

  pizzaPlaces.getNearbyPizza = function(latlng) {
    var deferred = $q.defer();
    var request = {
      location: latlng,
      radius: 5000,
      keyword: 'pizza',
      opennow: true,
      types: ['meal_delivery']
    };
    googleMapsPlaces.nearbySearch(request, function(places) {
      deferred.resolve(places);
    });
    return deferred.promise;
  };

  pizzaPlaces.getPlaceDetails = function(place) {
    var deferred = $q.defer();
    /*jshint camelcase: false */
    googleMapsPlaces.getDetails({placeId: place.place_id}, function (details) {
      deferred.resolve(details);
    });
    return deferred.promise;
  };

  return pizzaPlaces;
}]);
