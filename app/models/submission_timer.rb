class SubmissionTimer < ApplicationRecord
	belongs_to :user
	belongs_to :assignment_group
	belongs_to :assignment
	belongs_to :practice
end
