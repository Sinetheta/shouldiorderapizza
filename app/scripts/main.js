'use strict';

var chooseRandom = function(array) {
  return array[Math.floor(Math.random() * array.length)];
};

var byline = chooseRandom(window.bylines);
$('.ribbon').text(byline);
