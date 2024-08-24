class AddIndexesToResults < ActiveRecord::Migration[7.1]
  def change
    add_index :results, :player_id, name: "index_results_on_player_id"
    add_index :results, :team_id, name: "index_results_on_team_id"
  end
end