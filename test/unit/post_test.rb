require 'test_helper'

class PostTest < ActiveSupport::TestCase
  
  should_belong_to :post, :author
  should_have_many :taggings
  
  def setup
    set_current_user
    mock_date_and_time
  end
  
  context "a new Post instance" do
    should_belong_to :author, :post
    should_validate_presence_of :post, :name
  
    context "with no current user" do
      setup { Ando.current_user = nil }
      should_validate_presence_of :author
    end
  end
  
  
  # tagging
  
  context "A post" do
    setup { @post = Factory(:article).post }
    
    should "return tags as array" do
      @post._tags = "[one] [two]"
      assert_instance_of Array, @post.tags
      assert_contains @post.tags, "one", "two"
    end
    
    should "accept tags passed as string" do
      @post.tags = "one, two"
      assert_equal "[one] [two]", @post._tags
    end
    
    should "create tags after save" do
      assert_difference "@post.taggings.count" do
        @post.tags = "one"
        assert @post.save
      end
    end
    
  end
  
end
