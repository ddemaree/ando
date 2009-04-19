ActionController::Routing::Routes.draw do |map|
  
  map.namespace :ando do |admin|
    admin.resources :blogs do |blog|
      blog.resources :items
      blog.resources :articles, :links, :pictures
    end
    
    admin.root :controller => "blogs"
  end

  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
  
  map.connect '*wildcard', :controller => "website", :action => "show"
end
