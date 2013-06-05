class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.datetime :date
      t.integer :doctor_id
      t.integer :prac_mem_id

      t.timestamps
    end
  end
end
