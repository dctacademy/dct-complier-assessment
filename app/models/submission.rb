class Submission < ApplicationRecord

  belongs_to :practice
  belongs_to :assignment
  belongs_to :user
end
