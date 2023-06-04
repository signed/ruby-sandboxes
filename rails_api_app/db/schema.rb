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

ActiveRecord::Schema[7.0].define(version: 2023_06_04_092432) do
  create_table "moons", force: :cascade do |t|
    t.string "name"
    t.integer "radius"
    t.integer "planet_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["planet_id"], name: "index_moons_on_planet_id"
  end

  create_table "planets", force: :cascade do |t|
    t.string "name"
    t.integer "radius"
    t.integer "star_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["star_id"], name: "index_planets_on_star_id"
  end

  create_table "stars", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "radius"
  end

  add_foreign_key "moons", "planets"
  add_foreign_key "planets", "stars"
end
