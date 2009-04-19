
config.cache_classes = true
config.whiny_nils    = true
config.action_controller.consider_all_requests_local = true
config.action_controller.perform_caching             = false
config.action_controller.allow_forgery_protection    = false
config.action_mailer.delivery_method = :test
config.log_level = :debug

config.gem 'faker', :version => '>=0.3.1'

config.gem 'thoughtbot-shoulda', :source => 'http://gems.github.com/', 
                                 :lib => 'shoulda',
                                 :version => '~>2.10.0'
                                 
config.gem 'thoughtbot-factory_girl', :source => 'http://gems.github.com', 
                                 :lib => 'factory_girl',
                                 :version => "~>1.2.0"