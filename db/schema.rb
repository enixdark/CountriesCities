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

ActiveRecord::Schema.define(version: 20150421173729) do

  create_table "cities", force: :cascade do |t|
    t.integer  "country_id", limit: 4
    t.string   "name",       limit: 255
    t.string   "image",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "url",        limit: 255
  end

  add_index "cities", ["country_id"], name: "fk_rails_996e05be41", using: :btree

  create_table "countries", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.string   "flag",            limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "countries_id_id", limit: 4
    t.integer  "cities_id",       limit: 4
    t.string   "url",             limit: 255
  end

  add_index "countries", ["cities_id"], name: "index_countries_on_cities_id", using: :btree
  add_index "countries", ["countries_id_id"], name: "index_countries_on_countries_id_id", using: :btree

end
