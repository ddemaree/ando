# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.2' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  
  config.gem 'thoughtbot-clearance',
		:lib => 'clearance',
		:source => 'http://gems.github.com/',
		:version => '>= 0.5.0'
  
  config.gem 'mislav-will_paginate',
    :lib => 'will_paginate',
    :source => 'http://gems.github.com',
    :version => '~> 2.2.3'
  
  config.gem 'rubyist-aasm',
		:source => 'http://gems.github.com/',
    :lib => 'aasm',
    :version => '~> 2.0.2'
  
  config.gem 'rdiscount', :version => '~> 1.3.4'
  
  config.time_zone = 'UTC'
end