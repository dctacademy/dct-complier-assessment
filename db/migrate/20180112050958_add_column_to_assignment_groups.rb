class AddColumnToAssignmentGroups < ActiveRecord::Migration[5.0]
  def change
    add_column :assignment_groups, :allow_points, :boolean, default: true
  end
end
