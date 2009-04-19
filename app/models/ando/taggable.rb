module Ando::Taggable
  
  def self.included(receiver)
    receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods
    
    receiver.class_eval do
      has_many :taggings, :dependent => :destroy, :extend => AssociationExtension
      after_save :update_taggings
    end
  end
  
  module ClassMethods
    
  end
  
  module InstanceMethods
    
    def tags=(list)
      @tags_array = Tag.parse(list)
      self._tags  = Tag.serialize(@tags_array)
      @tags_array
    end

    def tags
      @tags_array ||= Tag.unserialize(self._tags)
    end

    def _tags=(tag_string)
      @tags_array = nil
      write_attribute(:_tags, tag_string)
      tag_string
    end
  
    protected
    
      def update_taggings
        self.class.transaction do
          taggings.destroy_all
          self.taggings.tag_with(self.tags)
          @tags_as_array = nil
        end
      end
  
  end
  
  module AssociationExtension
    def tag_with(tag_list)
      raise ArgumentError unless tag_list.is_a?(Array)
      tag_list.each do |tag|
        tag_obj = Tag.find_or_create_by_name(tag)
        create(:tag => tag_obj)
      end
    end
  end
  
  
end