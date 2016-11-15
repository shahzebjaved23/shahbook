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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20161105181446) do

  create_table "activity_feeds", force: :cascade do |t|
    t.string   "targetable_name",  limit: 255
    t.integer  "targetable_id",    limit: 4
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "targetable_type",  limit: 255
    t.string   "status",           limit: 255
    t.integer  "user_id",          limit: 4
    t.integer  "securitylevel_id", limit: 4
  end

  create_table "albums", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "bios", force: :cascade do |t|
    t.string   "work_place",        limit: 255
    t.string   "designation",       limit: 255
    t.string   "college",           limit: 255
    t.string   "school",            limit: 255
    t.string   "university",        limit: 255
    t.string   "university_degree", limit: 255
    t.string   "school_cert",       limit: 255
    t.string   "college_cert",      limit: 255
    t.string   "home_town",         limit: 255
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "user_id",           limit: 4
  end

  create_table "books", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "author",      limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "interest_id", limit: 4
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id",             limit: 4
    t.text     "body",                limit: 65535
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.integer  "reply_of_comment_id", limit: 4
    t.integer  "commentable_id",      limit: 4
    t.string   "commentable_type",    limit: 255
  end

  create_table "friend_ships", force: :cascade do |t|
    t.boolean  "friend_state"
    t.integer  "user_id",           limit: 4
    t.integer  "friends_id",        limit: 4
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "securitylevel1_id", limit: 4
    t.integer  "securitylevel2_id", limit: 4
    t.string   "state",             limit: 255
  end

  create_table "friendlevels", force: :cascade do |t|
    t.string   "friendlevel", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "interest_books", force: :cascade do |t|
    t.integer "interest_id", limit: 4
    t.integer "book_id",     limit: 4
  end

  create_table "interest_movies", force: :cascade do |t|
    t.integer "interest_id", limit: 4
    t.integer "movie_id",    limit: 4
  end

  create_table "interests", force: :cascade do |t|
    t.integer "user_id", limit: 4
  end

  create_table "likes", force: :cascade do |t|
    t.integer  "user_id",       limit: 4
    t.integer  "likeable_id",   limit: 4
    t.string   "likeable_type", limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "movies", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "interest_id", limit: 4
  end

  create_table "photos", force: :cascade do |t|
    t.string   "file_name",            limit: 255
    t.text     "caption",              limit: 65535
    t.integer  "user_id",              limit: 4
    t.integer  "album_id",             limit: 4
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "picture_file_name",    limit: 255
    t.string   "picture_content_type", limit: 255
    t.integer  "picture_file_size",    limit: 4
    t.datetime "picture_updated_at"
  end

  create_table "posts", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.text     "body",       limit: 65535
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "profile_pictures", force: :cascade do |t|
    t.integer  "user_id",              limit: 4
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "picture_file_name",    limit: 255
    t.string   "picture_content_type", limit: 255
    t.integer  "picture_file_size",    limit: 4
    t.datetime "picture_updated_at"
  end

  create_table "requests", force: :cascade do |t|
    t.integer  "user_id",           limit: 4
    t.integer  "sender_id",         limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "friend_request_id", limit: 4
  end

  create_table "security_settings", force: :cascade do |t|
    t.string   "name",             limit: 255
    t.integer  "securable_id",     limit: 4
    t.string   "securable_type",   limit: 255
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "securitylevel_id", limit: 4
  end

  add_index "security_settings", ["securable_type", "securable_id"], name: "index_security_settings_on_securable_type_and_securable_id", using: :btree

  create_table "securitylevels", force: :cascade do |t|
    t.string   "securitylevel", limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "user_requests", force: :cascade do |t|
    t.integer "user_id",   limit: 4
    t.integer "friend_id", limit: 4
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name",             limit: 255
    t.string   "last_name",              limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
