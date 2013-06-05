class ChangeColumnNameFromDocToDocId < ActiveRecord::Migration
  def up
    rename_column :referrals, :from_doctor, :doctor_id
  end

  def down
    rename_column :referrals, :doctor_id, :from_doctor
  end
end
