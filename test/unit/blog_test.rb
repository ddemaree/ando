require File.dirname(__FILE__) + '/../test_helper'

class BlogTest < ActiveSupport::TestCase

  def test_find_mapping_for_route
    request_uri = "2010/12"
    blog = blogs(:practicalmadness)
    
    assert_not_nil (template = blog.find_template_by_route(request_uri))
    assert_equal template, templates(:archive_template)
    
    request_uri = "2010/12/some_kind_of_slug"
    assert_not_nil (template = blog.find_template_by_route(request_uri))
    assert_equal template, templates(:individual_template)
  end
  
  def test_finding_index_template_for_route
    request_uri = ""
    blog = blogs(:practicalmadness)
    template = blog.find_template_by_route(request_uri)
    
    assert_not_nil template
    assert template.is_a?(Template::Index)
    assert_equal template, templates(:index_template)
  end

end
