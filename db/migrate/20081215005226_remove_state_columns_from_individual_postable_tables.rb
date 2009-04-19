class RemoveStateColumnsFromIndividualPostableTables < ActiveRecord::Migration
  def self.up
    remove_column :articles, :status
    remove_column :links, :status
  end

  def self.down
    add_column :links, :status, :string
    add_column :articles, :status, :string
  end
end
