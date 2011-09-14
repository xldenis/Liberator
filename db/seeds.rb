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
User.create(:email => "reporter@liberator.com", :encrypted_password=> "$2a$10$oUDLvCUVDVS2EuJFem//yOF.RJxnRgE4uFaVJvj35MD3hvIBV7RUK", :name => "Reporter User", :role => "reporter")
User.create(:email => "admin@liberator.com", :encrypted_password=> "$2a$10$njr3d3a.NxH8YiE0HJRbG.lDNJ7lvkYS3X2ptS.6y19gDbaff14aK",:name => "Admin User", :role => "admin")
