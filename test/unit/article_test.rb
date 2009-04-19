require 'test_helper'

class ArticleTest < ActiveSupport::TestCase

  context "an Article" do
    should_have_one :post
    should_validate_presence_of :body
  end

  # pseudo title
  context "on an article with no title saved" do
    setup do
      @article = Article.new({
        :body => Faker::Lorem.paragraphs(6).join("\n\n")
      })
    end
    
    context "the title" do
      should "not be blank" do
        assert !@article.title.blank?
      end
      
      should "be an excerpt of the body" do
        assert_equal @article.body.first(40), @article.title
      end
    end
    
    context "_title" do
      should "be blank" do
        assert @article._title.blank?
      end
    end
    
    
  end

end
