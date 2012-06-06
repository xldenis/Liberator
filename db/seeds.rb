# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.fir

Mongoid.master.collections.reject { |c| c.name =~ /^system/}.each(&:drop)
Category.create(:name => "Everything",:front_page_articles => nil)
Category.create(:name => "Sports")
Category.create(:name => "Feature")
Category.create(:name => "People")
Category.create(:name => "Fun")
cat = Category.create(:name =>  "News", :front_page_articles => nil)

15.times do |index|
  cat.articles.create(:title => "Article #{index}",:byline => "Slug #{index}",:content => Lorem::Base.new('paragraphs',4).output)
end
puts 'Articles Created.'
puts 'Everything has #{Category.first.articles.count} articles in it.'
user =User.create! :email=> "reporter@liberator.com", :password=> "reporter",:password_confirmation => "reporter", :name => "Reporter User"
user.role = "reporter"
user.save
puts 'New user created: ' <<user.name
user = User.create! :email=> "admin@liberator.com", :password => "administrator",:password_confirmation => "administrator", :name => "Admin User", :role => "admin"
user.role = "admin"
user.save
puts 'New user created: ' << user.name
