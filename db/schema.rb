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

ActiveRecord::Schema.define(version: 20141006083729) do

  create_table "attachments", force: true do |t|
    t.integer  "attachment_owner_id"
    t.string   "attachment_owner_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
  end

  add_index "attachments", ["attachment_owner_id", "attachment_owner_type"], name: "index_attachments_on_its_owner_id_and_owner_type"

  create_table "contact_records", force: true do |t|
    t.integer  "customer_id"
    t.integer  "creator_id"
    t.datetime "time"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "conclusion"
    t.string   "location"
  end

  add_index "contact_records", ["creator_id"], name: "index_contact_records_on_creator_id"
  add_index "contact_records", ["customer_id"], name: "index_contact_records_on_customer_id"

  create_table "corporate_customer_link_man_link_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "corporate_customer_link_men", force: true do |t|
    t.integer  "corporate_customer_id"
    t.integer  "individual_customer_id"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "corporate_customer_link_man_type_id"
  end

  add_index "corporate_customer_link_men", ["corporate_customer_id"], name: "index_corporate_customer_link_men_on_corporate_customer_id"
  add_index "corporate_customer_link_men", ["individual_customer_id"], name: "index_corporate_customer_link_men_on_individual_customer_id"

  create_table "corporate_customers", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "currencies", force: true do |t|
    t.string   "name"
    t.string   "symbol"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "name_abbrpy"
  end

  add_index "currencies", ["name_abbrpy"], name: "index_currencies_on_name_abbrpy"

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
    t.string   "country"
    t.string   "province"
    t.string   "city"
    t.string   "address"
    t.string   "tel"
    t.string   "email"
    t.string   "fax"
    t.string   "postcode"
    t.text     "comment"
    t.text     "name_abbrpy"
  end

  add_index "customers", ["creator_id"], name: "index_customers_on_creator_id"
  add_index "customers", ["customer_id"], name: "index_customers_on_customer_id"
  add_index "customers", ["name_abbrpy"], name: "index_customers_on_name_abbrpy"

  create_table "degrees", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "name_abbrpy"
  end

  add_index "degrees", ["name_abbrpy"], name: "index_degrees_on_name_abbrpy"

  create_table "donation_record_actual_funds", force: true do |t|
    t.integer  "donation_record_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "fund_type_id"
  end

  add_index "donation_record_actual_funds", ["donation_record_id"], name: "index_donation_record_actual_funds_on_donation_record_id"

  create_table "donation_record_interest_periods", force: true do |t|
    t.decimal  "rate"
    t.date     "start"
    t.date     "end"
    t.text     "comment"
    t.integer  "donation_record_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "donation_record_interest_periods", ["donation_record_id"], name: "index_donation_record_interest_periods_on_donation_record_id"

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
    t.text     "name_abbrpy"
  end

  add_index "donation_types", ["name_abbrpy"], name: "index_donation_types_on_name_abbrpy"

  create_table "employees", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "name_abbrpy"
  end

  add_index "employees", ["name_abbrpy"], name: "index_employees_on_name_abbrpy"

  create_table "fund_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "name_abbrpy"
  end

  add_index "fund_types", ["name_abbrpy"], name: "index_fund_types_on_name_abbrpy"

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
    t.boolean  "gender"
    t.string   "nation"
    t.string   "native_place"
    t.date     "birthday"
    t.integer  "corporate_customer_id"
    t.string   "title"
  end

  add_index "individual_customers", ["corporate_customer_id"], name: "index_individual_customers_on_corporate_customer_id"

  create_table "majors", force: true do |t|
    t.string   "name"
    t.integer  "univ_unit_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "name_abbrpy"
  end

  add_index "majors", ["name_abbrpy"], name: "index_majors_on_name_abbrpy"
  add_index "majors", ["univ_unit_id"], name: "index_majors_on_univ_unit_id"

  create_table "online_customers", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "project_levels", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "name_abbrpy"
  end

  add_index "project_levels", ["name_abbrpy"], name: "index_project_levels_on_name_abbrpy"

  create_table "project_link_men", force: true do |t|
    t.integer  "customer_id"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "project_link_men", ["customer_id"], name: "index_project_link_men_on_customer_id"
  add_index "project_link_men", ["project_id"], name: "index_project_link_men_on_project_id"

  create_table "project_news", force: true do |t|
    t.string   "title"
    t.text     "link"
    t.text     "comment"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "project_news", ["project_id"], name: "index_project_news_on_project_id"

  create_table "project_states", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "name_abbrpy"
  end

  add_index "project_states", ["name_abbrpy"], name: "index_project_states_on_name_abbrpy"

  create_table "project_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "name_abbrpy"
  end

  add_index "project_types", ["name_abbrpy"], name: "index_project_types_on_name_abbrpy"

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
    t.decimal  "interest_rate"
    t.integer  "create_unit_id"
    t.integer  "create_manager_id"
    t.text     "comment"
    t.text     "name_abbrpy"
  end

  add_index "projects", ["creator_id"], name: "index_projects_on_creator_id"
  add_index "projects", ["name_abbrpy"], name: "index_projects_on_name_abbrpy"
  add_index "projects", ["project_level_id"], name: "index_projects_on_project_level_id"
  add_index "projects", ["project_state_id"], name: "index_projects_on_project_state_id"
  add_index "projects", ["project_type_id"], name: "index_projects_on_project_type_id"

  create_table "schoolfellow_study_experiences", force: true do |t|
    t.integer  "schoolfellow_id"
    t.integer  "major_id"
    t.integer  "degree_id"
    t.date     "attendance_date"
    t.date     "graduated_date"
    t.string   "student_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "schoolfellow_study_experiences", ["degree_id"], name: "index_schoolfellow_study_experiences_on_degree_id"
  add_index "schoolfellow_study_experiences", ["major_id"], name: "index_schoolfellow_study_experiences_on_major_id"
  add_index "schoolfellow_study_experiences", ["schoolfellow_id"], name: "index_schoolfellow_study_experiences_on_schoolfellow_id"

  create_table "schoolfellow_teach_experiences", force: true do |t|
    t.integer  "schoolfellow_id"
    t.integer  "teacher_title_id"
    t.integer  "univ_unit_id"
    t.date     "teach_start"
    t.date     "teach_end"
    t.string   "idnum"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "schoolfellow_teach_experiences", ["schoolfellow_id"], name: "index_schoolfellow_teach_experiences_on_schoolfellow_id"
  add_index "schoolfellow_teach_experiences", ["teacher_title_id"], name: "index_schoolfellow_teach_experiences_on_teacher_title_id"
  add_index "schoolfellow_teach_experiences", ["univ_unit_id"], name: "index_schoolfellow_teach_experiences_on_univ_unit_id"

  create_table "schoolfellows", force: true do |t|
    t.integer  "individual_customer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "schoolfellows", ["individual_customer_id"], name: "index_schoolfellows_on_individual_customer_id"

  create_table "teacher_titles", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "name_abbrpy"
  end

  add_index "teacher_titles", ["name_abbrpy"], name: "index_teacher_titles_on_name_abbrpy"

  create_table "univ_unit_managers", force: true do |t|
    t.string   "name"
    t.integer  "univ_unit_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "tel"
    t.string   "mobile"
    t.string   "email"
    t.string   "fax"
    t.string   "postcode"
    t.text     "name_abbrpy"
  end

  add_index "univ_unit_managers", ["name_abbrpy"], name: "index_univ_unit_managers_on_name_abbrpy"
  add_index "univ_unit_managers", ["univ_unit_id"], name: "index_univ_unit_managers_on_univ_unit_id"

  create_table "univ_units", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "name_abbrpy"
  end

  add_index "univ_units", ["name_abbrpy"], name: "index_univ_units_on_name_abbrpy"

  create_table "usage_record_used_funds", force: true do |t|
    t.integer  "usage_record_id"
    t.integer  "fund_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "usage_record_used_funds", ["fund_type_id"], name: "index_usage_record_used_funds_on_fund_type_id"
  add_index "usage_record_used_funds", ["usage_record_id"], name: "index_usage_record_used_funds_on_usage_record_id"

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
    t.text     "comment"
    t.text     "usage_comment"
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
    t.text     "name_abbrpy"
  end

  add_index "usage_types", ["name_abbrpy"], name: "index_usage_types_on_name_abbrpy"

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
