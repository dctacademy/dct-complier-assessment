class CreatePractices < ActiveRecord::Migration[5.0]
  def change
    create_table :practices do |t|
      t.integer :assignment_group_id
      t.integer :assignment_id

      t.timestamps
    end
  end
end
