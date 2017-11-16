class CreateAssignmentGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :assignment_groups do |t|
      t.string :title
      t.integer :batch_id

      t.timestamps
    end
  end
end
