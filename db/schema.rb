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

ActiveRecord::Schema.define(:version => 20140513114312) do

  create_table "articles", :force => true do |t|
    t.string   "title"
    t.text     "cotent"
    t.datetime "time"
    t.integer  "counter"
    t.integer  "channel_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "articles", ["channel_id"], :name => "index_articles_on_channel_id"

  create_table "channels", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contact_records", :force => true do |t|
    t.integer  "customer_id"
    t.integer  "employee_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "contact_records", ["customer_id"], :name => "index_contact_records_on_customer_id"
  add_index "contact_records", ["employee_id"], :name => "index_contact_records_on_employee_id"

  create_table "corporate_customers", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "customer_projects", :force => true do |t|
    t.integer  "customer_id"
    t.integer  "project_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "customer_types", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type_name"
    t.string   "table_name"
  end

  create_table "customers", :force => true do |t|
    t.string   "name"
    t.integer  "employee_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "customer_id"
    t.string   "customer_type"
  end

  add_index "customers", ["employee_id"], :name => "index_customers_on_employee_id"

  create_table "donation_records", :force => true do |t|
    t.integer  "employee_id"
    t.integer  "fund_id"
    t.integer  "donation_type_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "customer_id"
    t.integer  "project_id"
  end

  create_table "donation_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "employees", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fund_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "funds", :force => true do |t|
    t.decimal  "amount"
    t.datetime "time"
    t.integer  "fund_type_id"
    t.text     "comment"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "funds", ["fund_type_id"], :name => "index_funds_on_fund_type_id"

  create_table "individual_customers", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "online_customers", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orgnization_customers", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "project_levels", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "project_states", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "project_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.string   "serialnum"
    t.date     "create_date"
    t.text     "brief"
    t.decimal  "gross"
    t.decimal  "balance"
    t.boolean  "endowment"
    t.integer  "project_level_id"
    t.integer  "project_state_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "employee_id"
    t.integer  "project_type_id"
  end

  add_index "projects", ["project_level_id"], :name => "index_projects_on_project_level_id"
  add_index "projects", ["project_state_id"], :name => "index_projects_on_project_state_id"

  create_table "users", :force => true do |t|
    t.string   "account"
    t.string   "password_digest"
    t.integer  "user_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "user_type"
  end

end
