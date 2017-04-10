class CreateTeam < ActiveRecord::Migration[5.0]
  def change
    create_table :teams do |t|
      t.string :name, null: false, index: { unique: true }
    end

    add_reference :creatures, :team, foreign_key: true
  end
end
