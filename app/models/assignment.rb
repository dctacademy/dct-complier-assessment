class Assignment < ApplicationRecord

  # searchable do
  #   string :title
  #   text :body
  #   string :tag_list ,:multiple => true, :stored => true
  # end

  has_many :practices
  has_many :assignment_groups, through: :practices

  validates_uniqueness_of :code , message: "Re-submit to generate a new code."

  belongs_to :user

  has_many :answers
  has_many :submissions

  acts_as_taggable
	acts_as_taggable_on :tags,:companies

  has_many :favourites
  has_many :users,through: :favourites

  has_many :list_assignments
  has_many :lists,through: :list_assignments

  has_many :solutions

  before_validation :assign_code,on: :create

  def assign_code
    @code = "DCT" + SecureRandom.hex(2)
    self.code = @code
  end

end
