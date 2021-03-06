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

ActiveRecord::Schema.define(version: 2021_10_02_064641) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "artists", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "artists_songs", force: :cascade do |t|
    t.bigint "artist_id", null: false
    t.bigint "song_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["artist_id", "song_id"], name: "index_artists_songs_on_artist_id_and_song_id", unique: true
    t.index ["artist_id"], name: "index_artists_songs_on_artist_id"
    t.index ["song_id"], name: "index_artists_songs_on_song_id"
  end

  create_table "entries", force: :cascade do |t|
    t.integer "year", null: false
    t.integer "week", null: false
    t.integer "position", null: false
    t.bigint "song_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["song_id"], name: "index_entries_on_song_id"
    t.index ["year", "week", "position"], name: "index_entries_on_year_and_week_and_position", unique: true
    t.index ["year", "week"], name: "index_entries_on_year_and_week"
    t.index ["year"], name: "index_entries_on_year"
  end

  create_table "songs", force: :cascade do |t|
    t.string "title", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.decimal "rating"
    t.integer "fondness", default: 0, null: false
    t.boolean "is_acclaimed", default: false, null: false
    t.string "video_youtube_id"
    t.string "stream_apple_music_id"
    t.string "stream_spotify_id"
  end

  create_table "stat_dates", force: :cascade do |t|
    t.bigint "song_id", null: false
    t.integer "median_year"
    t.integer "median_week"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "point"
    t.index ["median_year", "median_week"], name: "index_stat_dates_on_median_year_and_median_week"
    t.index ["song_id"], name: "index_stat_dates_on_song_id", unique: true
  end

end
