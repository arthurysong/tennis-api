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

ActiveRecord::Schema[7.0].define(version: 2022_11_11_180243) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "reports", force: :cascade do |t|
    t.bigint "tennis_court_id", null: false
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tennis_court_id"], name: "index_reports_on_tennis_court_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.bigint "tennis_court_id", null: false
    t.text "comment"
    t.integer "rating"
    t.string "device_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tennis_court_id"], name: "index_reviews_on_tennis_court_id"
  end

  create_table "tennis_courts", force: :cascade do |t|
    t.decimal "lat", precision: 8, scale: 6
    t.decimal "long", precision: 9, scale: 6
    t.string "name"
    t.string "address"
    t.string "google_place_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.geography "lonlat", limit: {:srid=>4326, :type=>"st_point", :geographic=>true}
    t.string "street_address_1"
    t.string "street_address_2"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.integer "num_courts"
    t.boolean "lights"
    t.time "time_lights_off"
    t.integer "court_type"
    t.string "type"
    t.bigint "version_id"
    t.bigint "master_id"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_tennis_courts_on_deleted_at"
    t.index ["lonlat"], name: "index_tennis_courts_on_lonlat", using: :gist
    t.index ["master_id"], name: "index_tennis_courts_on_master_id"
    t.index ["version_id"], name: "index_tennis_courts_on_version_id"
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.bigint "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object"
    t.datetime "created_at"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  add_foreign_key "tennis_courts", "tennis_courts", column: "master_id"
end
