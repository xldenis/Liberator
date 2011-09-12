# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.fir
cat = Category.create(:name =>  "News", :front_page_articles => nil)
15.times do |index|
  cat.articles.create(:title => "Article #{index}",:slug => "Slug #{index}",:content => "test")
end
