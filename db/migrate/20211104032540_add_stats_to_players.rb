class AddStatsToPlayers < ActiveRecord::Migration[6.1]
  def change
    add_column :players, :gp, :float
    add_column :players, :thpg, :float
  end
end
