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

ActiveRecord::Schema.define(:version => 20101026033433) do

  create_table "designs", :force => true do |t|
    t.integer  "site_id"
    t.integer  "pattern_id"
    t.text     "properties"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sales_count",        :default => 0
    t.datetime "approved_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "title"
  end

  add_index "designs", ["site_id"], :name => "index_designs_on_site_id"

  create_table "patterns", :force => true do |t|
    t.integer  "site_id"
    t.text     "properties"
    t.string   "name"
    t.string   "view"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "patterns", ["site_id"], :name => "index_patterns_on_site_id"

  create_table "sites", :force => true do |t|
    t.string   "domain"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sites", ["domain"], :name => "index_sites_on_domain"

end
