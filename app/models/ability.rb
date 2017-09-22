class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    alias_action :update, :create, :to => :modify

    if user.has_role? :access
      if user.has_role? :admin
        manager
        can :manage, :all
      elsif user.has_role? :manager
        manager
      elsif user.has_role? :boss
        can :read, [Car, Client, Order, Worker, Part, Oil, Service, Job, Task, Material, History]
      else
        can :read, Client, :id => Client.with_role(:client, user).pluck(:id)
        can :show, Car if (user.has_role? :clients)
        can :show, Worker, :id => Worker.with_role(:worker, user).pluck(:id)
      end
    end
  end

  def manager
    can :manage, [Car, Client, Order, Worker, Part, Oil, Service, Job, Task, Material, History]
  end
end