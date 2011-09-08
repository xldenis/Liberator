$ ->
  article = $('.article')
  list = $('li',"#list")
  submit = $('#submit')
  serialize =->
    for elem in article
      do (elem) ->
        $(elem).contents().attr('id')

     
  list.draggable 
    cancel: "a.ui-icon",
    revert: "invalid",
    helper: "clone",
    cursor: "move"
  article.droppable accept: "#list >li", 
    drop: (event, ui) -> 
      $(@).html ui.draggable
      
  submit.live 'ajax:beforeSend',(xhr) ->
    xhr.data.append serialize()
    true
  true
  
