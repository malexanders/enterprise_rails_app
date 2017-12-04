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

ActiveRecord::Schema.define(version: 20171204203341) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", id: false, force: :cascade do |t|
    t.string "line_1",       limit: 256, null: false
    t.string "line_2",       limit: 256
    t.string "city",         limit: 128, null: false
    t.string "state",        limit: 2,   null: false
    t.string "zip_code",     limit: 9,   null: false
    t.string "phone_number", limit: 10,  null: false
  end

  create_table "auditoria", force: :cascade do |t|
    t.integer "theatre_id",                       null: false
    t.string  "auditorium_identifier", limit: 64, null: false
    t.integer "seats_available",                  null: false
  end

  add_index "auditoria", ["theatre_id", "auditorium_identifier"], name: "auditoria_theatre_id_auditorium_identifier_key", unique: true, using: :btree

  create_table "movie_showtimes", force: :cascade do |t|
    t.integer  "movie_id",              null: false
    t.integer  "theatre_id",            null: false
    t.string   "auditorium", limit: 16, null: false
    t.datetime "start_time",            null: false
  end

  add_index "movie_showtimes", ["movie_id"], name: "movie_showtimes_movie_id_idx", using: :btree
  add_index "movie_showtimes", ["start_time"], name: "movie_showtimes_start_time_idx", using: :btree
  add_index "movie_showtimes", ["theatre_id"], name: "movie_showtimes_theatre_id_idx", using: :btree

  create_table "movies", force: :cascade do |t|
    t.string  "name",           limit: 256, null: false
    t.integer "length_minutes",             null: false
  end

  add_index "movies", ["name"], name: "movies_name_key", unique: true, using: :btree

  create_table "orders", force: :cascade do |t|
    t.string   "line_1",             limit: 256, null: false
    t.string   "line_2",             limit: 256
    t.string   "city",               limit: 128, null: false
    t.string   "state",              limit: 2,   null: false
    t.string   "zip_code",           limit: 9,   null: false
    t.string   "phone_number",       limit: 10,  null: false
    t.string   "confirmation_code",  limit: 256, null: false
    t.integer  "movie_showtime_id",              null: false
    t.integer  "payment_type_id",                null: false
    t.integer  "credit_card_number",             null: false
    t.datetime "expiration_date",                null: false
  end

  add_index "orders", ["confirmation_code"], name: "orders_confirmation_code_key", unique: true, using: :btree

  create_table "purchased_tickets", force: :cascade do |t|
    t.integer "order_id",             null: false
    t.integer "purchase_price_cents", null: false
  end

  create_table "ratings", force: :cascade do |t|
    t.string "rating_name",        limit: 16
    t.text   "rating_description"
  end

  create_table "theatres", force: :cascade do |t|
    t.string "line_1",       limit: 256, null: false
    t.string "line_2",       limit: 256
    t.string "city",         limit: 128, null: false
    t.string "state",        limit: 2,   null: false
    t.string "zip_code",     limit: 9,   null: false
    t.string "phone_number", limit: 10,  null: false
    t.string "name",         limit: 256
  end

  add_index "theatres", ["zip_code"], name: "theatres_zip_idx", using: :btree

  add_foreign_key "auditoria", "theatres", name: "auditoria_theatre_id_fkey"
  add_foreign_key "movie_showtimes", "movies", name: "movie_showtimes_movie_id_fkey"
  add_foreign_key "movie_showtimes", "theatres", name: "movie_showtimes_theatre_id_fkey"
  add_foreign_key "orders", "movie_showtimes", name: "orders_movie_showtime_id_fkey"
  add_foreign_key "purchased_tickets", "orders", name: "purchased_tickets_order_id_fkey"
end
