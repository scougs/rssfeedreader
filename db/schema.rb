# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130801174826) do

  create_table "entries", :force => true do |t|
    t.string   "title"
    t.text     "url"
    t.text     "author"
    t.text     "summary"
    t.text     "content"
    t.datetime "published"
    t.text     "categories"
    t.integer  "feed_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.text     "guid"
  end

  create_table "entry_users", :force => true do |t|
    t.integer  "entry_id"
    t.integer  "user_id"
    t.boolean  "read"
    t.boolean  "favourite"
    t.boolean  "archive"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "feed_users", :force => true do |t|
    t.integer  "feed_id"
    t.integer  "user_id"
    t.string   "tag"
    t.boolean  "private"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "feeds", :force => true do |t|
    t.string   "title"
    t.text     "url"
    t.text     "feed_url"
    t.text     "etag"
    t.datetime "last_modified"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.text     "bio"
    t.string   "photo"
    t.string   "role"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
