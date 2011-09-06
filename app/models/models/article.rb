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
end
