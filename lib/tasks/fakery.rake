namespace :ando do
  namespace :fake do
    task :setup_user => :environment do
      Ando.current_user = User.find_by_email("ddemaree@gmail.com") || 
                          User.first
    end
  
  
    desc "Make fake articles"
    task :articles => :setup_user do
      50.times do |x|
        article = Factory.build(:article)
        article.published_at = (Time.now - [*1..60].rand.days)
        article.save
      end
      #puts article.inspect
    
    end
  
  end
end