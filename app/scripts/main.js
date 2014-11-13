'use strict';

var chooseRandom = function(array) {
  return array[Math.floor(Math.random() * array.length)];
};

var byline = chooseRandom(window.bylines);
$('.ribbon').text(byline);


$('.should-i').on('click', function() {
  var answer = chooseRandom(window.answers);
  var mainContent = $('.main-content');
  mainContent.empty();
  $('<h2>').text(answer.text).appendTo(mainContent);
  $('<p>').text(answer.explanation).appendTo(mainContent);
});
