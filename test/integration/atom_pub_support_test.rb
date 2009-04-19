require 'test_helper'

class AtomPubSupportTest < ActionController::IntegrationTest
  fixtures :users
  
  ATOM_DOCUMENT = <<-PORK
  <?xml version="1.0" encoding="UTF-8" standalone="yes"?>
  <entry xmlns="http://www.w3.org/2005/Atom">
  <title type="text"><![CDATA[#{Faker::Lorem.sentence}]]></title>
  <content type="html" xml:space="preserve"><![CDATA[#{Faker::Lorem.paragraph}]]></content>
  <summary type="html" xml:space="preserve"><![CDATA[]]></summary>
  <app:control xmlns:app='http://purl.org/atom/app#'>
  	<app:draft>no</app:draft> 															
  </app:control>
  <generator url="http://www.red-sweater.com/marsedit/">MarsEdit</generator>
  </entry>
  PORK
  
  context "on GET to service document" do
    setup do
      get "/admin/services.atom", {}, {"HTTP_AUTHORIZATION" => "Basic #{Base64.encode64('quentin:monkey')}"}
    end
    
    should_respond_with :success
    should_respond_with_content_type Mime::ATOM
  end

  context "on POST to :create using AtomPub protocol" do
    setup do
      post "/admin/articles", ATOM_DOCUMENT, {"CONTENT_TYPE" => "application/atom+xml", "Accept" => "application/atom+xml", "HTTP_AUTHORIZATION" => "Basic #{Base64.encode64('quentin:monkey')}"}
    end
    
    should_respond_with 201
    should_respond_with_content_type Mime::ATOM
    
    should "include article IRI in response" do
      assert_not_nil @response
      
      assert @response.body =~ /admin\/articles\/[0-9a-z_\-]+\.atom/
      assert_not_nil @response.headers["Location"]
      
      get @response.headers["Location"]
      assert_response :success
    end
  end
  
  context "on PUT to :update using AtomPub" do
    setup do
      @article = Article.make
      
      put "/admin/articles/#{@article.to_param}.atom", ATOM_DOCUMENT, {"CONTENT_TYPE" => "application/atom+xml", "Accept" => "application/atom+xml", "HTTP_AUTHORIZATION" => "Basic #{Base64.encode64('quentin:monkey')}"}
    end
    
    should_respond_with :success
    should_respond_with_content_type Mime::ATOM
  end
  
  context "on DELETE to :destroy using AtomPub" do
    setup do
      @article = Article.make
      
      delete "/admin/articles/#{@article.to_param}.atom", {}, {"CONTENT_TYPE" => "application/atom+xml", "Accept" => "application/atom+xml", "HTTP_AUTHORIZATION" => "Basic #{Base64.encode64('quentin:monkey')}"}
    end
    
    should_respond_with :success
    should_respond_with_content_type Mime::ATOM
  end
  
end
