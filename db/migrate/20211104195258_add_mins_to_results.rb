class AddMinsToResults < ActiveRecord::Migration[6.1]
  def change
    add_column :results, :numberfiremins, :float
  end
end
