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

ActiveRecord::Schema.define(:version => 20140109085401) do

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
