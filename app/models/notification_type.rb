class NotificationType < ApplicationRecord
	has_many :notifications

	validates_presence_of :name
	validates_uniqueness_of :name
end
