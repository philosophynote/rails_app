# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_11_03_095304) do

  create_table "authorities", charset: "utf8mb4", force: :cascade do |t|
    t.integer "authority", default: 0, null: false
    t.bigint "rule_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["rule_id"], name: "index_authorities_on_rule_id"
  end

  create_table "authority_service_relations", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "authority_id"
    t.bigint "service_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["authority_id"], name: "index_authority_service_relations_on_authority_id"
    t.index ["service_id"], name: "index_authority_service_relations_on_service_id"
  end

  create_table "books", id: :integer, charset: "utf8mb4", force: :cascade do |t|
    t.string "category", limit: 45
    t.string "tag1", limit: 45
    t.string "tag2", limit: 45
  end

  create_table "rules", charset: "utf8mb4", force: :cascade do |t|
    t.string "rule_name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "services", charset: "utf8mb4", force: :cascade do |t|
    t.string "service_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "authorities", "rules"
end
