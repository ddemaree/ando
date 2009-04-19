class Template < ActiveRecord::Base
  include Blrb::Routing
  
  validates_uniqueness_of :name, :scope => [:type, :blog_id]
  validates_uniqueness_of :cached_regexp, :scope => :blog_id
  
  class Index < self
  
    def route_to_regexp_string
      super.gsub("\$","(\/#{'*' if route.blank?}index)*(.html)*")
    end
  end
  
  class Archive < self; end
  class Partial < self; end
end
