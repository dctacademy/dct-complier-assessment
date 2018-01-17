class AddColumnAssignmentGroup < ActiveRecord::Migration[5.0]
  def change
  	add_column :assignment_groups, :is_timed, :boolean, default: false
  end
end
