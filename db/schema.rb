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

ActiveRecord::Schema.define(version: 20180525042341) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "challenges", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "competitions", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.date "start"
    t.date "finish"
    t.bigint "challenge_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "rules", default: {}
    t.index ["challenge_id"], name: "index_competitions_on_challenge_id"
  end

  create_table "group_runs", force: :cascade do |t|
    t.string "title"
    t.string "place"
    t.string "distance"
    t.string "tempo"
    t.datetime "beginning"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "runs", force: :cascade do |t|
    t.integer "user_id"
    t.string "place"
    t.string "distance"
    t.string "tempo"
    t.datetime "beginning"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "group_run_id"
    t.bigint "competition_id"
    t.boolean "approved", default: false
    t.index ["competition_id"], name: "index_runs_on_competition_id"
    t.index ["group_run_id"], name: "index_runs_on_group_run_id"
    t.index ["user_id"], name: "index_runs_on_user_id"
  end

  create_table "strava_imports", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "strava_id"
    t.float "distance"
    t.string "name"
    t.float "avg_speed"
    t.datetime "beginning"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "run_id"
    t.index ["run_id"], name: "index_strava_imports_on_run_id"
    t.index ["user_id"], name: "index_strava_imports_on_user_id"
  end

  create_table "support_messages", force: :cascade do |t|
    t.string "email"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.integer "role"
    t.string "provider"
    t.string "uid"
    t.string "first_name"
    t.string "last_name"
    t.string "age_range"
    t.string "link"
    t.text "image"
    t.integer "strava_athlete_id"
    t.string "strava_access_token"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "votes", id: :serial, force: :cascade do |t|
    t.string "votable_type"
    t.integer "votable_id"
    t.string "voter_type"
    t.integer "voter_id"
    t.boolean "vote_flag"
    t.string "vote_scope"
    t.integer "vote_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope"
    t.index ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope"
  end

  add_foreign_key "strava_imports", "users"
end
