class Ability

include CanCan::Ability

def initialize(user)
        user ||= User.new
        if user.role == "admin"
            can :manage, :all
        elsif user.role == "basic_user"
            can :read, :all
            can :create, Feed
            can :manage, User if user.id == current_user.id
            end
            can [:read, :edit, :update, :destroy], FeedUser do |feeduser|
                feeduser.user_id == user.id
            end
            can [:read, :edit, :update, :destroy], EntryUser do |entryuser|
                entryuser.user_id == user.id
            end
            can [:read, :edit, :update, :destroy], User do |user|
                user_id == user.id
            end
        else
            can :create, User
            can :
        end
    end
