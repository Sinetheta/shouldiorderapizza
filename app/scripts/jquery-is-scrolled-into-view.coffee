$.fn.isScrolledIntoView = ->
  docViewTop = $(window).scrollTop()
  docViewBottom = docViewTop + $(window).height()

  elemTop = $(this).offset().top
  elemBottom = elemTop + $(this).height()

  ((elemBottom <= docViewBottom) && (elemTop >= docViewTop))
