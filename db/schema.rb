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

ActiveRecord::Schema[7.2].define(version: 2024_08_24_214911) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "collects", force: :cascade do |t|
    t.text "text"
    t.bigint "day_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["day_id"], name: "index_collects_on_day_id"
  end

  create_table "days", force: :cascade do |t|
    t.string "name"
    t.string "service"
    t.string "year"
    t.string "season"
    t.string "color"
    t.integer "rank"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lessons", force: :cascade do |t|
    t.string "references", array: true
    t.bigint "day_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["day_id"], name: "index_lessons_on_day_id"
  end

  create_table "passages", force: :cascade do |t|
    t.string "reference"
    t.text "esv_text"
    t.text "esv_html"
    t.bigint "lesson_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lesson_id"], name: "index_passages_on_lesson_id"
  end

  create_table "psalms", force: :cascade do |t|
    t.integer "number"
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "verses", force: :cascade do |t|
    t.integer "number"
    t.text "first_half"
    t.text "second_half"
    t.bigint "psalm_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["psalm_id"], name: "index_verses_on_psalm_id"
  end

  add_foreign_key "collects", "days"
  add_foreign_key "lessons", "days"
  add_foreign_key "passages", "lessons"
  add_foreign_key "verses", "psalms"
end
