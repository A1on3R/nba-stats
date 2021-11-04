class AddStatsToResults < ActiveRecord::Migration[6.1]
  def change
    add_column :results, :projpts, :float
    add_column :results, :projthrs, :float
    add_column :results, :projrbs, :float
    add_column :results, :projast, :float
    add_column :results, :projstls, :float
    add_column :results, :projblks, :float
  end
end
