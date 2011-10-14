class Ability
  include CanCan::Ability
  
  def initialize(user)
    user ||= User.new
    if user.role == "admin"
      can :manage, :all
    elsif user.role =="reporter"
      can :create, Article
      can :delete, Article, :user_id => user.id
      can :update, Article, :user_id => user.id
      can :read, Article
      can :read, Category
    else
      can :read, Article
      cannot :index, Article
      can :read, Category
    end
  end
end
