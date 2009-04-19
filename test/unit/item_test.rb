require File.dirname(__FILE__) + '/../test_helper'

class ItemTest < ActiveSupport::TestCase
  
  def test_conditions_generator_for_monthly_archive
    template = templates(:archive_template)
    params   = template.params_from_uri("2008/11")
    
    actual_conds   = Item.conditions_for_params(params)
    expected_conds = "MONTH(items.created_at) = '11' AND YEAR(items.created_at) = '2008'"
    
    assert_equal actual_conds, expected_conds
  end
  
end
