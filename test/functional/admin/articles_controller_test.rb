require 'test_helper'
require 'faker'

class Admin::ArticlesControllerTest < ActionController::TestCase
  fixtures :users
  
  context "on GET to :index" do
    setup do
      5.times { |x| Article.make }
      
      @request.session[:user_id] = users(:quentin).id
      get :index
    end
    
    should_respond_with :success
    should_assign_to :articles
    should_render_template :index
    should_not_set_the_flash
    
    should "have 5 articles" do
      assert_equal 5, assigns(:articles).size
    end
  end
  
  context "on GET to :new" do
    setup do
      @request.session[:user_id] = users(:quentin).id
      get :new
    end
    
    should_render_a_form
  end
  
  context "on POST to :create" do
    setup do
      @request.session[:user_id] = users(:quentin).id
      
      post :create, {:article => {:title => "Hello World", :body => "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."}}
    end
    
    should_respond_with :success
    should_assign_to :article
    
    should "set created by to current user from session" do
      assert_not_nil article = assigns(:article)
      assert_not_nil article.created_by
      assert_not_nil article.updated_by
      
      assert_equal users(:quentin), article.created_by
      assert_equal users(:quentin), article.updated_by
    end
  end
  
end
