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

ActiveRecord::Schema.define(version: 20150420020825) do

  create_table "active_admin_comments", force: true do |t|
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

  create_table "admin_users", force: true do |t|
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
    t.string   "admin_user"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true

  create_table "artifacts", force: true do |t|
    t.string   "title",         limit: nil
    t.string   "kind",          limit: nil
    t.string   "content",       limit: nil
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "user_id"
    t.string   "image",         limit: nil
    t.string   "link",          limit: nil
    t.string   "tldr",          limit: nil
    t.integer  "fellowship_id"
    t.string   "link_favicon",  limit: nil
    t.string   "slug",          limit: nil
  end

  add_index "artifacts", ["slug"], name: "index_artifacts_on_slug"

  create_table "fellowshipments", force: true do |t|
    t.integer  "user_id"
    t.integer  "fellowship_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "fellowships", force: true do |t|
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "user_id"
    t.string   "fellowship_name",        limit: nil
    t.boolean  "public_fellowship"
    t.string   "fellowship_description"
  end

  create_table "follows", force: true do |t|
    t.integer  "followable_id",                               null: false
    t.string   "followable_type", limit: nil,                 null: false
    t.integer  "follower_id",                                 null: false
    t.string   "follower_type",   limit: nil,                 null: false
    t.boolean  "blocked",                     default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "follows", ["followable_id", "followable_type"], name: "fk_followables"
  add_index "follows", ["follower_id", "follower_type"], name: "fk_follows"

  create_table "identities", force: true do |t|
    t.integer  "user_id"
    t.string   "provider",   limit: nil
    t.string   "uid",        limit: nil
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "identities", ["user_id"], name: "index_identities_on_user_id"

  create_table "sessions", force: true do |t|
    t.string   "session_id", limit: nil, null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at"

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type", limit: nil
    t.integer  "tagger_id"
    t.string   "tagger_type",   limit: nil
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", force: true do |t|
    t.string  "name",           limit: nil
    t.integer "taggings_count",             default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true

  create_table "users", force: true do |t|
    t.string   "email",                    limit: nil, default: "",                            null: false
    t.string   "encrypted_password",       limit: nil, default: "",                            null: false
    t.string   "reset_password_token",     limit: nil
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                        default: 0,                             null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",       limit: nil
    t.string   "last_sign_in_ip",          limit: nil
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "fellowship_id"
    t.string   "username",                 limit: nil
    t.string   "profile_pic_file_name",    limit: nil
    t.string   "profile_pic_content_type", limit: nil
    t.integer  "profile_pic_file_size"
    t.datetime "profile_pic_updated_at"
    t.string   "default_pic",              limit: nil, default: "http://pkm.me/noprofile.png"
    t.text     "description"
    t.string   "facebook_link",            limit: nil, default: ""
    t.string   "twitter_link",             limit: nil, default: ""
    t.string   "linkedin_link",            limit: nil, default: ""
    t.string   "provider",                 limit: nil
    t.string   "uid",                      limit: nil
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["username"], name: "index_users_on_username", unique: true

  create_table "votes", force: true do |t|
    t.integer  "votable_id"
    t.string   "votable_type", limit: nil
    t.integer  "voter_id"
    t.string   "voter_type",   limit: nil
    t.boolean  "vote_flag"
    t.string   "vote_scope",   limit: nil
    t.integer  "vote_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope"
  add_index "votes", ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope"

end
