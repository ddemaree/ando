module Ando::Publishing
  
  def self.included(base)
    base.send(:include, InstanceMethods)
    
    base.class_eval do
      include AASM
      
      before_validation :set_initial_state_if_blank
      before_validation :set_published_at_if_blank
      
      aasm_initial_state :draft
      aasm_state :draft
      aasm_state :published
      aasm_state :hidden
      
      aasm_event :publish do
        transitions :to => :published, :from => [:draft, :published, :hidden]
      end
      
      aasm_event :unpublish do
        transitions :to => :hidden, :from => [:draft, :published, :hidden]
      end
      
    end
  end
  
  module InstanceMethods
    
    def aasm_state
      self.status || "draft"
    end

    def aasm_state=(new_state)
      self.status = new_state
    end

    def set_initial_state_if_blank
      self.status ||= "draft"
    end
    
    def set_published_at_if_blank
      self.published_at ||= self.created_at
    end
    
  end
  
end