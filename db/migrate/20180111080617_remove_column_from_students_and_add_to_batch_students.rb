class RemoveColumnFromStudentsAndAddToBatchStudents < ActiveRecord::Migration[5.0]
  def change
  	remove_column :students, :points
  	add_column :batch_students, :points, :integer, default: 0
  end
end
