require 'test_helper'

class LinkTest < ActiveSupport::TestCase
  
  context "Link URL" do
    should "be normalized to http if protocol is not present" do
      link = Factory.build(:first_link, :url => "practical.cc")
      assert link.valid?
      assert_equal "http://practical.cc", link.url
    end
    
    should "allow urls from protocols other than http" do
      link = Factory.build(:first_link, :url => "feed://feeds.feedburner.com/Practicalmadness")
      assert link.valid?
      
      # Check to ensure we're not normalizing to http
      assert_equal "feed://feeds.feedburner.com/Practicalmadness", link.url
    end
    
    should "return protocol from url as link type" do
      link = Factory.build(:first_link, :url => "feed://feeds.feedburner.com/Practicalmadness")
      assert link.valid?
      assert_equal :feed, link.link_type
      
      link.url = "practical.cc"
      assert_equal :http, link.link_type
    end
    
    should "return itunes as link type for iTMS urls" do
      link = Factory(:itunes_link)
      assert link.valid?
      assert_equal :itunes, link.link_type
    end
    
    should "respond to dynamic link type query methods" do
      link = Factory.build(:first_link)
      assert link.http_link?
      
      link = Factory(:itunes_link)
      assert !link.http_link?
      assert link.itunes_link?
    end
  end
  
end
