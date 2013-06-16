class AddStatusTypeToReferral < ActiveRecord::Migration
  def up
    add_column :referrals, :status_type, :string
    remove_column :referrals, :status_id
  end
  def down
    remove_column :referrals, :status_type
    add_column :referrals, :status_id, :integer
  end

end
