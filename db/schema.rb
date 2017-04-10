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

ActiveRecord::Schema.define(version: 20170410135555) do

  create_table "creature_items", force: :cascade do |t|
    t.integer "creature_id",       null: false
    t.integer "item_id",           null: false
    t.integer "creature_skill_id", null: false
    t.integer "hp",                null: false
    t.index ["creature_id"], name: "index_creature_items_on_creature_id"
    t.index ["creature_skill_id"], name: "index_creature_items_on_creature_skill_id"
    t.index ["item_id"], name: "index_creature_items_on_item_id"
  end

  create_table "creature_skills", force: :cascade do |t|
    t.integer "creature_id",             null: false
    t.integer "skill_id",                null: false
    t.integer "xp",          default: 0, null: false
    t.index ["creature_id", "skill_id"], name: "index_creature_skills_on_creature_id_and_skill_id", unique: true
    t.index ["creature_id"], name: "index_creature_skills_on_creature_id"
    t.index ["skill_id"], name: "index_creature_skills_on_skill_id"
  end

  create_table "creatures", force: :cascade do |t|
    t.string   "type",                          null: false
    t.string   "name",                          null: false
    t.integer  "str",                           null: false
    t.integer  "coo",                           null: false
    t.integer  "wil",                           null: false
    t.integer  "mem",                           null: false
    t.integer  "hp",                            null: false
    t.integer  "xp",                default: 0, null: false
    t.integer  "default_position",  default: 1, null: false
    t.integer  "current_position",  default: 1, null: false
    t.integer  "current_weapon_id"
    t.string   "def_mode_type"
    t.integer  "def_mode_id"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.index ["def_mode_type", "def_mode_id"], name: "index_creatures_on_def_mode_type_and_def_mode_id"
  end

  create_table "damages", force: :cascade do |t|
    t.integer  "dices_side", default: 6, null: false
    t.integer  "nb_dices",   default: 1, null: false
    t.integer  "bonus",      default: 0, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["dices_side", "nb_dices", "bonus"], name: "index_damages_on_dices_side_and_nb_dices_and_bonus", unique: true
  end

  create_table "items", force: :cascade do |t|
    t.string   "name",       null: false
    t.integer  "skill_id"
    t.integer  "difficulty"
    t.integer  "hp"
    t.integer  "damage_id"
    t.integer  "reach"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["damage_id"], name: "index_items_on_damage_id"
    t.index ["skill_id"], name: "index_items_on_skill_id"
  end

  create_table "skills", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "trait",      null: false
    t.integer  "difficulty", null: false
    t.integer  "damage_id"
    t.integer  "reach"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["damage_id"], name: "index_skills_on_damage_id"
  end

end
