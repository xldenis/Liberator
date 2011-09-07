$ ->
  article = $('.article')
  list = $('li',"#list")
  list.draggable 
    cancel: "a.ui-icon",
    revert: "invalid",
    helper: "clone",
    cursor: "move"
  article.droppable accept: "#list >li", 
    drop: (event, ui) -> 
      $(@).html ui.draggable
    
  
  true
  
