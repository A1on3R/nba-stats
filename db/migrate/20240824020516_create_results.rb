class CreateResults < ActiveRecord::Migration[7.1]
  def change
    create_table :results do |t|
      t.integer :player_id
      t.integer :team_id
      t.float :projfpts
      t.float :projval
      t.integer :salary
      t.string :pos
      t.float :projpts
      t.float :projthrs
      t.float :projrbs
      t.float :projast
      t.float :projstls
      t.float :projblks
      t.float :numberfiremins

      t.timestamps
    end
  end
end
