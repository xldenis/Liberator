$ ->
  article = $('.article')
  submit = $('#submit')
  list = $('li',"#list")
  content = $('.content')
  status = $('.status')
  overlay = $('.per-article-overlay')
  ajaxsuccess = (xhr,data,status) ->
    data = eval data
    data_list = data[0]
    html = data[1]
    list.remove()
    $('#list').append data_list
    article.droppable "destroy"
    content.html html
    enabledraggable()
    enabledroppable()

  status.live 'click',->
    $('#layout-menu').toggleClass 'open'
  livesave =->
    $.ajax {
      url: location.href.substr(0,location.href.length-5 )
      type: 'PUT'
      data: {front_page_articles: serialize()}
      success: (data,status,xhr)->
        ajaxsuccess(xhr,data,status)
    }
  serialize =->
    for elem in article
      do (elem) ->
        if $(elem).data('id') 
          $(elem).data('id')
        else
          "nil"

  enabledroppable =->
    article = $('.article') 
    article.droppable accept: "#list >li,.article,.per-article-overlay",
      drop: (event, ui) ->
        window.test = event
        window.ui = ui
        

        $(@).data 'id',ui.draggable.data 'id'
        if(ui.draggable.hasClass('article'))
          $(ui.draggable).data 'id', 'nil'
        livesave()
      over: (event,ui) ->
        $(@).children().first().toggleClass 'overlay-edit'
      out: (event,ui) ->
        $(@).children().first().toggleClass 'overlay-edit'
    true

  enabledraggable=-> 
    list = $('li',"#list")
    article= $('.article')
    list.draggable 
      cancel: "a.ui-icon",
      revert: "invalid",
      helper: "clone",
      cursor: "move",
      cursorAt:
        top: 32,
        left: 120
    article.draggable
      cancel: "a.ui-icon",
      revert: "invalid",
      helper: ->
        li= $(document.createElement 'li' ).toggleClass 'dragging'
        $(li).html $(@).find('h2>a').html()
      cursor: "move",
      cursorAt: 
        left: 120,
        top: 32
      start: (ev)->
        $(@).find('.per-article-overlay').css('opacity','0')
      stop: (ev)->
        $(@).find('.per-article-overlay').css('opacity','1')
    true

  enabledroppable()
  enabledraggable()
  article.live 'ajaxSuccess', (xhr,data,status) ->
    ajaxsuccess(xhr,data,status)
  submit.live 'ajax:before',->
    $(this).data('params',{front_page_articles: serialize()})

  submit.live 'ajax:success', (xhr,data,status) ->
    ajaxsuccess(xhr,data,status)

  true

