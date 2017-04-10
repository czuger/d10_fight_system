class CreateDamage < ActiveRecord::Migration[5.0]

  def change

    create_table :damages do |t|

      t.integer :dices_side, null: false, default: 6
      t.integer :nb_dices, null: false, default: 1
      t.integer :bonus, null: false, default: 0

      t.timestamps
    end

    add_index :damages, [ :dices_side, :nb_dices, :bonus ], unique: true

  end
end
