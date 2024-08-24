class AddForeignKeysToResults < ActiveRecord::Migration[7.1]
  def change
    add_foreign_key :results, :players
    add_foreign_key :results, :teams
  end
end