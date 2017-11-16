class CreateBatches < ActiveRecord::Migration[5.0]
  def change
    create_table :batches do |t|
      t.string :title
      t.date :start_date
      t.date :end_date
      t.integer :course_id
      t.boolean :is_completed, default: false

      t.timestamps
    end
  end
end
