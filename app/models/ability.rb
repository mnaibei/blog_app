# class Ability
#     include CanCan::Ability

#     def initialize(user)
#       user ||= User.new # Guest user (not logged in)

#       if user.role == 'admin'
#         can :manage, :all
#       else
#         can :read, :all
#         can :create, Comment
#         can :update, Comment, author_id: user.id
#         can :destroy, Comment, author_id: user.id
#         can :create, Post
#         can :update, Post, author_id: user.id
#         can :destroy, Post, author_id: user.id
#       end
#     end
#   end

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.role == 'admin'
      can :manage, :all
    else
      can :manage, Post, author: user
      can :manage, Comment, author: user
      can :read, :all
    end
  end
end
