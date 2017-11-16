class AssignmentGroup < ApplicationRecord

	has_many :practices
	has_many :assignments, through: :practices

	has_many :practice_students
	has_many :students, through: :practice_students

	belongs_to :batch
	validates_presence_of :title, :batch_id, :due_datetime
end
