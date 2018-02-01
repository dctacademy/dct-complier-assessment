class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :invitable, :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable
     has_many :my_answers,foreign_key: "user_id",class_name: "Answer"
     has_many :submissions
     has_many :permissions
     has_many :roles,through: :permissions

     has_many :my_assignments,foreign_key: "user_id",class_name: "Assignment"

     has_many :favourites
     has_many :assignments, through: :favourites

     has_many :forks
     has_many :answers,through: :forks

     has_many :lists
     has_many :solutions
     has_many :notifications
     has_many :comments

     has_many :assignment_timers

     has_one :editor_setting

     belongs_to :student
     #after_create :assign_user_role


     def role? role
       self.roles.pluck(:name).include? role
     end

    #  def assign_user_role
    #    Permission.create(user_id: self.id,role_id: Role.last.id)
    #  end
end
