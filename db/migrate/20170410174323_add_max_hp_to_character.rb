class AddMaxHpToCharacter < ActiveRecord::Migration[5.0]
  def change

    add_column :creatures, :max_hp, :integer
    rename_column :creatures, :hp, :current_hp

  end
end
