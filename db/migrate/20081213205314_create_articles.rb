class CreateArticles < ActiveRecord::Migration
  def self.up
    create_table :articles do |t|
      t.string :title
      t.text :body
      t.text :extended
      t.text :excerpt
      t.text :keywords
      t.string :basename
      t.string :status
      t.string :text_filter
      t.datetime :published_at

      t.timestamps
    end
  end

  def self.down
    drop_table :articles
  end
end
