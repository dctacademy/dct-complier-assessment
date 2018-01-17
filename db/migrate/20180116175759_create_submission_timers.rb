class CreateSubmissionTimers < ActiveRecord::Migration[5.0]
  def change
    create_table :submission_timers do |t|
      t.integer :user_id
      t.integer :assignment_group_id
      t.integer :assignment_id
      t.integer :practice_id

      t.timestamps
    end
  end
end
