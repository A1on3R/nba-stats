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

ActiveRecord::Schema[7.1].define(version: 2024_08_24_025927) do
  create_table "dvps", force: :cascade do |t|
    t.string "pos"
    t.string "team"
    t.string "pts"
    t.string "fgp"
    t.string "ftp"
    t.string "thrs"
    t.string "rbs"
    t.string "ast"
    t.string "stl"
    t.string "blk"
    t.string "to"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "players", force: :cascade do |t|
    t.string "fname"
    t.string "teamname"
    t.string "pos"
    t.float "usg"
    t.float "efg"
    t.float "ts"
    t.float "ppg"
    t.float "rpg"
    t.float "apg"
    t.float "spg"
    t.float "bpg"
    t.float "mpg"
    t.float "gp"
    t.float "thpg"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "results", force: :cascade do |t|
    t.integer "player_id"
    t.integer "team_id"
    t.float "projfpts"
    t.float "projval"
    t.integer "salary"
    t.string "pos"
    t.float "projpts"
    t.float "projthrs"
    t.float "projrbs"
    t.float "projast"
    t.float "projstls"
    t.float "projblks"
    t.float "numberfiremins"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["player_id"], name: "index_results_on_player_id"
    t.index ["team_id"], name: "index_results_on_team_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.float "pts_to_pg"
    t.float "pts_to_sg"
    t.float "pts_to_sf"
    t.float "pts_to_pf"
    t.float "pts_to_c"
    t.float "rbs_to_pg"
    t.float "rbs_to_sg"
    t.float "rbs_to_sf"
    t.float "rbs_to_pf"
    t.float "rbs_to_c"
    t.float "ast_to_pg"
    t.float "ast_to_sg"
    t.float "ast_to_sf"
    t.float "ast_to_pf"
    t.float "ast_to_c"
    t.float "blks_to_pg"
    t.float "blks_to_sg"
    t.float "blks_to_sf"
    t.float "blks_to_pf"
    t.float "blks_to_c"
    t.float "stl_to_pg"
    t.float "stl_to_sg"
    t.float "stl_to_sf"
    t.float "stl_to_pf"
    t.float "stl_to_c"
    t.float "thrs_to_pg"
    t.float "thrs_to_sg"
    t.float "thrs_to_pf"
    t.float "thrs_to_sf"
    t.float "thrs_to_c"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "results", "players"
  add_foreign_key "results", "teams"
end
