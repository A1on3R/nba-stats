class AddStatsToTeams < ActiveRecord::Migration[6.1]
  def change
    add_column :teams, :thrs_to_pg, :float
    add_column :teams, :thrs_to_sg, :float
    add_column :teams, :thrs_to_pf, :float
    add_column :teams, :thrs_to_sf, :float
    add_column :teams, :thrs_to_c, :float
  end
end
