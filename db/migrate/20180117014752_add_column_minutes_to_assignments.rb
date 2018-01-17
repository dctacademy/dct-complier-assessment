class AddColumnMinutesToAssignments < ActiveRecord::Migration[5.0]
  def change
    add_column :assignments, :minutes, :integer, default: 5
  end
end
