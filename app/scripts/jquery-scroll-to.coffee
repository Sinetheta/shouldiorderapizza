$.scrollTo = (target) ->
  $('html, body').animate
      scrollTop: target.offset().top
  , 250
