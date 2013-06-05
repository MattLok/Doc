class CreateConnections < ActiveRecord::Migration
  def change
    create_table :connections do |t|
      t.integer :requestor_id
      t.integer :target_id
      t.integer :status_id

      t.timestamps
    end
  end
end
