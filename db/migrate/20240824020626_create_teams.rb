class CreateTeams < ActiveRecord::Migration[7.1]
  def change
    create_table :teams do |t|
      t.string :name
      t.float :pts_to_pg
      t.float :pts_to_sg
      t.float :pts_to_sf
      t.float :pts_to_pf
      t.float :pts_to_c
      t.float :rbs_to_pg
      t.float :rbs_to_sg
      t.float :rbs_to_sf
      t.float :rbs_to_pf
      t.float :rbs_to_c
      t.float :ast_to_pg
      t.float :ast_to_sg
      t.float :ast_to_sf
      t.float :ast_to_pf
      t.float :ast_to_c
      t.float :blks_to_pg
      t.float :blks_to_sg
      t.float :blks_to_sf
      t.float :blks_to_pf
      t.float :blks_to_c
      t.float :stl_to_pg
      t.float :stl_to_sg
      t.float :stl_to_sf
      t.float :stl_to_pf
      t.float :stl_to_c
      t.float :thrs_to_pg
      t.float :thrs_to_sg
      t.float :thrs_to_pf
      t.float :thrs_to_sf
      t.float :thrs_to_c

      t.timestamps
    end
  end
end
