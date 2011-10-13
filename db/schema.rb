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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111013204323) do

  create_table "games", :force => true do |t|
    t.string   "name"
    t.string   "uuid"
    t.boolean  "started"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "games_players", :id => false, :force => true do |t|
    t.integer "game_id"
    t.integer "player_id"
  end

  add_index "games_players", ["game_id", "player_id"], :name => "index_games_players_on_game_id_and_player_id"
  add_index "games_players", ["player_id", "game_id"], :name => "index_games_players_on_player_id_and_game_id"

  create_table "messages", :force => true do |t|
    t.integer  "player_id"
    t.text     "message"
    t.integer  "priority",   :default => 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "players", :force => true do |t|
    t.string   "name"
    t.string   "uuid"
    t.integer  "current_game"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ships", :force => true do |t|
    t.string   "home"
    t.string   "vector"
    t.integer  "length"
    t.integer  "player_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
