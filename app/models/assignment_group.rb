class AssignmentGroup < ApplicationRecord

	acts_as_taggable_on
	acts_as_taggable_on :tags


	has_many :practices
	has_many :assignments, through: :practices

	has_many :practice_students
	has_many :students, through: :practice_students

	has_many :assignment_timers

	belongs_to :batch
	validates_presence_of :title, :batch_id, :due_datetime
end
