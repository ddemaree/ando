module Ando::Postable
  
  def self.included(base)
    base.send(:include, InstanceMethods)
    
    base.class_eval do
      has_one :post, :as => :post
      after_create  :update_postable
      before_update :update_postable # OPTIMIZE: Should this be after_update?
      after_destroy :destroy_postable
      
      %w(status author tags tag_string published_at).each do |attr|
        delegate attr.to_sym, "#{attr}=".to_sym, :to => :current_post
      end
      
      alias_method_chain :method_missing, :postable_passthru
    end
  end
  
  module InstanceMethods
    
    def current_post
      @current_post ||= (self.post || self.build_post)
      @current_post.post = self
      @current_post
    end
    
    def method_missing_with_postable_passthru(name,*args)
      if self.current_post.respond_to?(name)
        self.current_post.send(name, *args)
      else
        method_missing_without_postable_passthru(name,*args)
      end
    end
    
    def update_postable
      pp              = self.current_post
      
      pp.name         = self.to_name
      pp.content      = self.postable_content
      pp.description  = self.postable_description
      pp.published_at = self.published_at
      pp.created_at   = self.created_at
      pp.updated_at   = self.updated_at
      
      pp.save!
    end
    
    def destroy_postable
      self.post.destroy
    end
    
    def to_name
      self.respond_to?(:title) ? self.title : "#{self.class.to_s} #{self.id}"
    end
    
    def postable_content
      self.try(:body) || self.try(:description)
    end
    
    def postable_description
      self.try(:excerpt) || self.try(:description)
    end
    
  end
  
end