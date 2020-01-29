# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_01_29_102037) do

  create_table "infinite_blocks_monthly_records", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci", force: :cascade do |t|
    t.integer "user_id"
    t.integer "score"
    t.integer "level"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "infinite_blocks_records", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci", force: :cascade do |t|
    t.integer "user_id"
    t.integer "score"
    t.integer "level"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "infinite_blocks_weekly_records", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci", force: :cascade do |t|
    t.integer "user_id"
    t.integer "score"
    t.integer "level"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "infinite_blocks_yearly_records", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci", force: :cascade do |t|
    t.integer "user_id"
    t.integer "score"
    t.integer "level"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "news", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci", force: :cascade do |t|
    t.string "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.string "image"
    t.string "description"
    t.string "url"
    t.string "twitter_uid"
    t.string "twitter_url"
    t.boolean "is_published_profile"
    t.boolean "is_published_description"
    t.boolean "is_published_url"
    t.boolean "is_published_twitter_url"
    t.string "reset_password_token"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "twitter_image"
    t.boolean "is_published_record"
    t.string "twitter_access_token"
    t.string "twitter_access_token_secret"
  end

end
