class Practice < ApplicationRecord

	has_many :practice_students
	has_many :students, through: :practice_students
	has_many :submissions

	has_many :notifications
	has_many :submission_timers
	belongs_to :assignment_group
	belongs_to :assignment

end
