# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20080526174449) do

  create_table "articles", :force => true do |t|
    t.integer  "blog_id",      :limit => 11
    t.integer  "kind_id",      :limit => 11
    t.string   "title"
    t.text     "body"
    t.text     "extended"
    t.text     "excerpt"
    t.text     "keywords"
    t.string   "basename"
    t.string   "status",                     :default => "draft"
    t.string   "text_filter"
    t.datetime "published_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "blogs", :force => true do |t|
    t.string   "name"
    t.string   "basename"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "links", :force => true do |t|
    t.integer  "blog_id",     :limit => 11
    t.string   "title"
    t.string   "url"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "postables", :force => true do |t|
    t.integer  "blog_id",    :limit => 11
    t.string   "name"
    t.string   "post_type"
    t.integer  "post_id",    :limit => 11
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", :force => true do |t|
    t.integer "taggable_id",   :limit => 11
    t.integer "tag_id",        :limit => 11
    t.string  "taggable_type"
  end

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "templates", :force => true do |t|
    t.integer  "blog_id",       :limit => 11
    t.string   "name"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type"
    t.string   "route"
    t.string   "cached_regexp"
  end

  add_index "templates", ["type"], :name => "index_templates_on_type"
  add_index "templates", ["blog_id"], :name => "index_templates_on_blog_id"

end
