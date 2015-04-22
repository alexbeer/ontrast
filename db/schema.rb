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

ActiveRecord::Schema.define(version: 20150422210730) do

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true

  create_table "contests", force: :cascade do |t|
    t.string   "title"
    t.text     "prize"
    t.text     "description"
    t.text     "rules"
    t.string   "name"
    t.string   "email"
    t.string   "company"
    t.datetime "start_at"
    t.datetime "end_at"
    t.string   "status",           default: "pending", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "facebook_handle"
    t.string   "twitter_handle"
    t.string   "instagram_handle"
    t.string   "website_url"
    t.string   "image_large_url"
    t.string   "image_medium_url"
    t.string   "image_thumb_url"
  end

  create_table "photos", force: :cascade do |t|
    t.string   "caption"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
    t.integer  "contest_id"
    t.string   "name"
    t.string   "facebook_handle"
    t.string   "twitter_handle"
    t.string   "instagram_handle"
    t.string   "website_url"
    t.string   "image_large_url"
    t.string   "image_medium_url"
    t.string   "image_thumb_url"
  end

end
