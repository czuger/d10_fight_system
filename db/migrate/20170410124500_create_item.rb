class CreateItem < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|

      t.string :type

      t.string :name, null: false, index: { unique: true }

      t.references :skill, foreign_key: true
      t.integer :difficulty

      t.integer :hp

      t.references :damage, foreign_key: true
      t.integer :reach

      t.timestamps

    end
  end
end
