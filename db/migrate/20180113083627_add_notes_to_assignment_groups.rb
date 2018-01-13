class AddNotesToAssignmentGroups < ActiveRecord::Migration[5.0]
  def change
    add_column :assignment_groups, :notes, :text
  end
end
