module ApplicationHelper
def markdown(text)
  options = [:hard_wrap, :autolink,:no_intraemphasis,:fenced_code,:gh_blockcode]
  Redcarpet.new(text,*options)
end
end
