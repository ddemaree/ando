require 'test_helper'

class Ando::PostableTest < ActiveSupport::TestCase
  
  def self.model_class
    Article
  end
  
  def setup
    set_current_user
  end
  
  # Post creation
  context "when saving a Postable model" do
    setup { @article = Factory(:article) }
    should_change "Post.count", :by => 1
  end
  
  # passthru
  
  context "a Postable model instance" do
    setup { @article = Factory.build(:article) }
    should_provide_accessors_for :published_at, :status, :tags
  end
  

  
end