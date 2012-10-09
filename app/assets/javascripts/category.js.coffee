$ ->
  article = $('.article')
  list = $('li',"#list")
  content = $('.content')
  status = $('.status')
  overlay = $('.per-article-overlay')
  #Only load the js if the edit action is actually opened.
  if location.href.indexOf('edit') != -1
    #This function corrects the list of articles and refreshes the draggable / droppable objects
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

    #This function is responsible for the Ajax call when an object is dropped
    livesave =->
      $.ajax {
        url: location.href.substr(0,location.href.length-5 )
        type: 'PUT'
        data: {front_page_articles: serialize()}
        success: (data,status,xhr)->
          ajaxsuccess(xhr,data,status)
      }
    #This function makes sure that the id of the article is included in AJAX calls
    serialize =->
      for elem in article
        do (elem) ->
          if $(elem).data('id') 
            $(elem).data('id')
          else
            "nil"
    #This function makes the articles droppable targets.
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
    #This function is responsible for making items draggable
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
    #Initialize the draggable objects
    enabledroppable()
    enabledraggable()



