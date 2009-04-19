require "#{File.dirname(__FILE__)}/../test_helper"

class ArticleTest < ActiveSupport::TestCase
  
  def test_auto_assignment_of_excerpt
    article = articles(:first_article)
    assert_equal "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad m...", article.excerpt
  end
  
  def test_manually_assigned_excerpt
    article = articles(:second_article)
    assert_equal "This is the excerpt", article.excerpt
  end

  def test_basename_auto_assignment
    article = Article.new({
      :title => "Third Article",
      :blog  => blogs(:practicalmadness)
    })
    
    assert article.valid?, article.errors.full_messages.join(", ")
    assert_equal "third_article", article.basename
  end
  
  def test_basename_manual_assignment_with_valid_name
    article = Article.new({
      :title => "Fourth Article",
      :blog  => blogs(:practicalmadness),
      :basename => "something_about_ponies"
    })
    
    assert article.valid?, article.errors.full_messages.join(", ")
    assert_equal "something_about_ponies", article.basename
  end
  
  def test_basename_manual_assignment_with_invalid_name
    article = Article.new({
      :title => "Fifth Article",
      :blog  => blogs(:practicalmadness),
      :basename => "first_article"
    })
    
    assert !article.valid?, article.errors.full_messages.join(", ")
    assert article.errors.on(:basename)
    
    article.basename = "article_the_first"
    assert article.valid?
  end
  
  def test_basename_auto_assignment_with_duplicate_name
    article = Article.new({
      :title => "First Article",
      :blog  => blogs(:practicalmadness),
    })

    assert article.valid?, article.errors.full_messages.join(", ")
    assert_equal "first_article_1", article.basename
  end

end
