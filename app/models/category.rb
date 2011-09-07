class Category
  include Mongoid::Document
  has_many :articles
  field :name
  field :front_page_articles, :type=> Array
end
