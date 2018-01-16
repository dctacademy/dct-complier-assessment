class Submission < ApplicationRecord

	has_many :comments
	
  belongs_to :practice
  belongs_to :assignment
  belongs_to :user
end
