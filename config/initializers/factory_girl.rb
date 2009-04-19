class ActiveRecord::Base
  
  def self.factory(name,&block)
    Factory.define(name, :class => self, &block)
  end
  
end