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

ActiveRecord::Schema.define(version: 20151012065534) do

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "favoritings", force: :cascade do |t|
    t.integer  "topic_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "favoritings", ["topic_id"], name: "index_favoritings_on_topic_id"
  add_index "favoritings", ["user_id"], name: "index_favoritings_on_user_id"

  create_table "feedbacks", force: :cascade do |t|
    t.string   "name"
    t.integer  "topic_id"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.text     "content"
    t.integer  "user_id"
    t.string   "status",            default: "published"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
  end

  add_index "feedbacks", ["topic_id"], name: "index_feedbacks_on_topic_id"
  add_index "feedbacks", ["user_id"], name: "index_feedbacks_on_user_id"

  create_table "firefights", force: :cascade do |t|
    t.integer  "firefight_id"
    t.string   "name"
    t.string   "result"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "legislators", force: :cascade do |t|
    t.integer  "legislator_id"
    t.string   "name"
    t.string   "party"
    t.string   "constituency"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "likings", force: :cascade do |t|
    t.integer  "topic_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "likings", ["topic_id"], name: "index_likings_on_topic_id"
  add_index "likings", ["user_id"], name: "index_likings_on_user_id"

  create_table "profiles", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "email"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "status"
    t.integer  "user_id"
  end

  add_index "profiles", ["status"], name: "index_profiles_on_status"
  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id"

  create_table "subscribings", force: :cascade do |t|
    t.integer  "topic_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "subscribings", ["topic_id"], name: "index_subscribings_on_topic_id"
  add_index "subscribings", ["user_id"], name: "index_subscribings_on_user_id"

  create_table "taggings", force: :cascade do |t|
    t.integer  "topic_id"
    t.integer  "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id"
  add_index "taggings", ["topic_id"], name: "index_taggings_on_topic_id"

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "topics", force: :cascade do |t|
    t.string   "name"
    t.text     "content"
    t.boolean  "is_public"
    t.integer  "capacity"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "status"
    t.integer  "user_id"
    t.integer  "category_id"
    t.integer  "feedbacks_count",      default: 0
    t.datetime "latest_feedback_time"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.integer  "favoritings_count",    default: 0
    t.integer  "likings_count",        default: 0
    t.integer  "Subscribings_count",   default: 0
  end

  add_index "topics", ["category_id"], name: "index_topics_on_category_id"
  add_index "topics", ["user_id"], name: "index_topics_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",           null: false
    t.string   "encrypted_password",     default: "",           null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,            null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.string   "role",                   default: "normal"
    t.string   "fb_uid"
    t.string   "fb_token"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "favoritings_count",      default: 0
    t.integer  "likings_count",          default: 0
    t.integer  "Subscribings_count",     default: 0
    t.string   "username",               default: "unregister"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["fb_uid"], name: "index_users_on_fb_uid"
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
