module Ando::ActsAsPostable
  
  def self.included(base)
    base.send(:include, InstanceMethods)
    
    base.class_eval do
      has_one :postable, :as => :post
      after_create :update_postable
      before_update :update_postable # OPTIMIZE: Should this be after_update?
      after_destroy :destroy_postable
      
      %w(status created_by updated_by tags tag_string).each do |attr|
        delegate attr.to_sym, "#{attr}=".to_sym, :to => :current_postable
      end
      
      alias_method_chain :method_missing, :postable_passthru
    end
  end
  
  module InstanceMethods
    
    # def tags
    #   @tag_string ||= self.tag_string_from_postable
    # end
    # 
    # def tags=(incoming_tags)
    #   @tag_string = incoming_tags
    # end
    #
    # def tag_string_from_postable
    #   return "" if self.new_record?
    #   self.postable.tag_string
    # end
    
    
    def current_postable
      @current_postable ||= (self.postable || self.build_postable)
    end
    
    def method_missing_with_postable_passthru(name,*args)
      if self.current_postable.respond_to?(name)
        self.current_postable.send(name, *args)
      else
        method_missing_without_postable_passthru(name,*args)
      end
    end
    
    def update_postable
      pp              = self.current_postable
      
      pp.name         = self.to_name
      pp.content      = self.postable_content
      pp.description  = self.postable_description
      pp.published_at = self.published_at
      pp.created_at   = self.created_at
      pp.updated_at   = self.updated_at
      #pp.tag_string = self.tags
      
      pp.save!
    end
    
    def destroy_postable
      self.postable.destroy
    end
    
    def to_name
      respond_to?(:title) ? self.title : "#{self.class.to_s} #{self.id}"
    end
    
    def postable_content
      self.try(:body) || self.try(:description)
    end
    
    def postable_description
      self.try(:excerpt) || self.try(:description)
    end
    
  end
  
end