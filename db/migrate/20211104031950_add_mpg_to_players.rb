class AddMpgToPlayers < ActiveRecord::Migration[6.1]
  def change
    add_column :players, :mpg, :float
  end
end
