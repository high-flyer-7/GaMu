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

ActiveRecord::Schema[8.1].define(version: 2026_10_04_032818) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "games", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "title", null: false
    t.datetime "updated_at", null: false
  end

  create_table "moods", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
  end

  create_table "track_moods", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "mood_id", null: false
    t.bigint "track_id", null: false
    t.datetime "updated_at", null: false
    t.index ["mood_id"], name: "index_track_moods_on_mood_id"
    t.index ["track_id", "mood_id"], name: "index_track_moods_on_track_id_and_mood_id", unique: true
    t.index ["track_id"], name: "index_track_moods_on_track_id"
  end

  create_table "tracks", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "game_id", null: false
    t.string "title", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_tracks_on_game_id"
  end

  create_table "youtube_videos", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.boolean "is_active", default: true, null: false
    t.integer "priority", default: 1, null: false
    t.bigint "track_id", null: false
    t.datetime "updated_at", null: false
    t.string "video_id", null: false
    t.index ["track_id"], name: "index_youtube_videos_on_track_id"
    t.index ["video_id"], name: "index_youtube_videos_on_video_id", unique: true
  end

  add_foreign_key "track_moods", "moods"
  add_foreign_key "track_moods", "tracks"
  add_foreign_key "tracks", "games"
  add_foreign_key "youtube_videos", "tracks"
end
