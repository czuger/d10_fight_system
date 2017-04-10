class CreateCreature < ActiveRecord::Migration[5.0]

  def change
    create_table :creatures do |t|

      t.string :type, null: false

      t.string :name, null: false, index: { unique: true }

      t.integer :str, null: false
      t.integer :coo, null: false
      t.integer :wil, null: false
      t.integer :mem, null: false

      t.integer :hp, null: false
      t.integer :xp, null: false, default: 0

      t.integer :default_position, null: false, default: 1
      t.integer :current_position, null: false, default: 1

      t.references :def_mode, polymorphic: true
      t.references :current_weapon, polymorphic: true

      t.timestamps
    end
  end

end