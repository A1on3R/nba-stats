require 'rails_helper'

RSpec.describe Team, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'database columns' do
    it { should have_db_column(:name).of_type(:string) }

    %w[pg sg sf pf c].each do |pos|
      it { should have_db_column("pts_to_#{pos}").of_type(:float) }
      it { should have_db_column("rbs_to_#{pos}").of_type(:float) }
      it { should have_db_column("ast_to_#{pos}").of_type(:float) }
      it { should have_db_column("blks_to_#{pos}").of_type(:float) }
      it { should have_db_column("stl_to_#{pos}").of_type(:float) }
      it { should have_db_column("thrs_to_#{pos}").of_type(:float) }
    end
  end
end