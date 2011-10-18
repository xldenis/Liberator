class Picture
  include Mongoid::Document
  include Mongoid::Paperclip
embedded_in :user

end
