module ApplicationHelper
def markdown(text)
  _text = text
  
  options = Hash[:hard_wrap,true, :autolink,true,:no_intraemphasis,true,:fenced_code_blocks,true,:gh_blockcode,true]
  Redcarpet::Markdown.new(Redcarpet::Render::HTML,options).render(_text).html_safe
  
end
end
