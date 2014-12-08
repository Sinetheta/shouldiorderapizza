describe 'geolocation', ->
  window.google =
    maps:
      places:
        PlacesService: {}
      LatLng: class LatLng
        constructor: (@latitude, @longitude) ->

  beforeEach module 'shouldiorderapizzacomApp'
  beforeEach inject (geolocation, $httpBackend, $q, $rootScope, $window) ->
    @geolocation = geolocation
    @$httpBackend = $httpBackend
    @$q = $q
    @$scope = $rootScope.$new()
    @$window = $window

  describe 'getCoords', ->
    describe 'user accepts geolocation request', ->
      beforeEach ->
        @fakePosition = coords: {}
        @$window.navigator.geolocation =
          getCurrentPosition: (success) =>
            success(@fakePosition)

      it 'returns coords from the geolocation API', (done) ->
        @geolocation.getCoords().then (coords) =>
          expect(coords).toBe(@fakePosition.coords)
          done()
        @$scope.$apply()

    describe 'user denies geolocation request', ->
      beforeEach ->
        @errorMessage = 'fail town'
        @$window.navigator.geolocation =
          getCurrentPosition: (success, error) =>
            error(@errorMessage)

      it 'rejects the returned promise', (done) ->
        @geolocation.getCoords().catch (e) =>
          expect(e).toBe(@errorMessage)
          done()
        @$scope.$apply()

  describe 'getCurrentLocation', ->
    describe 'user accepts geolocation request', ->
      beforeEach ->
        @fakeCoords = {latitude: 1, longitude: 2}
        @geolocation.getCoords = =>
          deferred = @$q.defer()
          deferred.resolve(@fakeCoords)
          deferred.promise
        spyOn(window.google.maps, 'LatLng')
        .and.callThrough()

      it 'returns a new google maps LatLng', (done) ->
        @geolocation.getCurrentLocation().then (latlng) =>
          expect(window.google.maps.LatLng).toHaveBeenCalledWith(1, 2)
          done()
        @$scope.$apply()
