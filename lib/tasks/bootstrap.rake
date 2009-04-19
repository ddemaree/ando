namespace :ando do
  
  task :bootstrap => :environment do
    Rake::Task["db:reset"].invoke
    
    # Create default user
    u = User.new({
      :name  => "David Ellen Nemesis",
      :email => "ddemaree@gmail.com",
      :password => "kelsey"
    })
    
    u.save(false)
  end
  
end