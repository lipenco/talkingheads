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

ActiveRecord::Schema.define(version: 20140422031934) do

  create_table "comments", force: true do |t|
    t.string   "content"
    t.integer  "user_id"
    t.integer  "talk_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["talk_id"], name: "index_comments_on_talk_id"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "conferences", force: true do |t|
    t.string   "name"
    t.string   "tags"
    t.date     "date"
    t.string   "organizer"
    t.string   "place"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "conferences", ["user_id"], name: "index_conferences_on_user_id"

  create_table "favourites", force: true do |t|
    t.integer  "user_id"
    t.integer  "talk_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "favourites", ["talk_id"], name: "index_favourites_on_talk_id"
  add_index "favourites", ["user_id"], name: "index_favourites_on_user_id"

  create_table "impressions", force: true do |t|
    t.string   "impressionable_type"
    t.integer  "impressionable_id"
    t.integer  "user_id"
    t.string   "controller_name"
    t.string   "action_name"
    t.string   "view_name"
    t.string   "request_hash"
    t.string   "ip_address"
    t.string   "session_hash"
    t.text     "message"
    t.text     "referrer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "impressions", ["controller_name", "action_name", "ip_address"], name: "controlleraction_ip_index"
  add_index "impressions", ["controller_name", "action_name", "request_hash"], name: "controlleraction_request_index"
  add_index "impressions", ["controller_name", "action_name", "session_hash"], name: "controlleraction_session_index"
  add_index "impressions", ["impressionable_type", "impressionable_id", "ip_address"], name: "poly_ip_index"
  add_index "impressions", ["impressionable_type", "impressionable_id", "request_hash"], name: "poly_request_index"
  add_index "impressions", ["impressionable_type", "impressionable_id", "session_hash"], name: "poly_session_index"
  add_index "impressions", ["impressionable_type", "message", "impressionable_id"], name: "impressionable_type_message_index"
  add_index "impressions", ["user_id"], name: "index_impressions_on_user_id"

  create_table "talks", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "video_url"
    t.string   "slides_url"
    t.string   "speaker"
    t.integer  "conference_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "impressions_count"
  end

  add_index "talks", ["conference_id"], name: "index_talks_on_conference_id"

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.integer  "uid"
    t.string   "provider"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image"
  end

end
