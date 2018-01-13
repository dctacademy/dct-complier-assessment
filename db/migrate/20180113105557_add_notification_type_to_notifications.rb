class AddNotificationTypeToNotifications < ActiveRecord::Migration[5.0]
  def change
    add_column :notifications, :notification_type_id, :integer
  end
end
