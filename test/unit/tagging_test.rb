require 'test_helper'

class TaggingTest < ActiveSupport::TestCase
  
  should_belong_to :tag, :post
  should_validate_presence_of :tag, :post
  
end
