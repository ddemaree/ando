require "#{File.dirname(__FILE__)}/../test_helper"

class PostableTest < ActiveSupport::TestCase

  def test_creation_of_postable
    blog = blogs(:practicalmadness)
    
    article = Article.new({
      :title => "New Article",
      :blog => blog
    })
    
    assert_difference "blog.postables.count" do
      assert article.save
      assert_not_nil article.postable
      assert_equal "New Article", article.postable.name
    end
  end
  
  def test_destruction_of_postable
    blog = blogs(:practicalmadness)
    assert_equal 2, blog.postables.count
  
    article = articles(:first_article)
    assert article.destroy
    assert_equal 1, blog.postables.count
  end

end
