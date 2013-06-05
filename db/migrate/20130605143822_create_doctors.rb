class CreateDoctors < ActiveRecord::Migration
  def change
    create_table :doctors do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.integer :practice_id

      t.timestamps
    end
  end
end
