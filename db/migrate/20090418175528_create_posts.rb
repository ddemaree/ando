class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.belongs_to :post, :polymorphic => true
      t.belongs_to :author
      t.string :name
      t.string :status, :default => 'draft'
      t.datetime :published_at
      t.text :description, :content, :post_tags
      t.timestamps
    end
  end

  def self.down
    drop_table :posts
  end
end
