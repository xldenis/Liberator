$ ->
  article = $('.article')
  submit = $('#submit')
  list = $('li',"#list")
  content = $('.content')
  status = $('.status')

  ajaxsuccess = (xhr,data,status) ->
    data = eval data
    data_list = data[0]
    html = data[1]
    list.remove()
    $('#list').append data_list
    enabledraggable()
    article.droppable "destroy"
    content.html html
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
    article.droppable accept: "#list >li",
      drop: (event, ui) ->
        $(@).html ui.draggable
        $(@).data 'id',ui.draggable.data 'id'
        livesave()
      over: (event,ui) ->
        $(@).animate({'backgroundColor': '#000 !important '})
      out: (event,ui) ->
        child.animate({'backgroundColor': '#FFF'})
    true

  enabledraggable=-> 
    list = $('li',"#list")
    list.draggable 
      cancel: "a.ui-icon",
      revert: "invalid",
      helper: "clone",
      cursor: "move"
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

