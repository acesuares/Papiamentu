class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action(:read, :create, :update, :to => :access_but_not_delete)
    alias_action(:_vote_reset_thumbs, :_vote_for_thumbs, :_vote_against_thumbs, :to => :vote)
    alias_action(:read, :palabra, :tra_palabra, :search, :check_text, :my_profile, :to => :do_frontend_stuff)

    user ||= User.new # guest user

    # roles
    if user.role?(:superadmin)
      can :manage, :all
    elsif user.role? :admin
      can :access_but_not_delete,  [:words, :sources, :wordtypes, :goals,:roles,:fshp_categories]
      can [:destroy, :revert],      :words
      cannot :update,               :words,                               [:buki_di_oro, :buki_di_oro_text]
      can :do_frontend_stuff,       :frontend
      can :rapport,                 :frontend
      can :vote,                    :words
      can :access_but_not_delete,   :users,                               id: user.id
      can :read,                    :users,                               [:name, :email, :roles]
      cannot :update,               :users,                               :roles
      can :read,                    :roles
    elsif user.role? :worker
      can :read,                    [:words, :sources, :wordtypes, :goals,:roles,:fshp_categories]
      can :update,                  :words,                               user_id: user.id
      can :update,                  :words,                               [:attested, :attested_on]
      cannot :update,               :words,                               [:buki_di_oro, :buki_di_oro_text]
      can :update,                  :words,                               :views
      can :create,                  :words
      can :do_frontend_stuff,       :frontend
      can :vote,                    :words
      can :read,                    :users,                               [:name, :email, :roles]
      can :access_but_not_delete,   :users,                               id: user.id
      cannot :update,               :users,                               :roles
    elsif user.role? :viewer
      can :read,                    [:words, :sources, :wordtypes, :goals, :roles]
      can :update,                  :words,                               :views
      can :create,                  :words
      can :do_frontend_stuff,       :frontend
      can :vote,                    :words
      can :access_but_not_delete,   User,                               id: user.id
      cannot :update,   :users,                               [:roles, :email]
    end
  end
end
