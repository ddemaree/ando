require 'tag'

module Ando::Taggable

  def self.included(base)
    base.send(:include, InstanceMethods)
    
    base.class_eval do
      has_many :taggings
      has_many :tags, :through => :taggings
    
      after_save :update_tags
    end
  end
  
  module InstanceMethods
  
    def tag_list
      tags.collect { |tag| tag.name.include?(" ") ? %{"#{tag.name}"} : tag.name }.join(" ")
    end
    
    def tag_string
      @tag_string || self.tag_list
    end

    def tag_string=(list)
      @tag_string = list
    end

    def tag_with(list)
      Tag.transaction do

        self.taggings.destroy_all
        Tag.parse(list).each do |tag|
          tag = Tag.find_or_initialize_by_name(tag)

          unless self.tags.include?(tag)
            self.tags << tag
          end
        end

      end
    end
    
    def update_tags
      return true if @tag_string.nil?
      
      self.tag_with(@tag_string)
      @tag_string = nil
    end
  
  end

end