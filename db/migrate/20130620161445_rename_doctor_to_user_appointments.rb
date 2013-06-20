class RenameDoctorToUserAppointments < ActiveRecord::Migration
  def up
    rename_column :appointments, :doctor_id, :user_id
  end

  def down
    rename_column :appointments, :user_id, :doctor_id
  end
end
