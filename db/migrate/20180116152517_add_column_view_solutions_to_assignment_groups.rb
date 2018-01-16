class AddColumnViewSolutionsToAssignmentGroups < ActiveRecord::Migration[5.0]
  def change
    add_column :assignment_groups, :view_solutions, :boolean, default: false
  end
end
