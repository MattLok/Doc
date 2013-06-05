class CreateReferrals < ActiveRecord::Migration
  def change
    create_table :referrals do |t|
      t.integer :from_doctor
      t.integer :to_doctor
      t.integer :patient_id
      t.text :notes
      t.integer :status_id

      t.timestamps
    end
  end
end
