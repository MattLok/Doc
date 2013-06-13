class AddStatusTypeToConnection < ActiveRecord::Migration
  def up
    add_column :connections, :status_type, :string
    remove_column :connections, :status_id


  end

  def down
    remove_column :connections, :status_type
    add_column :connections, :status_id, :integer 
  end
end
