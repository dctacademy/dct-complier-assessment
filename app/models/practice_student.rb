class PracticeStudent < ApplicationRecord
	belongs_to :student 
	belongs_to :assignment_group
end
