class AddStatusTypeToConnection < ActiveRecord::Migration
  def up
    add_column :connection, :status_type, :string
    remove_column :connection, :status_id


  end

  def down
    remove_column :connection, :status_type
    add_column :connection, :status_id, :integer 
  end
end
