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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140113043600) do

  create_table "blogs", :force => true do |t|
    t.string   "titile"
    t.string   "type"
    t.string   "author"
    t.string   "link"
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "customers", :force => true do |t|
    t.string   "weixin"
    t.string   "name"
    t.string   "phone"
    t.string   "address"
    t.text     "remark"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "fruit_with_zones", :force => true do |t|
    t.integer  "fruit_id"
    t.integer  "fruit_zone_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "fruit_zones", :force => true do |t|
    t.string   "name"
    t.text     "desc"
    t.string   "state"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "fruits", :force => true do |t|
    t.string   "name"
    t.text     "desc"
    t.integer  "inventory"
    t.float    "price"
    t.string   "state"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "items", :force => true do |t|
    t.integer  "order_id"
    t.integer  "fruit_id"
    t.string   "name"
    t.integer  "count"
    t.float    "price"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "order_with_fruits", :force => true do |t|
    t.integer  "order_id"
    t.integer  "fruit_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "orders", :force => true do |t|
    t.string   "weixin"
    t.string   "ip"
    t.text     "browser"
    t.string   "name"
    t.string   "phone"
    t.string   "address"
    t.string   "date_at"
    t.text     "remark"
    t.text     "info"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "count"
    t.float    "checkout"
  end

  create_table "users", :force => true do |t|
    t.string   "name",                   :default => "", :null => false
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "weixin_recevers", :force => true do |t|
    t.string   "to_user_name"
    t.string   "from_user_name"
    t.datetime "create_time"
    t.string   "msg_type"
    t.text     "content"
    t.string   "pic_url"
    t.string   "media_id"
    t.string   "format"
    t.string   "thumb_media_id"
    t.string   "location_x"
    t.string   "location_y"
    t.string   "scale"
    t.string   "label"
    t.string   "title"
    t.text     "description"
    t.string   "url"
    t.string   "msg_id"
    t.string   "event"
    t.string   "event_key"
    t.string   "ticket"
    t.string   "latitude"
    t.string   "longitude"
    t.string   "precision"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

end
