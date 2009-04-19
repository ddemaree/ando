namespace :ando do
  task :setup_user => :environment do
    Ando.current_user = User.find_by_email("ddemaree@gmail.com") || 
                        User.first
  end
  
  namespace :import do
    desc "Imports entries from a YAML file"
    task :file => :setup_user do
      Article.delete_all; Post.delete_all
      
      if entries = YAML.load_file(ENV["FILE"])
        entries.each do |entry|
          post, comments = entry['post'], entry['comments']
          
          article = Article.new({
            :title    => post["title"],
            :excerpt  => post["description"],
            :body     => post["body"],
            :extended => post["extended"],
            :published_at => Time.parse(post["published_on"]),
            :url_slug => post["basename"],
            :created_at => Time.parse(post["published_on"]),
            :updated_at => Time.parse(post["published_on"]),
            :status => "published"
          })
          
          puts article.save
          #puts article.inspect
          
        end
      end
    end
  end
  
  desc "Imports entries from YAML files in ./import"
  task :import_entries => :environment do
    # Dir.glob("#{RAILS_ROOT}/import/*.yml").sort.reverse.each do |f|
    #   if hashed_entries = YAML.load_file(f)
    #     hashed_entries.each do |entry|
    #       post, comments = entry['post'], entry['comments']
    #       
    #       item = Item.new(post.merge({:blog_id => 1, :kind_id => 1}))
    #       if item.save
    #         puts "Added item #{item.id}: #{item.title}"
    #       end
    #     end
    #   end
    # end
    
  end
  
  
end