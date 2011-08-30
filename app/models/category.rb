class Category
  include Mongoid::Document
  has_many :articles
  field :name
  field :published
end
