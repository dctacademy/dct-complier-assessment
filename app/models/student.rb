class Student < ApplicationRecord

	has_many :student_courses
	has_many :courses, through: :student_courses

	has_many :batch_students
	has_many :batches, through: :batch_students

	has_many :practice_students
	has_many :assignment_groups, through: :practice_students

	validates_presence_of :name, :email, :mobile
	validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
	validates_uniqueness_of :email, :mobile
	validates_length_of :mobile, is: 10
end
