$ ->
  $("body").bind "click", (e) ->
    $(".dropdown-toggle, .menu").parent("li").removeClass "open"

  $(".dropdown-toggle, .menu").click (e) ->
    $li = $(this).parent("li").toggleClass("open")
    false
