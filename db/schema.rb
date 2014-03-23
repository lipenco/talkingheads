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

ActiveRecord::Schema.define(version: 20140322224346) do

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

  create_table "talks", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "video_url"
    t.string   "slides_url"
    t.string   "speaker"
    t.integer  "conference_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "talks", ["conference_id"], name: "index_talks_on_conference_id"

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.integer  "uid"
    t.string   "provider"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
