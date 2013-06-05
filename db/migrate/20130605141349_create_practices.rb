class CreatePractices < ActiveRecord::Migration
  def change
    create_table :practices do |t|
      t.string :office_name
      t.string :contact_name
      t.string :phone
      t.string :email

      t.timestamps
    end
  end
end
