/*global angular*/
'use strict';

angular.module('pizzaApp', [])
.controller('pageController', [
  '$q',
  '$scope',
  'geolocation',
  'pizzaPlaces',
  function($q, $scope, geolocation, pizzaPlaces) {

    $scope.hideResults = function() {
      return $scope.looking || ($scope.pizzaPlaces || []).length === 0;
    };

    $scope.hideNoResults = function() {
      return $scope.looking || ($scope.pizzaPlaces || []).length > 0;
    };

    $scope.lookForPizza = function() {
      $scope.hasSearched = true;
      $scope.looking = true;

      geolocation.getCurrentLocation()
      .then(pizzaPlaces.getNearbyPizza)
      .then(function(places) {
        var topResults = places.slice(0, 3);
        var getDetails = topResults.map(pizzaPlaces.getPlaceDetails);
        return $q.all(getDetails);
      }).then(function(details) {
        $scope.pizzaPlaces = details;
        $scope.looking = false;
      });
    };
  }
]);
