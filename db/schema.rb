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

ActiveRecord::Schema.define(version: 20171123025718) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "movie_showtimes", force: :cascade do |t|
    t.integer  "movie_id",              null: false
    t.integer  "theatre_id",            null: false
    t.string   "auditorium", limit: 16, null: false
    t.datetime "start_time",            null: false
  end

  add_index "movie_showtimes", ["movie_id"], name: "movie_showtimes_movie_id_idx", using: :btree
  add_index "movie_showtimes", ["theatre_id"], name: "movie_showtimes_theatre_id_idx", using: :btree

  create_table "movies", force: :cascade do |t|
    t.string  "name",           limit: 256, null: false
    t.integer "length_minutes",             null: false
    t.string  "rating",         limit: 8,   null: false
  end

  add_index "movies", ["name"], name: "movies_name_key", unique: true, using: :btree

  create_table "theatres", force: :cascade do |t|
    t.string "name",             limit: 256
    t.string "address_line_1",   limit: 256
    t.string "address_line_2",   limit: 256
    t.string "address_city",     limit: 128
    t.string "address_state",    limit: 2
    t.string "address_zip_code", limit: 9
    t.string "phone_number",     limit: 10
  end

  add_foreign_key "movie_showtimes", "movies", name: "movie_showtimes_movie_id_fkey"
  add_foreign_key "movie_showtimes", "theatres", name: "movie_showtimes_theatre_id_fkey"
end
