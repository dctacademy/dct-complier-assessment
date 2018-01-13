class Notification < ApplicationRecord
	belongs_to :user, optional: true
	belongs_to :notification_type
end
