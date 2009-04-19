class ExpandTemplatesToAllowForIndexes < ActiveRecord::Migration
  def self.up
    add_column :templates, :type, :string
    add_index :templates, :type
    add_index :templates, :blog_id
    execute "UPDATE templates SET type = 'Archive'"
  end

  def self.down
    remove_column :templates, :type
  end
end
