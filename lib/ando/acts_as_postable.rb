module Ando::ActsAsPostable
  
  def self.included(base)
    base.send(:include, InstanceMethods)
    
    base.class_eval do
      has_one :postable, :as => :post
      after_create :update_postable
      before_update :update_postable # OPTIMIZE: Should this be after_update?
      after_destroy :destroy_postable
    end
  end
  
  module InstanceMethods
    
    def tags
      @tag_string ||= self.tag_string_from_postable
    end
    
    def tags=(incoming_tags)
      @tag_string = incoming_tags
    end
    
    def tag_string_from_postable
      return "" if self.new_record?
      self.postable.tag_string
    end
    
    def update_postable
      pp            = (self.postable || self.build_postable)
      pp.name       = self.to_name
      pp.blog_id    = self.blog_id
      pp.tag_string = self.tags
      pp.save!
    end
    
    def destroy_postable
      self.postable.destroy
    end
    
    def to_name
      respond_to?(:title) ? self.title : "#{self.class.to_s} #{self.id}"
    end
    
  end
  
end