require File.dirname(__FILE__) + '/../test_helper'

class TemplateTest < ActiveSupport::TestCase
  
  # def test_invalid_key_check
  #   mapping = mappings(:monthly_archive)
  #   mapping.route = ":year/:month/:pork"
  #   assert !mapping.valid?
  #   assert_equal "contains invalid keys: :pork", mapping.errors.on(:route)
  # end
  # 
  # def test_regexp_conversion
  #   mapping = mappings(:monthly_archive)
  #   
  #   regexp_shoulda = Regexp.compile("^\\d{4}\/\\d{2}$")
  #   
  #   assert_match(regexp_shoulda, "2008/02")
  #   assert_match(mapping.to_regexp, "2008/02")
  # end
  # 
  # def test_extract_params_from_route
  #   mapping = mappings(:individual_archive)
  #   request_uri = "2008/03/test_post"
  #   
  #   actual_params = mapping.params_from_uri(request_uri)
  #   expected_params = {:month=>"03", :year=>"2008", :basename=>"test_post"}
  #   
  #   assert_equal expected_params, actual_params
  # end
  
  
  # Replace this with your real tests.
  def test_basic_singleton_template
    blog.route("2008/02/first_post")
    
    template_content = %{<h2><blrb:post:title /></h2>}
    expected_output  = %{<h2>First Post</h2>}
    actual_output    = blog.render_template(template_content)
    
    assert_equal expected_output, actual_output
  end
  
  def test_basic_aggregation_template
    blog.route("2008/01")
    
    template_content = %{<blrb:posts><h2><blrb:title /></h2></blrb:posts>}
    expected_output  = %{<h2>Second Post</h2><h2>First Page</h2><h2>First Post</h2>}
    actual_output    = blog.render_template(template_content)
    
    assert_equal expected_output, actual_output
  end
  
  def test_blog_override
    template_content = %{<blrb:blog name="David's Rails Blog"><blrb:posts lastn="1"><h2><blrb:title /></h2></blrb:posts></blrb:blog>}
    expected_output  = %{<h2>RSpec Post</h2>}
    actual_output    = blog.render_template(template_content)
    
    assert_equal expected_output, actual_output
  end
  
  def test_partial_inclusion
    template_content = %{<blrb:partial name="Porkwalk" />}
    expected_output  = %{<div id="porkwalk">Pork is walking to school</div>}.strip
    actual_output    = blog.render_template(template_content).strip
    
    assert_equal expected_output, actual_output
  end
  
  def test_partial_inclusion_with_blog_tags
    template_content = %{<blrb:posts><blrb:partial name="Link Post" /></blrb:posts>}
    expected_output  = %{<div id="link">Second Post</div><div id="link">First Page</div><div id="link">First Post</div>}.strip
    actual_output    = blog.render_template(template_content).strip
    
    assert_equal expected_output, actual_output
  end
  
  def test_partial_inclusion_with_blog_tags_outside_a_scope
    template_content = %{<blrb:partial name="Link Post" />}
    actual_output    = blog.render_template(template_content).strip
    flunk("Test should fail because exception should have raised")
  rescue Radius::UndefinedTagError
    assert true
  end
  
  def test_blog_tag_without_scope_change    
    template_content = %{<blrb:blog />}
    expected_output  = %{#{blog.name}}
    actual_output    = blog.render_template(template_content)
    assert_equal expected_output, actual_output    
    
    template_content = %{<blrb:blog:name />}
    expected_output  = %{#{blog.name}}
    actual_output    = blog.render_template(template_content)
    assert_equal expected_output, actual_output
  end
  
  def test_blog_tag_in_overridden_scope    
    template_content = %{<blrb:blog name="David's Rails Blog"><blrb:name /></blrb:blog>}
    expected_output  = %{David's Rails Blog}
    actual_output    = blog.render_template(template_content)
    assert_equal expected_output, actual_output
  end

protected

  def blog
    blogs(:practicalmadness)
  end
  
end
