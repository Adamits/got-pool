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

ActiveRecord::Schema.define(version: 20190406011756) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "characters", force: :cascade do |t|
    t.text     "name"
    t.text     "status",     default: "alive"
    t.string   "filename"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "guesses", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "question_id"
    t.text     "text"
    t.boolean  "correct",         default: false
    t.boolean  "extra_points",    default: false
    t.boolean  "negative_points", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "guesses", ["question_id"], name: "index_guesses_on_question_id", using: :btree
  add_index "guesses", ["user_id"], name: "index_guesses_on_user_id", using: :btree

  create_table "questions", force: :cascade do |t|
    t.integer  "character_id"
    t.text     "text"
    t.boolean  "answered",     default: false
    t.text     "answer"
    t.integer  "points",       default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "questions", ["character_id"], name: "index_questions_on_character_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.integer  "points",     default: 0
    t.boolean  "paid",       default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
