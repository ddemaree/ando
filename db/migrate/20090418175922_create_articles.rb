class CreateArticles < ActiveRecord::Migration
  def self.up
    create_table :articles do |t|
      t.string :title, :url_slug
      t.text :body, :extended, :excerpt
      t.timestamps
    end
  end

  def self.down
    drop_table :articles
  end
end
