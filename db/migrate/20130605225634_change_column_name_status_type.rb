class ChangeColumnNameStatusType < ActiveRecord::Migration
  def up
    rename_column :statuses, :type, :status_type
  end

  def down
    rename_column :statuses, :status_type, :type
  end
end
