class Ability
  include CanCan::Ability
  
  def initialize(user)
    user ||= User.new
    if user.role == "admin"
      can :manage, :all
    elsif user.role =="reporter"
      can :create, Article
      can :update, Article, :user_id => user.id
      can :read, Article
      can :read, Category
    else
      can :read, Article,:published => true
      cannot :index, Article
      can :read, Category, :published => true
    end
  end
end
