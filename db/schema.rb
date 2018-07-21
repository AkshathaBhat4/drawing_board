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

ActiveRecord::Schema.define(version: 2018_07_21_140547) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "boards", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cells", force: :cascade do |t|
    t.integer "x_axis"
    t.integer "y_axis"
    t.boolean "filled", default: false
    t.bigint "color_id"
    t.bigint "user_id"
    t.bigint "board_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["board_id"], name: "index_cells_on_board_id"
    t.index ["color_id"], name: "index_cells_on_color_id"
    t.index ["user_id"], name: "index_cells_on_user_id"
  end

  create_table "colors", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_actions", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "board_id"
    t.bigint "cell_id"
    t.bigint "color_id"
    t.integer "action_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["board_id"], name: "index_user_actions_on_board_id"
    t.index ["cell_id"], name: "index_user_actions_on_cell_id"
    t.index ["color_id"], name: "index_user_actions_on_color_id"
    t.index ["user_id"], name: "index_user_actions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "color_id"
    t.index ["color_id"], name: "index_users_on_color_id"
  end

  add_foreign_key "cells", "boards"
  add_foreign_key "cells", "colors"
  add_foreign_key "cells", "users"
  add_foreign_key "user_actions", "boards"
  add_foreign_key "user_actions", "cells"
  add_foreign_key "user_actions", "colors"
  add_foreign_key "user_actions", "users"
  add_foreign_key "users", "colors"
end
