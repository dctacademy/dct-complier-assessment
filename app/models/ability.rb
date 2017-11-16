class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    if user.role? "admin"
        can [:create,:destroy,:update], :all
        can :read, :all
    elsif user.role?  "contributor"
        can :create, [Assignment,Answer]
        can :read , [Assignment,Answer]
        can :update, Assignment do |a|
          a.user == user
        end
        can :update, Answer do |ans|
          ans.user == user
        end
        can :destroy, Assignment do |a|
          a.user == user
        end
    elsif user.role? "solver"
        can :read, [Assignment,Answer]
        can :create, Answer
        can :update, Answer do |ans|
          ans.user == user
        end
    elsif user.role? "moderator"
        can :read ,[Assignment,Answer]
        can :update, Assignment
    elsif user.role? "student"
        can :read, [Assignment]
    end
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
