class AddPracticeIdToNotifications < ActiveRecord::Migration[5.0]
  def change
    add_column :notifications, :practice_id, :integer
  end
end
