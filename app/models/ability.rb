class Ability
  include CanCan::Ability

  def initialize(user)
    if user.class == Admin
      can :read, Admin, id: admin.id
    else
      can :read, User, id: user.id
    end
  end
end
