class CreatePlayers < ActiveRecord::Migration[7.1]
  def change
    create_table :players do |t|
      t.string :fname
      t.string :teamname
      t.string :pos
      t.float :usg
      t.float :efg
      t.float :ts
      t.float :ppg
      t.float :rpg
      t.float :apg
      t.float :spg
      t.float :bpg
      t.float :mpg
      t.float :gp
      t.float :thpg

      t.timestamps
    end
  end
end
