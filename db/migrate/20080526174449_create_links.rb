class CreateLinks < ActiveRecord::Migration
  def self.up
    create_table :links do |t|
      t.integer :blog_id
      t.string :title
      t.string :url
      t.text :description
      t.timestamps
    end
  end

  def self.down
    drop_table :links
  end
end
