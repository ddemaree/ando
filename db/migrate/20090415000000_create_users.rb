class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :name, :email, :password, :open_id, :role
      t.string   "token",           :limit => 128
      t.datetime "token_expires_at"
      t.boolean  "email_confirmed", :default => false, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
