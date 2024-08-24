class CreateDvps < ActiveRecord::Migration[7.1]
  def change
    create_table :dvps do |t|
      t.string :pos
      t.string :team
      t.string :pts
      t.string :fgp
      t.string :ftp
      t.string :thrs
      t.string :rbs
      t.string :ast
      t.string :stl
      t.string :blk
      t.string :to

      t.timestamps
    end
  end
end
