class Postable < ActiveRecord::Base
  
  # TODO: Need a version of find_tagged_with that'll work within the scope of a single blog
  acts_as_taggable
  
  belongs_to :blog
  belongs_to :post, :polymorphic => true
  
end
