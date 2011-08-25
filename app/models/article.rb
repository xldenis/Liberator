class Article
  include Mongoid::Document
  referenced_in :user
  validates_presence_of :title,:slug,:content
  field :title
  field :slug
  field :content
  field :published_on, :type => Date
end
