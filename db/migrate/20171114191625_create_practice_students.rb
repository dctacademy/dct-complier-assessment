class CreatePracticeStudents < ActiveRecord::Migration[5.0]
  def change
    create_table :practice_students do |t|
      t.integer :assignment_group_id
      t.integer :student_id

      t.timestamps
    end
  end
end
