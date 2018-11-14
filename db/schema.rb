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

ActiveRecord::Schema.define(version: 20181031193949) do

  create_table "qbuilders", force: :cascade do |t|
    t.string "object"
    t.string "address"
    t.string "fields"
    t.string "groups"
    t.string "aggregates"
    t.datetime "moment"
    t.string "author"
    t.string "result"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "qparsers", force: :cascade do |t|
    t.string "input"
    t.string "source"
    t.string "object"
    t.string "fields"
    t.string "conditions"
    t.string "groups"
    t.string "aggregates"
    t.string "author"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "qtexts", force: :cascade do |t|
    t.integer "parent_id"
    t.string "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "type"
    t.index ["parent_id"], name: "index_qtexts_on_parent_id"
  end

end
