class CreateBatchStudents < ActiveRecord::Migration[5.0]
  def change
    create_table :batch_students do |t|
      t.integer :batch_id
      t.integer :student_id

      t.timestamps
    end
  end
end
