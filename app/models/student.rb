class Student < ApplicationRecord

	has_one :user

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

	after_create :create_user_and_assign_role

  def create_user_and_assign_role
  	user = User.create(email: self.email, username: self.name, password: self.mobile, student_id: self.id)
    Permission.create(user_id: user.id, role_id: Role.find_by(name: "student").id)
  end  
end
