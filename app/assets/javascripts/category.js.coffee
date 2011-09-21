$ ->
  article = $('.article')
  list = $('li',"#list")
  submit = $('#submit')
  content = $('.content')
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
    true
  list.draggable 
    cancel: "a.ui-icon",
    revert: "invalid",
    helper: "clone",
    cursor: "move"
  enabledroppable()
  submit.live 'ajax:before',->
    $(this).data('params',{front_page_articles: serialize()})
  submit.live 'ajax:success',(xhr,data,status) ->
    html = eval data
    article.droppable "destroy"
    content.html html
    enabledroppable()
    true
  true
  
