class RenameDoctorColumnsToUserColumns < ActiveRecord::Migration
  def up
    rename_column :referrals, :doctor_id, :user_id
    rename_column :referrals, :to_doctor, :to_user
  end

  def down
    rename_column :referrals, :user_id, :doctor_id
    rename_column :referrals, :to_user, :to_doctor
  end
end
