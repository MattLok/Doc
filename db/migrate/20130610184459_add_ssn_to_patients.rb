class AddSsnToPatients < ActiveRecord::Migration
  def up
    add_column :patients, :ssn, :integer
  end

  def down
    remove_column :patients, :ssn
  end
end
