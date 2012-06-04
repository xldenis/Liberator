namespace :categories do
  task :max_front_page_articles => :environment do
    if length = ENV['MAX_ARTICLES'].to_i
      Category.all.each do |cat|
        cat.front_page_articles = Array.new(length)
        cat.save
      end
      puts "Set new length of category pages to #{length} "
    else
      puts "set MAX_ARTICLES to an integer value" 
    end
    end
end
