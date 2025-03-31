class AddPacingToTeams < ActiveRecord::Migration[7.1]
  def change
    add_column :teams, :pacing, :float
  end
end
