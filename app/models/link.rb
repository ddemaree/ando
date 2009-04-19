class Link < ActiveRecord::Base
  include Ando::ActsAsPostable
  
  validates_presence_of :title, :url
  
  def to_s
    title
  end
  
end
