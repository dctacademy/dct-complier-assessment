class Solution < ApplicationRecord
	belongs_to :assignment
	belongs_to :user

	validates_presence_of :body, :assignment_id, :user_id, :language
end
