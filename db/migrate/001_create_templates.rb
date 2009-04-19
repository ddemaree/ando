class CreateTemplates < ActiveRecord::Migration
  def self.up
    create_table :templates do |t|
      t.integer :blog_id
      t.string :name
      t.text :content

      t.timestamps
    end
  end

  def self.down
    drop_table :templates
  end
end