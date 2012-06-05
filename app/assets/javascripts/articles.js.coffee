$ ->
  links = $('.publish')

  links.live 'click', (ev) ->
    ev.preventDefault()
    $.ajax
      url: ev.currentTarget
      success: ->
        text = ev.currentTarget.innerHTML
        if text == "Publish"
          ev.currentTarget.innerHTML = "Unpublish"
        else
          ev.currentTarget.innerHTML = "Publish"
