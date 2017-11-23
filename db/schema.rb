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
    t.integer  "movie_id"
    t.integer  "theatre_id"
    t.string   "auditorium", limit: 16
    t.datetime "start_time"
  end

  create_table "movies", force: :cascade do |t|
    t.string  "name",           limit: 256
    t.integer "length_minutes"
    t.string  "rating",         limit: 8
  end

  create_table "theatres", force: :cascade do |t|
    t.string "name",             limit: 256
    t.string "address_line_1",   limit: 256
    t.string "address_line_2",   limit: 256
    t.string "address_city",     limit: 128
    t.string "address_state",    limit: 2
    t.string "address_zip_code", limit: 9
    t.string "phone_number",     limit: 10
  end

end