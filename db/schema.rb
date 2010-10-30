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

ActiveRecord::Schema.define(:version => 20101030200108) do

  create_table "cafepress_products", :force => true do |t|
    t.string   "cafepress_id"
    t.integer  "product_id"
    t.integer  "design_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.string   "key"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "designs", :force => true do |t|
    t.integer  "site_id"
    t.integer  "pattern_id"
    t.text     "properties"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sales_count",              :default => 0
    t.datetime "approved_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "title"
    t.integer  "user_id"
    t.string   "offsets"
    t.integer  "category_id"
    t.string   "cafepress_id"
    t.string   "cafepress_dark_id"
    t.string   "cafepress_media_url"
    t.string   "cafepress_dark_media_url"
    t.integer  "store_id"
    t.string   "cafepress_section_id"
    t.string   "cached_slug"
  end

  add_index "designs", ["site_id"], :name => "index_designs_on_site_id"

  create_table "patterns", :force => true do |t|
    t.integer  "site_id"
    t.text     "properties"
    t.string   "name"
    t.string   "view"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "preview_file_name"
    t.string   "preview_content_type"
    t.integer  "preview_file_size"
    t.datetime "preview_updated_at"
    t.string   "offsets"
    t.boolean  "has_dark",             :default => true
    t.string   "description"
  end

  add_index "patterns", ["site_id"], :name => "index_patterns_on_site_id"

  create_table "products", :force => true do |t|
    t.string   "name"
    t.string   "section"
    t.string   "cafepress_id"
    t.string   "media_regions"
    t.string   "default_region"
    t.string   "default_alignment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "dark",              :default => false
    t.string   "marketplace_price"
  end

  create_table "sites", :force => true do |t|
    t.string   "domain"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "default_category_id"
    t.integer  "current_store_id"
  end

  add_index "sites", ["domain"], :name => "index_sites_on_domain"

  create_table "slugs", :force => true do |t|
    t.string   "name"
    t.integer  "sluggable_id"
    t.integer  "sequence",                     :default => 1, :null => false
    t.string   "sluggable_type", :limit => 40
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "slugs", ["name", "sluggable_type", "sequence", "scope"], :name => "index_slugs_on_n_s_s_and_s", :unique => true
  add_index "slugs", ["sluggable_id"], :name => "index_slugs_on_sluggable_id"

  create_table "stores", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                              :default => "",    :null => false
    t.string   "encrypted_password",  :limit => 128, :default => "",    :null => false
    t.string   "password_salt",                      :default => "",    :null => false
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.boolean  "admin",                              :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "approved",                           :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
