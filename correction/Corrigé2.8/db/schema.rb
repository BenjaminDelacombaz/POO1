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

ActiveRecord::Schema.define(version: 20170322071622) do

  create_table "categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name",        limit: 50, null: false
    t.string "description"
  end

  create_table "clients", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "firstname", limit: 50
    t.string "lastname",  limit: 50
    t.string "type",      limit: 50
    t.string "name",      limit: 50
  end

  create_table "comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "body",        limit: 500, null: false
    t.integer "author_id",               null: false
    t.string  "target_type",             null: false
    t.integer "target_id",               null: false
    t.index ["author_id"], name: "index_comments_on_author_id", using: :btree
    t.index ["target_type", "target_id"], name: "index_comments_on_target_type_and_target_id", using: :btree
  end

  create_table "order_items", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "quantity",                           null: false
    t.decimal "item_price", precision: 8, scale: 2, null: false
    t.integer "order_id",                           null: false
    t.integer "product_id",                         null: false
    t.index ["order_id"], name: "index_order_items_on_order_id", using: :btree
    t.index ["product_id"], name: "index_order_items_on_product_id", using: :btree
  end

  create_table "orders", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "created_at"
    t.datetime "shipped_at"
    t.string   "status",     limit: 20
    t.integer  "client_id",             null: false
    t.index ["client_id"], name: "index_orders_on_client_id", using: :btree
  end

  create_table "products", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "name",        limit: 50,                         null: false
    t.decimal "price",                  precision: 8, scale: 2, null: false
    t.string  "description"
    t.integer "category_id"
    t.integer "supplier_id"
    t.index ["category_id"], name: "index_products_on_category_id", using: :btree
    t.index ["supplier_id"], name: "index_products_on_supplier_id", using: :btree
  end

  create_table "suppliers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", limit: 50, null: false
  end

  add_foreign_key "comments", "clients", column: "author_id"
  add_foreign_key "order_items", "orders"
  add_foreign_key "order_items", "products"
  add_foreign_key "orders", "clients"
  add_foreign_key "products", "categories"
  add_foreign_key "products", "suppliers"
end
