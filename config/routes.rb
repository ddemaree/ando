ActionController::Routing::Routes.draw do |map|
  SprocketsApplication.routes(map)
  
  map.resources :links, :articles

  map.namespace :admin do |admin|
    admin.resources :services, :only => [:index]
    
    admin.resources :postables, :posts, :controller => "posts", :only => [:index]
    admin.resources :articles, :links
    admin.resources :users
    
    admin.root :controller => "posts"
  end

  map.root :controller => 'website'

  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'create'
  map.signup '/signup', :controller => 'users', :action => 'new'
  
  map.resource :session
  
  #map.connect ':controller/:action/:id'
  #map.connect ':controller/:action/:id.:format'
  
end
