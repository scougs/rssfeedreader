class Ability

include CanCan::Ability

def initialize(user)
        user ||= User.new
        if user.role == "admin"
            can :manage, :all
        elsif user.role == "basic_user"
            can :read, :all
            can :create, Feed
            can [:manage, :"my_profile"], User do |u|
                u.id == user.id
            end
            can [:edit, :update, :destroy], FeedUser do |feeduser|
                feeduser.user_id == user.id
            end
            can [:edit, :update, :destroy], EntryUser do |entryuser|
                entryuser.user_id == user.id
            end
        else
            can :manage, User
        end
    end
end