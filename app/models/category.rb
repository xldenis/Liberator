class Category
  include Mongoid::Document
  has_many :articles
  field :name
  field :front_page_articles, :type=> Array
def front_to_articles
  articles=[]
    if self.front_page_articles
      self.front_page_articles.each do |article|
    if !(article=="nil") then articles<<Article.find(article) else articles<<nil end
  end
  else
    articles = nil
  end
  articles
end
def stuff
articles = Article.first
end
end
