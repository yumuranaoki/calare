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

ActiveRecord::Schema.define(version: 20180215052038) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.bigint "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "determined_day"
    t.string "determined_start"
    t.string "determined_end"
    t.string "name"
    t.index ["group_id"], name: "index_answers_on_group_id"
  end

  create_table "comments", force: :cascade do |t|
    t.bigint "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.index ["group_id"], name: "index_comments_on_group_id"
  end

  create_table "detail_dates", force: :cascade do |t|
    t.bigint "submission_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "starttime"
    t.datetime "endtime"
    t.integer "counted", default: 0
    t.index ["submission_id"], name: "index_detail_dates_on_submission_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "title"
    t.datetime "startday"
    t.datetime "endday"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "calendar_id"
    t.index ["calendar_id"], name: "index_events_on_calendar_id", unique: true
    t.index ["user_id"], name: "index_events_on_user_id"
  end

  create_table "google_calendars", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "next_sync_token"
    t.string "email"
    t.string "refresh_token"
    t.boolean "sync", default: false, null: false
    t.index ["user_id"], name: "index_google_calendars_on_user_id"
  end

  create_table "group_user_relationships", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followed_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followed_id"], name: "index_group_user_relationships_on_followed_id"
    t.index ["follower_id", "followed_id"], name: "index_group_user_relationships_on_follower_id_and_followed_id", unique: true
    t.index ["follower_id"], name: "index_group_user_relationships_on_follower_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.datetime "starttime"
    t.integer "timelength"
    t.datetime "endtime"
    t.string "starttime_of_day"
    t.string "endtime_of_day"
    t.string "access_id"
    t.boolean "multi"
    t.date "determined_day"
    t.string "determined_start"
    t.string "determined_end"
    t.boolean "finished", default: false
    t.index ["access_id"], name: "index_groups_on_access_id", unique: true
    t.index ["user_id"], name: "index_groups_on_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "answer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "read", default: false
    t.index ["answer_id"], name: "index_notifications_on_answer_id"
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followed_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followed_id"], name: "index_relationships_on_followed_id"
    t.index ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
    t.index ["follower_id"], name: "index_relationships_on_follower_id"
  end

  create_table "schedules", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "comment_id"
    t.string "result"
    t.date "date"
    t.index ["comment_id"], name: "index_schedules_on_comment_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "submission_relationships", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followed_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["follower_id", "followed_id"], name: "index_submission_relationships_on_follower_id_and_followed_id", unique: true
  end

  create_table "submissions", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "access_id"
    t.string "title"
    t.boolean "more_than_two"
    t.boolean "finished_flag", default: false
    t.boolean "expired_flag", default: false
    t.index ["user_id"], name: "index_submissions_on_user_id"
  end

  create_table "user_relations", force: :cascade do |t|
    t.integer "user_follower_id"
    t.integer "user_followed_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.string "activation_digest"
    t.boolean "activated", default: false
    t.datetime "activated_at"
    t.string "reset_digest"
    t.datetime "reset_sent_at"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "answers", "groups"
  add_foreign_key "comments", "groups"
  add_foreign_key "detail_dates", "submissions"
  add_foreign_key "events", "users"
  add_foreign_key "google_calendars", "users"
  add_foreign_key "groups", "users"
  add_foreign_key "notifications", "answers"
  add_foreign_key "notifications", "users"
  add_foreign_key "schedules", "comments"
  add_foreign_key "submissions", "users"
end
