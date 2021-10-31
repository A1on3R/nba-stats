class CreateResults < ActiveRecord::Migration[6.1]
  def change
    create_table :results do |t|
      t.references :player, null: false, foreign_key: true
      t.references :team, null: false, foreign_key: true
      t.float :projfpts
      t.float :projval
      t.integer :salary
      t.string :pos

      t.timestamps
    end
  end
end
