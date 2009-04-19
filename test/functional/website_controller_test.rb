require File.dirname(__FILE__) + '/../test_helper'

class WebsiteControllerTest < ActionController::TestCase
  
  def test_empty_route
    get :show, :wildcard => []
    assert :success
  end
  
  def test_aggregate_route
    get :show, :wildcard => ["2008","01"]
    assert :success
  end
  
  def test_singleton_route
    get :show, :wildcard => ["2008","01","first_post"]
    assert :success
  end
  
  def test_bogus_route
    get :show, :wildcard => ["pork","walks"]
    flunk("Should have raised Blog::UnrouteableError")
  rescue Blog::UnrouteableError
    assert true
  end
  
end
