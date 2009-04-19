class AddRoutingFeaturesToTemplates < ActiveRecord::Migration
  def self.up
    add_column :templates, :route, :string
    add_column :templates, :cached_regexp, :string
  end

  def self.down
    remove_column :templates, :route
    remove_column :templates, :cached_regexp
  end
end
