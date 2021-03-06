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

ActiveRecord::Schema.define(:version => 20110818032830) do

  create_table "comments", :force => true do |t|
    t.string   "content"
    t.integer  "post_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "faqs", :force => true do |t|
    t.integer   "user_id"
    t.text      "bio"
    t.text      "skillsets"
    t.text      "schools"
    t.text      "companies"
    t.text      "music"
    t.text      "movies"
    t.text      "television"
    t.text      "books"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "friendships", :force => true do |t|
    t.integer   "user_id"
    t.integer   "friend_id"
    t.string    "status"
    t.timestamp "initiated_at"
    t.timestamp "accepted_at"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "microposts", :force => true do |t|
    t.string    "content"
    t.integer   "user_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  add_index "microposts", ["created_at"], :name => "index_microposts_on_created_at"
  add_index "microposts", ["user_id"], :name => "index_microposts_on_user_id"

  create_table "networks", :force => true do |t|
    t.integer   "user_id"
    t.string    "facebook"
    t.string    "twitter"
    t.string    "linkedin"
    t.string    "youtube"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "posts", :force => true do |t|
    t.integer  "user_id"
    t.integer  "poster_id"
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "posts", ["created_at"], :name => "index_posts_on_created_at"
  add_index "posts", ["poster_id"], :name => "index_posts_on_poster_id"
  add_index "posts", ["user_id", "poster_id"], :name => "index_posts_on_user_id_and_poster_id"
  add_index "posts", ["user_id"], :name => "index_posts_on_user_id"

  create_table "preferences", :force => true do |t|
    t.integer   "user_id"
    t.string    "profile_view", :default => "all"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "settings", :force => true do |t|
    t.integer   "user_id"
    t.string    "profile_view", :default => "all"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "specs", :force => true do |t|
    t.integer   "user_id"
    t.string    "first_name"
    t.string    "last_name"
    t.string    "gender"
    t.date      "birthday"
    t.string    "occupation"
    t.string    "city"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string    "name"
    t.string    "email"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "encrypted_password"
    t.string    "salt"
    t.boolean   "admin",              :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
