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

ActiveRecord::Schema.define(version: 20121021122002) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", force: :cascade do |t|
    t.string   "name"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "guid"
    t.string   "initials"
    t.decimal  "overtime_multiplier", precision: 10, scale: 2
  end

  create_table "comments", force: :cascade do |t|
    t.string   "title",            limit: 50, default: ""
    t.text     "comment"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active"
  end

  add_index "comments", ["commentable_id"], name: "index_comments_on_commentable_id", using: :btree
  add_index "comments", ["commentable_type"], name: "index_comments_on_commentable_type", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "contacts", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email_address"
    t.string   "phone_number"
    t.integer  "client_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "receives_email", default: false
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "county"
    t.string   "country"
  end

  add_index "contacts", ["client_id"], name: "index_contacts_on_client_id", using: :btree

  create_table "data_vaults", force: :cascade do |t|
    t.integer  "data_vaultable_id"
    t.string   "data_vaultable_type"
    t.text     "encrypted_data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "data_vaults", ["data_vaultable_id", "data_vaultable_type"], name: "dv_poly_vaultable", using: :btree

  create_table "file_attachments", force: :cascade do |t|
    t.integer  "client_id"
    t.integer  "ticket_id"
    t.integer  "project_id"
    t.string   "attachment_file_file_name"
    t.string   "attachment_file_file_content_type"
    t.integer  "attachment_file_file_size"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "not_valid"
  end

  add_index "file_attachments", ["client_id"], name: "index_file_attachments_on_client_id", using: :btree
  add_index "file_attachments", ["project_id"], name: "index_file_attachments_on_project_id", using: :btree
  add_index "file_attachments", ["ticket_id"], name: "index_file_attachments_on_ticket_id", using: :btree

  create_table "git_commits", force: :cascade do |t|
    t.text     "payload"
    t.integer  "git_push_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "git_commits", ["git_push_id"], name: "index_git_commits_on_git_push_id", using: :btree

  create_table "git_pushes", force: :cascade do |t|
    t.text     "payload"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "git_pushes", ["user_id"], name: "index_git_pushes_on_user_id", using: :btree

  create_table "github_concernable_git_pushes", force: :cascade do |t|
    t.string   "github_concernable_type"
    t.integer  "github_concernable_id"
    t.integer  "git_push_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "github_concernable_git_pushes", ["git_push_id"], name: "gh_concern_push_id", using: :btree
  add_index "github_concernable_git_pushes", ["github_concernable_id", "github_concernable_type"], name: "gh_concern_poly", using: :btree

  create_table "oauth_access_grants", force: :cascade do |t|
    t.integer  "resource_owner_id", null: false
    t.integer  "application_id",    null: false
    t.string   "token",             null: false
    t.integer  "expires_in",        null: false
    t.string   "redirect_uri",      null: false
    t.datetime "created_at",        null: false
    t.datetime "revoked_at"
    t.string   "scopes"
  end

  add_index "oauth_access_grants", ["token"], name: "index_oauth_access_grants_on_token", unique: true, using: :btree

  create_table "oauth_access_tokens", force: :cascade do |t|
    t.integer  "resource_owner_id"
    t.integer  "application_id",    null: false
    t.string   "token",             null: false
    t.string   "refresh_token"
    t.integer  "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at",        null: false
    t.string   "scopes"
  end

  add_index "oauth_access_tokens", ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true, using: :btree
  add_index "oauth_access_tokens", ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id", using: :btree
  add_index "oauth_access_tokens", ["token"], name: "index_oauth_access_tokens_on_token", unique: true, using: :btree

  create_table "oauth_applications", force: :cascade do |t|
    t.string   "name",         null: false
    t.string   "uid",          null: false
    t.string   "secret",       null: false
    t.string   "redirect_uri", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "oauth_applications", ["uid"], name: "index_oauth_applications_on_uid", unique: true, using: :btree

  create_table "projects", force: :cascade do |t|
    t.string   "name"
    t.integer  "client_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "guid"
    t.decimal  "overtime_multiplier", precision: 10, scale: 2
    t.string   "git_repo_name"
    t.boolean  "completed",                                    default: false
    t.string   "git_repo_url"
    t.text     "release_notes"
    t.text     "xrono_notes"
    t.string   "rate_a"
    t.string   "rate_b"
  end

  add_index "projects", ["client_id"], name: "index_projects_on_client_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name",              limit: 40
    t.string   "authorizable_type", limit: 40
    t.integer  "authorizable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["authorizable_id", "authorizable_type"], name: "roles_auth", using: :btree

  create_table "roles_users", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "roles_users", ["role_id"], name: "index_roles_users_on_role_id", using: :btree
  add_index "roles_users", ["user_id"], name: "index_roles_users_on_user_id", using: :btree

  create_table "site_settings", force: :cascade do |t|
    t.decimal  "overtime_multiplier",       precision: 10, scale: 2
    t.string   "site_logo_file_name"
    t.string   "site_logo_content_type"
    t.integer  "site_logo_file_size"
    t.datetime "site_logo_updated_at"
    t.decimal  "total_yearly_pto_per_user", precision: 10, scale: 2
    t.integer  "client_id"
  end

  add_index "site_settings", ["client_id"], name: "index_site_settings_on_client_id", using: :btree

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree
  add_index "taggings", ["tagger_id", "tagger_type"], name: "taggings_tagger", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string "name"
  end

  create_table "tickets", force: :cascade do |t|
    t.integer  "project_id"
    t.string   "priority"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "guid"
    t.string   "state"
    t.decimal  "estimated_hours", precision: 10, scale: 2
    t.string   "git_branch"
    t.boolean  "completed",                                default: false
  end

  add_index "tickets", ["project_id"], name: "index_tickets_on_project_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "middle_initial"
    t.datetime "locked_at"
    t.string   "guid"
    t.boolean  "full_width",             default: false
    t.integer  "daily_target_hours"
    t.boolean  "expanded_calendar"
    t.boolean  "client",                 default: false
    t.string   "authentication_token"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

  create_table "work_units", force: :cascade do |t|
    t.text     "description"
    t.integer  "ticket_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "hours",           precision: 10, scale: 2
    t.boolean  "overtime"
    t.datetime "scheduled_at"
    t.string   "guid"
    t.integer  "user_id"
    t.string   "paid"
    t.string   "invoiced"
    t.datetime "invoiced_at"
    t.datetime "paid_at"
    t.string   "hours_type"
    t.decimal  "effective_hours", precision: 10, scale: 2
  end

  add_index "work_units", ["ticket_id"], name: "index_work_units_on_ticket_id", using: :btree
  add_index "work_units", ["user_id"], name: "index_work_units_on_user_id", using: :btree

end
