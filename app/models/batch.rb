class Batch < ApplicationRecord

	has_many :assignment_groups
	has_many :batch_students
	has_many :students, through: :batch_students
	has_many :chat_rooms, dependent: :destroy
	has_many :messages

	belongs_to :course

	validates_presence_of :title, :start_date, :end_date, :course_id

	validate  :check_end_date


	private

	def check_end_date
		if !self.start_date.nil? && !self.end_date.nil? && self.end_date < self.start_date
			errors.add(:end_date, "cannot be less than start date")
		end
	end
end
