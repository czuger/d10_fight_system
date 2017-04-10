class CreateCreatureItem < ActiveRecord::Migration[5.0]
  def change
    create_table :creature_items do |t|

      t.references :creature, foreign_key: true, null: false
      t.references :item, foreign_key: true, null: false
      t.references :creature_skill, foreign_key: true, null: false

      t.integer :hp, null: false

    end
  end
end
