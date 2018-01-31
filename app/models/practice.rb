class Practice < ApplicationRecord

	has_many :practice_students
	has_many :students, through: :practice_students
	has_many :submissions

	has_many :notifications
	has_many :submission_timers

	has_many :code_play_backs

	belongs_to :assignment_group
	belongs_to :assignment

end
