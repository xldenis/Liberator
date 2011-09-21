source 'http://rubygems.org'

gem 'rails', '3.1.0'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'
gem 'bson_ext'
gem 'mongodb'
gem 'mongoid'
gem 'heroku'
# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "  ~> 3.1.0"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
end
group :production do
gem 'thin'
group :development,:test do
gem 'lorem'
gem 'therubyracer'
end
end
gem 'nifty-generators'
gem 'cancan'
gem 'devise'
gem 'jquery-rails'
gem 'coffeebeans'
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
