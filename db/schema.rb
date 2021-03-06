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

ActiveRecord::Schema.define(version: 0) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "samples", force: :cascade do |t|
    t.string   "sample_name",              :null=>false
    t.string   "product_matrix",           :null=>false
    t.decimal  "unit_measurement",         :precision=>8, :scale=>3
    t.integer  "unit_of_measurement"
    t.decimal  "unit_weight_in_grams"
    t.decimal  "grams_per_ml"
  end

  create_table "tests", force: :cascade do |t|
    t.string   "name",         :null=>false
  end

  create_table "sample_tests", force: :cascade do |t|
    t.bigint   "sample_id",            :null=>false
    t.bigint   "test_id",              :null=>false
  end

  create_table "sample_reports", force: :cascade do |t|
    t.bigint   "sample_id",            :null=>false
  end

  create_table "sample_test_reports", force: :cascade do |t|
    t.bigint   "sample_report_id",        :null=>false
    t.bigint   "sample_test_id",          :null=>false
    t.string   "input_units",             :default=>"", :null=>false
    t.string   "primary_display_units",   :default=>"", :null=>false
    t.string   "secondary_display_units", :default=>"", :null=>false
    t.integer  "decimal_places",          :default=>2, :null=>false
  end
end
