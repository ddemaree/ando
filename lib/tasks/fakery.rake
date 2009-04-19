desc "Hello world"
task :populate_articles => :environment do
  #ENV["NUM_ARTICLES"] ||= 10
  require 'faker' unless defined?(Faker)

  10.times do |x|
    article = Article.create!({
      :title => Faker::Lorem.sentence(3),
      :body  => Faker::Lorem.paragraphs(3)
    })
    puts "== Added #{article.title}"
  end
  
end