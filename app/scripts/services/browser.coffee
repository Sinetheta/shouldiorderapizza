angular.module('shouldiorderapizzacomApp')
.service 'browser', [
  '$window'
(
  $window
) ->
  whichBrowser = ->
    userAgent = $window.navigator.userAgent
    browsers =
      chrome: /chrome/i
      safari: /safari/i
      firefox: /firefox/i
      ie: /internet explorer/i

    for name, regexp of browsers
      if regexp.test(userAgent) then return name
    return 'unknown'
]
