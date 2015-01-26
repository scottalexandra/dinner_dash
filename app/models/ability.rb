class Ability
  include CanCan::Ability

  def initialize(user)
    if user.class == Admin
      can :read, Admin, id: user.id
    elsif user.class == User
      can :read, User, id: user.id
    end
  end
end
