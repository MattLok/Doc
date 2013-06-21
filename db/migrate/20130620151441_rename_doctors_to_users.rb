class RenameDoctorsToUsers < ActiveRecord::Migration
  def up
    rename_table :doctors, :users
  end

  def down
    rename_table :users, :doctors
  end
end
