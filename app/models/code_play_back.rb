class CodePlayBack < ApplicationRecord
	validates_presence_of :user_id, :practice_id, :statement
	belongs_to :practice
	belongs_to :user
end
