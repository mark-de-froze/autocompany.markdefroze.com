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

ActiveRecord::Schema.define(version: 20170921142737) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cars", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.string "brand"
    t.string "model"
    t.integer "year"
    t.bigint "client_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "engine_number"
    t.integer "engine_type"
    t.integer "engine_capacity"
    t.string "state_number"
    t.integer "mileage"
    t.string "vin"
    t.index ["client_id"], name: "index_cars_on_client_id"
  end

  create_table "clients", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "phone"
    t.index ["user_id"], name: "index_clients_on_user_id"
  end

  create_table "clients_users", id: false, force: :cascade do |t|
    t.bigint "client_id", null: false
    t.bigint "user_id", null: false
    t.index ["client_id"], name: "index_clients_users_on_client_id"
    t.index ["user_id"], name: "index_clients_users_on_user_id"
  end

  create_table "histories", force: :cascade do |t|
    t.string "title"
    t.integer "price"
    t.string "code"
    t.integer "quantity"
    t.integer "status"
    t.string "trackable_type"
    t.bigint "trackable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["trackable_type", "trackable_id"], name: "index_histories_on_trackable_type_and_trackable_id"
  end

  create_table "jobs", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.integer "price"
    t.bigint "service_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["service_id"], name: "index_jobs_on_service_id"
  end

  create_table "materials", force: :cascade do |t|
    t.bigint "order_id"
    t.string "title"
    t.integer "price"
    t.integer "storable_id"
    t.string "storable_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "quantity", default: 1
    t.index ["order_id"], name: "index_materials_on_order_id"
    t.index ["storable_id"], name: "index_materials_on_storable_id"
    t.index ["storable_type"], name: "index_materials_on_storable_type"
  end

  create_table "oils", force: :cascade do |t|
    t.string "title"
    t.integer "price"
    t.string "code"
    t.integer "unit"
    t.string "storable_type"
    t.bigint "storable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "quantity"
    t.integer "total"
    t.index ["storable_type", "storable_id"], name: "index_oils_on_storable_type_and_storable_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.bigint "car_id"
    t.bigint "client_id"
    t.datetime "finished_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "mileage"
    t.bigint "worker_id"
    t.integer "status"
    t.index ["car_id"], name: "index_orders_on_car_id"
    t.index ["client_id"], name: "index_orders_on_client_id"
    t.index ["worker_id"], name: "index_orders_on_worker_id"
  end

  create_table "parts", force: :cascade do |t|
    t.string "title"
    t.integer "price"
    t.string "code"
    t.integer "unit"
    t.string "storable_type"
    t.bigint "storable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "quantity"
    t.index ["storable_type", "storable_id"], name: "index_parts_on_storable_type_and_storable_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["name"], name: "index_roles_on_name"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource_type_and_resource_id"
  end

  create_table "services", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "services_workers", id: false, force: :cascade do |t|
    t.bigint "service_id", null: false
    t.bigint "worker_id", null: false
    t.index ["service_id", "worker_id"], name: "index_services_workers_on_service_id_and_worker_id"
    t.index ["worker_id", "service_id"], name: "index_services_workers_on_worker_id_and_service_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.bigint "order_id"
    t.bigint "service_id"
    t.bigint "job_id"
    t.bigint "worker_id"
    t.integer "price"
    t.datetime "finished_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_id"], name: "index_tasks_on_job_id"
    t.index ["order_id"], name: "index_tasks_on_order_id"
    t.index ["service_id"], name: "index_tasks_on_service_id"
    t.index ["worker_id"], name: "index_tasks_on_worker_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

  create_table "workers", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_workers_on_user_id"
  end

  add_foreign_key "cars", "clients"
  add_foreign_key "clients", "users"
  add_foreign_key "jobs", "services"
  add_foreign_key "materials", "orders"
  add_foreign_key "orders", "cars"
  add_foreign_key "orders", "clients"
  add_foreign_key "orders", "workers"
  add_foreign_key "tasks", "jobs"
  add_foreign_key "tasks", "orders"
  add_foreign_key "tasks", "services"
  add_foreign_key "tasks", "workers"
  add_foreign_key "workers", "users"
end
