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

ActiveRecord::Schema.define(version: 20180213131149) do

  create_table "bookie_odds", force: :cascade do |t|
    t.string "hometeam"
    t.string "awayteam"
    t.decimal "homeodds"
    t.decimal "drawodds"
    t.decimal "awayodds"
    t.date "matchdate"
    t.string "homebookie"
    t.string "drawbookie"
    t.string "awaybookie"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "played_games", force: :cascade do |t|
    t.string "hometeam"
    t.string "awayteam"
    t.string "homescore"
    t.string "awayscore"
    t.string "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "matchday"
  end

  create_table "scheduled_games", force: :cascade do |t|
    t.string "hometeam"
    t.string "awayteam"
    t.integer "matchday"
    t.float "homebet"
    t.float "drawbet"
    t.float "awaybet"
    t.date "matchdate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
