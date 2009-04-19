require "test_helper"

class ArticleTest < ActiveSupport::TestCase
  
  context "Article title" do
    should "be required if article is published" do
      article = Article.make_unsaved(:title => "", :status => "published")
      article.publish!
      
      assert !article.valid?
      assert article.errors.on(:title), article.errors.full_messages.join("\n")
    end
    
    should "be allowed to be blank if article is not published" do
      article = Article.make_unsaved(:title => "")
      assert article.save
    end
  end
  
  context "Article display title" do
    should "be excerpt of body if title is blank but body is not" do
      articleBody = "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
      article = Article.make(:title => "", :body => articleBody)
      
      assert_equal "#{articleBody.first(Article::FakeTitleLength)}…",
                    article.title_from_body
      
      assert_equal "#{articleBody.first(Article::FakeTitleLength)}…", 
                    article.display_title
    end
  end
  
  context "Article excerpt" do
    should "be autopopulated from body if blank" do
      article = Factory(:first_article)
      assert_equal "One morning, as Gregor Samsa was waking up from anxious dreams, he discovered that in bed he had been changed into a monstrous verminous ...", article.excerpt
      assert article.attributes[:excerpt].blank?
    end
    
    should "use a manually assigned excerpt if one is set" do
      article2 = Factory(:second_article)
      assert_equal "This is the excerpt", article2.excerpt
    end
  end
  
  context "Article basename" do
    should "be autoassigned from article title" do
      article = Article.new({
        :title => "Third Article"
      })
      
      assert article.valid?, article.errors.full_messages.join(", ")
      assert_equal "third_article", article.basename
    end
    
    should "be manually settable with valid name" do
      article = Article.new({
        :title => "Fourth Article",
        :basename => "something_about_ponies"
      })
    
      assert article.valid?, article.errors.full_messages.join(", ")
      assert_equal "something_about_ponies", article.basename
    end
    
    should "not be settable with name containing invalid characters" do
      article = Article.new({
        :title => "Article with bad basename",
        :basename => "first @rticle"
      })
      
      assert !article.valid?, article.errors.full_messages.join("; ")
      assert article.errors.on(:basename), article.errors.full_messages.join("; ")
    end
    
    should "not be settable with non-unique name" do
      article1 = Factory.build(:first_article, :basename => "extant_basename")
      article1.save!
      
      article = Factory.build(:first_article, :basename => "extant_basename")
      assert !article.valid?, article.errors.full_messages.join("; ")
      assert article.errors.on(:basename), article.errors.full_messages.join("; ")
    end
    
    should "auto-set an incremented name if blank and title is not unique" do
      article1 = Article.create({
        :title => "Blah Blah Blah"
      })
      
      assert_equal "blah_blah_blah", article1.basename
      
      article2 = Article.create({
        :title => "Blah Blah Blah"
      })
      
      assert_equal "blah_blah_blah_1", article2.basename
    end
  end
  
  context "Article state" do
    should "change in response to AASM events" do
      article  = Factory(:first_article)
      assert article.draft?
      
      assert article.publish!
      assert article.published?
    end
  end

end
