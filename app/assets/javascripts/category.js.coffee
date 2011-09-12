$ ->
  article = $('.article')
  list = $('li',"#list")
  submit = $('#submit')
  serialize =->
    for elem in article
      do (elem) ->
        if $(elem).data('id') 
          $(elem).data('id')
        else
          "nil"
     
  list.draggable 
    cancel: "a.ui-icon",
    revert: "invalid",
    helper: "clone",
    cursor: "move"
  article.droppable accept: "#list >li", 
    drop: (event, ui) -> 
      $(@).html ui.draggable
      $(@).data 'id',ui.draggable.data 'id' 
  submit.live 'ajax:before',->
    $(this).data('params',{front_page_articles: serialize()})
  true
  
