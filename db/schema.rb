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

ActiveRecord::Schema[7.1].define(version: 0) do
  create_table "rss_feeds", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rss_items", force: :cascade do |t|
    t.integer "rss_feed_id"
    t.string "title"
    t.string "link"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["rss_feed_id"], name: "index_rss_items_on_rss_feed_id"
  end

  create_table "rss_urls", force: :cascade do |t|
    t.string "url"
    t.boolean "is_original"
    t.integer "rss_feed_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["rss_feed_id"], name: "index_rss_urls_on_rss_feed_id"
  end

  add_foreign_key "rss_items", "rss_feeds"
  add_foreign_key "rss_urls", "rss_feeds"
end
