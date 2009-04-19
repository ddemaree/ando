module ActiveRecord
  module Acts #:nodoc:
    module Taggable #:nodoc:
      def self.included(base)
        base.extend(ClassMethods)  
      end
      
      module ClassMethods
        def acts_as_taggable(options = {})
          options.reverse_merge!({
            :tagging_class => "Tagging",
            :tag_class => "Tag"
          })
          
          write_inheritable_attribute(:acts_as_taggable_options, {
            :taggable_type => ActiveRecord::Base.send(:class_name_of_active_record_descendant, self).to_s,
            :from => options[:from]
          })
          
          class_inheritable_reader :acts_as_taggable_options

          has_many :taggings, :as => :taggable, :dependent => :destroy, :class_name => options[:tagging_class]
          has_many :tags, :through => :taggings
          
          after_save :update_tags

          include ActiveRecord::Acts::Taggable::InstanceMethods
          extend ActiveRecord::Acts::Taggable::SingletonMethods          
        end
      end
      
      module SingletonMethods
        def find_tagged_with(list)
          find_by_sql(
            "SELECT #{table_name}.* FROM #{table_name}, tags, taggings " +
            "WHERE #{table_name}.#{primary_key} = taggings.taggable_id " +
            "AND taggings.taggable_type = '#{acts_as_taggable_options[:taggable_type]}' " +
            "AND taggings.tag_id = tags.id AND tags.name IN (#{list.collect { |name| "'#{name}'" }.join(", ")})"
          )
        end
      end
      
      module InstanceMethods
        def tag_with(list)
          Tag.transaction do
            taggings.destroy_all

            Tag.parse(list).each do |name|
              if acts_as_taggable_options[:from]
                send(acts_as_taggable_options[:from]).tags.find_or_create_by_name(name).on(self)
              else
                Tag.find_or_create_by_name(name).on(self)
              end
            end
          end
        end

        def tag_list
          tags.collect { |tag| tag.name.include?(" ") ? %{"#{tag.name}"} : tag.name }.join(" ")
        end
        
        def tag_string
          @tag_string || self.tag_list
        end

        def tag_string=(new_tags)
          @tag_string = new_tags
        end
        alias_method :tags=, :tag_string=
        
        def update_tags
          unless @tag_string.nil?
            self.tag_with(@tag_string)
            @tag_string = nil
          end
        end
        
      end
    end
  end
end