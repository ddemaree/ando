class AddContentStuffToPostables < ActiveRecord::Migration
  def self.up
    add_column :postables, :description, :text
    add_column :postables, :content, :text
  end

  def self.down
    remove_column :postables, :content
    remove_column :postables, :description
  end
end
