class AddColumnStudentIdToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :student_id, :integer
  end
end
