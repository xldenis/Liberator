(function() {
return ["<%= escape_javascript(render :partial =>"article_list" )%>","<%= escape_javascript(render :partial =>"index",:locals => {:articles => @front_page_articles}) %>"]
}).call(this);
