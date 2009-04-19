class AddUserIdFieldsToPostables < ActiveRecord::Migration
  def self.up
    add_column :postables, :created_by_id, :integer
    add_column :postables, :updated_by_id, :integer
  end

  def self.down
    remove_column :postables, :updated_by_id
    remove_column :postables, :created_by_id
  end
end
