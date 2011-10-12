$ ->
  article = $('.article')
  submit = $('#submit')
  list = $('div',"#list").not(':first')
  content = $('.content')
  status = $('#status')
  status.live 'click',->
    $('#list').toggleClass 'open'
  serialize =->
    for elem in article
      do (elem) ->
        if $(elem).data('id') 
          $(elem).data('id')
        else
          "nil"
  enabledroppable =->
    article = $('.article') 
    article.droppable accept: "#list >div",
      drop: (event, ui) ->
        $(@).html ui.draggable
        $(@).data 'id',ui.draggable.data 'id'
    true
  enabledraggable=-> 
    list = $('div',"#list").not(':first')
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
  submit.live 'ajax:success',(xhr,data,status) ->
    data = eval data
    data_list = data[0]
    html = data[1]
    list.remove()
    $('#list').append data_list
    enabledraggable()
    article.droppable "destroy"
    alert html
    content.html html
    enabledroppable()
    true
  true
  
