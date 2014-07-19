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

ActiveRecord::Schema.define(version: 20140719045646) do

  create_table "contact_records", force: true do |t|
    t.integer  "customer_id"
    t.integer  "employee_id"
    t.datetime "time"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "contact_records", ["customer_id"], name: "index_contact_records_on_customer_id"
  add_index "contact_records", ["employee_id"], name: "index_contact_records_on_employee_id"

  create_table "corporate_customers", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "currencies", force: true do |t|
    t.string   "name"
    t.string   "symbol"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "customer_group_customers", force: true do |t|
    t.integer  "customer_id"
    t.integer  "customer_group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "customer_group_customers", ["customer_group_id"], name: "index_customer_group_customers_on_customer_group_id"
  add_index "customer_group_customers", ["customer_id"], name: "index_customer_group_customers_on_customer_id"

  create_table "customer_groups", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "customers", force: true do |t|
    t.string   "name"
    t.integer  "customer_id"
    t.string   "customer_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id"
  end

  add_index "customers", ["creator_id"], name: "index_customers_on_creator_id"
  add_index "customers", ["customer_id"], name: "index_customers_on_customer_id"

  create_table "donation_record_actual_funds", force: true do |t|
    t.integer  "donation_record_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "fund_type_id"
  end

  add_index "donation_record_actual_funds", ["donation_record_id"], name: "index_donation_record_actual_funds_on_donation_record_id"

  create_table "donation_records", force: true do |t|
    t.integer  "customer_id"
    t.integer  "project_id"
    t.integer  "creator_id"
    t.integer  "donation_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "donation_records", ["creator_id"], name: "index_donation_records_on_creator_id"
  add_index "donation_records", ["customer_id"], name: "index_donation_records_on_customer_id"
  add_index "donation_records", ["donation_type_id"], name: "index_donation_records_on_donation_type_id"
  add_index "donation_records", ["project_id"], name: "index_donation_records_on_project_id"

  create_table "donation_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "employees", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fund_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "funds", force: true do |t|
    t.decimal  "amount"
    t.datetime "time"
    t.text     "comment"
    t.integer  "currency_id"
    t.decimal  "origin_amount"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "fund_instance_type"
    t.integer  "fund_instance_id"
  end

  add_index "funds", ["currency_id"], name: "index_funds_on_currency_id"

  create_table "individual_customers", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "online_customers", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "project_levels", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "project_link_men", force: true do |t|
    t.integer  "customer_id"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "project_link_men", ["customer_id"], name: "index_project_link_men_on_customer_id"
  add_index "project_link_men", ["project_id"], name: "index_project_link_men_on_project_id"

  create_table "project_states", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "project_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", force: true do |t|
    t.string   "name"
    t.string   "serialnum"
    t.date     "create_date"
    t.integer  "creator_id"
    t.text     "brief"
    t.boolean  "endowment"
    t.integer  "project_level_id"
    t.integer  "project_state_id"
    t.integer  "project_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "projects", ["creator_id"], name: "index_projects_on_creator_id"
  add_index "projects", ["project_level_id"], name: "index_projects_on_project_level_id"
  add_index "projects", ["project_state_id"], name: "index_projects_on_project_state_id"
  add_index "projects", ["project_type_id"], name: "index_projects_on_project_type_id"

  create_table "univ_unit_managers", force: true do |t|
    t.string   "name"
    t.integer  "univ_unit_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "univ_unit_managers", ["univ_unit_id"], name: "index_univ_unit_managers_on_univ_unit_id"

  create_table "univ_units", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "usage_records", force: true do |t|
    t.integer  "creator_id"
    t.integer  "project_id"
    t.integer  "exec_unit_id"
    t.integer  "exec_manager_id"
    t.integer  "benefit_unit_id"
    t.integer  "benefit_manager_id"
    t.integer  "usage_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "fund_type_id"
  end

  add_index "usage_records", ["benefit_manager_id"], name: "index_usage_records_on_benefit_manager_id"
  add_index "usage_records", ["benefit_unit_id"], name: "index_usage_records_on_benefit_unit_id"
  add_index "usage_records", ["creator_id"], name: "index_usage_records_on_creator_id"
  add_index "usage_records", ["exec_manager_id"], name: "index_usage_records_on_exec_manager_id"
  add_index "usage_records", ["exec_unit_id"], name: "index_usage_records_on_exec_unit_id"
  add_index "usage_records", ["project_id"], name: "index_usage_records_on_project_id"
  add_index "usage_records", ["usage_type_id"], name: "index_usage_records_on_usage_type_id"

  create_table "usage_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "account",                             null: false
    t.string   "email"
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "user_id"
    t.string   "user_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["account"], name: "index_users_on_account", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["user_id"], name: "index_users_on_user_id"

end
