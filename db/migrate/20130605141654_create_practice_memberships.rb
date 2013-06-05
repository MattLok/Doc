class CreatePracticeMemberships < ActiveRecord::Migration
  def change
    create_table :practice_memberships do |t|
      t.integer :practice_id
      t.integer :patient_id

      t.timestamps
    end
  end
end
