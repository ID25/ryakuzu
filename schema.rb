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

ActiveRecord::Schema.define(version: 20151118230646) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "atonher", force: :cascade do |t|
    t.string   "pidor",      default: ""
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "new_table", force: :cascade do |t|
    t.integer  "test"
    t.string   "zisor"
    t.datetime "rororooro",  null: false
    t.datetime "updated_at", null: false
  end

  add_index "new_table", ["test"], name: "index_new_table_on_test", using: :btree

  create_table "xzzxxzzx", force: :cascade do |t|
    t.string   "xyeli666",               default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "ooooooooo"
    t.datetime "ororor",                              null: false
    t.datetime "updated_at",                          null: false
    t.string   "name",                   default: ""
    t.string   "last_name",              default: ""
  end

  add_index "xzzxxzzx", ["reset_password_token"], name: "index_xzzxxzzx_on_reset_password_token", unique: true, using: :btree
  add_index "xzzxxzzx", ["xyeli666"], name: "index_xzzxxzzx_on_xyeli666", unique: true, using: :btree

  create_table "you_very", force: :cascade do |t|
    t.integer  "attachment_id"
    t.integer  "tag_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "pidor"
  end

  add_index "you_very", ["attachment_id"], name: "index_you_very_on_attachment_id", using: :btree
  add_index "you_very", ["tag_id"], name: "index_you_very_on_tag_id", using: :btree

  create_table "zzx", force: :cascade do |t|
    t.integer  "cool_man"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "zzx", ["cool_man"], name: "index_zzx_on_cool_man", using: :btree

  add_foreign_key "new_table", "xzzxxzzx", column: "test"
  add_foreign_key "you_very", "atonher", column: "tag_id"
  add_foreign_key "you_very", "new_table", column: "attachment_id"
  add_foreign_key "zzx", "xzzxxzzx", column: "cool_man"
end
