# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_03_02_004704) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "badges", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description"
    t.string "icon"
    t.string "name"
    t.integer "requirement_days"
    t.datetime "updated_at", null: false
  end

  create_table "check_ins", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.date "date"
    t.bigint "habit_id", null: false
    t.datetime "updated_at", null: false
    t.index ["date"], name: "index_check_ins_on_date"
    t.index ["habit_id"], name: "index_check_ins_on_habit_id"
  end

  create_table "earned_badges", force: :cascade do |t|
    t.bigint "badge_id", null: false
    t.datetime "created_at", null: false
    t.datetime "earned_at"
    t.bigint "habit_id", null: false
    t.datetime "updated_at", null: false
    t.index ["badge_id"], name: "index_earned_badges_on_badge_id"
    t.index ["habit_id"], name: "index_earned_badges_on_habit_id"
  end

  create_table "entries", force: :cascade do |t|
    t.text "content"
    t.datetime "created_at", null: false
    t.date "entry_date"
    t.bigint "habit_id", null: false
    t.datetime "updated_at", null: false
    t.index ["habit_id"], name: "index_entries_on_habit_id"
  end

  create_table "habit_tags", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "habit_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "updated_at", null: false
    t.index ["habit_id"], name: "index_habit_tags_on_habit_id"
    t.index ["tag_id"], name: "index_habit_tags_on_tag_id"
  end

  create_table "habits", force: :cascade do |t|
    t.boolean "archived"
    t.datetime "archived_at"
    t.string "category"
    t.datetime "created_at", null: false
    t.text "description"
    t.string "name"
    t.string "prompt"
    t.time "reminder_time"
    t.boolean "reminders_enabled", default: false
    t.datetime "updated_at", null: false
  end

  create_table "tags", force: :cascade do |t|
    t.string "color"
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
  end

  add_foreign_key "check_ins", "habits"
  add_foreign_key "earned_badges", "badges"
  add_foreign_key "earned_badges", "habits"
  add_foreign_key "entries", "habits"
  add_foreign_key "habit_tags", "habits"
  add_foreign_key "habit_tags", "tags"
end
