class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :download, :to => :read

    user ||= User.new

    if user.dispatcher?
      can :manage, :all
    elsif user.driver?
      can :read, Load
    end
  end
end
