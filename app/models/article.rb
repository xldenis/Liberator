class Article
  include Mongoid::Document
  belongs_to :user
  belongs_to :category
  validates_presence_of :title,:slug,:content
  field :title
  field :slug
  field :content
  field :published, :type => Boolean
  field :published_on, :type => Date
  before_destroy :remove_frontpage

  def remove_frontpage
    if index = self.category.front_page_articles.index(self.id.to_s)
      self.category.front_page_articles[index]="nil"
      self.category.save
  end
  end
end
