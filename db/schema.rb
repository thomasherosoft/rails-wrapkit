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

ActiveRecord::Schema.define(version: 20150818185254) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string   "city",                        null: false
    t.string   "country",                     null: false
    t.string   "phone_home",                  null: false
    t.string   "postal_zip",                  null: false
    t.string   "state_province",              null: false
    t.string   "street_name",                 null: false
    t.string   "street_number",               null: false
    t.string   "street_type",                 null: false
    t.string   "unit_num",                    null: false
    t.integer  "square_footage"
    t.string   "pre_existing_heating"
    t.string   "pre_existing_heating_age"
    t.string   "pre_existing_cooling"
    t.string   "pre_existing_cooling_age"
    t.string   "pre_existing_water"
    t.string   "pre_existing_water_age"
    t.string   "pre_existing_water_provider"
    t.string   "address_type",                null: false
    t.integer  "customer_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "addresses", ["customer_id"], name: "index_addresses_on_customer_id", using: :btree

  create_table "agents", force: :cascade do |t|
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "badge_image_file_name"
    t.string   "badge_image_content_type"
    t.integer  "badge_image_file_size"
    t.datetime "badge_image_updated_at"
    t.integer  "team_lead_id",             null: false
  end

  create_table "agreements", force: :cascade do |t|
    t.integer  "agreement_num",     null: false
    t.string   "lead_booker",       null: false
    t.string   "preinspector",      null: false
    t.string   "method_of_payment", null: false
    t.datetime "agreement_date",    null: false
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "agreements_products", id: false, force: :cascade do |t|
    t.integer "agreement_id"
    t.integer "product_id"
  end

  add_index "agreements_products", ["agreement_id"], name: "index_agreements_products_on_agreement_id", using: :btree
  add_index "agreements_products", ["product_id"], name: "index_agreements_products_on_product_id", using: :btree

  create_table "applications", force: :cascade do |t|
    t.integer  "application_number"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "customer_products", force: :cascade do |t|
    t.integer  "customer_id"
    t.string   "application_number"
    t.integer  "status"
    t.integer  "program_id"
    t.integer  "product_id"
    t.float    "price"
    t.boolean  "hst"
    t.boolean  "free"
    t.string   "serial_number"
    t.string   "model_number"
    t.integer  "cp_type"
    t.string   "coil_serial_number"
    t.string   "coil_model_number"
    t.date     "purchase_date"
    t.boolean  "funded"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "customer_products", ["customer_id"], name: "index_customer_products_on_customer_id", using: :btree
  add_index "customer_products", ["product_id"], name: "index_customer_products_on_product_id", using: :btree
  add_index "customer_products", ["program_id"], name: "index_customer_products_on_program_id", using: :btree

  create_table "customers", force: :cascade do |t|
    t.string   "initial_lead_booker",     null: false
    t.string   "initial_closer",          null: false
    t.string   "primary_first_name",      null: false
    t.string   "primary_last_name",       null: false
    t.string   "secondary_first_name"
    t.string   "secondary_last_name"
    t.string   "security_question"
    t.string   "security_answer"
    t.string   "phone_mobile"
    t.string   "void_image_content_type"
    t.string   "void_image_file_name"
    t.integer  "void_image_file_size"
    t.datetime "void_image_updated_at"
    t.string   "oba_ref_num"
    t.string   "enbridge_num"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.boolean  "use_service_address"
    t.integer  "financial_details_id"
    t.integer  "address_service_id"
    t.integer  "address_mailing_id"
    t.integer  "address_billing_id"
  end

  add_index "customers", ["financial_details_id"], name: "index_customers_on_financial_details_id", using: :btree

  create_table "distributors", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "distributors_distributorships", id: false, force: :cascade do |t|
    t.integer "distributor_id",     null: false
    t.integer "distributorship_id", null: false
  end

  add_index "distributors_distributorships", ["distributor_id"], name: "index_distributors_distributorships_on_distributor_id", using: :btree
  add_index "distributors_distributorships", ["distributorship_id"], name: "index_distributors_distributorships_on_distributorship_id", using: :btree

  create_table "distributorships", force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "employees", force: :cascade do |t|
    t.string   "city",           null: false
    t.string   "employee_type"
    t.string   "country",        null: false
    t.string   "designation"
    t.string   "phone_home",     null: false
    t.string   "phone_mobile"
    t.string   "postal_zip",     null: false
    t.string   "sin"
    t.string   "state_province", null: false
    t.string   "street_name",    null: false
    t.string   "street_number",  null: false
    t.string   "street_type"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "financial_details", force: :cascade do |t|
    t.string   "account_number"
    t.string   "branch_number"
    t.integer  "address_id"
    t.integer  "financial_institution_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "financial_details", ["address_id"], name: "index_financial_details_on_address_id", using: :btree
  add_index "financial_details", ["financial_institution_id"], name: "index_financial_details_on_financial_institution_id", using: :btree

  create_table "financial_institutions", force: :cascade do |t|
    t.string   "fi_name"
    t.string   "fi_number"
    t.integer  "fi_head_address"
    t.integer  "address_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "financial_institutions", ["address_id"], name: "index_financial_institutions_on_address_id", using: :btree
  add_index "financial_institutions", ["fi_head_address"], name: "index_financial_institutions_on_fi_head_address", using: :btree

  create_table "ic_subtypes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "independent_contractors", force: :cascade do |t|
    t.integer  "agent_number",      null: false
    t.string   "business_num",      null: false
    t.string   "city",              null: false
    t.string   "country",           null: false
    t.string   "card_number",       null: false
    t.string   "gst_number"
    t.string   "ic_code",           null: false
    t.string   "payment_method",    null: false
    t.string   "phone_business"
    t.string   "phone_home",        null: false
    t.string   "phone_mobile",      null: false
    t.string   "postal_zip",        null: false
    t.string   "sin"
    t.string   "state_province",    null: false
    t.string   "street_name",       null: false
    t.string   "street_number",     null: false
    t.string   "street_type"
    t.string   "unit_num",          null: false
    t.boolean  "preinspector",      null: false
    t.boolean  "lead_booker",       null: false
    t.boolean  "ic_signed",         null: false
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "distributor_id"
    t.integer  "office_manager_id"
    t.integer  "office_admin_id"
    t.integer  "recruiter_id"
    t.integer  "team_lead_id"
    t.integer  "agent_id"
    t.integer  "office_id"
  end

  add_index "independent_contractors", ["agent_number"], name: "index_independent_contractors_on_agent_number", unique: true, using: :btree
  add_index "independent_contractors", ["office_id"], name: "index_independent_contractors_on_office_id", using: :btree

  create_table "marketing_documents", force: :cascade do |t|
    t.string   "name"
    t.string   "filename"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "office_admins", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "office_managers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "offices", force: :cascade do |t|
    t.string   "name",               null: false
    t.string   "street_num"
    t.string   "street_name"
    t.string   "street_type"
    t.string   "unit_num"
    t.string   "postal_zip"
    t.string   "city"
    t.string   "state_province"
    t.string   "country"
    t.integer  "distributorship_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "offices", ["distributorship_id"], name: "index_offices_on_distributorship_id", using: :btree

  create_table "product_program_prices", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "program_id"
    t.float    "price"
    t.integer  "free_days"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "product_program_prices", ["product_id"], name: "index_product_program_prices_on_product_id", using: :btree
  add_index "product_program_prices", ["program_id"], name: "index_product_program_prices_on_program_id", using: :btree

  create_table "product_sub_types", force: :cascade do |t|
    t.string   "name"
    t.integer  "product_type_id"
    t.boolean  "active"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "product_sub_types", ["product_type_id"], name: "index_product_sub_types_on_product_type_id", using: :btree

  create_table "product_types", force: :cascade do |t|
    t.string  "name"
    t.boolean "active"
  end

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "duration"
    t.boolean  "allow_sales"
    t.integer  "product_type_id"
    t.integer  "product_sub_type_id"
    t.boolean  "active"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "products", ["product_sub_type_id"], name: "index_products_on_product_sub_type_id", using: :btree
  add_index "products", ["product_type_id"], name: "index_products_on_product_type_id", using: :btree

  create_table "programs", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "billing_type"
    t.boolean  "active"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "recruiters", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "street_suffixes", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "team_leads", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_subtypes", force: :cascade do |t|
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                     default: "",      null: false
    t.string   "encrypted_password",        default: "",      null: false
    t.string   "provider",                  default: "email", null: false
    t.string   "uid",                       default: "",      null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",             default: 0,       null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.json     "tokens"
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "active"
    t.integer  "independent_contractor_id"
    t.integer  "employee_id"
    t.string   "username"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true, using: :btree

  add_foreign_key "agents", "team_leads"
  add_foreign_key "agreements_products", "agreements"
  add_foreign_key "agreements_products", "products"
  add_foreign_key "customer_products", "customers"
  add_foreign_key "customer_products", "products"
  add_foreign_key "customer_products", "programs"
  add_foreign_key "distributors_distributorships", "distributors"
  add_foreign_key "distributors_distributorships", "distributorships"
  add_foreign_key "financial_details", "addresses"
  add_foreign_key "financial_details", "financial_institutions"
  add_foreign_key "financial_institutions", "addresses"
  add_foreign_key "independent_contractors", "offices"
  add_foreign_key "offices", "distributorships"
  add_foreign_key "product_program_prices", "products"
  add_foreign_key "product_program_prices", "programs"
  add_foreign_key "product_sub_types", "product_types"
  add_foreign_key "products", "product_sub_types"
  add_foreign_key "products", "product_types"
end
