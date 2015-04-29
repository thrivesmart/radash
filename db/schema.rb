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

ActiveRecord::Schema.define(version: 20150429183822) do

  create_table "ads", force: :cascade do |t|
    t.integer  "org_id"
    t.integer  "creative_id"
    t.string   "bid_type"
    t.integer  "bid_in_cents"
    t.text     "locations"
    t.text     "devices"
    t.text     "os"
    t.text     "os_versions"
    t.text     "subreddits"
    t.text     "interests"
    t.text     "placements"
    t.datetime "paused_at"
    t.datetime "approved_at"
    t.string   "approver_name"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "ads", ["approved_at"], name: "index_ads_on_approved_at"
  add_index "ads", ["approver_name"], name: "index_ads_on_approver_name"
  add_index "ads", ["bid_type"], name: "index_ads_on_bid_type"
  add_index "ads", ["creative_id"], name: "index_ads_on_creative_id"
  add_index "ads", ["org_id", "bid_type"], name: "index_ads_on_org_id_and_bid_type"
  add_index "ads", ["org_id", "creative_id"], name: "index_ads_on_org_id_and_creative_id"
  add_index "ads", ["org_id"], name: "index_ads_on_org_id"
  add_index "ads", ["paused_at"], name: "index_ads_on_paused_at"

  create_table "ads_campaigns", id: false, force: :cascade do |t|
    t.integer "ad_id"
    t.integer "campaign_id"
  end

  add_index "ads_campaigns", ["ad_id"], name: "index_ads_campaigns_on_ad_id"
  add_index "ads_campaigns", ["campaign_id"], name: "index_ads_campaigns_on_campaign_id"

  create_table "assets", force: :cascade do |t|
    t.integer  "org_id"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.text     "html"
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "assets", ["height"], name: "index_assets_on_height"
  add_index "assets", ["org_id", "width", "height"], name: "index_assets_on_org_id_and_width_and_height"
  add_index "assets", ["org_id"], name: "index_assets_on_org_id"
  add_index "assets", ["width"], name: "index_assets_on_width"

  create_table "campaigns", force: :cascade do |t|
    t.integer  "org_id"
    t.integer  "total_budget_in_cents"
    t.integer  "goal_value"
    t.string   "goal_type"
    t.text     "flights"
    t.datetime "paused_at"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "campaigns", ["org_id", "paused_at"], name: "index_campaigns_on_org_id_and_paused_at"
  add_index "campaigns", ["org_id"], name: "index_campaigns_on_org_id"
  add_index "campaigns", ["paused_at"], name: "index_campaigns_on_paused_at"

  create_table "creatives", force: :cascade do |t|
    t.integer  "org_id"
    t.integer  "asset_id"
    t.string   "title"
    t.string   "url"
    t.string   "postername"
    t.string   "posterid"
    t.string   "promoted_thingid"
    t.string   "locale"
    t.string   "attachment_type"
    t.text     "attachment_html"
    t.datetime "approved_at"
    t.string   "approver_name"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "creatives", ["approved_at"], name: "index_creatives_on_approved_at"
  add_index "creatives", ["approver_name"], name: "index_creatives_on_approver_name"
  add_index "creatives", ["asset_id"], name: "index_creatives_on_asset_id"
  add_index "creatives", ["locale"], name: "index_creatives_on_locale"
  add_index "creatives", ["org_id", "locale"], name: "index_creatives_on_org_id_and_locale"
  add_index "creatives", ["org_id"], name: "index_creatives_on_org_id"
  add_index "creatives", ["posterid"], name: "index_creatives_on_posterid"
  add_index "creatives", ["postername"], name: "index_creatives_on_postername"
  add_index "creatives", ["promoted_thingid"], name: "index_creatives_on_promoted_thingid"
  add_index "creatives", ["title"], name: "index_creatives_on_title"
  add_index "creatives", ["url"], name: "index_creatives_on_url"

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
