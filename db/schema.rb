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

  create_table "clients", force: :cascade do |t|
    t.string   "name",                limit: 255
    t.string   "status",              limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "guid",                limit: 255
    t.string   "initials",            limit: 255
    t.decimal  "overtime_multiplier",             precision: 10, scale: 2
  end

  create_table "comments", force: :cascade do |t|
    t.string   "title",            limit: 50,    default: ""
    t.text     "comment",          limit: 65535
    t.integer  "commentable_id",   limit: 4
    t.string   "commentable_type", limit: 255
    t.integer  "user_id",          limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active"
  end

  add_index "comments", ["commentable_id"], name: "index_comments_on_commentable_id", using: :btree
  add_index "comments", ["commentable_type"], name: "index_comments_on_commentable_type", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "contacts", force: :cascade do |t|
    t.string   "first_name",     limit: 255
    t.string   "last_name",      limit: 255
    t.string   "email_address",  limit: 255
    t.string   "phone_number",   limit: 255
    t.integer  "client_id",      limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "receives_email",             default: false
    t.string   "street",         limit: 255
    t.string   "city",           limit: 255
    t.string   "state",          limit: 255
    t.string   "zip",            limit: 255
    t.string   "county",         limit: 255
    t.string   "country",        limit: 255
  end

  add_index "contacts", ["client_id"], name: "index_contacts_on_client_id", using: :btree

  create_table "data_vaults", force: :cascade do |t|
    t.integer  "data_vaultable_id",   limit: 4
    t.string   "data_vaultable_type", limit: 255
    t.text     "encrypted_data",      limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "data_vaults", ["data_vaultable_id", "data_vaultable_type"], name: "dv_poly_vaultable", using: :btree

  create_table "file_attachments", force: :cascade do |t|
    t.integer  "client_id",                         limit: 4
    t.integer  "ticket_id",                         limit: 4
    t.integer  "project_id",                        limit: 4
    t.string   "attachment_file_file_name",         limit: 255
    t.string   "attachment_file_file_content_type", limit: 255
    t.integer  "attachment_file_file_size",         limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "not_valid"
  end

  add_index "file_attachments", ["client_id"], name: "index_file_attachments_on_client_id", using: :btree
  add_index "file_attachments", ["project_id"], name: "index_file_attachments_on_project_id", using: :btree
  add_index "file_attachments", ["ticket_id"], name: "index_file_attachments_on_ticket_id", using: :btree

  create_table "git_commits", force: :cascade do |t|
    t.text     "payload",     limit: 65535
    t.integer  "git_push_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "git_commits", ["git_push_id"], name: "index_git_commits_on_git_push_id", using: :btree

  create_table "git_pushes", force: :cascade do |t|
    t.text     "payload",    limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id",    limit: 4
  end

  add_index "git_pushes", ["user_id"], name: "index_git_pushes_on_user_id", using: :btree

  create_table "github_concernable_git_pushes", force: :cascade do |t|
    t.string   "github_concernable_type", limit: 255
    t.integer  "github_concernable_id",   limit: 4
    t.integer  "git_push_id",             limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "github_concernable_git_pushes", ["git_push_id"], name: "gh_concern_push_id", using: :btree
  add_index "github_concernable_git_pushes", ["github_concernable_id", "github_concernable_type"], name: "gh_concern_poly", using: :btree

  create_table "oauth_access_grants", force: :cascade do |t|
    t.integer  "resource_owner_id", limit: 4,   null: false
    t.integer  "application_id",    limit: 4,   null: false
    t.string   "token",             limit: 255, null: false
    t.integer  "expires_in",        limit: 4,   null: false
    t.string   "redirect_uri",      limit: 255, null: false
    t.datetime "created_at",                    null: false
    t.datetime "revoked_at"
    t.string   "scopes",            limit: 255
  end

  add_index "oauth_access_grants", ["token"], name: "index_oauth_access_grants_on_token", unique: true, using: :btree

  create_table "oauth_access_tokens", force: :cascade do |t|
    t.integer  "resource_owner_id", limit: 4
    t.integer  "application_id",    limit: 4,   null: false
    t.string   "token",             limit: 255, null: false
    t.string   "refresh_token",     limit: 255
    t.integer  "expires_in",        limit: 4
    t.datetime "revoked_at"
    t.datetime "created_at",                    null: false
    t.string   "scopes",            limit: 255
  end

  add_index "oauth_access_tokens", ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true, using: :btree
  add_index "oauth_access_tokens", ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id", using: :btree
  add_index "oauth_access_tokens", ["token"], name: "index_oauth_access_tokens_on_token", unique: true, using: :btree

  create_table "oauth_applications", force: :cascade do |t|
    t.string   "name",         limit: 255, null: false
    t.string   "uid",          limit: 255, null: false
    t.string   "secret",       limit: 255, null: false
    t.string   "redirect_uri", limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "oauth_applications", ["uid"], name: "index_oauth_applications_on_uid", unique: true, using: :btree

  create_table "projects", force: :cascade do |t|
    t.string   "name",                limit: 255
    t.integer  "client_id",           limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "guid",                limit: 255
    t.decimal  "overtime_multiplier",               precision: 10, scale: 2
    t.string   "git_repo_name",       limit: 255
    t.boolean  "completed",                                                  default: false
    t.string   "git_repo_url",        limit: 255
    t.text     "release_notes",       limit: 65535
    t.text     "xrono_notes",         limit: 65535
    t.string   "rate_a",              limit: 255
    t.string   "rate_b",              limit: 255
  end

  add_index "projects", ["client_id"], name: "index_projects_on_client_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name",              limit: 40
    t.string   "authorizable_type", limit: 40
    t.integer  "authorizable_id",   limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["authorizable_id", "authorizable_type"], name: "roles_auth", using: :btree

  create_table "roles_users", id: false, force: :cascade do |t|
    t.integer "user_id", limit: 4
    t.integer "role_id", limit: 4
  end

  add_index "roles_users", ["role_id"], name: "index_roles_users_on_role_id", using: :btree
  add_index "roles_users", ["user_id"], name: "index_roles_users_on_user_id", using: :btree

  create_table "site_settings", force: :cascade do |t|
    t.decimal  "overtime_multiplier",                   precision: 10, scale: 2
    t.string   "site_logo_file_name",       limit: 255
    t.string   "site_logo_content_type",    limit: 255
    t.integer  "site_logo_file_size",       limit: 4
    t.datetime "site_logo_updated_at"
    t.decimal  "total_yearly_pto_per_user",             precision: 10, scale: 2
    t.integer  "client_id",                 limit: 4
  end

  add_index "site_settings", ["client_id"], name: "index_site_settings_on_client_id", using: :btree

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id",        limit: 4
    t.integer  "taggable_id",   limit: 4
    t.string   "taggable_type", limit: 255
    t.integer  "tagger_id",     limit: 4
    t.string   "tagger_type",   limit: 255
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree
  add_index "taggings", ["tagger_id", "tagger_type"], name: "taggings_tagger", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string "name", limit: 255
  end

  create_table "tickets", force: :cascade do |t|
    t.integer  "project_id",      limit: 4
    t.string   "priority",        limit: 255
    t.string   "name",            limit: 255
    t.text     "description",     limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "guid",            limit: 255
    t.string   "state",           limit: 255
    t.decimal  "estimated_hours",               precision: 10, scale: 2
    t.string   "git_branch",      limit: 255
    t.boolean  "completed",                                              default: false
  end

  add_index "tickets", ["project_id"], name: "index_tickets_on_project_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "",    null: false
    t.string   "encrypted_password",     limit: 255, default: "",    null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name",             limit: 255
    t.string   "last_name",              limit: 255
    t.string   "middle_initial",         limit: 255
    t.datetime "locked_at"
    t.string   "guid",                   limit: 255
    t.boolean  "full_width",                         default: false
    t.integer  "daily_target_hours",     limit: 4
    t.boolean  "expanded_calendar"
    t.boolean  "client",                             default: false
    t.string   "authentication_token",   limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",  limit: 255,   null: false
    t.integer  "item_id",    limit: 4,     null: false
    t.string   "event",      limit: 255,   null: false
    t.string   "whodunnit",  limit: 255
    t.text     "object",     limit: 65535
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

  create_table "work_units", force: :cascade do |t|
    t.text     "description",     limit: 65535
    t.integer  "ticket_id",       limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "hours",                         precision: 10, scale: 2
    t.boolean  "overtime"
    t.datetime "scheduled_at"
    t.string   "guid",            limit: 255
    t.integer  "user_id",         limit: 4
    t.string   "paid",            limit: 255
    t.string   "invoiced",        limit: 255
    t.datetime "invoiced_at"
    t.datetime "paid_at"
    t.string   "hours_type",      limit: 255
    t.decimal  "effective_hours",               precision: 10, scale: 2
  end

  add_index "work_units", ["ticket_id"], name: "index_work_units_on_ticket_id", using: :btree
  add_index "work_units", ["user_id"], name: "index_work_units_on_user_id", using: :btree

end
