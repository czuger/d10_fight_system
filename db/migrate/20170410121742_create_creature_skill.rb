class CreateCreatureSkill < ActiveRecord::Migration[5.0]

  def change

    create_table :creature_skills do |t|

      t.references :creature, foreign_key: true, null: false
      t.references :skill, foreign_key: true, null: false

      t.integer :xp, null: false, default: 0

    end

    add_index :creature_skills, [ :creature_id, :skill_id ], unique: true

  end

end
