class CreateSkill < ActiveRecord::Migration[5.0]
  def change

    create_table :skills do |t|

      t.string :name, null: false
      t.string :trait, null: false
      t.integer :difficulty, null: false

      t.references :damage, foreign_key: true
      t.integer :reach

      t.timestamps

    end

  end
end
