class Tagging < ActiveRecord::Base
  
  belongs_to :tag
  belongs_to :post
  
  validates_presence_of :tag, :post
  
end
