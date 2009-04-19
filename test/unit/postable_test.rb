require 'test_helper'

class PostableTest < ActiveSupport::TestCase
  fixtures :users
  
  should_belong_to :created_by
  
  context "Postable filters" do
    
    
    
  end
  
  context "Postable tags" do
    
    should "be settable from string on create" do
      article = Article.make_unsaved
      article.tag_string = "hello world dude"
      article.save
      assert_equal 3, article.tags.count
      assert_equal 3, article.taggings.count
    end
    
    should "be settable from string on update" do
      article = Article.make_unsaved
      article.tag_string = "hello world dude"
      article.save
      
      article.tag_string = "goodbye dude"
      assert article.save
      assert_equal 2, article.tags.count
      assert_equal 2, article.taggings.count
    
      #assert_equal 5, Tag.count
    end
    
  end
  
  context "Postable created by user" do
    setup do
      @current_author = users(:quentin)
      Postable.current_user = @current_author
    end
    
    should "be set from class variable on create" do
      assert_not_nil article = Article.make
      assert !article.new_record?
      assert_not_nil article.created_by
      assert_equal @current_author, article.created_by
      assert_equal @current_author, article.updated_by    
    end
  end
  
  context "Postable updated by user" do
    setup do
      @original_author = users(:quentin)
      Postable.current_user = @original_author
      @article = Article.make
      
      @current_author = users(:aaron)
      Postable.current_user = @current_author
    end
    
    should "be set from class variable on update" do
      @article.body = "New body text here"
      assert @article.save
      assert_equal @current_author, @article.updated_by
      assert_equal @original_author, @article.created_by
    end
  end
  
  context "Postable creation time" do
    should "match article's creation time" do
      article1 = Factory(:first_article)
      january1 = "2008-01-01 18:01:01 UTC".to_time
      
      assert_equal january1, article1.created_at
      assert_equal january1, article1.postable.created_at
      assert_equal article1.created_at, article1.postable.created_at
    end
  end
  
  context "Postable keyword search" do
    setup do
      Article.destroy_all
      @article1 = Factory(:first_article)
      @article2 = Factory(:second_article)
    end
    
    should "find articles by date" do
      search = Postable.new_search
      search.conditions = {
        :created_at_gte => "2008-02-01",
        :created_at_lte => "2008-12-31"
      }
      
      assert_equal 1, search.count
      
      search.conditions.created_at_gte = "2007-10-31"
      assert_equal 2, search.count
      
      search.conditions.created_at_lte = "2007-12-31"
      assert_equal 0, search.count
      
      search = Postable.new_search
      search.conditions.year_of_created_at = 2008
      assert_equal 2, search.count
      
      search.conditions.dom_of_created_at = 1
      search.conditions.month_of_created_at = 1
      assert_equal 1, search.count
    end
    
    should "find articles using keyword search scope" do
      assert_equal 2, Postable.count
      
      postables = Postable.with_keywords("anxious")
      assert !postables.empty?
      assert_contains postables, @article1.postable
      
      postables = Postable.with_keywords("Gregor Samsa")
      assert !postables.empty?
      assert_contains postables, @article1.postable
      
      postables = Postable.with_keywords("Gregor Alice")
      assert postables.empty?
      
      postables = Postable.with_keywords("Alice white rabbit")
      assert !postables.empty?
      assert_contains postables, @article2.postable
    end
    
    should "find articles using kw search and params in combination" do
      search = Postable.with_keywords("Gregor").new_search
      search.conditions.name_contains = "First"
      postables = search.all
      
      assert_equal 1, search.count
      assert_contains postables, @article1.postable
      
      search.conditions.status = "published"
      assert_equal 0, search.count
      
      search.conditions.status = ["published", "draft"]
      assert_equal 1, search.count
    end
  end
  
  context "Postable for article" do
    should "be created when article is created" do
      article = Article.new({
        :title => "Can has postable?"
      })
      
      assert_difference "Postable.count" do
        assert article.save
        assert_not_nil article.postable
        assert_equal "Can has postable?", article.postable.name
      end
    end
    
    should "be destroyed when article is destroyed" do
      article = Factory(:first_article)
      assert_not_nil article.postable
      assert article.destroy
      
      assert_nil Postable.find_by_id(article.postable.id)
    end
  end
  
  context "Postable state" do
    should "be changed when post state is changed" do
      article  = Factory(:first_article)
      assert article.draft?
      assert article.postable.draft?
      
      assert article.publish!
      assert article.published?
      assert article.postable.published?
    end
  end
  
end
