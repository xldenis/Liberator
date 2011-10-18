$ ->
  article = $('.article')
  submit = $('#submit-button')
  list = $('div',"#layout-menu")
  content = $('.content')
  toggle = $('#toggle')

  toggle.live 'click',->
    $('#article-list').toggleClass 'open'
  
  serialize =->
    for elem in article
      do (elem) ->
        if $(elem).data('id') 
          $(elem).data('id')
        else
          "nil"

  enabledroppable =->
    article = $('.article') 
    article.droppable accept: "#article-list >li",
      drop: (event, ui) ->
        $(@).html ui.draggable
        $(@).data 'id',ui.draggable.data 'id'
    true

  enabledraggable=->
    list = $('ul',"#article-list")
    list.draggable
      cancel: "a.ui-icon",
      revert: "invalid",
      helper: "clone",
      cursor: "move"
    true

  enabledroppable()
  enabledraggable()

  submit.live 'ajax:before',->
    $(this).data('params',{front_page_articles: serialize()})

  submit.live 'ajax:success',(xhr,data,toggle) ->
    data = eval data
    data_list = data[0]
    html = data[1]
    list.remove()
    $('#article-list').append data_list
    enabledraggable()
    article.droppable "destroy"
    content.html html
    enabledroppable()
    true
  true
  
