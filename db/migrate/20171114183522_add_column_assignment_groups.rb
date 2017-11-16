class AddColumnAssignmentGroups < ActiveRecord::Migration[5.0]
  def change
  	add_column :assignment_groups, :due_datetime, :datetime
  end
end
