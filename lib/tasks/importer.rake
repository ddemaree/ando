namespace :ando do
  desc "Imports entries from YAML files in ./import"
  task :import_entries => :environment do
    Dir.glob("#{RAILS_ROOT}/import/*.yml").sort.reverse.each do |f|
      if hashed_entries = YAML.load_file(f)
        hashed_entries.each do |entry|
          post, comments = entry['post'], entry['comments']
          
          item = Item.new(post.merge({:blog_id => 1, :kind_id => 1}))
          if item.save
            puts "Added item #{item.id}: #{item.title}"
          end
        end
      end
    end
    
  end
end