class Postable < ActiveRecord::Base
  cattr_accessor :current_user
  
  include Ando::Publishing
  include Ando::Taggable
  
  default_scope :order => "created_at DESC"
  
  belongs_to :post, :polymorphic => true
  belongs_to :created_by, :class_name => "User"
  belongs_to :updated_by, :class_name => "User"
  
  before_validation_on_create :set_created_by_user
  before_validation :set_updated_by_user
  
  named_scope :with_keywords, lambda { |k| {:conditions => Postable.conditions_for_keyword(k) }  }
  
  def self.conditions_for_keyword(query)
    if query.to_s.blank?
      nil
    else
      params =
        %w(name description content).inject({}) do |coll, key|
          coll["#{key}_keywords"] = query; coll
        end
      
      params.merge!({:any => true})
      params
    end
  end
  
  def to_s
    name
  end
  
protected

  def set_created_by_user
    self.created_by = self.current_user
  end
  
  def set_updated_by_user
    self.updated_by = self.current_user
  end
  
  def current_user
    @@current_user
  end
  
end
