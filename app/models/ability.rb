class Ability
  include CanCan::Ability
  
  def initialize(user)
    user ||= User.new
    if user.role == "admin"
      can :manage, :all
      can :publish, Article
    elsif user.role =="reporter"
      can :create, Article
      can :delete, Article, :user_id => user.id
      can :update, Article, :user_id => user.id
      can :read, Article
      can :read, Category
      cannot :publish, Article
    else
      can :home, Category
      can :read, Article
      cannot :index, Article
      can :read, Category
    end
  end
end
