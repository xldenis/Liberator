source 'http://rubygems.org'

gem 'rails'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'
gem 'mongoid'
gem 'bson_ext'
gem 'carrierwave-mongoid', :require=>'carrierwave/mongoid'
gem 'mongoid_slug'

gem 'redcarpet'

gem 'rmagick'
gem 'mini_magick'

gem 'fog'

gem 'truncate_html'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
  gem 'haml'
end
group :production do
  gem 'thin'
  gem 'unicorn'
end
gem 'lorem'
group :development,:test do
  gem 'therubyracer'
  gem 'ruby-debug19'
end
gem 'nifty-generators'
gem 'cancan'
gem 'devise'
gem 'jquery-rails'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :test do
  # Pretty printed test output
  gem 'turn', :require => false
end
