class CreatePostables < ActiveRecord::Migration
  def self.up
    create_table :postables do |t|
      t.integer :blog_id
      t.string :name
      t.string :post_type
      t.integer :post_id
      t.timestamps
    end
  end

  def self.down
    drop_table :postables
  end
end
