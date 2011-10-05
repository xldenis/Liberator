class Article
  include Mongoid::Document
  has_and_belongs_to_many :categories 
  validates_presence_of :title,:slug,:content
  field :title
  field :slug
  field :content
  field :published, :type => Boolean
  field :published_on, :type => Date
  before_destroy :remove_frontpage
  after_create :init_to_everything
  before_save :add_to_everything
 private 
  def add_to_everything
  puts "testing"
  puts self.inspect
  if self.persisted? && !(self.categories.where(:name=>"Everything").exists?)
  self.categories<<Category.where(:name => "Everything").first
  
  end
    
  end
  def init_to_everything
  unless self.categories.where(:name=>"Everything").exists?
  self.categories<<Category.where(:name=>"Everything").first
  self.save
  end
  end
  def remove_frontpage
    if index = self.category.front_page_articles.index(self.id.to_s)
      self.category.front_page_articles[index]="nil"
      self.category.save
  end
  end

end
