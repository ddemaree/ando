class Article < ActiveRecord::Base
  include Ando::Postable
  
  validates_presence_of :body
  
  alias_attribute :_title, :title
  alias_attribute :_excerpt, :excerpt
  
  def title
    _title || self.body.first(40)
  end
  
  def _title
    read_attribute(:title)
  end
  
  def excerpt
    _excerpt || self.body.first(140)
  end
  
  def _excerpt
    read_attribute(:excerpt)
  end
  
end
