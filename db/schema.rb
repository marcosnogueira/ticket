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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111012182525) do

  create_table "coupons", :force => true do |t|
    t.float    "price"
    t.string   "title"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "events", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "coupons_count", :default => 0
  end

  create_table "hit_data", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hits", :force => true do |t|
    t.integer  "hit_data_id"
    t.integer  "user_id"
    t.integer  "resource_id"
    t.string   "resource_class_name"
    t.integer  "source_url_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "source_id"
    t.integer  "ammount",             :default => 0
  end

  create_table "referral_stats", :force => true do |t|
    t.integer  "visit_count", :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "share_urls", :force => true do |t|
    t.integer  "user_id"
    t.integer  "resource_id"
    t.string   "resource_class_name"
    t.string   "id_base62"
    t.integer  "share_count",         :default => 0
    t.integer  "hit_count",           :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "not_share_count",     :default => 0
    t.integer  "view_count",          :default => 0
  end

  create_table "source_urls", :force => true do |t|
    t.integer  "source_id"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sources", :force => true do |t|
    t.string   "domain"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.float    "credit"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
