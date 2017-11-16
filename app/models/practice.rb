class Practice < ApplicationRecord

	has_many :practice_students
	has_many :students, through: :practice_students

	belongs_to :assignment_group
	belongs_to :assignment

end
