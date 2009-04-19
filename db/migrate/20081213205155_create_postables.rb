class CreatePostables < ActiveRecord::Migration
  def self.up
    create_table :postables do |t|
      t.string   :name
      t.string   :post_type
      t.integer  :post_id
      t.string   :status
      t.datetime :published_at
      t.timestamps
    end
    
    add_index :postables, [:post_type, :post_id]
  end

  def self.down
    drop_table :postables
  end
end
