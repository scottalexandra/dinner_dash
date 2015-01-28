class Ability
  include CanCan::Ability

  def initialize(user)
    if user.class == Admin
      can [:read, :update, :destroy], Admin, id: user.id
      can [:new, :create, :destroy], Admin
      can [:read, :edit, :update, :new, :create, :destroy], Item
      can [:edit, :update, :new, :create, :destroy], Category
    elsif user.class == User
      can :read, User, id: user.id
    end
  end
end
