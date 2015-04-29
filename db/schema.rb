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

ActiveRecord::Schema.define(version: 20150429040609) do

  create_table "memberships", force: :cascade do |t|
    t.integer  "org_id"
    t.integer  "user_id"
    t.string   "privileges"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "memberships", ["org_id", "user_id", "privileges"], name: "index_memberships_on_org_id_and_user_id_and_privileges"
  add_index "memberships", ["org_id"], name: "index_memberships_on_org_id"
  add_index "memberships", ["user_id"], name: "index_memberships_on_user_id"

  create_table "orgs", force: :cascade do |t|
    t.string   "name"
    t.string   "permalink"
    t.string   "email"
    t.string   "phone"
    t.string   "url"
    t.integer  "owner_id"
    t.string   "street_address1"
    t.string   "street_address2"
    t.string   "city"
    t.string   "state_province_region"
    t.string   "zip_postal_code"
    t.string   "country_code"
    t.string   "timezone"
    t.string   "currency_code"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "orgs", ["country_code"], name: "index_orgs_on_country_code"
  add_index "orgs", ["email"], name: "index_orgs_on_email"
  add_index "orgs", ["owner_id"], name: "index_orgs_on_owner_id"
  add_index "orgs", ["permalink"], name: "index_orgs_on_permalink"

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "email"
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.string   "phone"
    t.string   "picurl"
    t.string   "redditid"
    t.boolean  "superuser"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "users", ["email"], name: "index_users_on_email"
  add_index "users", ["redditid"], name: "index_users_on_redditid"
  add_index "users", ["superuser"], name: "index_users_on_superuser"
  add_index "users", ["username"], name: "index_users_on_username"

end
