class Article
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Document::Taggable 
  include Mongoid::Slug
  belongs_to :user
  has_and_belongs_to_many :categories 
  mount_uploader :image, ImageUploader

  validates_presence_of :title,:byline,:content
  
  field :title
  slug :title
  field :byline
  field :content
  field :published, :type => Boolean
  field :published_on, :type => Date
  
  attr_accessor :crop_x,:crop_y,:crop_h,:crop_w
  
  before_destroy :remove_frontpage
  after_create :init_to_everything
  before_save :add_to_everything
  after_update :reprocess_image, :if => :cropping?
  
  def article_category
    categories.excludes(:name=> "Everything").first
  end
  def cropping?
    !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  end
  private 
  def add_to_everything
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
    self.categories.each do |cat|
    if cat.front_page_articles &&(index=  cat.front_page_articles.index(self.id.to_s))
     cat.front_page_articles[index]="nil"
     cat.save
    end
    end
  end
  def reprocess_image
    self.image.recreate_versions!
  end
end
