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

ActiveRecord::Schema.define(version: 20151115140639) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"

  create_table "admin_users", force: :cascade do |t|
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
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true

  create_table "answers", force: :cascade do |t|
    t.text     "subject"
    t.text     "description"
    t.string   "reference",   limit: 255
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "question_id"
  end

  create_table "comments", force: :cascade do |t|
    t.text     "body"
    t.integer  "user_id"
    t.integer  "court_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "loco_id"
  end

  create_table "confirmations", force: :cascade do |t|
    t.integer  "court_id"
    t.integer  "user_id"
    t.boolean  "confirmed"
    t.boolean  "infirmed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "courts", force: :cascade do |t|
    t.string   "performance",                   limit: 255
    t.string   "jurisdiction",                  limit: 255
    t.string   "date"
    t.string   "bar",                           limit: 255
    t.boolean  "have_found"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.text     "details"
    t.boolean  "is_external"
    t.string   "external_requester_first_name"
    t.string   "external_requester_last_name"
    t.string   "external_requester_email"
    t.datetime "internalized_at"
    t.boolean  "to_confirm"
    t.boolean  "infirmed"
    t.datetime "confirmed_at"
    t.datetime "infirmed_at"
  end

  add_index "courts", ["user_id"], name: "index_courts_on_user_id"

  create_table "documentations", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.integer  "court_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "document_file_name"
    t.string   "document_content_type"
    t.integer  "document_file_size"
    t.datetime "document_updated_at"
  end

  create_table "dominus_litis_evaluations", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "court_id"
    t.string   "evaluation"
    t.text     "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "loco_evaluations", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "court_id"
    t.string   "evaluation"
    t.text     "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "locos", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "court_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.integer  "notifier_id"
    t.integer  "notifiee_id"
    t.string   "message"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.boolean  "read",            default: false
    t.string   "notifiable_type"
    t.integer  "notifiable_id"
  end

  create_table "prefered_areas", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "private_documentations", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.integer  "loco_id"
    t.string   "document_file_name"
    t.string   "document_content_type"
    t.integer  "document_file_size"
    t.datetime "document_updated_at"
  end

  create_table "questions", force: :cascade do |t|
    t.text     "subject"
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "responses", force: :cascade do |t|
    t.boolean  "content"
    t.integer  "user_id"
    t.integer  "court_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "skills", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "prefered_area_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                   limit: 255, default: "", null: false
    t.string   "encrypted_password",      limit: 255, default: "", null: false
    t.string   "reset_password_token",    limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",      limit: 255
    t.string   "last_sign_in_ip",         limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name",              limit: 255
    t.string   "last_name",               limit: 255
    t.string   "bar",                     limit: 255
    t.integer  "telephone"
    t.integer  "mobile"
    t.integer  "fax"
    t.string   "street",                  limit: 255
    t.string   "street_number",           limit: 255
    t.integer  "zipcode"
    t.string   "city",                    limit: 255
    t.boolean  "loco"
    t.boolean  "dominus_litis"
    t.boolean  "subscribed"
    t.string   "stripeid",                limit: 255
    t.boolean  "extended_trial"
    t.datetime "extended_trial_end_date"
    t.text     "presentation"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "website"
    t.string   "twitter"
    t.string   "facebook"
    t.string   "linkedin"
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.integer  "invitations_count",                   default: 0
    t.string   "plan"
    t.datetime "plan_start_date"
    t.datetime "plan_end_date"
    t.datetime "subscription_start_date"
    t.string   "subscription_id"
    t.datetime "last_seen_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true
  add_index "users", ["invitations_count"], name: "index_users_on_invitations_count"
  add_index "users", ["invited_by_id"], name: "index_users_on_invited_by_id"
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
